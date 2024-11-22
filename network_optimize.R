library("lpSolve")

# Decision varible coefficients
transport_cost <- c(5, 7, 8,
                    10, 8, 6,
                    9, 4, 3,
                    12, 6, 2,
                    4, 10, 11,
                    0, 0, 350000, 200000, 480000)

# Constraint matrices
lhs <- matrix(c(
  rep(1, 3), rep(0, 12), -2500, rep(0, 4), # Supply constraint for Source 1
  rep(0, 3), rep(1, 3), rep(0, 9), 0, -2500, rep(0, 3), # Supply constraint for Source 2
  rep(0, 6), rep(1, 3), rep(0, 6), 0, 0, -10000, 0, 0, # Supply constraint for Source 3
  rep(0, 9), rep(1, 3), rep(0, 3), 0, 0, 0, -10000, 0, # Supply constraint for Source 4
  rep(0, 12), rep(1, 3), rep(0, 4), -10000, # Supply constraint for Source 5
  1, rep(0, 2), 1, rep(0, 2), 1, rep(0, 2), 1, rep(0, 2), 1, rep(0, 2), rep(0, 5), # Demand for Destination 1
  0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, rep(0, 5), # Demand for Destination 2
  0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, rep(0, 5) # Demand for Destination 3
), nrow = 8, ncol = 20, byrow = TRUE)

direction <- c(rep('<=',5), rep('=',3))
rhs <- c(0, 0, 0, 0, 0, 3000, 8000, 9000)

# Model
model <- lp(
  direction = "min",
  objective.in = transport_cost,
  const.mat = lhs,
  const.dir = direction,
  const.rhs = rhs,
  bin = 16:20
)

model$solution
model$objval
