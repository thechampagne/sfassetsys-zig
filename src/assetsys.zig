// Copyright 2023 XXIV
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
pub const ASSETSYS_U64 = c_ulonglong;

pub const assetsys_error_t = enum(c_int) {
    SUCCESS = 0,
    INVALID_PATH = -1,
    INVALID_MOUNT = -2, 
    FAILED_TO_READ_ZIP = -3,
    FAILED_TO_CLOSE_ZIP = -4,
    FAILED_TO_READ_FILE = -5,
    FILE_NOT_FOUND = -6,
    DIR_NOT_FOUND = -7, 
    INVALID_PARAMETER = -8,
    BUFFER_TOO_SMALL = -9
};

pub const assetsys_t = opaque {};

pub const assetsys_file_t = extern struct {
    mount: ASSETSYS_U64,
    path: ASSETSYS_U64,
    index: c_int,
};

pub extern "C" fn assetsys_create(memctx: ?*anyopaque) ?*assetsys_t;
pub extern "C" fn assetsys_destroy(sys: ?*assetsys_t) void;
pub extern "C" fn assetsys_mount(sys: ?*assetsys_t, path: [*c]const u8, mount_as: [*c]const u8) assetsys_error_t;
pub extern "C" fn assetsys_dismount(sys: ?*assetsys_t, path: [*c]const u8, mounted_as: [*c]const u8) assetsys_error_t;
pub extern "C" fn assetsys_file(sys: ?*assetsys_t, path: [*c]const u8, file: [*c]assetsys_file_t) assetsys_error_t;
pub extern "C" fn assetsys_file_load(sys: ?*assetsys_t, file: assetsys_file_t, size: [*c]c_int, buffer: ?*anyopaque, capacity: c_int) assetsys_error_t;
pub extern "C" fn assetsys_file_size(sys: ?*assetsys_t, file: assetsys_file_t) c_int;
pub extern "C" fn assetsys_file_count(sys: ?*assetsys_t, path: [*c]const u8) c_int;
pub extern "C" fn assetsys_file_name(sys: ?*assetsys_t, path: [*c]const u8, index: c_int) [*c]const u8;
pub extern "C" fn assetsys_file_path(sys: ?*assetsys_t, path: [*c]const u8, index: c_int) [*c]const u8;
pub extern "C" fn assetsys_subdir_count(sys: ?*assetsys_t, path: [*c]const u8) c_int;
pub extern "C" fn assetsys_subdir_name(sys: ?*assetsys_t, path: [*c]const u8, index: c_int) [*c]const u8;
pub extern "C" fn assetsys_subdir_path(sys: ?*assetsys_t, path: [*c]const u8, index: c_int) [*c]const u8;
