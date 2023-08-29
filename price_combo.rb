require "csv"

#verifies csv is being read
table = CSV.read("data.csv")

#verifies that csv contents printed correctly
#pp table

#saves target price as variable using csv data
target_price = table[0][1].to_f

#deletes target price from table to prep data
table.delete_at(0)

#new array that stores prices as floats
prices = []
table.each do |item|
  prices << item[1].to_f
end

#new array that saves combos using data from prices array
combos = []
i = 0
while i < prices.length
  combos << prices.combo(prices.length - i).to_a
  i += 1
end

#reduces array nesting into a single array
combos = combos.flatten(1)

#saves sum of each combo
sum = 0
i = 0
combo_sums = []
while i < combos.length
  combos[i].each do |number|
    sum = sum + number
  end
  combo_sums[i] = sum.round(2)
  sum = 0
  i += 1
end

#saves index of sums that match target price
sums_index = []
index = 0
while index < combo_sums.length
  if combo_sums[index] == target_price
    sums_index << index
  end
  index += 1
end

#accesses sums_index array to save working combos
good_combos = []
sums_index.each do |index|
  good_combos << combos[index]
end

#covert items in array to display the names of associated dishes
i = 0
j = 0
while i < good_combos.length
  while j < good_combos[i].length
    good_combos[i][j] = prices.key(good_combos[i][j])
    j += 1
  end
  j = 0
  i += 1
end

#check if there were any solutions
if good_combos.length == 0
  p "There are no possible solutions!"
else
  i = 0
  p "Number of possible solutions: #{good_combos.length}"
  while i < good_combos.length
    p "Solution #{i + 1} includes: #{good_combos[i]}.join(", ")"
    i += 1
  end
end
