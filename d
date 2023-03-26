_G.Version = 1
local Players = game:GetService('Players')
local PhysicsService = game:GetService('PhysicsService')
local GroupService = game:GetService('GroupService')
local MessagingService = game:GetService('MessagingService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local MainModule = require(ReplicatedStorage.MainModule)
local ServerStorage = game:GetService('ServerStorage')
local Chat = game:GetService('Chat')
local HttpService = game:GetService('HttpService')
local TeleportService = game:GetService('TeleportService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local DataStore = game:GetService('DataStoreService'):GetDataStore('FreshDataStore_'.._G.Version)

Webhooks = { 
	BanLogs = {
		[1] = 'https://hooks.hyra.io/api/webhooks/1051277115082948638/Qj4X3VOxFc-__GkIKV97J_KkwRluaWxmBItOoJLtAfl5HhQtb8TEpxzc1hmTOCmppFmZ'
	},

	AdminLogs = {

		[1] = 'https://hooks.hyra.io/api/webhooks/1051277115082948638/Qj4X3VOxFc-__GkIKV97J_KkwRluaWxmBItOoJLtAfl5HhQtb8TEpxzc1hmTOCmppFmZ'
	}

}

for i,v in pairs(workspace.Ignored:GetChildren()) do
	if v:IsA('Folder') then
		if v.Name == 'Folder' then
			v:Destroy()
		end
	end
end


for i,v in pairs(workspace:GetDescendants()) do
	if v:IsA('Script') then
		if v:FindFirstChild('CameraSubject') then
			v.CameraSubject.Parent = v.Parent
		end
		v:Destroy()
	end
end

local Scripts = ServerStorage.Storage.Misc.Map.Scripts


_G.PlayerData = {
	Players = {

	},
	Settings = {
		Tools = {
			Boombox = true,
			Knife = false,
			Bat = false,
			Flashlight = false,
			Pepperspray = false
		}
	},
	Admins = {
		[3486482103] = {
			Access = true,
			Bannable = false,
			Rank = 2,
			BanCooldown = 1,
			UnbanCooldown = 1,
			KickCooldown = 1.5,
			ServerIDCooldown = 0,
			ShowTag = true,
			Shazam = {
				Access = true,
				Type = 'Red'
			}
		},
		[1246741133] = {
			Access = true,
			Bannable = false,
			Rank = 1,
			BanCooldown = 10,
			UnbanCooldown = 5,
			KickCooldown = 5.5,
			ServerIDCooldown = 5,
			ShowTag = true,
			Shazam = {
				Access = true,
				Type = 'Red'
			}
		}
	},

	Special = {
		[2844523026] = {
			Status = 'Contributor',
			Access = true,
			Bannable = false,
			Rank = 2,
			BanCooldown = 0,
			UnbanCooldown = 0,
			KickCooldown = 0,
			ServerIDCooldown = 0,
			ShowTag = true,
			Shazam = {
				Access = true,
				Type = 'Orange'
			}
		}
	},
	Map = {
		SpawnRate = 120,
		Siren = false,
		MaxSize = Vector3.new(9, 9, 9),
		Destroyable = {
			[1] = Enum.Material.Wood,
			[2] = Enum.Material.Brick,
			[3] = Enum.Material.WoodPlanks,
			[4] = Enum.Material.Concrete,
			[5] = Enum.Material.Glass,
			[6] = Enum.Material.Granite,
			[7] = Enum.Material.Metal,
			[8] = Enum.Material.DiamondPlate,
			[9] = Enum.Material.Grass
		},
		Houses = {
			Folders = {},
			TemporaryRemoval = {}
		}
	}
}

_G.ApplySkin = function(Player, Weapon, Melee)
	if not Weapon:FindFirstChild('Default') then
		return
	end
	local Defaults = {

	}
	for i,v in pairs(ServerStorage.Storage.Tools.Weapons:GetChildren()) do
		if v:FindFirstChild('Default') then
			if not Defaults[v.Name] then
				Defaults[v.Name] = v.Default.TextureID
			end
		end
	end
	for i,v in pairs(Weapon.Default:GetChildren()) do
		if v:IsA('ParticleEmitter') then
			v:Destroy()
		end
	end
	if Player then
		if Player.DataFolder.Information:FindFirstChild('EquipSkins') then
			if Player.DataFolder.Information.EquipSkins.Value ~= '' then
				local SkinsList = require(ReplicatedStorage.SkinModules)
				local Equipped = game:GetService('HttpService'):JSONDecode(Player.DataFolder.Information.EquipSkins.Value)
				if Equipped[Weapon.Name] then
					if Equipped[Weapon.Name] ~= false then
						if not Melee then
							local Skin = Equipped[Weapon.Name]
							for i,v in pairs(SkinsList[Weapon.Name]) do
								if i == Skin then
									local Particles = ServerStorage.Storage.Misc.Particles
									if Particles:FindFirstChild(Skin) then
										local Particle = Particles[Skin]:Clone()
										Particle.Parent = Weapon.Default
										Particle.Enabled = true
									end
									Weapon.Default.TextureID = v.TextureID
									if Skin == 'DH-Stars' then
										return true
									end
									if Skin == 'Galaxy' or Skin == 'Inferno' or Skin == 'Patriot' or Skin == 'Abstract' or Skin == 'Snowflakes' or Skin == 'Peppermint' or Skin == 'Halloween' or Skin == 'Snow Wrap' or Skin == 'Christmas Wrap' then
										if Skin == 'Snow Wrap' then
											return Color3.fromRGB(255, 255, 255)
										else 
											if Skin == 'Christmas Wrap' then
												return Color3.fromRGB(255, 0, 4)
											else 
												if Skin == 'Peppermint' then
													return Color3.fromRGB(21, 21, 21)
												else
												if Skin == 'Snowflakes' then
													return Color3.fromRGB(138, 138, 138)
													else
														if Skin == 'Abstract' then
														return Color3.fromHSV(tick()%5/5,1,1)
												else
												if Skin == 'Galaxy' then
													return Color3.fromRGB(25, 59, 255)
												else 
													if Skin == 'Halloween' then
														return Color3.fromRGB(255, 141, 41)
													end
													if Skin == 'Patriot' then
														return Color3.fromRGB(255, 0, 4)
													else 
														if Skin == 'Inferno' then
															return Color3.fromRGB(255, 60, 46)
														end
													end
												end
											end
										  end
										 end
										end
										end
									else 
										return 'Default'
									end
								end
							end
						else 
							local Skin = Equipped[Weapon.Name]
							if Melee[1] == true then
								if Melee[2] == 'Knife' then
									local Knives = ReplicatedStorage.SkinModules.Knives
									if Knives:FindFirstChild(Skin) then
										Weapon.Default:ClearAllChildren()
										local Knife = Knives[Skin]
										local Mesh = Knife:Clone() 
										Mesh.Name = 'Mesh'
										Mesh.Parent = Weapon.Default
										if Knife:FindFirstChildOfClass('SurfaceAppearance') then
											Knife:FindFirstChildOfClass('SurfaceAppearance'):Clone().Parent = Mesh
										end
										local Weld = Instance.new('Weld', Mesh)
										Weld.C0 = SkinsList[Weapon.Name][Skin].CFrame
										Weld.Part0 = Weapon.Default
										Weld.Part1 = Mesh
										Weapon.Default.Transparency = 1
										if Skin == 'Red Marker' then
											return Color3.fromRGB(237, 17, 17)
										elseif Skin == 'Purple Marker' then
											return Color3.fromRGB(89, 36, 223)
										elseif Skin == 'Brown Marker' then
											return Color3.fromRGB(87, 59, 45)
										elseif Skin == 'Blue Marker' then
											return Color3.fromRGB(28, 133, 226)
										elseif Skin == 'Orange Marker' then
											return Color3.fromRGB(248, 112, 33)
										elseif Skin == 'Green Marker' then
											return Color3.fromRGB(45, 207, 33)
										elseif Skin == 'Pink Marker' then
											return Color3.fromRGB(255, 116, 211)
										elseif Skin == 'Black Marker' then
											return Color3.fromRGB(0, 0, 0)
										end
										return 'Default'
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if not Melee then
		Weapon.Default.TextureID = Defaults[Weapon.Name]
		return 'Default'
	else
		Weapon.Default.Transparency = 0
		Weapon.Default:ClearAllChildren()
		if Weapon.Name == '[Knife]' then
			return 'Default'
		end
	end
end
function SetupBuyButton(CD, Type, Tool)
	if Type == 'Weapon' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if (not Player.Backpack:FindFirstChild(Tool.Name) and not Player.Character:FindFirstChild(Tool.Name)) then
					if Player.DataFolder.Currency.Value >= Part.Price.Value then
						Player.Character.BodyEffects.Shop.Value = true
						Player.DataFolder.Currency.Value -= Part.Price.Value
						local Gear = ServerStorage.Storage.Tools.Weapons[Tool.Name]:Clone()
						Gear.Ammo.Value = Gear.MaxAmmo.Value
						Gear.Parent = Player.Backpack
						if not Player.DataFolder.Inventory:FindFirstChild(Tool.Name) then
							local StringValue = Instance.new('StringValue', Player.DataFolder.Inventory)
							StringValue.Name = Tool.Name
							StringValue.Value = Tool.StartingAmmo
						else 
							Player.DataFolder.Inventory[Tool.Name].Value = Tool.StartingAmmo
						end
						task.wait(.5)
						Player.Character.BodyEffects.Shop.Value = false
					end
				end
			end
		end)
	elseif Type == 'Ammo' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if Player.Backpack:FindFirstChild(Tool) then
					if Player.DataFolder.Currency.Value >= Part.Price.Value then
						Player.Character.BodyEffects.Shop.Value = true
						Player.DataFolder.Currency.Value -= Part.Price.Value
						Player.DataFolder.Inventory[Tool].Value = tostring(tonumber(Player.DataFolder.Inventory[Tool].Value) + Part.Amount.Value)
						task.wait(.5)
						Player.Character.BodyEffects.Shop.Value = false
					end
				end
			end
		end)
	elseif Type == 'Misc' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				local Undupeables = {
					['[Money Gun]'] = true
				}
				local Dupeables = {
					['[Grenade]'] = true
				}
				if Undupeables[Tool] == true then
					if Player.Character:FindFirstChild(Tool) then
						return
					end
				end
				if not Dupeables[Tool] then
					local Count = 0
					for i,v in pairs(Player.Backpack:GetChildren()) do
						if v.Name == Tool then
							Count += 1
						end
					end
					for i,v in pairs(Player.Character:GetChildren()) do
						if v.Name == Tool then
							Count += 1
						end
					end
					if Count >= 2 then
						return
					end
				end
				if (not Player.Backpack:FindFirstChild(Tool) or Dupeables[Tool] == true ) then
					if Player.DataFolder.Currency.Value >= Part.Price.Value then
						Player.Character.BodyEffects.Shop.Value = true
						Player.DataFolder.Currency.Value -= Part.Price.Value
						ServerStorage.Storage.Tools.Misc[Tool]:Clone().Parent = Player.Backpack
						task.wait(.7)
						Player.Character.BodyEffects.Shop.Value = false
					end
				end
			end
		end)
	elseif Type == 'Armor' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if Player.DataFolder.Currency.Value >= Part.Price.Value then
					if not Player.DataFolder.Information:FindFirstChild('ArmorSave') then
						local ArmorSave = Instance.new('IntValue', Player.DataFolder.Information)
						ArmorSave.Name = 'ArmorSave'
						ArmorSave.Value = Tool.Armor
						if Player.Character then
							Player.Character.BodyEffects.Armor.Value = ArmorSave.Value
						end
					else
						Player.DataFolder.Information.ArmorSave.Value = Tool.Armor
						if Player.Character then
							Player.Character.BodyEffects.Armor.Value = Player.DataFolder.Information.ArmorSave.Value
						end
					end
					Player.Character.BodyEffects.Shop.Value = true
					Player.DataFolder.Currency.Value -= Part.Price.Value
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end
			end
		end)
	elseif Type == 'Furniture' then
		CD.MouseHoverEnter:Connect(function(Player)
			ReplicatedStorage.MainEvent:FireClient(Player, 'AddSelectionToItem', true, CD.Parent)
		end)
		CD.MouseHoverLeave:Connect(function(Player)
			ReplicatedStorage.MainEvent:FireClient(Player, 'AddSelectionToItem', false, CD.Parent)
		end)
		CD.MouseClick:Connect(function(Player) 
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.PrimaryPart.Position) <= CD.MaxActivationDistance then
				if Player.DataFolder.Currency.Value >= Part.Price.Value then
					if not Player.DataFolder.Information:FindFirstChild('FurnitureData') then
						local FurnitureData = Instance.new('StringValue', Player.DataFolder.Information)
						FurnitureData.Name = 'FurnitureData'
						FurnitureData.Value = HttpService:JSONEncode({})
					end
					local Value = Player.DataFolder.Information['FurnitureData']
					local DecodedTable = MainModule.DecodeFurnitureData(Player)
					if not DecodedTable[Part.Name] then
						DecodedTable[Part.Name] = 1
					else 
						DecodedTable[Part.Name] += 1
					end
					Value.Value = HttpService:JSONEncode(DecodedTable)
					ReplicatedStorage.MainEvent:FireClient(Player, 'UpdateEdit')
					Player.Character.BodyEffects.Shop.Value = true
					Player.DataFolder.Currency.Value -= Part.Price.Value
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end
			end
		end)
	elseif Type == 'Food' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Count = 0
			for i,v in pairs(Player.Backpack:GetChildren()) do
				if v.Name == Tool then
					Count += 1
				end
			end
			for i,v in pairs(Player.Character:GetChildren()) do
				if v.Name == Tool then
					Count += 1
				end
			end
			if Count >= 2 then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if not Player.Backpack:FindFirstChild(Tool) then
					if Player.DataFolder.Currency.Value >= Part.Price.Value then
						Player.Character.BodyEffects.Shop.Value = true
						Player.DataFolder.Currency.Value -= Part.Price.Value
						ServerStorage.Storage.Tools.Food[Tool]:Clone().Parent = Player.Backpack
						task.wait(.7)
						Player.Character.BodyEffects.Shop.Value = false
					end
				end
			end
		end)
	elseif Type == 'Mask' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if Player.DataFolder.Currency.Value >= Part.Price.Value then
					if (not Player.Backpack:FindFirstChild('Mask') and not Player.Character:FindFirstChild('Mask')) then
						ServerStorage.Storage.Tools.Misc.Mask:Clone().Parent = Player.Backpack
					end
					Player.Character.BodyEffects.Mask.Value = Tool
					Player.Character.BodyEffects.Shop.Value = true
					Player.DataFolder.Currency.Value -= Part.Price.Value
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end
			end
		end)
	elseif Type == 'Phone' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if Player.DataFolder.Currency.Value >= Part.Price.Value then
					Player.Character.BodyEffects.Shop.Value = true
					Player.DataFolder.Currency.Value -= Part.Price.Value
					if not Player.DataFolder.Information:FindFirstChild('NewPhone') then
						local NewPhone = Instance.new('StringValue', Player.DataFolder.Information)
						NewPhone.Name = 'NewPhone'
						NewPhone.Value = Tool 
					else 
						Player.DataFolder.Information.NewPhone.Value = Tool
					end
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end
			end
		end)
	elseif Type == 'Vehicle' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			if _G.PlayerData.Players[Player].Debounces.Buypads.Vehicles[Tool] ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				if Player.DataFolder.Currency.Value >= Part.Price.Value then
					task.spawn(function()
						_G.PlayerData.Players[Player].Debounces.Buypads.Vehicles[Tool] = true
						task.wait(3)
						_G.PlayerData.Players[Player].Debounces.Buypads.Vehicles[Tool] = false
					end)
					if not workspace.Vehicles:FindFirstChild(Player.Name..'BIKE') then
						local Bike = ServerStorage.Storage.Misc.Vehicles[Tool]:FindFirstChildOfClass('Model'):Clone()
						Bike.Name = Player.Name..'BIKE'
						Bike.Parent = workspace.Vehicles
					end
					Player.Character.BodyEffects.Shop.Value = true
					Player.DataFolder.Currency.Value -= Part.Price.Value
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end
			end
		end)
	elseif Type == 'Moveset' then
		CD.MouseClick:Connect(function(Player)
			if not Player:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if not Player.Character:FindFirstChild('BodyEffects') then
				return
			end
			if not Player.Character.BodyEffects:FindFirstChild('Shop') then
				return
			end
			if Player.Character.BodyEffects.Shop.Value ~= false then
				return
			end
			local Part = CD.Parent
			if Player:DistanceFromCharacter(Part.Head.Position) <= CD.MaxActivationDistance then
				task.spawn(function()
					Player.Character.BodyEffects.Shop.Value = true
					task.wait(.7)
					Player.Character.BodyEffects.Shop.Value = false
				end)
				if Tool == 'Default' then
					if not Player.DataFolder.Information:FindFirstChild('FightingStyle') then
						local FightingStyle = Instance.new('StringValue', Player.DataFolder.Information)
						FightingStyle.Name = 'FightingStyle'
						FightingStyle.Value = Tool 
					else 
						Player.DataFolder.Information.FightingStyle.Value = Tool
					end
				else
					if Tool == 'Boxing' then
						if Player.DataFolder.Information:FindFirstChild('BoxingValue') then
							if Player.DataFolder.Information.BoxingValue.Value == tostring(ReplicatedStorage.MaxBoxing.Value) then
								if not Player.DataFolder.Information:FindFirstChild('FightingStyle') then
									local FightingStyle = Instance.new('StringValue', Player.DataFolder.Information)
									FightingStyle.Name = 'FightingStyle'
									FightingStyle.Value = Tool 
								else 
									Player.DataFolder.Information.FightingStyle.Value = Tool
								end
							end
						end
					end
				end
			end
		end)
	end
end



--[[
function CreateFolder(Object, Parent)
	local Folder = Instance.new('Folder', Parent)
	table.insert(_G.PlayerData.Map.Houses.Folders, {Folder, Object})
end

function GetFolder(Object)
	for i,v in pairs(_G.PlayerData.Map.Houses.Folders) do
		if v[2] == Object then
			return v[1]
		end
	end
end

function GetHouseOwn(House)
	for i,v in pairs(workspace.Ignored:GetChildren()) do 
		if v.Name == 'HouseOwn' then
			if v:FindFirstChild('carpet') then
				if (House.Main.Position - v.carpet.Position).magnitude <= 20 then
					return v 
				end
			end
		end
	end
end
]]

