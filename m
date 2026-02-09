Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30483081BA
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677355; cv=none; b=BiL/TManmMSXVrBfcFVb9GtmVlQCFw251EvLJ6TlHOHNys77LZPLK3wR4HhWMdfV6vRqT/HDsf5uQ5PmAcUYcyJMCiJfBGV/WoJ3G8ayiIwBYoaBVO5Twq5GQEPmgl0NGm/FJOp5V/g5S1ew6xD4dbwq0Xz2Uwjni5b/T/TxNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677355; c=relaxed/simple;
	bh=OzRpEH8RCEE19DjkcPAWfB3AoN9RhZtfRwI4EM3SQXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi17wfHx5H4h36AFjqiB1Fh/bNKo3o24bRpNgfWZHtDsipbOPoanuA7roLuYl9/ahvOrzm5tdpv83gARUVXEyAKcWDeZ4zzTghjOMGkEWQC7H7aj4dzn22AVEVGrjOZGpD7AN9XBJf9NRxfa65W/0MRHxKP8c81Yje4xGUFQnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <glandium@glandium.org>)
	id 1vpa3x-00000001MZc-24oj;
	Mon, 09 Feb 2026 22:49:02 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <glandium@goemon>)
	id 1vpa3p-00000005wc5-0ay8;
	Tue, 10 Feb 2026 07:48:53 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH v2] Move rust gitcore crate to a different subdirectory
Date: Tue, 10 Feb 2026 07:48:47 +0900
Message-ID: <20260209224847.1416916-1-mh@glandium.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204232208.1615320-1-mh@glandium.org>
References: <20260204232208.1615320-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While `src/` is the default directory convention for Rust projects, it
is too generic in the context of a multi-language project that is barely
starting to (optionally) use Rust code.

Additionally, having `Cargo.toml` at the top-level of the repository
implies that one can run `cargo build` directly, but this doesn't
produce anything useful on its own.

Moving all Rust-specific files into a dedicated `rust/` subdirectory
makes things clearer.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 .gitignore                    |  2 ++
 Makefile                      | 12 ++++++------
 meson.build                   |  2 +-
 Cargo.toml => rust/Cargo.toml |  0
 {src => rust}/cargo-meson.sh  |  0
 {src => rust}/meson.build     |  6 +++---
 {src => rust/src}/lib.rs      |  0
 {src => rust/src}/varint.rs   |  0
 8 files changed, 12 insertions(+), 10 deletions(-)
 rename Cargo.toml => rust/Cargo.toml (100%)
 rename {src => rust}/cargo-meson.sh (100%)
 rename {src => rust}/meson.build (87%)
 rename {src => rust/src}/lib.rs (100%)
 rename {src => rust/src}/varint.rs (100%)

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..c7453b6fb2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -258,3 +258,5 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+/rust/target
+/rust/Cargo.lock
diff --git a/Makefile b/Makefile
index 8aa489f3b6..b60af704ed 100644
--- a/Makefile
+++ b/Makefile
@@ -939,9 +939,9 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 
 ifdef DEBUG
-RUST_TARGET_DIR = target/debug
+RUST_TARGET_DIR = rust/target/debug
 else
-RUST_TARGET_DIR = target/release
+RUST_TARGET_DIR = rust/target/release
 endif
 
 ifeq ($(uname_S),Windows)
@@ -1545,8 +1545,8 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-RUST_SOURCES += src/lib.rs
-RUST_SOURCES += src/varint.rs
+RUST_SOURCES += rust/src/lib.rs
+RUST_SOURCES += rust/src/varint.rs
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
@@ -3007,8 +3007,8 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+$(RUST_LIB): rust/Cargo.toml $(RUST_SOURCES)
+	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS)
 
 .PHONY: rust
 rust: $(RUST_LIB)
diff --git a/meson.build b/meson.build
index dd52efd1c8..3a92936241 100644
--- a/meson.build
+++ b/meson.build
@@ -1723,7 +1723,7 @@ libgit_sources += version_def_h
 cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
 rust_option = get_option('rust').disable_auto_if(not cargo.found())
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
similarity index 87%
rename from src/meson.build
rename to rust/meson.build
index 25b9ad5a14..9490272521 100644
--- a/src/meson.build
+++ b/rust/meson.build
@@ -10,7 +10,7 @@ libgit_rs_sources = [
 cargo_command = [
   shell,
   meson.current_source_dir() / 'cargo-meson.sh',
-  meson.project_source_root(),
+  meson.current_source_dir(),
   meson.current_build_dir(),
 ]
 if get_option('buildtype') == 'release'
@@ -19,7 +19,7 @@ endif
 
 libgit_rs = custom_target('git_rs',
   input: libgit_rs_sources + [
-    meson.project_source_root() / 'Cargo.toml',
+    meson.current_source_dir() / 'Cargo.toml',
   ],
   output: 'libgitcore.a',
   command: cargo_command,
@@ -31,7 +31,7 @@ if get_option('tests')
     args: [
       'test',
       '--manifest-path',
-      meson.project_source_root() / 'Cargo.toml',
+      meson.current_source_dir() / 'Cargo.toml',
       '--target-dir',
       meson.current_build_dir() / 'target',
     ],
diff --git a/src/lib.rs b/rust/src/lib.rs
similarity index 100%
rename from src/lib.rs
rename to rust/src/lib.rs
diff --git a/src/varint.rs b/rust/src/varint.rs
similarity index 100%
rename from src/varint.rs
rename to rust/src/varint.rs
-- 
2.52.0

