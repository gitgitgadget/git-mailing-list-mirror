Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3547A87D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042273; cv=none; b=p7sNSoVc0+USp2FPAZp+AGYvDc6B/HRGInXlG7cUaSnEOwsBroWRZr7xfGX2bLjsoUZ0Uacjw3KWL8D04sT6H6fD6rYq4vwRT4up8tlB6/wGTC6gghG3sIpp8F5wA4ptpvwl1G+5KJti1OejccLy5zrhGOIszyuxj3cPK3JiF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042273; c=relaxed/simple;
	bh=NTmSPSOYDhICCSVQlYDhgWqzmUl7OLCft0Y6SA1xwco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFNZsaGD477wPE1sA5YpCEcKD2XsdYUXXP4e1jO+z8+Hwm9W/gfzyFENS5miRx2WmGLJ6Ie9t2KztFjtqdKXaA5Jxkv7ZmyJEMY+raj3V5J0IAvbZSBNkYKsDmCpn2y7Jk9qM/AIVkep5IaqWHWtgRiiD8fE+Uu026n37Zu60wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <glandium@glandium.org>)
	id 1x4dcM-0000000Gx3g-0RT9;
	Thu, 10 Sep 2026 12:11:05 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <glandium@goemon>)
	id 1x4dcI-0000000BXIo-27XE;
	Thu, 10 Sep 2026 21:10:58 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH v4] Move rust gitcore crate to a different subdirectory
Date: Thu, 10 Sep 2026 21:10:56 +0900
Message-ID: <20260910121056.2749578-1-mh@glandium.org>
X-Mailer: git-send-email 2.55.0.807.gc06c3eb732
In-Reply-To: <20260909013858.1729643-1-mh@glandium.org>
References: <20260909013858.1729643-1-mh@glandium.org>
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

Move all Rust-specific files into a dedicated `rust/` subdirectory.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 .gitignore                     |  4 ++--
 Makefile                       | 24 ++++++++++++------------
 meson.build                    |  2 +-
 Cargo.toml => rust/Cargo.toml  |  0
 build.rs => rust/build.rs      |  0
 {src => rust}/cargo-meson.sh   |  0
 {src => rust}/meson.build      | 16 ++++++++--------
 {src => rust/src}/csum_file.rs |  0
 {src => rust/src}/hash.rs      |  0
 {src => rust/src}/lib.rs       |  0
 {src => rust/src}/loose.rs     |  0
 {src => rust/src}/varint.rs    |  0
 12 files changed, 23 insertions(+), 23 deletions(-)
 rename Cargo.toml => rust/Cargo.toml (100%)
 rename build.rs => rust/build.rs (100%)
 rename {src => rust}/cargo-meson.sh (100%)
 rename {src => rust}/meson.build (81%)
 rename {src => rust/src}/csum_file.rs (100%)
 rename {src => rust/src}/hash.rs (100%)
 rename {src => rust/src}/lib.rs (100%)
 rename {src => rust/src}/loose.rs (100%)
 rename {src => rust/src}/varint.rs (100%)

diff --git a/.gitignore b/.gitignore
index 4da58c6754..add6597643 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,4 @@
 /fuzz_corpora
-/target/
-/Cargo.lock
 /GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
@@ -261,3 +259,5 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+/rust/target
+/rust/Cargo.lock
diff --git a/Makefile b/Makefile
index d4b775953d..38dc3cc548 100644
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
@@ -1571,11 +1571,11 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
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
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
@@ -3038,8 +3038,8 @@ $(LIB_FILE): $(LIB_OBJS)
 
 ifndef NO_RUST
 ifeq ($(RUST_TARGETS),)
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+$(RUST_LIB): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
+	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS)
 else
 ifneq ($(words $(RUST_TARGETS)),1)
 ifneq ($(uname_S),Darwin)
@@ -3047,9 +3047,9 @@ $(error Building universal Rust libraries requires macOS (lipo is not available
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
@@ -3913,7 +3913,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) -r Cargo.lock target/
+	$(RM) -r rust/Cargo.lock rust/target/
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
diff --git a/meson.build b/meson.build
index d86f2acd2b..c7ff7c2a73 100644
--- a/meson.build
+++ b/meson.build
@@ -1782,7 +1782,7 @@ libgit_sources += version_def_h
 
 rust_option = get_option('rust')
 if rust_option.allowed()
-  subdir('src')
+  subdir('rust')
   libgit_c_args += '-DWITH_RUST'
 
   if host_machine.system() == 'windows'
diff --git a/Cargo.toml b/rust/Cargo.toml
similarity index 100%
rename from Cargo.toml
rename to rust/Cargo.toml
diff --git a/build.rs b/rust/build.rs
similarity index 100%
rename from build.rs
rename to rust/build.rs
diff --git a/src/cargo-meson.sh b/rust/cargo-meson.sh
similarity index 100%
rename from src/cargo-meson.sh
rename to rust/cargo-meson.sh
diff --git a/src/meson.build b/rust/meson.build
similarity index 81%
rename from src/meson.build
rename to rust/meson.build
index 41a4b231e6..4c617371a5 100644
--- a/src/meson.build
+++ b/rust/meson.build
@@ -1,9 +1,9 @@
 libgit_rs_sources = [
-  'csum_file.rs',
-  'hash.rs',
-  'lib.rs',
-  'loose.rs',
-  'varint.rs',
+  'src/csum_file.rs',
+  'src/hash.rs',
+  'src/lib.rs',
+  'src/loose.rs',
+  'src/varint.rs',
 ]
 
 # Unfortunately we must use a wrapper command to move the output file into the
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
2.55.0.807.gc06c3eb732