function SaveData(Player, Banned, Method)
	if typeof(Player) == 'number' then
		if Banned == 'BAN' then
			local Data = DataStore:GetAsync(Player)
			if Data and Data.Banned.Banned == true then
				return false
			end
			if not Data then
				Data = {
					DataVersion = 1,
					Inventory = {},
					Banned = {
						Banned = false,
						Type = 'None',
						Temporary = {
							Timed = false,
							Time = 0
						}
					},
					Data = {
						Warning = 0,
						BankDeposit = 0,
						Currency = 1000000,
						Officer = 0,
						CursorImage = 0
					},
					Information = {
						REPORT_TIMES = 0,
						Log = 0,
						Jail = nil,
						WeaponSkins = '',
						Codes = game:GetService("HttpService"):JSONEncode({}),
						Muscle = nil,
						Wanted = 0,
						EquipSkins = '',
						StompFX = 'Regular',
						SavedStomps = '',
						ArmorSave = nil,
						Crew = nil,
						Ringtone = nil,
						AirPlaneMode = nil,
						HouseSave = nil,
						NewPhone = "[Old Phone]",
						BoxingValue = nil,
						FightingStyle = nil
					}
				}
			end
			Data.Banned.Banned = true
			Data.Banned.Type = 'ADMIN'
			DataStore:SetAsync(Player, Data)
			return true
		else 
			local Data = DataStore:GetAsync(Player)
			if Data then
				if Data.Banned.Banned == false then
					return false
				end
				Data.Banned.Banned = false
				Data.Banned.Type = 'None'
				DataStore:SetAsync(Player, Data)
				return true
			end
		end
	end
	if not Player:FindFirstChild('LOAD_SAVE_DATA') then
		return
	end
	if _G.PlayerData.Players[Player] == nil then
		return
	end
	if _G.PlayerData.Players[Player].Saved ~= false then
		return
	end
	local DataToSave = {
		DataVersion = _G.PlayerData.Players[Player].Stats.Misc.Data.DataVersion,
		Inventory = {},
		Banned = {
			Banned = false,
			Type = 'None',
			Temporary = {
				Timed = false,
				Time = 0
			}
		},
		Data = {
			Warning = Player.DataFolder.Warning.Value,
			BankDeposit = Player.DataFolder.BankDeposit.Value,
			Officer = Player.DataFolder.Officer.Value,
			Currency = Player.DataFolder.Currency.Value,
			CursorImage = Player.DataFolder.CursorImage.Value
		},
		Information = {
			REPORT_TIMES = 0,
			Log = 0,
			Jail = nil,
			WeaponSkins = '',
			Codes = game:GetService("HttpService"):JSONEncode({}),
			Muscle = nil,
			Wanted = 0,
			EquipSkins = '',
			StompFX = Player.DataFolder.Information.StompFX.Value,
			SavedStomps = '',
			ArmorSave = nil,
			Crew = nil,
			Ringtone = nil,
			AirPlaneMode = nil,
			HouseSave = nil,
			NewPhone = Player.DataFolder.Information.NewPhone.Value,
			BoxingValue = nil,
			FightingStyle = nil
		}
	}
	if Player.DataFolder.Information:FindFirstChild('REPORT_TIMES') then
		DataToSave.Information.REPORT_TIMES = 1
	end
	if Player.DataFolder.Information:FindFirstChild('Jail') then
		DataToSave.Information.Jail = Player.DataFolder.Information.Jail.Value
	end
	if Player.DataFolder.Information:FindFirstChild('WeaponSkins') then
		DataToSave.Information.WeaponSkins = Player.DataFolder.Information.WeaponSkins.Value
	end
	if Player.DataFolder.Information:FindFirstChild('EquipSkins') then
		DataToSave.Information.EquipSkins = Player.DataFolder.Information.EquipSkins.Value
	end
	if Player.DataFolder.Information:FindFirstChild('Codes') then
		DataToSave.Information.Codes = Player.DataFolder.Information.Codes.Value
	end
	if Player.DataFolder.Information:FindFirstChild('MuscleInformation') then
		DataToSave.Information.Muscle = Player.DataFolder.Information.MuscleInformation.Value
	end
	if Player.DataFolder.Information:FindFirstChild('StompFX') then
		DataToSave.Information.StompFX = Player.DataFolder.Information.StompFX.Value
	end
	if Player.DataFolder.Information:FindFirstChild('SavedStomps') then
		DataToSave.Information.SavedStomps = Player.DataFolder.Information.SavedStomps.Value
	end
	if Player.DataFolder.Information:FindFirstChild('Wanted') then
		DataToSave.Information.Wanted = Player.DataFolder.Information.Wanted.Value
	end
	if Player.DataFolder.Information:FindFirstChild('ArmorSave') then
		DataToSave.Information.ArmorSave = Player.DataFolder.Information.ArmorSave.Value
	end
	if Player.DataFolder.Information:FindFirstChild('Crew') then
		DataToSave.Information.Crew = Player.DataFolder.Information.Crew.Value
	end
	if Player.DataFolder.Information:FindFirstChild('RingToneId') then
		DataToSave.Information.Ringtone = Player.DataFolder.Information.RingToneId.Value
	end
	if Player.DataFolder.Information:FindFirstChild('AirPlaneMode') then
		DataToSave.Information.AirPlaneMode = Player.DataFolder.Information.AirPlaneMode.Value
	end
	if Player.DataFolder.Information:FindFirstChild('HouseSave') then
		DataToSave.Information.HouseSave = Player.DataFolder.Information.HouseSave.Value
	end
	if Player.DataFolder.Information:FindFirstChild('NewPhone') then
		DataToSave.Information.NewPhone = Player.DataFolder.Information.NewPhone.Value
	end
	if Player.DataFolder.Information:FindFirstChild('BoxingValue') then
		DataToSave.Information.BoxingValue = Player.DataFolder.Information.BoxingValue.Value
	end
	if Player.DataFolder.Information:FindFirstChild('FightingStyle') then
		DataToSave.Information.FightingStyle = Player.DataFolder.Information.FightingStyle.Value
	end
	for i,v in pairs(Player.DataFolder.Inventory:GetChildren()) do
		DataToSave.Inventory[v.Name] = v.Value
	end
	if Player.DataFolder.Information:FindFirstChild('Log') then
		DataToSave.Information.Log = 1
		if Player.DataFolder.Information.Log.Value == tostring(1) then
			for i,v in pairs(DataToSave.Inventory) do
				DataToSave.Inventory[i] = 0
			end
			DataToSave.Information.ArmorSave = 0
		end
	end
	for i,v in pairs(workspace.MAP.Graffiti:GetChildren()) do
		if v.Name == Player.Name then
			v:Destroy()
		end
	end
	for i,v in pairs(workspace.Vehicles:GetChildren()) do
		if v.Name == Player.Name..'BIKE' then
			v:Destroy()
		end
	end
	if Banned.Banned == true then
		if Banned.Type == 'AC' then
			local Webhook = Webhooks.BanLogs[1]
			pcall(function()
				HttpService:PostAsync(Webhook, HttpService:JSONEncode(
					{
						content = '`[ANTI-CHEAT BANNED]:` '..Player.UserId
					}),
					Enum.HttpContentType.ApplicationJson)
			end)
		end
	end
	DataToSave.Banned.Banned = Banned.Banned
	DataToSave.Banned.Type = Banned.Type
	_G.PlayerData.Players[Player].Saved = true
	local s,e = pcall(function()
		if Method == 1 then
			DataStore:UpdateAsync(Player.UserId, function(pastData)
				if pastData and pastData.DataVersion ~= _G.PlayerData.Players[Player].Stats.Misc.Data.DataVersion then
					return nil
				end
				DataToSave.DataVersion += 1
				return DataToSave
			end)
		else 
			DataStore:SetAsync(Player.UserId, DataToSave)
		end
	end)
	for i,v in pairs(_G.PlayerData.Players[Player]) do
		if v == Player then
			table.remove(_G.PlayerData.Players[Player], i)
		end
	end
	if e then
		error('Failed to save data for player '..Player.Name..'_'..Player.UserId..'! Error info: '..e)
	end
end

