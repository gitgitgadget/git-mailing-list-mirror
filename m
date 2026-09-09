Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6C302CC1
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919366; cv=none; b=kbm/zln9vkzl5z8+uRaNvwa/Z3qQsjdmR7eBbufGEwle4RbGQ4AeJSG4Qi/g/hFRbCdkcscsOj4GKAFCfdFpmo/7evhRw7eOCJvdsgTVpxUHTimLX9rDJm1QLOXVj73IGEuze/EsPLADjioWuYzlV989e9sUIjtkbwzFfbq+JaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919366; c=relaxed/simple;
	bh=UT252Y1pmh/sEdC7g4G+3sicnvpQEf31kpPGq+yWyUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8IrmkSzB+7AnFjJSoTc0VF/KIyAinyN2JPiguhCWx3GGUmpBb+WZi4iWDqSnD6LoRxIgSYbzIG7B0ECkqyYheQkysfQ0NYR5iCBR0Te4S7CyASr44W7SWjVY6s1mR5btHMjOx9VDrj+ZWRjP1drXYZUggNIYGQT6f9ORbX/P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <glandium@glandium.org>)
	id 1x47HQ-0000000DaDD-22i9;
	Wed, 09 Sep 2026 01:39:17 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <glandium@goemon>)
	id 1x47HK-00000007FyH-2V0a;
	Wed, 09 Sep 2026 10:39:10 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH v3] Move rust gitcore crate to a different subdirectory
Date: Wed,  9 Sep 2026 10:38:58 +0900
Message-ID: <20260909013858.1729643-1-mh@glandium.org>
X-Mailer: git-send-email 2.55.0.806.gb8242b093d.dirty
In-Reply-To: <20260209224847.1416916-1-mh@glandium.org>
References: <20260209224847.1416916-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having `Cargo.toml` at the top-level of the repository implies that one
can run `cargo build` directly, but this doesn't produce anything useful
on its own.

Additionally, when including the git source as a submodule of a Rust
project, it prevents the git source from being included at all in the
crate package because cargo skips directories that contain a Cargo.toml,
assuming that everything in the directory is relevant to the crate.

This moves all Rust-specific files into a dedicated `rust/`
subdirectory.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 .gitignore                     |  2 ++
 Makefile                       | 26 ++++++++++++++------------
 meson.build                    |  2 +-
 Cargo.toml => rust/Cargo.toml  |  0
 {src => rust}/cargo-meson.sh   |  0
 {src => rust}/meson.build      |  6 +++---
 {src => rust/src}/csum_file.rs |  0
 {src => rust/src}/hash.rs      |  0
 {src => rust/src}/lib.rs       |  0
 {src => rust/src}/loose.rs     |  0
 {src => rust/src}/varint.rs    |  0
 11 files changed, 20 insertions(+), 16 deletions(-)
 rename Cargo.toml => rust/Cargo.toml (100%)
 rename {src => rust}/cargo-meson.sh (100%)
 rename {src => rust}/meson.build (88%)
 rename {src => rust/src}/csum_file.rs (100%)
 rename {src => rust/src}/hash.rs (100%)
 rename {src => rust/src}/lib.rs (100%)
 rename {src => rust/src}/loose.rs (100%)
 rename {src => rust/src}/varint.rs (100%)

diff --git a/.gitignore b/.gitignore
index 4da58c6754..3ac0685800 100644
--- a/.gitignore
+++ b/.gitignore
@@ -261,3 +261,5 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+/rust/target
+/rust/Cargo.lock
diff --git a/Makefile b/Makefile
index d4b775953d..7991fa378d 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = rust/target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -1571,11 +1571,13 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-RUST_SOURCES += src/csum_file.rs
-RUST_SOURCES += src/hash.rs
-RUST_SOURCES += src/lib.rs
-RUST_SOURCES += src/loose.rs
-RUST_SOURCES += src/varint.rs
+RUST_SOURCES += rust/src/csum_file.rs
+RUST_SOURCES += rust/src/hash.rs
+RUST_SOURCES += rust/src/lib.rs
+RUST_SOURCES += rust/src/loose.rs
+RUST_SOURCES += rust/src/varint.rs
+RUST_SOURCES += rust/src/lib.rs
+RUST_SOURCES += rust/src/varint.rs
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
@@ -3038,8 +3040,8 @@ $(LIB_FILE): $(LIB_OBJS)
 
 ifndef NO_RUST
 ifeq ($(RUST_TARGETS),)
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+$(RUST_LIB): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
+	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS)
 else
 ifneq ($(words $(RUST_TARGETS)),1)
 ifneq ($(uname_S),Darwin)
