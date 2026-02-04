Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97FEEC0
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249656; cv=none; b=n3FzyNtXwUtBH5IYfgcHQcLNiazz9x/4NKMHZtuQQVD6/7I7BSdA+GoTicqNtYQ1AwuIm0ouB8+O6sQGGKgmTnHvHJ2ep4Ke4L2cqXNK/efdWtl7UujMJ/XG7w4rfuyIYa0YNLQJM40mGBkulYwqKl4ZySYRwH+ehvKggZahUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249656; c=relaxed/simple;
	bh=DQ/rOBieK/5ygha+Q+V42NJLplrmN8ikceDMg3q/wgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCOfF0rKufPJLYu3gfVOi9J1YJj5XEy05mBneP9NZ6wySgu/xAXXuLT7hpCdkVDqT3opWNUfeLo7u9KCtbHwvj/3w/K8vQhAIPrLwAYwPYDE8yS6vnslBUNdlHtI5CEPBH2h2V1tFMBJUBL7eazMs4PEvYn4U44ieAz418OsA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <glandium@glandium.org>)
	id 1vnmCc-000000070nE-2upR;
	Wed, 04 Feb 2026 23:22:32 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <glandium@goemon>)
	id 1vnmCU-00000006mFG-0pTI;
	Thu, 05 Feb 2026 08:22:22 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Mike Hommey <mh@glandium.org>
Subject: [RFC PATCH] Move rust gitcore crate to a different subdirectory
Date: Thu,  5 Feb 2026 08:22:08 +0900
Message-ID: <20260204232208.1615320-1-mh@glandium.org>
X-Mailer: git-send-email 2.53.0.1.g318204b87e.dirty
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

---

The above is a post hoc justification. I do think it makes sense to do,
but I should mention my real immediate motivation.

git-cinnabar, a git remote helper used to talk to Mercurial servers, is
a project based on libgit (the C parts). As such, its repository
includes the git codebase as a submodule.

As of about 3 years ago, most code that is not libgit in git-cinnabar is
written in Rust, and is published on crates.io.

Part of publishing on crates.io involves running `cargo publish`, which
does `cargo package` under the hood. `cargo package` has the feature
of... not including directories that contain a Cargo.toml, so upgrading
libgit to 2.52.0 breaks the publishing process because all of the git
source code is skipped, and git-cinnabar can't be built as a result.

Of course, what this means is that this change is merely kicking the can
down the road, because the problem will reappear when the rust code
becomes non-optional in Git, thus why I'm making this RFC at the moment.

 .gitignore                    |  2 ++
 Makefile                      | 12 ++++++------
 meson.build                   |  2 +-
 Cargo.toml => rust/Cargo.toml |  1 +
 {src => rust}/cargo-meson.sh  |  0
 {src => rust}/lib.rs          |  0
 {src => rust}/meson.build     |  0
 {src => rust}/varint.rs       |  0
 8 files changed, 10 insertions(+), 7 deletions(-)
 rename Cargo.toml => rust/Cargo.toml (89%)
 rename {src => rust}/cargo-meson.sh (100%)
 rename {src => rust}/lib.rs (100%)
 rename {src => rust}/meson.build (100%)
 rename {src => rust}/varint.rs (100%)

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
index 8aa489f3b6..d7e9b7fd75 100644
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
+RUST_SOURCES += rust/lib.rs
+RUST_SOURCES += rust/varint.rs
 
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
index dd52efd1c8..6732198042 100644
--- a/meson.build
+++ b/meson.build
@@ -1723,7 +1723,7 @@ libgit_sources += version_def_h
 cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
 rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
-  subdir('src')
+  subdir('rust')
   libgit_c_args += '-DWITH_RUST'
 
   if host_machine.system() == 'windows'
diff --git a/Cargo.toml b/rust/Cargo.toml
similarity index 89%
rename from Cargo.toml
rename to rust/Cargo.toml
index 2f51bf5d5f..29e6d1f4e1 100644
--- a/Cargo.toml
+++ b/rust/Cargo.toml
@@ -6,5 +6,6 @@ rust-version = "1.49.0"
 
 [lib]
 crate-type = ["staticlib"]
+path = "lib.rs"
 
 [dependencies]
diff --git a/src/cargo-meson.sh b/rust/cargo-meson.sh
similarity index 100%
rename from src/cargo-meson.sh
rename to rust/cargo-meson.sh
diff --git a/src/lib.rs b/rust/lib.rs
similarity index 100%
rename from src/lib.rs
rename to rust/lib.rs
diff --git a/src/meson.build b/rust/meson.build
similarity index 100%
rename from src/meson.build
rename to rust/meson.build
diff --git a/src/varint.rs b/rust/varint.rs
similarity index 100%
rename from src/varint.rs
rename to rust/varint.rs
-- 
2.53.0.1.g318204b87e.dirty