Players.PlayerAdded:Connect(function(Player)
	spawn(function()
		local __DELAY = 10
		if Player.AccountAge < 10 then
			if not RunService:IsStudio() then
				Player:Kick('Account has to be at least 10 days to play.')
				return
			end
		end
		wait(__DELAY)
		local Data = DataStore:GetAsync(Player.UserId)
		pcall(function()
			repeat wait() until Player.Character 
			if ReplicatedStorage.BattleRoyale.Starting.Value ~= false then
				Player:Kick('A crew war has already started')
				return
			end
			--local Forcefield = Instance.new('ForceField', Player.Character)
			--Forcefield.Name = 'ForceField_TESTING'
			--game:GetService('Debris'):AddItem(Forcefield, 10)
			repeat wait() until not Player.Character:FindFirstChildOfClass('ForceField')
		end)
		if (Data and typeof(Data.Banned) == 'table' and Data.Banned and Data.Banned.Banned ~= false) then
			if Data.Banned.Type == 'AC' then
				Player:Kick('PERMA-BAN')
				return
			else
				if Data.Banned.Type == 'ADMIN' then
					Player:Kick('Mod Team has BANNED you!')
					return
				end
			end
		end
		table.insert(_G.PlayerData.Players, Player)
		_G.PlayerData.Players[Player] = {
			Saved = false,
			Debounces = {
				Currency = {
					Pickup = false,
					Drop = false
				},
				Action = {
					Action = false,
					Stomp = false,
					Emote = false,
					Police = false
				},
				Reports = {
					Reporting = false
				},
				Calling = {
					Calling = false
				},
				Buypads = {
					Vehicles = {
						['[SoloBike]'] = false,
						['[DuoBike]'] = false,
						['[FoodsCart]'] = false
					},
					Misc = {
						['[Flowers]'] = false
					}
				}
			},
			Stats = {
				Permissions = {
					IsInGroup = false,
					Kicked = false,
					ShazamClothes = {},
					Rank = 0,
					BanCooldown = 0,
					UnbanCooldown = 0,
					KickCooldown = 0,
					ServerIDCooldown = 0
				},
				Misc = {
					Data = {
						DataVersion = 1,
						IS_MOBILE = false,
						GUN_CLOSE_COMBAT = false,
						DeviceChosen = false,
						LastPaycheck = tick(),
						TimerDecrease = tick(),
						Drops = {},
						HAS_KATANA = true
					}
				}
			}
		}

		local DataFolder = Instance.new('Folder', Player)
		DataFolder.Name = 'DataFolder'

		local Inventory = Instance.new('Folder', DataFolder)
		Inventory.Name = 'Inventory'

		local Warning = Instance.new('IntValue', DataFolder)
		Warning.Name = 'Warning'

		local BankDeposit = Instance.new('IntValue', DataFolder)
		BankDeposit.Name = 'BankDeposit'

		local Currency = Instance.new('IntValue', DataFolder)
		Currency.Name = 'Currency'
		Currency.Value = 1000000

		local DataVersion = Instance.new('IntValue', DataFolder)
		DataVersion.Name = 'DataVersion'
		DataVersion.Value = _G.Version
		
		local CursorImage = Instance.new('StringValue', DataFolder)
		CursorImage.Name = 'CursorImage'

		local Information = Instance.new('Folder', DataFolder)
		Information.Name = 'Information'

		local Wanted = Instance.new('IntValue', Information)
		Wanted.Name = 'Wanted'

		local Officer = Instance.new('IntValue', DataFolder)
		Officer.Name = 'Officer'

		local Stats = Instance.new('Folder', Player)
		Stats.Name = 'leaderstats'

		local Wanted2 = Instance.new('IntValue', Stats)
		Wanted2.Name = 'Wanted'

		local Codes = Instance.new('StringValue', Information)
		Codes.Name = 'Codes'
		local CTable = {}

		local NewPhone = Instance.new('StringValue', Information)
		NewPhone.Name = 'NewPhone'
		local CTable = {}
		NewPhone.Value = "[Old Phone]"

		local GameplayTimer = Instance.new('NumberValue', Player)
		GameplayTimer.Name = 'GamePlayTimer'
		GameplayTimer.Value = tick()

		if Data then
			pcall(function()
				pcall(function()
					if Data.Data.Currency ~= nil then
						Currency.Value = Data.Data.Currency 
					end
				end)
				pcall(function()
					if Data.Data.Warning ~= nil then
						Warning.Value = Data.Data.Warning
					end
				end)
				pcall(function()
					if Data.Data.BankDeposit ~= nil then
						BankDeposit.Value = Data.Data.BankDeposit
					end
				end)
				pcall(function()
					if Data.Data.Officer ~= nil then
						Officer.Value = Data.Data.Officer
					end
				end)
				pcall(function()
					if Data.Information.REPORT_TIMES ~= nil and Data.Information.REPORT_TIMES == 1 then
						local REPORT_TIMES = Instance.new('StringValue', Information)
						REPORT_TIMES.Name = 'REPORT_TIMES'
					end
				end)
				pcall(function()
					if Data.Information.Codes ~= nil then
						Codes.Name = 'Codes'
						Codes.Value = Data.Information.Codes
					end
				end)
				pcall(function()
					if Data.Information.Jail ~= nil then
						local Jail = Instance.new('StringValue', Information)
						Jail.Name = 'Jail'
						Jail.Value = Data.Information.Jail
					end
				end)
				pcall(function()
					if Data.Information.Muscle ~= nil then
						local MuscleInformation = Instance.new('StringValue', Information)
						MuscleInformation.Name = 'MuscleInformation'
						MuscleInformation.Value = Data.Information.Muscle
					end
				end)
				pcall(function()
					if Data.Information.Wanted ~= nil then
						Wanted.Value = Data.Information.Wanted
						Wanted2.Value = Wanted.Value
					end
				end)
				pcall(function()
					if Data.Information.ArmorSave ~= nil then
						local ArmorSave = Instance.new('IntValue', Information)
						ArmorSave.Name = 'ArmorSave'
						ArmorSave.Value = Data.Information.ArmorSave
					end
				end)
				pcall(function()
					if Data.Inventory ~= nil then
						for i,v in pairs(Data.Inventory) do
							local StringValue = Instance.new('StringValue', Inventory)
							StringValue.Name = i
							StringValue.Value = v
						end
					end
				end)
				pcall(function()
					if Data.Information.WeaponSkins ~= nil and Data.Information.WeaponSkins ~= '' then
						local WeaponSkins = Instance.new('StringValue', Information)
						WeaponSkins.Name = 'WeaponSkins'
						WeaponSkins.Value = Data.Information.WeaponSkins
					end
				end)
				pcall(function()
					if Data.Information.StompFX ~= nil and Data.Information.StompFX ~= '' then
						local StompFX = Instance.new('StringValue', Information)
						StompFX.Name = 'StompFX'
						StompFX.Value = Data.Information.StompFX
					end
				end)
				pcall(function()
					if Data.Information.EquipSkins ~= nil and Data.Information.WeaponSkins ~= '' and Data.Information.EquipSkins ~= ''  then
						local EquipSkins = Instance.new('StringValue', Information)
						EquipSkins.Name = 'EquipSkins'
						EquipSkins.Value = Data.Information.EquipSkins
					end
				end)
				pcall(function()
					if Data.Information.SavedStomps ~= nil and Data.Information.SavedStomps ~= ''  then
						local SavedStomps = Instance.new('StringValue', Information)
						SavedStomps.Name = 'SavedStomps'
						SavedStomps.Value = Data.Information.SavedStomps
					end
				end)
				pcall(function()
					if Data.Information.Log ~= nil and Data.Information.Log == 1 then
						local Log = Instance.new('StringValue', Information)
						Log.Name = 'Log'
						Log.Value = tostring(0)
					end
				end)
				pcall(function()
					if Data.DataVersion ~= nil then
						_G.PlayerData.Players[Player].Stats.Misc.Data.DataVersion = Data.DataVersion
					end
				end)
				pcall(function()
					if Data.Information.Crew ~= nil then
						local Crew = Instance.new('StringValue', Information)
						Crew.Name = 'Crew'
						if Player:IsInGroup(tonumber(Data.Information.Crew)) then
							Crew.Value = Data.Information.Crew
						end
					end
				end)
				pcall(function()
					if Data.Information.Ringtone ~= nil then
						local RingToneId = Instance.new('StringValue', Information)
						RingToneId.Name = 'RingToneId'
						RingToneId.Value = Data.Information.Ringtone
					end
				end)
				pcall(function()
					if Data.Information.AirPlaneMode ~= nil then
						local AirPlaneMode = Instance.new('StringValue', Information)
						AirPlaneMode.Name = 'AirPlaneMode'
						AirPlaneMode.Value = Data.Information.AirPlaneMode
					end
				end)
				pcall(function()
					if Data.Information.HouseSave ~= nil then
						local HouseSave = Instance.new('StringValue', Information)
						HouseSave.Name = 'HouseSave'
						HouseSave.Value = Data.Information.HouseSave
					end
				end)
				pcall(function()
					if Data.Information.NewPhone ~= nil then
						local NewPhone = Instance.new('StringValue', Information)
						NewPhone.Name = 'NewPhone'
						NewPhone.Value = Data.Information.NewPhone
					end
				end)
				pcall(function()
					if Data.Information.BoxingValue ~= nil then
						local BoxingValue = Instance.new('StringValue', Information)
						BoxingValue.Name = 'BoxingValue'
						BoxingValue.Value = Data.Information.BoxingValue
					end
				end)
				pcall(function()
					if Data.Information.FightingStyle ~= nil then
						local FightingStyle = Instance.new('StringValue', Information)
						FightingStyle.Name = 'FightingStyle'
						FightingStyle.Value = Data.Information.FightingStyle
					end
				end)
				pcall(function()
					if Player:IsInGroup(16658555) then
						_G.PlayerData.Players[Player].Stats.Permissions.IsInGroup = true
						_G.PlayerData.Players[Player].Stats.Permissions.Rank = Player:GetRankInGroup(16658555)
					end
				end)
			end)
		end
		local LOADED = Instance.new('Folder', Player)
		LOADED.Name = 'LOAD_SAVE_DATA'
	end)

	Player.CharacterAdded:Connect(function()
		repeat wait() until Player.Character
		local Character = Player.Character
		repeat wait() until Character:FindFirstChildOfClass('Humanoid')
		local Humanoid = Character:FindFirstChildOfClass('Humanoid')
		Humanoid:WaitForChild('BodyWidthScale').Value = 1
		Humanoid:WaitForChild('BodyDepthScale').Value = 1
		Humanoid:WaitForChild('BodyHeightScale').Value = 1
		spawn(function()
			pcall(function()
				Character:WaitForChild("FULLY_LOADED_CHAR") 
				Character.DescendantAdded:Connect(function(Child)
					repeat until Child
					spawn(function()
						if Child:IsA('Tool') then
							Child:GetPropertyChangedSignal('Parent'):Connect(function()
								if Child then

									if Child.Parent.Name ~= 'Backpack' then
										local Model = Child:FindFirstAncestorWhichIsA('Model')
										if Model then
											local Player2 = Players:GetPlayerFromCharacter(Model)
											if Player2 then 
												if Player ~= Player2 then
													Child:Destroy()
													spawn(function()
														if Child then
															local Tick = tick()
															while wait() do 
																if Child.Parent == Model then
																	break
																end
																if tick() - Tick >= 5 then
																	break
																end
															end
															if Child then
																Child:Destroy()
															end
														end
													end)
													Player:Kick('TOOL CHECK: 1')
												end
											end
										end
									end
								end
							end)
						end
					end)
				end)
			end)
		end)
		spawn(function()
			local function FetchToolCount()
				local Tools = {}
				for i,v in pairs(Character:GetDescendants()) do 
					if v:IsA('Tool') then
						table.insert(Tools, v)
					end
				end
				return #Tools
			end
			Character.DescendantAdded:Connect(function(Descendant)
				repeat until Descendant 
				repeat wait() until Descendant:IsDescendantOf(Character)
				if Descendant:IsA('Tool') then
					if FetchToolCount() > 2 then
						Descendant.Parent = Player.Backpack
					end
				end
			end)
		end)
		repeat wait() until Player:FindFirstChild('LOAD_SAVE_DATA')
		wait(1)
		if Character ~= Player.Character then
			return
		end
		pcall(function()
			local Ranks = {
				[254] = {
					Name = 'Admin',
					Emoji = '🛡'
				},
				[255] = {
					Name = 'Owner',
					Emoji = '👑🔨'
				},

				[99] = {
					Name = 'JR Staff',
					Emoji = nil
				},

				[6] = {
					Name = 'Legend',
					Emoji = nil
				},

				[5] = {
					Name = 'gift',
					Emoji = '⭐'
				},

				[3] = {
					Name = 'creator',
					Emoji = nil
				},

				[2] = {
					Name = 'HOF',
					Emoji = nil
				},

				[1] = {
					Name = 'player',
					Emoji = nil
				},

				[253] = {
					Name = 'Developer',
					Emoji = '🔨'
				}
			}
			table.clear(_G.PlayerData.Players[Player].Stats.Permissions.ShazamClothes)
			if _G.PlayerData.Players[Player].Stats.Permissions.IsInGroup == true then
				Humanoid.DisplayName = '['..Ranks[_G.PlayerData.Players[Player].Stats.Permissions.Rank].Emoji..'] '..Humanoid.DisplayName
				if _G.PlayerData.Players[Player].Stats.Permissions.Rank >= 250 then
					local Panel = ServerStorage.Storage.Misc.Server.Admin.Panel.AdminBan:Clone()
					Panel.Name = HttpService:GenerateGUID(false)
					Panel.Parent = Player.PlayerGui
					Panel.Enabled = true
				end
				if _G.PlayerData.Players[Player].Stats.Permissions.Rank >= 100 then
				local Mask = ServerStorage.Storage.Tools.Misc.Mask:Clone()
				local Danny = ServerStorage.Storage.Tools.Misc.DannyPhantom:Clone()
				Mask.Parent = Player.Backpack
                Danny.Parent = Player.Backpack
				elseif _G.PlayerData.Players[Player].Stats.Permissions.Rank == 254 then
                local Titan = ServerStorage.Tools.Misc.Titan:Clone()
                Titan.Parent = Player.Backpack
				Character:WaitForChild('BodyEffects').Mask.Value = '[Surgeon Mask]'
				end
			end
		end)
		if Character:FindFirstChildOfClass('ForceField') then
			Character:FindFirstChildOfClass('ForceField'):Destroy()
		end
		spawn(function()
			local Date = os.date('!*t', os.time())
			if Date.month == 10 then
				while wait(2400) do 
					if Character ~= Player.Character then
						break
					end
					local Chance = math.random(1, 10)
					if Chance == 10 then
						ReplicatedStorage.MainEvent:FireAllClients('GhostVisible', Player.Name, Player.Character.HumanoidRootPart.Position)
					end
				end
			end
		end)
		pcall(function()
			spawn(function()
				pcall(function()
					for i,v in pairs(Player.Backpack:GetChildren()) do
						if not v:FindFirstChild('OwnerTag') then
							local OwnerTag = Instance.new('ObjectValue', v)
							OwnerTag.Name = 'OwnerTag'
							OwnerTag.Value = Player
						end
					end
					Player.Backpack.ChildAdded:Connect(function(Child)
						if Child:IsA('Tool') then
							if not Child:FindFirstChild('OwnerTag') then
								local OwnerTag = Instance.new('ObjectValue', Child)
								OwnerTag.Name = 'OwnerTag'
								OwnerTag.Value = Player
							end
						end
					end)
				end)
			end)
			spawn(function()
				spawn(function()
					local Weave = Instance.new('Sound', Character:WaitForChild('HumanoidRootPart'))
					Weave.Name = 'Weave'
					Weave.SoundId = 'rbxassetid://231731980'
					Weave.Volume = 0.5
					Weave.Looped = false
					Weave.RollOffMode = Enum.RollOffMode.Inverse
				end)
				local LCUFF = ServerStorage.Storage.Misc.Character.Models.Cuffs.L.CUFF:Clone()
				local RCUFF = ServerStorage.Storage.Misc.Character.Models.Cuffs.L.CUFF:Clone()
				LCUFF.Massless = true
				RCUFF.Massless = true
				local LWELD, RWELD = Instance.new('Weld', LCUFF), Instance.new('Weld', RCUFF)
				LWELD.Part0 = Character:WaitForChild('LeftLowerArm')
				LWELD.Part1 = LWELD.Parent
				RWELD.Part0 = Character:WaitForChild('RightLowerArm')
				RWELD.Part1 = RWELD.Parent
				LCUFF.Parent = Character.LeftLowerArm
				RCUFF.Parent = Character.RightLowerArm
			end)
		end)
		if Player.DataFolder.Officer.Value == 1 then
			pcall(function()
				Character:SetPrimaryPartCFrame(workspace.Ignored.PoliceSpawn.CFrame)
				for i,v in pairs(Character:GetChildren()) do
					if v:IsA('Shirt') or v:IsA('Pants') then
						v:Destroy()
					end
				end
				for i,v in pairs(ServerStorage.Storage.Tools.Misc.Police:GetChildren()) do
					if v:IsA('Tool') then
						v:Clone().Parent = Player.Backpack
					end
				end
				local Shirt = Instance.new('Shirt', Character)
				Shirt.ShirtTemplate = 'rbxassetid://535806099'
				Shirt.Name = 'Shirt'
				local Pants = Instance.new('Pants', Character)
				Pants.PantsTemplate = 'rbxassetid://15224239'
				Pants.Name = 'Pants'
			end)
		end
		if Player.DataFolder.Information:FindFirstChild('Jail') then
			spawn(function()
			local Jail = Player.DataFolder.Information.Jail
			if tonumber(Jail.Value) > 0 then
				pcall(function()
					local JAILLOCATION = workspace.Ignored.JAILLOCATION1.CFrame
					Character:SetPrimaryPartCFrame(JAILLOCATION)
					Character:WaitForChild('BodyEffects').Cuff.Value = true
					Character:WaitForChild('LeftLowerArm').CUFF.Transparency = 0
					Character.LeftLowerArm.CUFF.Mesh.Scale = Character.LeftLowerArm.Size + Vector3.new(0, 0.051996, 0)
					Character:WaitForChild('RightLowerArm').CUFF.Transparency = 0
					Character.RightLowerArm.CUFF.Mesh.Scale = Character.RightLowerArm.Size + Vector3.new(0, 0.051996, 0)
					local Animation = Instance.new('Animation')
						Animation.AnimationId = 'rbxassetid://12884587898'
					local Track = Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(Animation)
					Track:Play()
				end)
				end
				end)
			spawn(function()
				pcall(function()
					local Humanoid = Character:FindFirstChildOfClass('Humanoid')
					while wait(0.1) do
						if not Character then
							break
						end
						if Character.BodyEffects.Cuff.Value == true then
							if Character:FindFirstChildOfClass('Tool') then
								Humanoid:UnequipTools()
							end
						end
					end
				end)
			end)
		end
		if _G.PlayerData.Settings.Tools.Boombox then
			local Boombox = ServerStorage.Storage.Tools.Misc['[Boombox]']:Clone()
			Boombox.Parent = Player.Backpack
		end
		if _G.PlayerData.Settings.Tools.Knife then
			local Knife = ServerStorage.Storage.Tools.Misc['[Knife]']:Clone()
			Knife.Parent = Player.Backpack
		end
		if _G.PlayerData.Settings.Tools.Bat then
			local Bat = ServerStorage.Storage.Tools.Misc['[Bat]']:Clone()
			Bat.Parent = Player.Backpack
		end
		if _G.PlayerData.Settings.Tools.Flashlight then
			local Flashlight = ServerStorage.Storage.Tools.Misc['[Flashlight]']:Clone()
			Flashlight.Parent = Player.Backpack
		end
		if _G.PlayerData.Settings.Tools.Pepperspray then
			local PepperSpray = ServerStorage.Storage.Tools.Misc['[PepperSpray]']:Clone()
			PepperSpray.Parent = Player.Backpack
		end
		if MainModule.CheckInCrew(Player) then
			if Player.DataFolder.Officer.Value ~= 1 then
				local SprayCan = ServerStorage.Storage.Tools.Misc['[SprayCan]']:Clone()
				SprayCan.Parent = Player.Backpack
			end
		end
		for i,v in pairs(workspace.MAP.Graffiti:GetChildren()) do
			if v.Name == Player.Name then
				v:Destroy()
			end
		end
		pcall(function()
			if Player.DataFolder.Information:FindFirstChild('MuscleInformation') then
				local Muscle = tonumber(Player.DataFolder.Information.MuscleInformation.Value)
				local Width = 1 + (Muscle * (1/400/75))
				local Depth = 1 + (Muscle * (1/400/75))
				local Height = 1
				if Muscle > 0 then
					Height = 1 + (Muscle * 0.00002)
				end
				Humanoid.BodyWidthScale.Value = Width
				Humanoid.BodyDepthScale.Value = Depth
				Humanoid.BodyHeightScale.Value = Height
			end
		end)
		spawn(function()
			pcall(function()
				local Chances = 1
				while wait(.1) do
					local Checked = false
					local Checked2 = false
					if Character ~= Player.Character then
						break
					end
					for i,v in pairs(Character:GetChildren()) do
						if v:IsA('Folder') then
							if v.Name == 'BodyEffects' then
								Checked = true
							end
						end
					end
					for i,v in pairs(Character:GetChildren()) do
						if v:IsA('Folder') then
							if v.Name == 'RagdollConstraints' then
								Checked2 = true
							end
						end
					end
					if Checked == true then
						if #Character.BodyEffects:GetChildren() ~= 22 then
							if not Character.BodyEffects:FindFirstChild('Block') then
								Checked = false
							else 
								if #Character.BodyEffects:GetChildren() ~= 23 then
									Checked = false
								end
							end
						end
					end
					if (Checked == false or Checked2 == false) then
						Chances -= 1
						if Chances == 0 then
							Player:Kick('BODY-EFFECTS CHECK: 1')
							break
						end
					end
				end
			end)
		end)
		spawn(function()
			pcall(function()
				while wait(.1) do
					if Character ~= Player.Character then
						break
					end
					if not Character:FindFirstChildOfClass('Humanoid') then
						Player:Kick('o')
						break
					end
				end
			end)
		end)
		if Player.DataFolder.Information:FindFirstChild('Log') then
			if Player.DataFolder.Information.Log.Value == tostring(1) then
				local ResetTools = true
				if Player.DataFolder.Information:FindFirstChild('Jail') then
					local Jail = Player.DataFolder.Information.Jail
					if tonumber(Jail.Value) > 0 then
						ResetTools = false
					end
				end
				Player.DataFolder.Information.Log.Value = tostring(0)
				if ResetTools then
					for i,v in pairs(Player.DataFolder.Inventory:GetChildren()) do
						v.Value = tostring(0)
					end
				end
			end
		end
		for i,v in pairs(Player.DataFolder.Inventory:GetChildren()) do
			if tonumber(v.Value) > 0 then
				if ServerStorage.Storage.Tools.Weapons:FindFirstChild(v.Name) then
					local Weapon = ServerStorage.Storage.Tools.Weapons[v.Name]:Clone()
					local Max = {
						['[Revolver]'] = '[Revolver]',
						['[SMG]'] = '[SMG]'
					}
					if Max[Weapon.Name] then
						Weapon.Ammo.Value = Weapon.MaxAmmo.Value
					else 
						Weapon.Ammo.Value = 0
					end
					Weapon.Parent = Player.Backpack
				end
			end
		end
		if Player.DataFolder.Information:FindFirstChild('ArmorSave') then
			Character:WaitForChild('BodyEffects').Armor.Value = Player.DataFolder.Information.ArmorSave.Value
		end
		Character.BodyEffects.Armor:GetPropertyChangedSignal('Value'):Connect(function()
			pcall(function()
				Player.DataFolder.Information.ArmorSave.Value = Character.BodyEffects.Armor.Value
			end)
		end)
		Character.Parent = workspace.Players
		local LOADED = Instance.new('Folder', Character)
		LOADED.Name = 'FULLY_LOADED_CHAR'
		spawn(function()
			require(ServerStorage.Storage.Misc.Server.Modules.Characters).SetupCharacter(Player.Character)
		end)
	end)


	Player.Chatted:Connect(function(msg)
		if not Player:FindFirstChild('LOAD_SAVE_DATA') then
			return
		end
		if Player.Character then
			if Player.Character:FindFirstChild('BodyEffects') then
				if Player.Character.BodyEffects:FindFirstChild('CallFrom') and Player.Character.BodyEffects:FindFirstChild('Calling') then
					if Player.Character.BodyEffects.CallFrom.Value ~= nil and Player.Character.BodyEffects.Calling.Value ~= false then
						local Player2 = Player.Character.BodyEffects.CallFrom.Value
						if Player2.Character then
							if Player2.Character:FindFirstChild('[Phone]') then
								if Player2.Character:FindFirstChild('BodyEffects') then
									if Player2.Character.BodyEffects:FindFirstChild('Calling') and Player2.Character.BodyEffects:FindFirstChild('CallFrom') and Player2.Character.BodyEffects.Calling.Value ~= false and Player and Player2.Character.BodyEffects.CallFrom.Value == Player then
										local User
										if Player.Character.BodyEffects:FindFirstChild('Anonymous') then
											if Player.Character.BodyEffects.Anonymous.Value == false then
												User = Player.Name
											else 
												User = 'Anonymous'
											end
											pcall(function()
												Chat:Chat(Player2.Character['[Phone]'].Handle, User..': '..Chat:FilterStringForBroadcast(msg, Player), Enum.ChatColor.White)
											end)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if RunService:IsStudio() then 
			if msg:lower() == '/bringall' then
				pcall(function()
					local HRP = Player.Character.HumanoidRootPart
					for i,v in pairs(workspace.Players:GetChildren()) do 
						if v:FindFirstChild('HumanoidRootPart') then
							v.HumanoidRootPart.CFrame = HRP.CFrame
						end
					end
				end)
			end
		end
		if _G.PlayerData.Players[Player].Stats.Permissions.Rank >= 254 then
			if msg:lower() == '/giveguns' then
				pcall(function()
					local Weapons = {
						['[Glock]'] = true, 
						['[Silencer]'] = true, 
						['[Shotgun]'] = true, 
						['[Rifle]'] = true,
						['[SMG]'] = true, 
						['[AR]'] = true, 
						['[RPG]'] = true, 
						['[GrenadeLauncher]'] = true, 
						['[P90]'] = true, 
						['[SilencerAR]'] = true, 
						['[Revolver]'] = true, 
						['[AK47]'] = true, 
						['[TacticalShotgun]'] = true, 
						['[DrumGun]'] = true, 
						['[Flamethrower]'] = true, 
						['[AUG]'] = true, 
						['[LMG]'] = true, 
						['[Double-Barrel SG]'] = true
					}
					for i,v in pairs(Weapons) do 
						if not Player.DataFolder.Inventory:FindFirstChild(i) then
							local Weapon = Instance.new('StringValue', Player.DataFolder.Inventory)
							Weapon.Name = i 
							Weapon.Value = tostring(99999)
						else 
							if tonumber(Player.DataFolder.Inventory[i].Value) > 0 then
								Player.DataFolder.Inventory[i].Value = tostring(0)
							else 
								Player.DataFolder.Inventory[i].Value = tostring(99999)
							end
						end
					end
					Player:LoadCharacter()
				end)
			end
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank >= 254 then
				if msg:lower() == 'shazam!' then
					pcall(function()
						if not Player.Character then
							return
						end
						if not Player.Character.PrimaryPart then
							return
						end
						if not Player.Character:FindFirstChild('LowerTorso') then
							return
						end
						if not Player.Character:FindFirstChildOfClass('Humanoid') then
							return
						end
						local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')
						if not Player.Character.LowerTorso:FindFirstChild('lighting_bolt') then
							local Sound = Instance.new('Sound', Player.Character.LowerTorso)
							Sound.Name = 'lighting_bolt'
							Sound.SoundId = 'rbxassetid://821439273'
							Sound.Volume = 1
							Sound:Play()
						else
							Player.Character.LowerTorso['lighting_bolt']:Play()
						end
						local function Lightning(Character)
							local Lightning = ServerStorage.Storage.Tools.Admin.Powers.Shazam.Lightning:GetChildren()
							local Bolt = Lightning[math.random(1, #Lightning)]:Clone()
							local Orientation = Bolt.PrimaryPart.Orientation
							Bolt:SetPrimaryPartCFrame(CFrame.new(Character.PrimaryPart.Position) * CFrame.Angles(math.rad(Orientation.X), math.rad(Orientation.Y), math.rad(Orientation.Z)))
							Bolt.Parent = Character
							local Tween = TweenService:Create(Bolt.Lightning, TweenInfo.new(1.85, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1})
							Tween:Play()
							Tween.Completed:Connect(function()
								delay(1, function()
									Bolt:Destroy()
								end)
							end)
						end
						if not Player.Backpack:FindFirstChild('Fly') and not Player.Character:FindFirstChild('Fly') then
							Lightning(Player.Character)
							local Outfit = ServerStorage.Storage.Tools.Admin.Powers.Shazam.Outfits.Red
							for i,v in pairs(Player.Character:GetChildren()) do 
								if (v:IsA('Shirt') or v:IsA('Pants')) then
									table.insert(_G.PlayerData.Players[Player].Stats.Permissions.ShazamClothes, {v, v.Parent})
									v.Parent = nil
								end
							end
							for i,v in pairs(Outfit:GetChildren()) do 
								v:Clone().Parent = Player.Character
							end
							Humanoid.MaxHealth = 450

							Humanoid.Health = Humanoid.MaxHealth
							local Fly = ServerStorage.Storage.Tools.Admin.Powers.Shazam.Fly:Clone()
							Fly.Parent = Player.Backpack
						else 
							Lightning(Player.Character)
							Humanoid.MaxHealth = 100
							Humanoid.Health = Humanoid.MaxHealth
							for i,v in pairs(Player.Backpack:GetChildren()) do 
								if v.Name == 'Fly' then
									v:Destroy()
								end
							end
							for i,v in pairs(Player.Character:GetChildren()) do 
								if v.Name == 'Fly' then
									v.Parent = Player.Backpack
								end
								if (v.Name == 'Fly' or v:IsA('Shirt') or v:IsA('Pants'))  then
									v:Destroy()
								end
							end
							for i,v in pairs(_G.PlayerData.Players[Player].Stats.Permissions.ShazamClothes) do 
								v[1].Parent = v[2]
							end
							table.clear(_G.PlayerData.Players[Player].Stats.Permissions.ShazamClothes)
						end
					end)
				end
			end
		end
	end)
end)
Players.PlayerRemoving:Connect(function(Player)
	local Banned = {
		Banned = false,
		Type = 'None'
	}
	SaveData(Player, Banned, 1)
end)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		local Banned = {
			Banned = false,
			Type = 'None'
		}
		SaveData(player, Banned, 2)
	end
end)

local Codes = {
	test = {"Dal Hood", 10000000}
}


ReplicatedStorage.MainEvent.OnServerEvent:Connect(function(Player, Subject, Argument1, Argument2, Argument3)
	if not Player:FindFirstChild('LOAD_SAVE_DATA') then
		return
	end
	if Subject == 'UpdateMousePos' then
		if Player.Character then
			if Player.Character:FindFirstChild('BodyEffects') then
				pcall(function()
					Player.Character.BodyEffects.MousePos.Value = Argument1
				end)
			end
		end
	elseif Subject == "EnterPromoCode" then
		local Code = Argument1
		local codesFolder = game:GetService("HttpService"):JSONDecode(Player.DataFolder.Information.Codes.Value);
		local Table = {}
		Table = codesFolder
		if Code ~= nil then
			if Codes[Code] and not codesFolder[Code] then
				Table[Code] = true;
				Player.DataFolder.Information.Codes.Value = game:GetService("HttpService"):JSONEncode(Table)
				for i,v in pairs(Codes[Code]) do
					local cash = Player.DataFolder.Currency
					print(v)
					cash.Value += v
				end
			end
		end
		return;
	elseif Subject == 'EquipWeaponSkins' then
		if Player.DataFolder.Information:FindFirstChild('WeaponSkins') then
			if Player.DataFolder.Information.WeaponSkins.Value ~= '' then
				local Skins = HttpService:JSONDecode(Player.DataFolder.Information.WeaponSkins.Value)
				if Skins[Argument1] then
					if Skins[Argument1][Argument2] == true then
						local Equipped
						local Table = {}
						if not Player.DataFolder.Information:FindFirstChild('EquipSkins') then
							Equipped = Instance.new('StringValue', Player.DataFolder.Information)
							Equipped.Name = 'EquipSkins'
						else 
							Equipped = Player.DataFolder.Information.EquipSkins
							Table = HttpService:JSONDecode(Equipped.Value)
						end
						if Table[Argument1] == Argument2 then
							Table[Argument1] = false
						else 
							Table[Argument1] = Argument2
						end
						Table = HttpService:JSONEncode(Table)
						Equipped.Value = Table 
						ReplicatedStorage.MainEvent:FireClient(Player, 'UpdateEquip')
					end
				end
			end
		end
	elseif Subject == 'EquipStompFX' then
		if Player.DataFolder.Information:FindFirstChild('StompFX') then
			if Player.DataFolder.Information.SavedStomps.Value ~= '' then
				local SavedStomps = HttpService:JSONDecode(Player.DataFolder.Information.SavedStomps.Value)
				for i,v in SavedStomps do
					if v == Argument1 then
						local StompFX
						local Table = {}
						local StarterTable = {"Regular"}
						if not Player.DataFolder.Information:FindFirstChild('SavedStomps') then
							StompFX = Instance.new('StringValue', Player.DataFolder.Information)
							StompFX.Name = 'SavedStomps'		
							StompFX.Value = HttpService:JSONEncode(StarterTable)
						else
							StompFX = Player.DataFolder.Information.StompFX
							StompFX.Value = Argument1
						end
						StompFX.Value = Argument1
						ReplicatedStorage.MainEvent:FireClient(Player, 'UpdateStomp')
					end
				end
			end
		end
	elseif Subject == 'Reload' then

		pcall(function()
			local Reloads = {
				['[RPG]'] = 1,
				['[Flamethrower]'] = 1,
				['[GrenadeLauncher]'] = 1,
				['[Rifle]'] = {
					Reload = 1,
					Type = 'Speed'
				},
				['[Revolver]'] = 1,
				['[Double-Barrel SG]'] = 1.5,
				['[AK47]'] = 1,
				['[AR]'] = 1,
				['[AUG]'] = 1,
				['[Glock]'] = 1,
				['[Silencer]'] = 1,
				['[DrumGun]'] = 1,
				['[LMG]'] = 1,
				['[TacticalShotgun]'] = {
					Reload = 1,
					Type = 'Multi'
				},
				['[Shotgun]'] = {
					Reload = 1,
					Type = 'Multi'
				},
				['[P90]'] = 1,
				['[SMG]'] = 1,
				['[SilencerAR]'] = 1
			}
			if Argument1:IsA('Tool') then
				if Argument1:FindFirstChild('Ammo') then
					if Argument1:IsDescendantOf(Player.Character) then
						if Argument1.Ammo.Value ~= Argument1.MaxAmmo.Value then
							if Reloads[Argument1.Name] and Player.DataFolder.Inventory:FindFirstChild(Argument1.Name) then
								if Player.Character then
									if Player.Character:FindFirstChildOfClass('Humanoid') and Player.Character:FindFirstChild('BodyEffects') and Player.Character.BodyEffects:FindFirstChild('Reload') and Player.Character.BodyEffects:FindFirstChild('K.O') then
										if tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) >= Argument1.MaxAmmo.Value then
											if Player.Character.BodyEffects.Reload.Value ~= false then
												return
											end
											if Player.Character.BodyEffects['K.O'].Value ~= false then
												return
											end
											if Player.Character.BodyEffects.Cuff.Value ~= false then
												return
											end
											if Player.Character.BodyEffects.Attacking.Value ~= false then
												return
											end
											if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') then
												return
											end
											if Player.Character.BodyEffects.Grabbed.Value ~= nil then
												return
											end
											if typeof(Reloads[Argument1.Name]) ~= 'table' then
												local anim = Instance.new('Animation')
												anim.AnimationId = 'rbxassetid://12884580623'
												local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
												track:Play(0.100000001, 1, 0.4)
												Player.Character.BodyEffects.Reload.Value = true
												task.wait(Reloads[Argument1.Name])
												pcall(function()
													wait(0.3)
													Player.Character.BodyEffects.Reload.Value = false
													Player.DataFolder.Inventory[Argument1.Name].Value = tostring(tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) - math.min(Argument1.MaxAmmo.Value - Argument1.Ammo.Value, Argument1.MaxAmmo.Value))
													Argument1.Ammo.Value = Argument1.MaxAmmo.Value
												end)
											else 
												if Reloads[Argument1.Name].Type == 'Multi' then
													local Ammo = math.min(Argument1.MaxAmmo.Value - Argument1.Ammo.Value, Argument1.MaxAmmo.Value)
													Player.Character.BodyEffects.Reload.Value = true
													for i = 1,Ammo do 
														pcall(function()
															local anim = Instance.new('Animation')
															anim.AnimationId = 'rbxassetid://12884575752'
															local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
															track:Play()
															track.Stopped:Wait()
														end)
													end
													pcall(function()
														Player.Character.BodyEffects.Reload.Value = false
														Player.DataFolder.Inventory[Argument1.Name].Value = tostring(tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) - math.min(Argument1.MaxAmmo.Value - Argument1.Ammo.Value, Argument1.MaxAmmo.Value))
														Argument1.Ammo.Value = Argument1.MaxAmmo.Value
													end)
												else 
													if Reloads[Argument1.Name].Type == 'Speed' then
														local anim = Instance.new('Animation')
														anim.AnimationId = 'rbxassetid://12884580623'
														local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
														track:Play()
														Player.Character.BodyEffects.Reload.Value = true
														task.wait(Reloads[Argument1.Name].Reload)
														pcall(function()
															Player.Character.BodyEffects.Reload.Value = false
															Player.DataFolder.Inventory[Argument1.Name].Value = tostring(tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) - math.min(Argument1.MaxAmmo.Value - Argument1.Ammo.Value, Argument1.MaxAmmo.Value))
															Argument1.Ammo.Value = Argument1.MaxAmmo.Value
														end)
													end
												end
											end
										else
											if tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) > 0 then
												if Player.Character.BodyEffects.Reload.Value ~= false then
													return
												end
												if Player.Character.BodyEffects['K.O'].Value ~= false then
													return
												end
												if Player.Character.BodyEffects.Cuff.Value ~= false then
													return
												end
												if Player.Character.BodyEffects.Attacking.Value ~= false then
													return
												end
												if Player.Character:FindFirstChild('GRABBING_CONSTRAINT') then
													return
												end
												if Player.Character.BodyEffects.Grabbed.Value ~= nil then
													return
												end
												if typeof(Reloads[Argument1.Name]) ~= 'table' then
													local anim = Instance.new('Animation')
													anim.AnimationId = 'rbxassetid://12884580623'
													local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
													track:Play(0.100000001, 1, 0.5)
													Player.Character.BodyEffects.Reload.Value = true
													task.wait(Reloads[Argument1.Name])
													pcall(function()
														Player.Character.BodyEffects.Reload.Value = false
														local Leftover = 0
														local Ammo = Argument1.Ammo.Value
														if (Ammo + tonumber(Player.DataFolder.Inventory[Argument1.Name].Value)) > Argument1.MaxAmmo.Value then
															Leftover = (Ammo + tonumber(Player.DataFolder.Inventory[Argument1.Name].Value)) - Argument1.MaxAmmo.Value
															Argument1.Ammo.Value = Argument1.MaxAmmo.Value
														else 
															Argument1.Ammo.Value = tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) + Ammo
														end
														Player.DataFolder.Inventory[Argument1.Name].Value = tostring(Leftover)
													end)
												else 
													if Reloads[Argument1.Name].Type == 'Multi' then
														local Ammo = math.min(Argument1.MaxAmmo.Value - Argument1.Ammo.Value, tonumber(Player.DataFolder.Inventory[Argument1.Name].Value))
														Player.Character.BodyEffects.Reload.Value = true
														for i = 1,Ammo do 
															pcall(function()
																local anim = Instance.new('Animation')
																anim.AnimationId = 'rbxassetid://12884575752'
																local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
																track:Play()
																track.Stopped:Wait()
															end)
														end
														pcall(function()
															Player.Character.BodyEffects.Reload.Value = false
															if (Argument1.Ammo.Value + Player.DataFolder.Inventory[Argument1.Name].Value) > Argument1.MaxAmmo.Value then
																Argument1.Ammo.Value = Argument1.MaxAmmo.Value
																Player.DataFolder.Inventory[Argument1.Name].Value = tostring(tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) - Ammo)
															else 
																Argument1.Ammo.Value += Ammo 
																Player.DataFolder.Inventory[Argument1.Name].Value = tostring(0)
															end
														end)
													else 
														if Reloads[Argument1.Name].Type == 'Speed' then
															local anim = Instance.new('Animation')
															anim.AnimationId = 'rbxassetid://12884575752'
															local track = Player.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(anim)
															track:Play()
															Player.Character.BodyEffects.Reload.Value = true
															task.wait(Reloads[Argument1.Name].Reload)
															pcall(function()
																Player.Character.BodyEffects.Reload.Value = false
																local Leftover = 0
																local Ammo = Argument1.Ammo.Value
																if (Ammo + tonumber(Player.DataFolder.Inventory[Argument1.Name].Value)) > Argument1.MaxAmmo.Value then
																	Leftover = (Ammo + tonumber(Player.DataFolder.Inventory[Argument1.Name].Value)) - Argument1.MaxAmmo.Value
																	Argument1.Ammo.Value = Argument1.MaxAmmo.Value
																else 
																	Argument1.Ammo.Value = tonumber(Player.DataFolder.Inventory[Argument1.Name].Value) + Ammo
																end
																Player.DataFolder.Inventory[Argument1.Name].Value = tostring(Leftover)
															end)
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)

	elseif Subject == 'DropMoney' then
		if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
		end
		if _G.PlayerData.Players[Player].Debounces.Currency.Drop ~= false then
			return
		end
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				_G.PlayerData.Players[Player].Debounces.Currency.Drop = true
				delay(10,function()
					_G.PlayerData.Players[Player].Debounces.Currency.Drop = false
					end)
				end
		end)
		pcall(function()
			if Player.Character.BodyEffects.Cuff.Value ~= false then
				return
			end
			if Argument1 then
				if tonumber(Argument1) then
					local Cash = math.floor(tonumber(Argument1))
					if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 and Cash >= 100 and Cash <= 10000 or _G.PlayerData.Players[Player].Stats.Permissions.Rank >= 40 and Cash >= 100 and Cash <= 2500000 then
						if Player.Character then
							ServerStorage.Storage.Misc.Server.BindableEvents.SpawnCash:Invoke(Player, 'Paid', Player.Character.Head.CFrame, Vector3.new(0, 5, 0), Cash)
						end
					end
				end
			end
		end)
	elseif Subject == 'AnimationPack' then
		if _G.PlayerData.Players[Player].Debounces.Action.Emote ~= false then
			return
		end
		pcall(function()
			spawn(function()
				_G.PlayerData.Players[Player].Debounces.Action.Emote = true
				wait(1)
				_G.PlayerData.Players[Player].Debounces.Action.Emote = false
			end)
		end)
		local Animations = {
			['Dance2'] = 'rbxassetid://12884554963',
			['Lean'] = 'rbxassetid://12884556588',
			['Lay'] = 'rbxassetid://12884558522',
			['Dance1'] = 'rbxassetid://12884560999',
			['Greet'] = 'rbxassetid://12884564158',
			['Praying'] = 'rbxassetid://12884566598',
			['Chest Pump'] = 'rbxassetid://12884569878'
		}
		if Animations[Argument1] then
			local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')
			local Animation = Instance.new('Animation')
			Animation.AnimationId = Animations[Argument1]
			pcall(function()
				local AnimationTrack = Humanoid:LoadAnimation(Animation)
				AnimationTrack:Play()
				local Connection
				Connection = Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(function()
					if AnimationTrack.IsPlaying then
						AnimationTrack:Stop()
						Connection:Disconnect()
					end
				end)
			end)
		end

	elseif Subject == 'REPORT_PLAYER' then
		if _G.PlayerData.Players[Player].Debounces.Reports.Reporting ~= false then
			return
		end
		spawn(function()
			_G.PlayerData.Players[Player].Debounces.Reports.Reporting = true
			wait(6)
			pcall(function()
				_G.PlayerData.Players[Player].Debounces.Reports.Reporting = false
			end)
		end)
		pcall(function()
			if Argument1.DataFolder.Information:FindFirstChild('REPORT_TIMES') then
				ReplicatedStorage.MainEvent:FireClient(Player, 'ReportSent')
			else
				local REPORT_TIMES = Instance.new('StringValue', Argument1.DataFolder.Information)
				REPORT_TIMES.Name = 'REPORT_TIMES'
				ReplicatedStorage.MainEvent:FireClient(Player, 'ReportSent')
			end
		end)
	elseif Subject == 'ShootButton' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Misc.Data.IS_MOBILE == false then
				return
			end
			if Player.Character:FindFirstChildOfClass('Tool') then
				local Tool = Player.Character:FindFirstChildOfClass('Tool')
				local Automatics = {
					['[Flamethrower]'] = true,
					['[AK47]'] = true,
					['[AR]'] = true,
					['[AUG]'] = true,
					['[DrumGun]'] = true,
					['[LMG]'] = true,
					['[P90]'] = true,
					['[SMG]'] = true,
					['[SilencerAR]'] = true
				}
				if Automatics[Tool.Name] == true then
					Tool:Activate()
				end
			end
		end)
	elseif Subject == 'ChargeButton' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Misc.Data.IS_MOBILE == false then
				return
			end
			if Player.Character:FindFirstChildOfClass('Tool') then
				local Tool = Player.Character:FindFirstChildOfClass('Tool')
				local Melees = {
					['Combat'] = true,
					['[Pitchfork]'] = true,
					['[Knife]'] = true,
					['[Bat]'] = true,
					['[Shovel]'] = true,
					['[SledgeHammer]'] = true,
					['[StopSign]'] = true
				}
				if Melees[Tool.Name] == true then
					Tool:Activate()
				end
			end
		end)
	elseif Subject == 'IS_MOBILE' then
		if Argument1 == (false or true) then
			if _G.PlayerData.Players[Player].Stats.Misc.Data.DeviceChosen == false then
				_G.PlayerData.Players[Player].Stats.Misc.Data.DeviceChosen = true
				_G.PlayerData.Players[Player].Stats.Misc.Data.IS_MOBILE = Argument1
			end
		end
	elseif Subject == 'JoinCrew' then
		pcall(function()
			if typeof(Argument1) ~= 'string' then
				return
			end
			if not MainModule.CheckInCrew(Player) then
				if Player:IsInGroup(tonumber(Argument1)) then
					local Crew
					if not Player.DataFolder.Information:FindFirstChild('Crew') then
						Crew = Instance.new('StringValue', Player.DataFolder.Information)
						Crew.Name = 'Crew'
					else 
						Crew = Player.DataFolder.Information['Crew']
					end
					Crew.Value = Argument1:gsub('%s+', '')
					ReplicatedStorage.MainEvent:FireClient(Player, 'updateCrewStuff')
					if not Player.Backpack:FindFirstChild('[SprayCan]') and not Player.Character:FindFirstChild('[SprayCan]') then
						local SprayCan = ServerStorage.Storage.Tools.Misc['[SprayCan]']:Clone()
						SprayCan.Parent = Player.Backpack
					end
				end
			end
		end)
	elseif Subject == 'LeaveCrew' then
		pcall(function()
			if MainModule.CheckInCrew(Player) then
				if Player.DataFolder.Information:FindFirstChild('Crew') then
					Player.DataFolder.Information.Crew.Value = ''
				end
			end
		end)
	elseif Subject == 'TimerMoney' then
		pcall(function()
			if tick() - _G.PlayerData.Players[Player].Stats.Misc.Data.LastPaycheck >= 358 then
				_G.PlayerData.Players[Player].Stats.Misc.Data.LastPaycheck = tick()
				if Player.DataFolder.Officer.Value ~= 1 then
					Player.DataFolder.Currency.Value += 100
				else 
					Player.DataFolder.Currency.Value += 300
				end
			end
		end)
	elseif Subject == 'AirPlaneMode' then
		pcall(function()
			local AirPlaneMode
			if not Player.DataFolder.Information:FindFirstChild('AirPlaneMode') then
				AirPlaneMode = Instance.new('StringValue', Player.DataFolder.Information)
				AirPlaneMode.Name = 'AirPlaneMode'
				AirPlaneMode.Value = '0'
			end
			AirPlaneMode = Player.DataFolder.Information['AirPlaneMode']
			if AirPlaneMode.Value == '0' then
				AirPlaneMode.Value = '1'
			else 
				AirPlaneMode.Value = '0'
			end
		end)
	elseif Subject == 'AnonymousMode' then
		pcall(function()
			if Player.Character then
				if Player.Character:FindFirstChild('BodyEffects') then
					if Player.Character.BodyEffects:FindFirstChild('Anonymous') then
						Player.Character.BodyEffects.Anonymous.Value = not Player.Character.BodyEffects.Anonymous.Value
					end
				end
			end
		end)
	elseif Subject == 'RingTone' then
		pcall(function()
			if tonumber(Argument1) then
				local RingToneId
				if not Player.DataFolder.Information:FindFirstChild('RingToneId') then
					RingToneId = Instance.new('StringValue', Player.DataFolder.Information)
					RingToneId.Name = 'RingToneId'
				end
				RingToneId = Player.DataFolder.Information['RingToneId']
				RingToneId.Value = tostring(Argument1)
			end
		end)
	elseif Subject == 'PhoneCall' then
		pcall(function()
			if _G.PlayerData.Players[Player].Debounces.Calling.Calling ~= false then
				return
			end
			spawn(function()
				_G.PlayerData.Players[Player].Debounces.Calling.Calling = true
				wait(1)
				pcall(function()
					_G.PlayerData.Players[Player].Debounces.Calling.Calling = false
				end)
			end)
			if Players:FindFirstChild(Argument1) then
				local Player2 = Players[Argument1]
				if Player2 == Player then
					return
				end
				if not Player2:FindFirstChild('LOAD_SAVE_DATA') then
					return
				end
				if Player2.Character.BodyEffects.CallFrom.Value ~= nil then
					return
				end
				if Player.Character then
					if Player.Character.BodyEffects.Calling.Value == true then
						return
					end
					if Player2.DataFolder.Information:FindFirstChild('AirPlaneMode') then
						if Player2.DataFolder.Information.AirPlaneMode.Value == '1' then
							if Player.Character:FindFirstChild('[Phone]') then
								Chat:Chat(Player.Character['[Phone]'].Handle, '*Couldn\'t reach this number*', Enum.ChatColor.Red)
							end
							return
						end
					end
					if Player2.Character and Player2.Character:FindFirstChild('BodyEffects') and Player2.Character.BodyEffects:FindFirstChild('Calling') and Player2.Character.BodyEffects:FindFirstChild('CallFrom') then
						if Player2.DataFolder.Information:FindFirstChild('RingToneId') then
							local Ringtone = Player2.DataFolder.Information.RingToneId.Value
							local PhoneRing
							if not Player2.Character.LowerTorso:FindFirstChild('PhoneRing') then
								PhoneRing = Instance.new('Sound', Player2.Character.LowerTorso)
								PhoneRing.Name = 'PhoneRing'
								PhoneRing.MaxDistance = 200
								PhoneRing.Looped = false
								PhoneRing.RollOffMode = Enum.RollOffMode.Inverse 
								PhoneRing.SoundId = 'rbxassetid://'..Ringtone
							end
							PhoneRing = Player2.Character.LowerTorso['PhoneRing']
							PhoneRing:Play()
						else 
							local PhoneRing
							if not Player2.Character.LowerTorso:FindFirstChild('PhoneRing') then
								PhoneRing = Instance.new('Sound', Player2.Character.LowerTorso)
								PhoneRing.Name = 'PhoneRing'
								PhoneRing.MaxDistance = 200
								PhoneRing.Looped = false
								PhoneRing.RollOffMode = Enum.RollOffMode.Inverse 
								PhoneRing.SoundId = 'rbxassetid://3361958675'
							end
							PhoneRing = Player2.Character.LowerTorso['PhoneRing']
							PhoneRing:Play()
						end
						Player.Character.BodyEffects.Calling.Value = true
						Player2.Character.BodyEffects.CallFrom.Value = Player
						local Count = 20
						while wait(0.1) do
							if not Player then
								break
							end
							Count -= 0.1
							if Player2 then
								if Player2.Character then
									if Player2.Character:FindFirstChild('BodyEffects') and Player2.Character.BodyEffects:FindFirstChild('CallFrom') then
										if Player2.Character.BodyEffects.CallFrom.Value ~= Player then
											break
										end
									else 
										break
									end
								else 
									break
								end
							else 
								break
							end
							if Count <= 0 then
								break
							end
						end
						pcall(function()
							if Player.Character.BodyEffects.Calling.Value == true then
								if Player2 then
									if Player2.Character then
										if Player2.Character.BodyEffects.CallFrom.Value == Player then
											Player.Character.BodyEffects.Calling.Value = false
											Player2.Character.BodyEffects.CallFrom.Value = nil
										else 
											Player.Character.BodyEffects.Calling.Value = false
										end
									else 
										Player.Character.BodyEffects.Calling.Value = false
									end
								else 
									Player.Character.BodyEffects.Calling.Value = false
								end
							end
						end)
					end
				end
			end
		end)
	elseif Subject == 'Grabbing' then
		pcall(function()
			local Character = Player.Character
			local Humanoid = Character:FindFirstChildOfClass('Humanoid')
			local BodyEffects = Character.BodyEffects
			if BodyEffects.Cuff.Value ~= false then
				return
			end
			if BodyEffects.Grabbed.Value == nil then
				local result = workspace:FindPartOnRayWithIgnoreList(Ray.new(Player.Character.LowerTorso.Position, Vector3.new(0, -Player.Character.UpperTorso.Size.y * 4.5, 0)), { Player.Character, unpack(require(ReplicatedStorage.MainModule).Ignored) })
				if not result then
					return
				end
				local Humanoid2 = result.Parent:FindFirstChildOfClass('Humanoid') or result.Parent.Parent:FindFirstChildOfClass('Humanoid') or result.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')
				if not Humanoid2 then
					return
				end
				local Plr = Players:GetPlayerFromCharacter(Humanoid.Parent)
				if not Plr then
					return
				end
				if BodyEffects.Attacking.Value ~= false then
					return
				end
				if BodyEffects['K.O'].Value ~= false then
					return
				end
				if Character:FindFirstChild('GRABBING_CONSTRAINT') then
					return
				end
				local Character2 = Humanoid2.Parent
				if Character2:FindFirstChild('GRABBING_CONSTRAINT') then
					return
				end
				if Character2.BodyEffects['K.O'].Value ~= true then
					return
				end
				if Character2.BodyEffects.Dead.Value ~= false then
					return
				end
				BodyEffects.Grabbed.Value = Character2
				local NoCollisionConstraints = {
					[1] = {
						Part0 = Character2.UpperTorso,
						Part1 = Character.LowerTorso
					},
					[2] = {
						Part0 = Character2.LowerTorso,
						Part1 = Character.LowerTorso
					},
					[3] = {
						Part0 = Character2.Head,
						Part1 = Character.LowerTorso
					},
					[4] = {
						Part0 = Character2.HumanoidRootPart,
						Part1 = Character.UpperTorso
					},
					[5] = {
						Part0 = Character2.UpperTorso,
						Part1 = Character.UpperTorso
					},
					[6] = {
						Part0 = Character2.LowerTorso,
						Part1 = Character.UpperTorso
					},
					[7] = {
						Part0 = Character2.Head,
						Part1 = Character.UpperTorso
					},
					[8] = {
						Part0 = Character2.HumanoidRootPart,
						Part1 = Character.HumanoidRootPart
					},
					[9] = {
						Part0 = Character2.UpperTorso,
						Part1 = Character.HumanoidRootPart
					},
					[10] = {
						Part0 = Character2.LowerTorso,
						Part1 = Character.HumanoidRootPart
					},
					[11] = {
						Part0 = Character2.Head,
						Part1 = Character.HumanoidRootPart
					},
					[12] = {
						Part0 = Character2.Head,
						Part1 = Character.HumanoidRootPart
					},
					[13] = {
						Part0 = Character2.HumanoidRootPart,
						Part1 = Character.Head
					},
					[14] = {
						Part0 = Character2.UpperTorso,
						Part1 = Character.Head
					},
					[15] = {
						Part0 = Character2.LowerTorso,
						Part1 = Character.Head
					},
					[16] = {
						Part0 = Character2.Head,
						Part1 = Character.Head
					}
				}
				local MainNCS = Instance.new('NoCollisionConstraint', Character2.HumanoidRootPart)
				MainNCS.Name = 'NoCollisionConstraint_HOLD'
				MainNCS.Part0 = Character2.HumanoidRootPart
				MainNCS.Part1 = Character.LowerTorso
				for i,v in pairs(NoCollisionConstraints) do 
					local NoCollisionConstraint = Instance.new('NoCollisionConstraint', MainNCS)
					NoCollisionConstraint.Name = 'NoCollisionConstraint_HOLD'
					NoCollisionConstraint.Part0 = v.Part0
					NoCollisionConstraint.Part1 = v.Part1
				end
				local GRABBING_CONSTRAINT = Instance.new('Weld', Character2)
				GRABBING_CONSTRAINT.Name = 'GRABBING_CONSTRAINT'
				GRABBING_CONSTRAINT.Part0 = Character.UpperTorso
				GRABBING_CONSTRAINT.Part1 = Character2.HumanoidRootPart
				GRABBING_CONSTRAINT.C0 = CFrame.new(-0.713337958, 1.41927958, 1.01924765, 1, -0, 0, 0, 0.965929627, 0.258804798, -0, -0.258804798, 0.965929627)
				GRABBING_CONSTRAINT.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				local Position = Character.PrimaryPart.CFrame
				Humanoid2.PlatformStand = true
				Character.PrimaryPart.CFrame = Position
				if Character2.HumanoidRootPart.Anchored == true then
					Character2.HumanoidRootPart.Anchored = false
				end
				for i,v in pairs(Character2:GetChildren()) do
					if v:IsA('MeshPart') or v:IsA('Part') then
						v:SetNetworkOwner(Player)
						v.Massless = true
					end
				end
				for i,v in pairs(Character2.BodyEffects.SpecialParts:GetChildren()) do
					if v:IsA('MeshPart') or v:IsA('Part') then
						v:SetNetworkOwner(Player)
					end
				end				
				-- Pick Up / Grab
				local Pickup = Instance.new('Animation')
				Pickup.AnimationId = 'rbxassetid://12884549784'
				local Grabbing = Instance.new('Animation')
				Grabbing.AnimationId = 'rbxassetid://12884547043'
				local Grabbed = Instance.new('Animation')
				Grabbed.AnimationId = 'rbxassetid://12884545151'
				local Track1 = Humanoid:LoadAnimation(Grabbing)
				local Track2 = Humanoid2:LoadAnimation(Grabbed)
				local Track3 = Humanoid:LoadAnimation(Pickup)
				Track3:Play()
				Track3:AdjustSpeed(2)
				Track1:Play()
				Track2:Play()
				spawn(function()
					pcall(function()
						while wait(1) do
							if (not Character:IsDescendantOf(workspace)) then
								pcall(function()
									for i,v in pairs(Humanoid2:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbed.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Character2:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
											pcall(function()
												v.Massless = false
											end)
										end
									end
									for i,v in pairs(Character2.BodyEffects.SpecialParts:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
										end
									end
								end)
								pcall(function()
									if MainNCS:IsDescendantOf(workspace) then
										MainNCS:Destroy()
									end
									if GRABBING_CONSTRAINT:IsDescendantOf(workspace) then
										GRABBING_CONSTRAINT:Destroy()
									end
								end)
								break
							end
							if (BodyEffects['K.O'].Value ~= false) then
								pcall(function()
									for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbing.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Humanoid2:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbed.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Character2:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
											pcall(function()
												v.Massless = false
											end)
										end
									end
									for i,v in pairs(Character2.BodyEffects.SpecialParts:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
										end
									end
								end)
								pcall(function()
									if MainNCS:IsDescendantOf(workspace) then
										MainNCS:Destroy()
									end
									if GRABBING_CONSTRAINT:IsDescendantOf(workspace) then
										GRABBING_CONSTRAINT:Destroy()
									end
								end)
								BodyEffects.Grabbed.Value = nil 
								break
							end
							if (not Character2:IsDescendantOf(workspace)) then
								for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do 
									if v.Animation.AnimationId == Grabbing.AnimationId then
										v:Stop()
									end
								end
								BodyEffects.Grabbed.Value = nil
								break
							end
							if (Humanoid2.Health >= 45) then
								pcall(function()
									for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbing.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Humanoid2:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbed.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Character2:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
											pcall(function()
												v.Massless = false
											end)
										end
									end
									for i,v in pairs(Character2.BodyEffects.SpecialParts:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											pcall(function()
												v.Anchored = false
											end)
											pcall(function()
												v:SetNetworkOwner(Plr)
											end)
										end
									end
								end)
								pcall(function()
									if MainNCS:IsDescendantOf(workspace) then
										MainNCS:Destroy()
									end
									if GRABBING_CONSTRAINT:IsDescendantOf(workspace) then
										GRABBING_CONSTRAINT:Destroy()
									end
								end)
								BodyEffects.Grabbed.Value = nil 
								break
							end
							if not GRABBING_CONSTRAINT:IsDescendantOf(workspace) then
								pcall(function()
									for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbing.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Humanoid2:GetPlayingAnimationTracks()) do 
										if v.Animation.AnimationId == Grabbed.AnimationId then
											v:Stop()
										end
									end
								end)
								pcall(function()
									for i,v in pairs(Character2:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											if v.Anchored ~= true then
												v:SetNetworkOwner(Plr)
												v.Massless = false
											end
										end
									end
									for i,v in pairs(Character2.BodyEffects.SpecialParts:GetChildren()) do
										if v:IsA('MeshPart') or v:IsA('Part') then
											if v.Anchored ~= true then
												pcall(function()
													v:SetNetworkOwner(Plr)
												end)
											end
										end
									end
								end)
								pcall(function()
									if MainNCS:IsDescendantOf(workspace) then
										MainNCS:Destroy()
									end
								end)
								BodyEffects.Grabbed.Value = nil 
								break
							end
						end
					end)
				end)
			else 
				pcall(function()
					local Character2 = BodyEffects.Grabbed.Value
					if Argument1 == false then
						if Character2:FindFirstChild('GRABBING_CONSTRAINT') then
							Character2.GRABBING_CONSTRAINT:Destroy()
						end
					else 
						if Character2:FindFirstChild('GRABBING_CONSTRAINT') then
							local Animation = Instance.new('Animation')
							Animation.AnimationId = 'rbxassetid://12884541573'
							local HOSTAGE_THROWN = Character.Humanoid:LoadAnimation(Animation)
							HOSTAGE_THROWN:Play(0.100000001, 1, 2.7)
							local BodyVelocity = Instance.new('BodyVelocity')
							BodyVelocity.MaxForce = Vector3.new(3723272, 236271, 7246232)
							BodyVelocity.Velocity = Character.HumanoidRootPart.CFrame.LookVector * 25 + Vector3.new(0, 50, 0)
							BodyVelocity.Name = 'HOSTAGE_THROWN'
							if math.random(1, 2) == 1 then
								BodyVelocity.Parent = Character2.UpperTorso
							else
								BodyVelocity.Parent = Character2.LowerTorso
							end
							Character2.GRABBING_CONSTRAINT:Destroy()
							delay(0.2, function()
								if Character2 then
									BodyVelocity:Destroy()
								end
							end)
						end
					end
				end)
			end
		end)
	elseif Subject == 'Boombox' then
		pcall(function()
			if tonumber(Argument1) then
				if not Player.Character.LowerTorso:FindFirstChild('BOOMBOXSOUND') then
					local BOOMBOXSOUND = Instance.new('Sound', Player.Character.LowerTorso)
					BOOMBOXSOUND.Name = 'BOOMBOXSOUND'
					BOOMBOXSOUND.MaxDistance = 500
					BOOMBOXSOUND.Looped = true
					BOOMBOXSOUND.RollOffMode = Enum.RollOffMode.Inverse 
					BOOMBOXSOUND.SoundId = 'rbxassetid://'..tostring(Argument1)
					BOOMBOXSOUND:Play()
				else 
					Player.Character.LowerTorso.BOOMBOXSOUND.SoundId = 'rbxassetid://'..tostring(Argument1)
					Player.Character.LowerTorso.BOOMBOXSOUND:Play()
				end
			end
		end)
	elseif Subject == 'BoomboxStop' then
		pcall(function()
			if Player.Character.LowerTorso:FindFirstChild('BOOMBOXSOUND') then
				Player.Character.LowerTorso.BOOMBOXSOUND:Stop()
			end
		end)
	elseif Subject == 'TimerDecrease' then 
		pcall(function()
			if Player.DataFolder.Information:FindFirstChild('Jail') then
				local HRP = Player.Character.HumanoidRootPart
				local Jail = Player.DataFolder.Information.Jail 
				local Location = workspace.Ignored.JAILLOCATION1
				if (HRP.Position - Location.Position).magnitude >= ReplicatedStorage.JailRadius.Value then
					return
				end
				if tonumber(Jail.Value) > 0 then
					if tick() - _G.PlayerData.Players[Player].Stats.Misc.Data.TimerDecrease >= 1 then
						_G.PlayerData.Players[Player].Stats.Misc.Data.TimerDecrease = tick()
						Jail.Value = tostring(tonumber(Jail.Value) - 1)
						if Jail.Value == tostring(0) then
							Player:LoadCharacter()
						end
					end
				end
			end
		end)
	elseif Subject == 'UNCUFF' then
		pcall(function()
			if Player.DataFolder.Information:FindFirstChild('Jail') then
				local Jail = Player.DataFolder.Information.Jail
				if Player.Character.BodyEffects.Cuff.Value == true then
					if tonumber(Jail.Value) <= 0 then
						Player.Character.BodyEffects.Cuff.Value = false
						Player:LoadCharacter()
					end
				end
			end
		end)
	elseif Subject == 'Block' then
		pcall(function()
			if Argument1 == false then
				for i,v in pairs(Player.Character.BodyEffects:GetChildren()) do 
					if v.Name == 'Block' then
						v:Destroy()
					end
				end
			elseif Argument1 == true then
				if not Player.Character.BodyEffects:FindFirstChild('Block') then
					MainModule.Block(Player.Character.BodyEffects, 'Block', 0)
					local Tick = Player.Character.BodyEffects.Defense.CurrentTimeBlock.Value
					Player.Character.BodyEffects.Defense.CurrentTimeBlock.Value = tick()
					if Tick ~= 0 then
						local Energy = (tick() - Tick)/2
						if (Player.Character.BodyEffects.Defense.Value + Energy) < 100 then
							Player.Character.BodyEffects.Defense.Value += Energy
						else 
							Player.Character.BodyEffects.Defense.Value = 100
						end
					end
				end
			end
		end)
	elseif Subject == 'GunCombatToggle' then
		pcall(function()
			if (Argument1 == false or Argument1 == true) then
				_G.PlayerData.Players[Player].Stats.Misc.Data.GUN_CLOSE_COMBAT = Argument1
			end
		end)
	elseif Subject == 'BANREMOTE' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			if _G.PlayerData.Players[Argument1].Stats.Permissions.Rank >= 40 and Argument1 ~= Player and _G.PlayerData.Players[Player].Stats.Permissions.Rank < 255 then
				return
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.BanCooldown < 10 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.BanCooldown = tick()
			if Argument1:FindFirstChild('LOAD_SAVE_DATA') then
				if Argument1.DataFolder.Information:FindFirstChild('Jail') then
					if tonumber(Argument1.DataFolder.Information.Jail.Value) > 250 then
						return
					end
					Argument1.DataFolder.Information.Jail.Value = tostring(99999999)
					Argument1.DataFolder.Officer.Value = 0
				else 
					local Jail = Instance.new('StringValue', Argument1.DataFolder.Information)
					Jail.Name = 'Jail'
					Jail.Value = tostring(99999999)
				end
				local Webhook = Webhooks.BanLogs[1]
				pcall(function()
					HttpService:PostAsync(Webhook, HttpService:JSONEncode(
						{
							content = '`[JAIL-BANNED]:` '..Argument1.UserId..' `[BY]:` '..Player.Name..' `[NOTE]:` '..Argument2
						}),
						Enum.HttpContentType.ApplicationJson)
				end)
				Argument1:LoadCharacter()
			end
		end)
	elseif Subject == 'UNBANREMOTE' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.UnbanCooldown < 10 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.UnbanCooldown = tick()
			if Argument1:FindFirstChild('LOAD_SAVE_DATA') then
				if Argument1.DataFolder.Information:FindFirstChild('Jail') then
					if tonumber(Argument1.DataFolder.Information.Jail.Value) > 250 then
						Argument1.DataFolder.Information.Jail.Value = tostring(5)
						Argument1:LoadCharacter()
						spawn(function()
							local Webhook = Webhooks.BanLogs[1]
							pcall(function()
								HttpService:PostAsync(Webhook, HttpService:JSONEncode(
									{
										content = '`[UNBANNED]:` '..Argument1.UserId..' `[BY]:` '..Player.Name
									}),
									Enum.HttpContentType.ApplicationJson)
							end)
						end)
					end
				end
			end
		end)
	elseif Subject == 'KICKREMOTE' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			if not Argument1:FindFirstChild('LOAD_SAVE_DATA') then
				return
			end
			if _G.PlayerData.Players[Argument1].Stats.Permissions.Rank >= 40 and Argument1 ~= Player and _G.PlayerData.Players[Player].Stats.Permissions.Rank < 250 then
				return
			end
			if Argument1 == Player then
				return
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.KickCooldown < 5 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.KickCooldown = tick()
			if Argument1 then
				if _G.PlayerData.Players[Argument1].Stats.Permissions.Kicked ~= true then
					_G.PlayerData.Players[Argument1].Stats.Permissions.Kicked = true
					Argument1:Kick('An admin kicked you')
					local Webhook = Webhooks.AdminLogs[1]
					pcall(function()
						spawn(function()
							HttpService:PostAsync(Webhook, HttpService:JSONEncode(
								{
									content = '`[KICKED]:` '..Argument1.UserId..' `[BY]:` '..Player.Name..' `[NOTE]:` '..Argument2
								}),
								Enum.HttpContentType.ApplicationJson)
						end)
					end)
				end
			end
		end)
	elseif Subject == 'FindServer' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.ServerIDCooldown < 5 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.ServerIDCooldown = tick()
			local Data = {
				Target = Argument1,
				JobId = game.JobId,
				Requester = Player.Name
			}
			MessagingService:PublishAsync('FindServerID', Data)
		end)
	elseif Subject == 'JoinServer' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, Argument1, Player)
			end)
		end)
	elseif Subject == 'PERMAIDBAN' then
		pcall(function()
			Argument1 = tonumber(Argument1)
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			local Groups = GroupService:GetGroupsAsync(Argument1)
			local Admin = false
			for i,v in pairs(Groups) do 
				if v.Id == 16658555 then
					if v['Rank'] and v['Rank'] >= 254 then
						Admin = true
					end
					break
				end
			end
			if Admin then
				if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
					return 
				end
			end
			if Argument1 == Player.UserId then
				return
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.BanCooldown < 10 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.BanCooldown = tick()
			for i,v in pairs(Players:GetPlayers()) do 
				if v.UserId == Argument1 then
					local Banned = {
						Banned = true,
						Type = 'ADMIN'
					}
					SaveData(v, Banned, 2)
					local Webhook = Webhooks.BanLogs[1]
					pcall(function()
						HttpService:PostAsync(Webhook, HttpService:JSONEncode(
							{
								content = '`[BANNED]:` '..v.UserId..' `[BY]:` '..Player.Name
							}),
							Enum.HttpContentType.ApplicationJson)
					end)
					v:Kick('Mod Team has BANNED you!')
					return
				end
			end
			local s,e = pcall(function()
				local Player = Players:GetNameFromUserIdAsync(Argument1)
			end)
			if s then
				local Data = {
					Target = Players:GetNameFromUserIdAsync(Argument1)
				}
				MessagingService:PublishAsync('PERMABAN', Data)
				local Success = SaveData(Argument1, 'BAN')
				if Success == true then
					local Webhook = Webhooks.BanLogs[1]
					pcall(function()
						HttpService:PostAsync(Webhook, HttpService:JSONEncode(
							{
								content = '`[BANNED]:` '..Argument1..' `[BY]:` '..Player.Name
							}),
							Enum.HttpContentType.ApplicationJson)
					end)
				end
			end
		end)
	elseif Subject == 'UNBANINGPLAYYER' then
		pcall(function()
			Argument1 = tonumber(Argument1)
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			local Groups = GroupService:GetGroupsAsync(Argument1)
			local Admin = false
			for i,v in pairs(Groups) do 
				if v.Id == 16658555 then
					if v['Rank'] and v['Rank'] >= 254 then
						Admin = true
					end
					break
				end
			end
			if Admin then
				if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 250 then
					return 
				end
			end
			if tick() - _G.PlayerData.Players[Player].Stats.Permissions.UnbanCooldown < 10 then
				return
			end
			_G.PlayerData.Players[Player].Stats.Permissions.UnbanCooldown = tick()
			local Success = SaveData(Argument1, 'UNBAN')
			if Success == true then
				local Webhook = Webhooks.BanLogs[1]
				pcall(function()
					HttpService:PostAsync(Webhook, HttpService:JSONEncode(
						{
							content = '`[UNBANNED]:` '..Argument1..' `[BY]:` '..Player.Name
						}),
						Enum.HttpContentType.ApplicationJson)
				end)
			end
		end)
	elseif Subject == 'DROP_CASH_ALL' then
		pcall(function()
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank < 40 then
				return
			end
			local Amount = math.random(5, 40)
			for i = 1, Amount do 
				spawn(function()
					for i = 1, math.random(5, 10) do 
						if Player.Character then
							if Player.Character:FindFirstChild('Head') then
								local x,y,z = 20, 20, 20
								local Position = Vector3.new(math.random(-x, x), math.random(-y, y), math.random(-z, z))
								ServerStorage.Storage.Misc.Server.BindableEvents.SpawnCash:Invoke(Player, 'Free', Player.Character.Head.CFrame, Position, math.random(250000, 2500000))
							else 
								break
							end
						else 
							break
						end
						wait(0.1)
					end
				end)
				wait(0.4)
			end
		end)
	end