@@ -3047,9 +3049,9 @@ $(error Building universal Rust libraries requires macOS (lipo is not available
 endif
 endif
 
-RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
-$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
+RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),rust/target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
+$(RUST_MEMBER_LIBS): rust/target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
+	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS) --target $*
 
 $(RUST_LIB): $(RUST_MEMBER_LIBS)
 	$(call mkdir_p_parent_template)
@@ -3913,7 +3915,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) -r Cargo.lock target/
+	$(RM) -r Cargo.lock rust/target/
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
diff --git a/meson.build b/meson.build
index d86f2acd2b..b91d30666e 100644
--- a/meson.build
+++ b/meson.build
@@ -1782,7 +1782,7 @@ libgit_sources += version_def_h
 
 rust_option = get_option('rust')
 if rust_option.allowed()
-  subdir('src')
+  subdir('rust/src')
   libgit_c_args += '-DWITH_RUST'
 
   if host_machine.system() == 'windows'
diff --git a/Cargo.toml b/rust/Cargo.toml
similarity index 100%
rename from Cargo.toml
rename to rust/Cargo.toml
diff --git a/src/cargo-meson.sh b/rust/cargo-meson.sh
similarity index 100%
rename from src/cargo-meson.sh
rename to rust/cargo-meson.sh
diff --git a/src/meson.build b/rust/meson.build
similarity index 88%
rename from src/meson.build
rename to rust/meson.build
index 41a4b231e6..495931f75a 100644
--- a/src/meson.build
+++ b/rust/meson.build
@@ -13,7 +13,7 @@ libgit_rs_sources = [
 cargo_command = [
   shell,
   meson.current_source_dir() / 'cargo-meson.sh',
-  meson.project_source_root(),
+  meson.current_source_dir(),
   meson.current_build_dir(),
 ]
 if get_option('buildtype') == 'release'
@@ -22,7 +22,7 @@ endif
 
 libgit_rs = custom_target('git_rs',
   input: libgit_rs_sources + [
-    meson.project_source_root() / 'Cargo.toml',
+    meson.current_source_dir() / 'Cargo.toml',
   ],
   output: 'libgitcore.a',
   command: cargo_command,
@@ -35,7 +35,7 @@ if get_option('tests')
     args: [
       'test',
       '--manifest-path',
-      meson.project_source_root() / 'Cargo.toml',
+      meson.current_source_dir() / 'Cargo.toml',
       '--target-dir',
       meson.current_build_dir() / 'target',
     ],
diff --git a/src/csum_file.rs b/rust/src/csum_file.rs
similarity index 100%
rename from src/csum_file.rs
rename to rust/src/csum_file.rs
diff --git a/src/hash.rs b/rust/src/hash.rs
similarity index 100%
rename from src/hash.rs
rename to rust/src/hash.rs
diff --git a/src/lib.rs b/rust/src/lib.rs
similarity index 100%
rename from src/lib.rs
rename to rust/src/lib.rs
diff --git a/src/loose.rs b/rust/src/loose.rs
similarity index 100%
rename from src/loose.rs
rename to rust/src/loose.rs
diff --git a/src/varint.rs b/rust/src/varint.rs
similarity index 100%
rename from src/varint.rs
rename to rust/src/varint.rs
-- 
2.55.0.806.gb8242b093d.dirty