end)

local Bindables = ServerStorage.Storage.Misc.Server.BindableEvents

Bindables.Fireworks.Event:Connect(function(Handle, Text)
	spawn(function()
		Handle.Orientation = Vector3.new(0, 0, 0)
		Handle.CanCollide = false
		Handle.Massless = true
		Handle.Velocity = Vector3.new(0, 110, 0)
		Handle.Parent = workspace
		local BodyForce = Instance.new('BodyForce', Handle)
		BodyForce.Force = Vector3.new(0, 314.873, 0)
		local Particle = ServerStorage.Storage.Misc.Particles.FlamethrowerFireParticle:Clone()
		Particle.Parent = Handle
		Particle.Enabled = true
		local Sound = ReplicatedStorage.Firework.Boom:Clone()
		Sound.PlayOnRemove = true
		local Sound2 = ReplicatedStorage.Firework.Launch:Clone()
		local P,P2 = ReplicatedStorage.Firework.P:Clone(), ReplicatedStorage.Firework.P2:Clone()
		Sound.Parent = Handle
		Sound2.Parent = Handle
		Sound2:Play()
		wait(3)
		Sound:Play()
		Handle:Destroy()
		ReplicatedStorage.MainEvent:FireAllClients('EXPLODE_FIREWORK', Handle.Position, Text)
	end)
end)

Bindables.Explosion.Event:Connect(function(Player, Position, FX)
	pcall(function()
		spawn(function()
			local Explosion = ServerStorage.Storage.Misc.RPG.exprosion:Clone()
			Explosion.Position = Position
			for i,v in pairs(Explosion:GetChildren()) do
				if v:IsA('Part') then
					local RandomOffsets = {
						[3] = {
							[1] = CFrame.new(0, 0, 0, 0.291951358, -0.454637647, 0.841468394, 0.837198734, -0.303921342, -0.454675913, 0.462452948, 0.837219477, 0.291891754),
							[2] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
							[3] = CFrame.new(0, 0, 0, 0.980090559, 0.139680177, 0.141109571, -0.159390777, 0.977284014, 0.139680177, -0.118393585, -0.159390777, 0.980090559),
							[4] = CFrame.new(0, 0, 0, 0.173127294, 0.378437281, 0.909292102, -0.722461104, -0.578677535, 0.378394246, 0.669385433, -0.722438574, 0.17322135),
							[5] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
						},
						[4] = {
							[1] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
							[2] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
							[3] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
							[4] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
							[5] = CFrame.new(0, 0, 0, 0.427273333, -0.494724542, -0.756759584, 0.120325297, 0.860679626, -0.494724542, 0.896079957, 0.120325297, 0.427273333)
						},
						[5] = {
							[1] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
							[2] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
							[3] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
							[4] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
						}
					}
					v.CFrame = Explosion.CFrame * RandomOffsets[i][math.random(1, #RandomOffsets[i])]
				end
			end
			Explosion.Parent = workspace.Ignored
			Explosion.Explosion:Play()
			spawn(function()
				local Tween1 = TweenService:Create(Explosion.Mesh, TweenInfo.new(5, Enum.EasingStyle.Circular), {Scale = Vector3.new(27.5, 27.5, 27.5)})
				Tween1:Play()
				for i,v in pairs(Explosion:GetChildren()) do
					if v:FindFirstChild('Mesh') then
						spawn(function()
							local Tween1 = TweenService:Create(v.Mesh, TweenInfo.new(0.1125, Enum.EasingStyle.Circular), {Scale = Vector3.new(12.5, 12.5, 12.5)})
							local Tween2 = TweenService:Create(v.Mesh, TweenInfo.new(1.5875, Enum.EasingStyle.Circular), {Scale = Vector3.new(13.75, 13.75, 13.75)})
							local Tween3 = TweenService:Create(v, TweenInfo.new(0.165), {Transparency = 0.35})
							local Tween4 = TweenService:Create(v, TweenInfo.new(0.9), {Transparency = 1})
							Tween1:Play()
							Tween3:Play()
							Tween1.Completed:Connect(function()
								Tween2:Play()
							end)
							delay(1.425, function()
								Tween4:Play()
							end)
						end)
					end
				end
				local Tween2 = TweenService:Create(Explosion, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Transparency = 1})
				wait(0.8)
				Tween2:Play()
			end)
			if not FX then
				local Region = Region3.new(Explosion.Position - (Vector3.new(20, 20, 20)/2), Explosion.Position + (Vector3.new(20, 20, 20)/2))
				local Touched = {}
				for i,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region, {workspace.Players}, 99999)) do 
					if (v.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')) then
						local Humanoid = (v.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid'))
						local Plr = Players:GetPlayerFromCharacter(Humanoid.Parent)
						if (not table.find(Touched, Humanoid.Parent)) and Plr then
							table.insert(Touched, Humanoid.Parent)
							local MainModule = require(ReplicatedStorage.MainModule)
							local Damage = 150
							if (MainModule.CheckTeam(Plr, Player, nil) ~= true or Plr == Player) then
								if (Humanoid.Health - Damage <= 0.5) then
									Humanoid.Health = 0.5
								else 
									Humanoid.Health -= Damage
								end
								ReplicatedStorage.MainEvent:FireClient(Plr, 'ShotFrom', Player.Character.LowerTorso.Position)
							end
						end
					end
				end
				ReplicatedStorage.MainEvent:FireAllClients('ExplodeRadius', Explosion.Position, 25)
				for i,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region, {workspace.MAP.Map}, 15)) do 
					if v:IsDescendantOf(workspace) then
						local Destroy = true
						local MaxVolume = _G.PlayerData.Map.MaxSize.X * _G.PlayerData.Map.MaxSize.Y * _G.PlayerData.Map.MaxSize.Z 
						local Volume = v.Size.X * v.Size.Y * v.Size.Z
						if v.Parent.Name == 'Door' then
							Destroy = false
						end
						if v.Parent.Parent.Name == 'Door' then
							Destroy = false
						end
						if v.Parent.Name == 'Mailbox' then
							Destroy = false
						end
						if not table.find(_G.PlayerData.Map.Destroyable, v.Material) then
							Destroy = false
						end
						pcall(function()
							if Volume > MaxVolume then
								Destroy = false
							end
						end)
						if v:IsDescendantOf(workspace.MAP.Indestructible) then
							Destroy = false
						end
						if Destroy ~= false then
							ServerStorage.Storage.Misc.Server.BindableEvents.TempRemove:Fire(v, v.Parent)
						end
					end
				end
			end
			game:GetService('Debris'):AddItem(Explosion, 5)
		end)
	end)
end)

Bindables.TempRemove.Event:Connect(function(Part, P)
	spawn(function()
		pcall(function()
			Part.Parent = nil
			wait(50)
			Part.Parent = P
		end)
	end)
end)

Bindables.Grenade.Event:Connect(function(Handle, Player)
	pcall(function()
		if Player.Character then
			if not Player.Character:FindFirstChildOfClass('Humanoid') then
				return
			end
			local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')
			local Animation = Instance.new('Animation')
			Animation.AnimationId = 'rbxassetid://12884525073'
			local Track = Humanoid:LoadAnimation(Animation)
			Track:Play()
			local Mouse = ReplicatedStorage.RemoteFunction.RemoteFunction:InvokeClient(Player, 'MOUSEPOS')
			Handle.CanCollide = true
			Handle.Parent = workspace.Ignored
			local VELOCITY = (Mouse - Handle.Position).Unit * 75
			local X = VELOCITY.X
			local Y = math.abs(VELOCITY.Y)
			if Y >= 10 and Y < 30 then
				Y = Random.new():NextNumber(10, 30) * Random.new():NextNumber(1.5, 2.5)
			elseif Y >= 30 and Y < 60 then
				Y *= 2
			elseif Y >= 60 and Y < 100 then
				Y *= 1.25
			end
			if Y < 25 then
				Y = 25 * Random.new():NextNumber(1.5, 2.5)
			elseif Y > 25 and Y < 50 then
				Y *= Random.new():NextNumber(1.75, 2.5)
			elseif Y > 50 and Y < 75 then
				Y *= Random.new():NextNumber(1.25, 2)
			elseif Y >= 75 then
				Y *= Random.new():NextNumber(1, 1.75)
			end
			Handle.Velocity = Vector3.new(X, Y, VELOCITY.Z)
			spawn(function()
				wait(math.round(Y/75))
				local Count = 0
				Handle.BrickColor = BrickColor.new('Bright red')
				while wait(0.3) do 
					if not Handle:IsDescendantOf(workspace) then
						break
					end
					if Handle.BrickColor == BrickColor.new('White') then
						Handle.BrickColor = BrickColor.new('Bright red')
					else 
						Handle.BrickColor = BrickColor.new('White')
					end
					Count += 1 
					if Count == 6 then
						Bindables.Explosion:Fire(Player, Handle.Position)
						Handle:Destroy()
						break
					end
				end
			end)
		end
	end)
end)

Bindables.FlashbangExplosion.Event:Connect(function(Player, Position)
	pcall(function()
		local Part = ServerStorage.Storage.Misc.RPG.Flashbang.Part:Clone()
		Part.Position = Position 
		Part.Parent = workspace
		Part.Sound:Play()
		Part.PointLight.Enabled = true
		local Tween = TweenService:Create(Part.PointLight, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {Range = 20, Brightness = 10})
		Tween:Play()
		local Region = Region3.new(Part.Position - (Vector3.new(20, 20, 20)/2), Part.Position + (Vector3.new(20, 20, 20)/2))
		local Touched = {}
		for i,v in pairs(workspace:FindPartsInRegion3WithWhiteList(Region, {workspace.Players}, 99999)) do 
			if (v.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid')) then
				local Humanoid = (v.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent:FindFirstChildOfClass('Humanoid') or v.Parent.Parent.Parent:FindFirstChildOfClass('Humanoid'))
				local Plr = Players:GetPlayerFromCharacter(Humanoid.Parent)
				local MainModule = require(ReplicatedStorage.MainModule)
				if (not table.find(Touched, Humanoid.Parent)) and Plr then
					table.insert(Touched, Humanoid.Parent)
					ReplicatedStorage.MainEvent:FireClient(Plr, 'FLASHBANG')
				end
			end
		end
		game:GetService('Debris'):AddItem(Part, 0.5)
	end)
end)

Bindables.Flashbang.Event:Connect(function(Handle, Player)
	pcall(function()
		if Player.Character then
			if not Player.Character:FindFirstChildOfClass('Humanoid') then
				return
			end
			local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')
			local Animation = Instance.new('Animation')
			Animation.AnimationId = 'rbxassetid://12884523428'
			local Track = Humanoid:LoadAnimation(Animation)
			Track:Play()
			local Mouse = ReplicatedStorage.RemoteFunction.RemoteFunction:InvokeClient(Player, 'MOUSEPOS')
			Handle.CanCollide = true
			Handle.Parent = workspace.Ignored
			local VELOCITY = (Mouse - Handle.Position).Unit * 75
			local X = VELOCITY.X
			local Y = math.abs(VELOCITY.Y)
			if Y >= 10 and Y < 30 then
				Y = Random.new():NextNumber(10, 30) * Random.new():NextNumber(1.5, 2.5)
			elseif Y >= 30 and Y < 60 then
				Y *= 2
			elseif Y >= 60 and Y < 100 then
				Y *= 1.25
			end
			if Y < 25 then
				Y = 25 * Random.new():NextNumber(1.5, 2.5)
			elseif Y > 25 and Y < 50 then
				Y *= Random.new():NextNumber(1.75, 2.5)
			elseif Y > 50 and Y < 75 then
				Y *= Random.new():NextNumber(1.25, 2)
			elseif Y >= 75 then
				Y *= Random.new():NextNumber(1, 1.75)
			end
			Handle.Velocity = Vector3.new(X, Y, VELOCITY.Z)
			spawn(function()
				wait(math.round(Y/75))
				Bindables.FlashbangExplosion:Fire(Player, Handle.Position)
				Handle:Destroy()
			end)
		end
	end)
end)

Bindables.BoneBreak.Event:Connect(function(HitPart, Character, Type)
	pcall(function()
		spawn(function()
			if not Character.BodyEffects.BreakingParts:FindFirstChild(Type) then
				local BoneBreak = Instance.new('Sound', HitPart)
				BoneBreak.Name = 'BoneBreak'
				BoneBreak.SoundId = 'rbxassetid://314390675'
				BoneBreak.Volume = 0.5
				BoneBreak.RollOffMode = Enum.RollOffMode.Inverse
				BoneBreak:Play()
				BoneBreak.Ended:Connect(function()
					BoneBreak:Destroy()
				end)
				local Folder = Instance.new('Folder', Character.BodyEffects.BreakingParts)
				Folder.Name = Type
				game:GetService('Debris'):AddItem(Folder, 14)
			end
		end)
	end)
end)
Bindables.GrenadeLauncher.Event:Connect(function(Player, Position, Mouse, Duration)
	pcall(function()
		spawn(function()
			local Grenade = game:GetService('ServerStorage').Storage.Misc.RPG.GrenadeLauncherAmmo:Clone()
			Grenade.Main.BodyForce.Force = Vector3.new(0, Random.new():NextNumber(50, 55), 0)
			Grenade.Parent = workspace.Ignored
			Grenade.PrimaryPart.CFrame = CFrame.lookAt(Position, Mouse) * CFrame.Angles(0, math.rad(90), 0)
			Grenade.PrimaryPart.Grenadelauncherswoosh:Play()
			local VELOCITY = (Mouse - Position).Unit * 85
			Grenade.PrimaryPart.Velocity = VELOCITY
			local Tween = TweenService:Create(Grenade.Main.BodyForce, TweenInfo.new(1.5), {Force = Vector3.new(0, 0, 0)})
			Tween:Play()	
			delay(Duration, function()
				if Grenade then
					game:GetService('ServerStorage').Storage.Misc.Server.BindableEvents.Explosion:Fire(Player, Grenade.PrimaryPart.Position)
					Grenade:Destroy()
				end
			end)
		end)
	end)
end)

Bindables.Bag.Event:Connect(function(Character)
	pcall(function()
		spawn(function()
			if not Character:FindFirstChild('Christmas_Sock') then
				local Bag = ServerStorage.Storage.Misc.Bag['Christmas_Sock']:Clone()
				Bag.Size = Character.HumanoidRootPart.Size * Vector3.new(4.0457048416137695, 2.9456400871276855, 3.3482799530029297)
				local Weld = Instance.new('Weld', Bag)
				Weld.C0 = CFrame.new(-9.72747803e-05, 1.49999332, 0.000152111053, -1, 0, 0, 0, -1, 0, 0, 0, 1)
				Weld.Part0 = Character.LowerTorso
				Weld.Part1 = Bag 
				Bag.Parent = Character 
				Bag.HIT:Play()
				game:GetService('Debris'):AddItem(Bag, 60)
			end
		end)
	end)
end)


Bindables.SpawnCash.OnInvoke = function(Player, Mode, Position, Offset, Amount, Velocity)
	if Player ~= nil then
		if not Player:FindFirstChild('LOAD_SAVE_DATA') then
			return
		end
	end
	if tonumber(Amount) == nil then
		return
	end
	local Taxed = nil
	if Player then
		if Mode ~= 'Free' then
			if _G.PlayerData.Players[Player].Stats.Permissions.Rank <= 40 then
				Taxed = math.round(0.7 * Amount)
			else
				Taxed = Amount
			end
			if Player.DataFolder.Currency.Value < Amount then
				return
			end
			Player.DataFolder.Currency.Value -= Amount
		end
	end
	local MoneyDrop = ServerStorage.Storage.Misc.Money.MoneyDrop:Clone()
	if Taxed ~= nil then
		MoneyDrop.BillboardGui.TextLabel.Text = '$'..MainModule.AddComma(Taxed)
	else 
		MoneyDrop.BillboardGui.TextLabel.Text = '$'..MainModule.AddComma(Amount)
	end
	MoneyDrop.CFrame = Position + Offset
	MoneyDrop.Parent = workspace.Ignored.Drop
	if Velocity then
		MoneyDrop.Velocity = Velocity
	end
	local Clicked = false
	local Connection
	Connection = MoneyDrop.ClickDetector.MouseClick:Connect(function(Plr)
		if not Plr:FindFirstChild('LOAD_SAVE_DATA') then
			return
		end
		if Plr:DistanceFromCharacter(MoneyDrop.Position) <= MoneyDrop.ClickDetector.MaxActivationDistance then
			if _G.PlayerData.Players[Plr].Debounces.Currency.Pickup ~= false then
				return
			end
			if Clicked == false then
				spawn(function()
					pcall(function()
						_G.PlayerData.Players[Plr].Debounces.Currency.Pickup = true
						wait(0.5)
						_G.PlayerData.Players[Plr].Debounces.Currency.Pickup = false
					end)
				end)
				pcall(function()
					if Taxed ~= nil then
						Plr.DataFolder.Currency.Value += Taxed
					else 
						Plr.DataFolder.Currency.Value += Amount
					end
				end)
				MoneyDrop:Destroy()
				Clicked = true
				Connection:Disconnect()
			end
		end
	end)
	return MoneyDrop
end

Bindables.ATM.Event:Connect(function(Player, Humanoid, Damage, Melee)
	if not Player:FindFirstChild('LOAD_SAVE_DATA') then
		return
	end
	if Player.DataFolder.Officer.Value ~= 0 then
		return
	end
	if Melee then
		if Melee == true then
			Humanoid.Parent.Head.Punch:Play()
		end
	end
	if Humanoid.Health > 0 then
		if (Humanoid.Health - Damage) > 0 then 
			if not Melee then
				Player.DataFolder.Information.Wanted.Value += 1
			else 
				if Melee == true then
					Player.DataFolder.Information.Wanted.Value += 5
				end
			end
			Humanoid.Health -= Damage
		else 
			if not Melee then
				Player.DataFolder.Information.Wanted.Value += 1
			else 
				if Melee == true then
					Player.DataFolder.Information.Wanted.Value += 5
				end
			end
			spawn(function()
				wait(300)
				Humanoid.Health = Humanoid.MaxHealth
				Humanoid.Parent.Open.Size = Vector3.new(2.6, 0.5, 0.1)
			end)
			if (Humanoid.Parent.Head.Position - workspace.Ignored.Siren.Radius.Position).magnitude < 20 then
				spawn(function()
					ServerStorage.Storage.Misc.Server.BindableEvents.BankAlarm:Fire()
				end)
			end
			Humanoid.Health = 0
			Humanoid.Parent.Head.Crash:Play()
			Humanoid.Parent.Open.Size = Vector3.new(2.6, 0.5, 1.3)
			for i = 1,4 do
				local Velocity 
				local Number = math.random(1, 2)
				if Number == 1 then 
					Velocity = Vector3.new(0, -3.27, 0)
				else 
					Velocity = Vector3.new(0, -4.0875, 0)
				end
				ServerStorage.Storage.Misc.Server.BindableEvents.SpawnCash:Invoke(nil, nil, Humanoid.Parent.Head.CFrame, Vector3.new(Random.new():NextNumber(0, 0.5), Random.new():NextNumber(1, 3), Random.new():NextNumber(0.2, 1)), math.random(20, 50000), Velocity)
			end
		end
		Player.leaderstats.Wanted.Value = Player.DataFolder.Information.Wanted.Value
	end
end)

game:GetService("ReplicatedStorage").MainEvent.OnServerEvent:Connect(function(Player, Subject, ...)
	if Subject == "UpdateCursorImage" then
		local Arg = ...
		pcall(function()
			if Player.DataFolder.CursorImage.Value ~= "" then
				Player.DataFolder.CursorImage.Value = ""
			else
				Player.DataFolder.CursorImage.Value = Arg
			end
		end)
	end
end)

--[[spawn(function()
	local Date = os.date('!*t', os.time())
	if Date.month == 10 then
		while wait(100) do 

		end
	end
end)]]


MessagingService:SubscribeAsync('FindServerID', function(Info)
	local Data = Info.Data
	if Data then
		if Data.Target then
			for i,v in pairs(Players:GetPlayers()) do 
				if v.Name:lower() == Data.Target:lower() then
					if game.JobId ~= Data.JobId then
						local Webhook = Webhooks.AdminLogs[1]
						pcall(function()
							HttpService:PostAsync(Webhook, HttpService:JSONEncode(
								{
									content = '`[TARGET]:` '..v.Name..' `[SERVER-ID]:` '..game.JobId..' `[REQUESTER]:` '..Data.Requester
								}),
								Enum.HttpContentType.ApplicationJson)
						end)
						break
					end
				end
			end
		end
	end
end)

MessagingService:SubscribeAsync('PERMABAN', function(Info)
	local Data = Info.Data
	if Data then
		if Data.Target then
			for i,v in pairs(Players:GetPlayers()) do 
				if v.Name == Data.Target then
					_G.PlayerData.Players[v].Saved = true
					v:Kick('Mod Team has BANNED you!')
					break
				end
			end
		end
	end
end)


for i,v in pairs(workspace.MAP.Map.SchoolStuff:GetChildren()) do
	if v.Name == 'ClassroomSeats_MODEL' then
		local Model = v 
		local Animations = {
			[1] = 'rbxassetid://11158189712',
			[2] = 'rbxassetid://11158184618',
			[3] = 'rbxassetid://11158178960',
			[4] = 'rbxassetid://11158193956',
			[5] = 'rbxassetid://11158200625',
			[6] = 'rbxassetid://11158171438',
			[7] = 'rbxassetid://11158207851',
			[8] = 'rbxassetid://11158217526',
			[9] = 'rbxassetid://11158224505',
			[10] = 'rbxassetid://11158193956',
			[11] = 'rbxassetid://11158233852',
			[12] = 'rbxassetid://11158242296'
		}
		for i,v in pairs(Model:GetChildren()) do
			if v:IsA('Seat') then
				if v.Name == 'School Seats' then
					local Animation = Animations[i]
					local Character
					v.ChildAdded:Connect(function(Child)
						if Child.Part1.Name == 'HumanoidRootPart' then
							local Player = Players:GetPlayerFromCharacter(Child.Part1.Parent)
							if not Player then
								return
							end
							if not Player:FindFirstChild('LOAD_SAVE_DATA') then
								return
							end
							if Child.Part1.Parent:FindFirstChildOfClass('Humanoid') then
								local Humanoid = Child.Part1.Parent:FindFirstChildOfClass('Humanoid')
								local Anim = Instance.new('Animation')
								Anim.AnimationId = Animation
								local Track = Humanoid:LoadAnimation(Anim)
								Track:Play()
								Character = Child.Part1.Parent
							end
						end
					end)
					v.ChildRemoved:Connect(function(Child)
						if Character then
							if Character:FindFirstChildOfClass('Humanoid') then
								local Humanoid = Character:FindFirstChildOfClass('Humanoid')
								for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
									if v.Animation.AnimationId == Animation then
										v:Stop()
									end
								end
							end
						end
					end)
				end
			end
		end
	elseif v.Name == 'PCSeats_MODEL' then
		local Model = v 
		local Animations = {
			[1] = 'rbxassetid://11158279222',
			[2] = 'rbxassetid://11158290964',
			[3] = 'rbxassetid://11158284813',
			[4] = 'rbxassetid://11158297122',
			[5] = 'rbxassetid://11158336835',
			[6] = 'rbxassetid://11158340488',
			[7] = 'rbxassetid://11158331883',
			[8] = 'rbxassetid://11158348143',
			[9] = 'rbxassetid://11158325298'
		}
		for i,v in pairs(Model:GetChildren()) do
			if v:IsA('Seat') then
				if v.Name == 'School Seats' then
					local Animation = Animations[i]
					local Character
					v.ChildAdded:Connect(function(Child)
						if Child.Part1.Name == 'HumanoidRootPart' then
							local Player = Players:GetPlayerFromCharacter(Child.Part1.Parent)
							if not Player then
								return
							end
							if not Player:FindFirstChild('LOAD_SAVE_DATA') then
								return
							end
							if Child.Part1.Parent:FindFirstChildOfClass('Humanoid') then
								local Humanoid = Child.Part1.Parent:FindFirstChildOfClass('Humanoid')
								local Anim = Instance.new('Animation')
								Anim.AnimationId = Animation
								local Track = Humanoid:LoadAnimation(Anim)
								Track:Play()
								Character = Child.Part1.Parent
							end
						end
					end)
					v.ChildRemoved:Connect(function(Child)
						if Character then
							if Character:FindFirstChildOfClass('Humanoid') then
								local Humanoid = Character:FindFirstChildOfClass('Humanoid')
								for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
									if v.Animation.AnimationId == Animation then
										v:Stop()
									end
								end
							end
						end
					end)
				end
			end
		end
	end
end

for i,v in pairs(workspace.MAP.Map.LocalBusiness:GetChildren()) do
	if v:IsA('Model') then
		if v.Name == 'WashingMachineFUNC' then
			local ToggleCooldown = false
			local Toggled = false
			local Opened = false
			local OpenCooldown = false
			local Timer = 30
			local Tween
			local CFrameValue
			local Circle = v.Circle
			local Colors = v.Colors
			local Opener = v.Opener
			local Button = Colors.Button
			local Code1 = Colors.Code1
			local Code2 = Colors.Code2
			local Glass = v.Glass
			local Text = Glass.SecondSurface.TextLabel
			local Decal = Button:FindFirstChildOfClass('Decal')
			local Toggle = Button:FindFirstChildOfClass('ClickDetector')
			local Connection
			local Open = Opener.Window:FindFirstChildOfClass('ClickDetector')
			Open.MouseClick:Connect(function(Player)
				pcall(function()
					if OpenCooldown then
						return
					end
					if Toggled then
						return
					end
					if Player:DistanceFromCharacter(Button.Position) <= Toggle.MaxActivationDistance then
						if Opened == false then
							Opened = true
							Button.WashOpen:Play()
							Opener:PivotTo(Opener:GetPivot() * CFrame.Angles(0, math.rad(-90), 0))
							spawn(function()
								OpenCooldown = true
								wait(0.3)
								OpenCooldown = false
							end)
						else 
							Opened = false
							Button.WashClose:Play()
							Opener:PivotTo(Opener:GetPivot() * CFrame.Angles(0, math.rad(90), 0))
							spawn(function()
								OpenCooldown = true
								wait(0.3)
								OpenCooldown = false
							end)
						end
					end
				end)
			end)
			Toggle.MouseClick:Connect(function(Player)
				pcall(function()
					if ToggleCooldown then
						return
					end
					if Opened then
						return
					end
					if Player:DistanceFromCharacter(Button.Position) <= Toggle.MaxActivationDistance then
						Button.ButtonClick:Play()
						if Toggled == false then
							Button.BrickColor = BrickColor.new('Persimmon')
							Decal.Texture = 'rbxassetid://4458862490'
							Code1.BrickColor = BrickColor.new('Olivine')
							Code2.BrickColor = BrickColor.new('Olivine')
							Toggled = true
							Timer = 30
							Text.Text = tostring(Timer)
							spawn(function()
								ToggleCooldown = true
								wait(0.1)
								ToggleCooldown = false
							end)
							spawn(function()
								Connection = true
								local Debounce = true
								spawn(function()
									wait(1)
									Debounce = false
								end)
								Button.WashRun:Play()
								CFrameValue = Instance.new('CFrameValue')
								CFrameValue.Value = Circle:GetPivot()
								CFrameValue:GetPropertyChangedSignal('Value'):Connect(function()
									Circle:PivotTo(CFrameValue.Value)
								end)
								local function PLAY_TWEEN()
									Tween = TweenService:Create(CFrameValue, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Value = Circle:GetPivot() * CFrame.Angles(math.rad(90), 0, 0)})
									Tween:Play()
									Tween.Completed:Connect(function()
										if Connection == false then
											ToggleCooldown = false
											Connection = false
											CFrameValue:Destroy()
											Tween = nil 
											CFrameValue = nil
										else 
											PLAY_TWEEN()
										end
									end)
								end
								PLAY_TWEEN()
								while true do 
									if Connection == false then
										Button.WashRun:Stop()
										break
									end
									if Timer == 0 then
										Connection = false
										Button.WashRun:Stop()
										break
									end
									wait()
									spawn(function()
										if Debounce == false then
											Timer -= 1
											if Timer >= 10 then
												Text.Text = tostring(Timer)
											else 
												Text.Text = '0'..tostring(Timer)
											end
											Debounce = true
											wait(1)
											Debounce = false
										end
									end)
								end
							end)
						else 
							Button.BrickColor = BrickColor.new('Olivine')
							Decal.Texture = 'rbxassetid://5173558738'
							Code1.BrickColor = BrickColor.new('Persimmon')
							Code2.BrickColor = BrickColor.new('Persimmon')
							Toggled = false
							if Connection then
								Connection = false
								spawn(function()
									ToggleCooldown = true
								end)
							end
						end
					end
				end)
			end)
		end
	end
end

for i,v in pairs(workspace.MAP.Map:GetDescendants()) do
	if v:IsA('Model') and v.Name == 'Door' and v:FindFirstChild('UnLOCK') then
		local Door = v
		local Open
		local Opened = false
		local Cooldown = false
		local LockCooldown = false
		local KnockCooldown = false
		local Lock
		local Folder = v.UnLOCK
		local Type
		for i,v in pairs(Door:GetChildren()) do
			if v.Name == 'Part' then
				if v:FindFirstChildOfClass('ClickDetector') then
					Open = v:FindFirstChildOfClass('ClickDetector')
					break
				end
			end
		end
		if Door:FindFirstChild('Lock') and Door.Lock:FindFirstChildOfClass('ClickDetector') then
			Type = 'Normal'
			Lock = Door.Lock:FindFirstChildOfClass('ClickDetector')
		else 
			Type = 'Police'
		end
		local function Raycast(player)
			local ignore = {}
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character and v ~= player then
					table.insert(ignore, v.Character)
				end
			end
			table.insert(ignore, Door.Lock)
			table.insert(ignore, Open.Parent)
			local raycastParams = RaycastParams.new()
			raycastParams.FilterDescendantsInstances = ignore
			raycastParams.IgnoreWater = true
			raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
			local results = workspace:Raycast(Door.Lock.Part.Position, (player.Character.PrimaryPart.Position - Door.Lock.Part.Position).Unit * (Lock.MaxActivationDistance + 2), raycastParams)
			if results then
				if results.Instance:IsDescendantOf(player.Character) then
					return true
				end
			end
			return false
		end
		if Lock then 
			if Lock:IsA('ClickDetector') then
				Lock.MouseClick:Connect(function(Player)
					pcall(function()
						if not Player:FindFirstChild('LOAD_SAVE_DATA') then
							return
						end
						if KnockCooldown then
							return
						end
						if LockCooldown then
							return
						end
						if Opened then
							return
						end
						if Player:DistanceFromCharacter(Lock.Parent.Locker.Position) <= Lock.MaxActivationDistance then
							local Result = Raycast(Player)
							if not Result then
								return
							end
							if Folder.Name == 'UnLOCK' then
								spawn(function()
									LockCooldown = true
									wait(0.25)
									LockCooldown = false
								end)
								Door.Door.Lock:Play()
								Folder.Name = 'LOCKKK'
								Door.Lock.Locker.CFrame = Door.Lock.Locker.CFrame * CFrame.Angles(0, 0, math.rad(90))
							else 
								spawn(function()
									LockCooldown = true
									wait(0.25)
									LockCooldown = false
								end)
								Door.Door.Lock:Play()
								Folder.Name = 'UnLOCK'
								Door.Lock.Locker.CFrame = Door.Lock.Locker.CFrame * CFrame.Angles(0, 0, math.rad(-90))
							end
						end
					end)
				end)
			end
		end
		Open.MouseClick:Connect(function(Player)
			pcall(function()
				if not Player:FindFirstChild('LOAD_SAVE_DATA') then
					return
				end
				if Player:DistanceFromCharacter(Open.Parent.Position) <= Open.MaxActivationDistance then
					if Cooldown then 
						return
					end
					if KnockCooldown then
						return
					end
					if Type == 'Police' then
						if Player.DataFolder.Officer.Value == 0 then
							return
						end
					end
					if Folder.Name == 'UnLOCK' then
						if Opened == false then
							for i,v in pairs(Door:GetDescendants()) do
								pcall(function()
									if v.Parent.Name ~= 'Lock' then
										v.CanCollide = false
									end
								end)
							end
							Opened = true
							Cooldown = true
							Door.Door.Opening:Play()
							local CFrameValue = Instance.new('CFrameValue')
							CFrameValue.Value = Door:GetPivot()
							local Info = TweenInfo.new(0.125)
							local Tween = TweenService:Create(CFrameValue, Info, {Value = Door:GetPivot() * CFrame.Angles(0, math.rad(90), 0)})
							Tween:Play()
							CFrameValue:GetPropertyChangedSignal('Value'):Connect(function()
								Door:PivotTo(CFrameValue.Value)
							end)
							Tween.Completed:Connect(function()
								spawn(function()
									wait(0.25)
									Cooldown = false
								end)
								CFrameValue:Destroy()
							end)
						elseif Opened == true then
							for i,v in pairs(Door:GetDescendants()) do
								pcall(function()
									if v.Parent.Name ~= 'Lock' then
										v.CanCollide = true
									end
								end)
							end
							Opened = false
							Cooldown = true
							Door.Door.Closing:Play()
							local CFrameValue = Instance.new('CFrameValue')
							CFrameValue.Value = Door:GetPivot()
							local Info = TweenInfo.new(0.125)
							local Tween = TweenService:Create(CFrameValue, Info, {Value = Door:GetPivot() * CFrame.Angles(0, math.rad(-90), 0)})
							Tween:Play()
							CFrameValue:GetPropertyChangedSignal('Value'):Connect(function()
								Door:PivotTo(CFrameValue.Value)
							end)
							Tween.Completed:Connect(function()
								spawn(function()
									wait(0.25)
									Cooldown = false
								end)
								CFrameValue:Destroy()
							end)
						end
					else 
						if KnockCooldown then
							return
						end
						KnockCooldown = true
						Door.Door.KNOCK:Play()
						for i = 1,3 do
							wait(0.05)
							Door:PivotTo(Door:GetPivot() * CFrame.Angles(0, math.rad(4.5), 0))
							wait(0.05)
							Door:PivotTo(Door:GetPivot() * CFrame.Angles(0, math.rad(-4.5), 0))
						end
						spawn(function()
							wait(0.6)
							KnockCooldown = false
						end)
					end
				end
			end)
		end)
	end
end


for i,v in pairs(workspace.Ignored.Shop:GetChildren()) do
	if v.Name == '[Revolver] - $1300' then
		local Info = {
			Name = '[Revolver]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[Revolver] - $1450' then
		local Info = {
			Name = '[Revolver]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[Revolver] - $1440' then
		local Info = {
			Name = '[Revolver]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '12 [Revolver Ammo] - $75' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Revolver]')
	elseif v.Name == '[Double-Barrel SG] - $1400' then
		local Info = {
			Name = '[Double-Barrel SG]',
			StartingAmmo = '9999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[Double-Barrel SG] - $1500' then
		local Info = {
			Name = '[Double-Barrel SG]',
			StartingAmmo = '9999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[Double-Barrel SG] - $1450' then
		local Info = {
			Name = '[Double-Barrel SG]',
			StartingAmmo = '9999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '18 [Double-Barrel SG Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Double-Barrel SG]')
	elseif v.Name == '[High-Medium Armor] - $2300' then
		local Info = {
			Armor = 130
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Double-Barrel SG]')
	elseif v.Name == '[High-Medium Armor] - $2000' then
		local Info = {
			Armor = 130
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Armor', Info)
	elseif v.Name == '[Medium Armor] - $1000' then
		local Info = {
			Armor = 100
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Armor', Info)
	elseif v.Name == '[Full-Armor] - $3000' then
		local Info = {
			Armor = 200
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Armor', Info)
	elseif v.Name == '[Medium Armor] - $1600' then
		local Info = {
			Armor = 100
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Armor', Info)
	elseif v.Name == '[Medium Armor] - $1100' then
		local Info = {
			Armor = 100
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Armor', Info)
	elseif v.Name == '[Lettuce] - $5' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Lettuce]')
	elseif v.Name == '[Weights] - $120' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Weights]')
	elseif v.Name == '[HeavyWeights] - $250' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[HeavyWeights]')
	elseif v.Name == '[AK47] - $2250' then
		local Info = {
			Name = '[AK47]',
			StartingAmmo = '99999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '90 [AK47 Ammo] - $80' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[AK47]')
	elseif v.Name == '[AR] - $1000' then
		local Info = {
			Name = '[AR]',
			StartingAmmo = '9999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '100 [AR Ammo] - $75' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[AR]')
	elseif v.Name == '[AUG] - $1950' then
		local Info = {
			Name = '[AUG]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '90 [AUG Ammo] - $80' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[AUG]')
	elseif v.Name == '[Glock] - $300' then
		local Info = {
			Name = '[Glock]',
			StartingAmmo = '99999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[Glock] - $500' then
		local Info = {
			Name = '[Glock]',
			StartingAmmo = '9999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '25 [Glock Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Glock]')
	elseif v.Name == '30 [Glock Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Glock]')
	elseif v.Name == '[DrumGun] - $3000' then
		local Info = {
			Name = '[DrumGun]',
			StartingAmmo = '999999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '100 [DrumGun Ammo] - $200' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[DrumGun]')
	elseif v.Name == '[LMG] - $3750' then
		local Info = {
			Name = '[LMG]',
			StartingAmmo = '999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '200 [LMG Ammo] - $300' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[LMG]')
	elseif v.Name == '[TacticalShotgun] - $1750' then
		local Info = {
			Name = '[TacticalShotgun]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info)
	elseif v.Name == '[TacticalShotgun] - $1500' then
		local Info = {
			Name = '[TacticalShotgun]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '[TacticalShotgun] - $1700' then
		local Info = {
			Name = '[TacticalShotgun]',
			StartingAmmo = '9999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '20 [TacticalShotgun Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[TacticalShotgun]')
	elseif v.Name == '[P90] - $1000' then
		local Info = {
			Name = '[P90]',
			StartingAmmo = '999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '120 [P90 Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[P90]')
	elseif v.Name == '[SMG] - $750' then
		local Info = {
			Name = '[SMG]',
			StartingAmmo = '999999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '80 [SMG Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[SMG]')
	elseif v.Name == '[Shotgun] - $1250' then
		local Info = {
			Name = '[Shotgun]',
			StartingAmmo = '99999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '[Shotgun] - $1260' then
		local Info = {
			Name = '[Shotgun]',
			StartingAmmo = '99999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '[Shotgun] - $1350' then
		local Info = {
			Name = '[Shotgun]',
			StartingAmmo = '99999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '20 [Shotgun Ammo] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Shotgun]')
	elseif v.Name == '[SilencerAR] - $1250' then
		local Info = {
			Name = '[SilencerAR]',
			StartingAmmo = '9999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '120 [SilencerAR Ammo] - $75' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[SilencerAR]')
	elseif v.Name == '[Silencer] - $550' then
		local Info = {
			Name = '[Silencer]',
			StartingAmmo = '99999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '[Silencer] - $400' then
		local Info = {
			Name = '[Silencer]',
			StartingAmmo = '999999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '25 [Silencer Ammo] - $50' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Silencer]')
	elseif v.Name == '[Rifle] - $1550' then
		local Info = {
			Name = '[Rifle]',
			StartingAmmo = '9999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '5 [Rifle Ammo] - $250' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Rifle]')
	elseif v.Name == '[RPG] - $20000' then
		local Info = {
			Name = '[RPG]',
			StartingAmmo = '9999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '[RPG] - $6000' then
		local Info = {
			Name = '[RPG]',
			StartingAmmo = '9999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '5 [RPG Ammo] - $1000' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[RPG]')
	elseif v.Name == '[Flamethrower] - $25000' then
		local Info = {
			Name = '[Flamethrower]',
			StartingAmmo = '9999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '140 [Flamethrower Ammo] - $1550' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Ammo', '[Flamethrower]')
	elseif v.Name == '[GrenadeLauncher] - $10000' then
		local Info = {
			Name = '[GrenadeLauncher]',
			StartingAmmo = '999999999'
		}
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Weapon', Info) 
	elseif v.Name == '12 [GrenadeLauncher Ammo] - $3000' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[GrenadeLauncher]')
	elseif v.Name == '[Chicken] - $7' then 
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Chicken]')
	elseif v.Name == '[Chicken] - $15' then 
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Chicken]')
	elseif v.Name == '[Cranberry] - $3' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Cranberry]')
	elseif v.Name == '[Cranberry] - $2' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Cranberry]')
	elseif v.Name == '[Donut] - $5' then 
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Donut]')
	elseif v.Name == '[Donut] - $11' then 
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Donut]')
	elseif v.Name == '[Donut] - $10' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Donut]')
	elseif v.Name == '[Hamburger] - $5' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Hamburger]')
	elseif v.Name == '[Hamburger] - $15' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Hamburger]')
	elseif v.Name == '[Hamburger] - $10' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Hamburger]')
	elseif v.Name == '[HotDog] - $8' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[HotDog]')
	elseif v.Name == '[Lemonade] - $3' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Lemonade]')
	elseif v.Name == '[Pizza] - $5' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Pizza]')
	elseif v.Name == '[Pizza] - $7' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Pizza]')
	elseif v.Name == '[Pizza] - $10' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Pizza]')
	elseif v.Name == '[Popcorn] - $7' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Popcorn]')
	elseif v.Name == '[Popcorn] - $14' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Popcorn]')
	elseif v.Name == '[Da Milk] - $7' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Da Milk]')
	elseif v.Name == '[Meat] - $12' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Meat]')
	elseif v.Name == '[Starblox Latte] - $5' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Starblox Latte]')
	elseif v.Name == '[Taco] - $2' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Taco]')
	elseif v.Name == '[Taco] - $7' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Taco]')
	elseif v.Name == '[Taco] - $4' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Taco]')
	elseif v.Name == '[Taco] - $6' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Food', '[Taco]')
	elseif v.Name == '[Surgeon Mask] - $25' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Surgeon Mask]')
	elseif v.Name == '[Paintball Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Paintball Mask]')
	elseif v.Name == '[Pumpkin Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Pumpkin Mask]')
	elseif v.Name == '[Skull Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Skull Mask]')
	elseif v.Name == '[Ninja Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Ninja Mask]')
	elseif v.Name == '[Hockey Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Hockey Mask]')
	elseif v.Name == '[Riot Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Riot Mask]')
	elseif v.Name == '[Breathing Mask] - $60' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Mask', '[Breathing Mask]')
	elseif v.Name == '[Money Gun] - $777' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Money Gun]')
	elseif v.Name == '[Flashlight] - $10' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Flashlight]')
	elseif v.Name == '[PepperSpray] - $75' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[PepperSpray]')
	elseif v.Name == '[PepperSpray] - $150' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[PepperSpray]')
	elseif v.Name == '[iPhone] - $600' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[iPhone]')
	elseif v.Name == '[iPhoneB] - $600' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[iPhoneB]')
	elseif v.Name == '[iPhoneG] - $600' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[iPhoneG]')
	elseif v.Name == '[iPhoneP] - $600' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[iPhoneP]')
	elseif v.Name == '[PinkPhone] - $400' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[PinkPhone]')
	elseif v.Name == '[Old Phone] - $100' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[Old Phone]')
	elseif v.Name == '[Orange Phone] - $400' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[Orange Phone]')
	elseif v.Name == '[Original Phone] - $50' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Phone', '[Original Phone]')
	elseif v.Name == '[LockPicker] - $100' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[LockPicker]')
	elseif v.Name == '[LockPicker] - $125' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[LockPicker]')
	elseif v.Name == '[Key] - $125' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Key]')
	elseif v.Name == '[Firework] - $10000' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Firework]')
	elseif v.Name == '[Grenade] - $1250' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Grenade]')
	elseif v.Name == '[Grenade] - $700' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Grenade]')
	elseif v.Name == '[Flashbang] - $550' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Flashbang]')
	elseif v.Name == '[Camera] - $100' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Camera]')
	elseif v.Name == '[Knife] - $150' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Knife]')
	elseif v.Name == '[Pitchfork] - $320' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Pitchfork]')
	elseif v.Name == '[Bat] - $250' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Bat]')
	elseif v.Name == '[Bat] - $275' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Bat]')
	elseif v.Name == '[StopSign] - $300' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[StopSign]')
	elseif v.Name == '[Pencil] - $175' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Pencil]')
	elseif v.Name == '[Shovel] - $320' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Shovel]')
	elseif v.Name == '[SledgeHammer] - $350' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[SledgeHammer]')
	elseif v.Name == '[Nunchucks] - $450' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[Nunchucks]')
	elseif v.Name == '[BrownBag] - $25' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Misc', '[BrownBag]')
	elseif v.Name == '[SoloBike] - $25' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Vehicle', '[SoloBike]')
	elseif v.Name == '[DuoBike] - $75' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Vehicle', '[DuoBike]')	
	elseif v.Name == '[FoodsCart] - $15' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Vehicle', '[FoodsCart]')	
	elseif v.Name == '[Default Moveset] - $0' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Moveset', 'Default')	
	elseif v.Name == 'Boxing Moveset (Require: Max Box Stat) - $0' then
		SetupBuyButton(v:FindFirstChildOfClass('ClickDetector'), 'Moveset', 'Boxing')
	end
end
