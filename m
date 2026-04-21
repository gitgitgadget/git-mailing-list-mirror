Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326C24886A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799080; cv=none; b=dxKjuz3j9MvHsRNW8pmgJY4D6qh3hJORnGmAqjhPsBofTK4ostGrn0577q4F+0ixNsxYkCalUtDeN77RqthnwryUUHByzCBhxcgNWGQBvjR7oqgP6JI+yddH/4o7hXXsh4K8Av/7BntZLSiAvFBxurSv+DuCnfZlxypec7168Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799080; c=relaxed/simple;
	bh=yn0PRozmJ/ytDX/dp9LGU44ZmQ6EFn/7HMKcFmOVZz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=trhlY6yWXv2Qh4GzvAiu5e7Nn0lT4dYciYEV1qUJuhf4zg4hNgs9CCclbcLF8bdKkMj3GGoxbCCbDvfFTz9g8qTOqEasEBY2kOtswNdTLI7Lg++FoPN5Is2iat3s8uP6LHV5cq/e/OJoYI4pxZ1CtLGDGk95ARSY2lTU7QiK1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0d1bejuI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0d1bejuI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1776799075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24CcZD2B+OChzNOBAoM5ny57z+Nt+buhvfjP7Sp10Xg=;
	b=0d1bejuIY63f4GbSNVu/VQrflSORWDzV6d0YtC6c+owihvL+mz7HWCuJKZn5phlJq5ZGuv
	OXcJeZRBClLYDi+JfjtHEjCk1mGfTKxKicRwk0w8Ls0JzuIgJIONco21QFzE3N24vcXWSR
	Vp8AvDYF70+UbTXHmKo24L3gy9d2WoM=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 21 Apr 2026 21:17:25 +0200
Subject: [PATCH] generate-configlist: collapse depfile for older Ninja
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0Q5EMBCF4VeRud5J2iGCVxEXXQYjtNKykYh3V
 /byS875TwjshQNUyQmefxLE2Qj9SaAdjR0YpYsGUpSrjDRuzlns5UAzL2YWux8FakUdlzotqMw
 gPlfPcfFW6+bvsH8nbrcnBdd1Aywbt+53AAAA
X-Change-ID: 20260421-toon-fix-almalinux8-102de9138294
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The tools/generate-configlist.sh script generates two files:
  * config-list.h
  * config-list.h.d

The former is included by the source code and the latter defines on
which files the former depends.

The contents of `config-list.h.d` consists of two sections:

    config-list.h: Documentation/config.adoc
    config-list.h: Documentation/git-config.adoc
    config-list.h: Documentation/config/add.adoc
    config-list.h: Documentation/config/advice.adoc
    config-list.h: Documentation/config/alias.adoc
    config-list.h: Documentation/config/am.adoc
    config-list.h: Documentation/config/apply.adoc
    ...

This first section actually defines on which individual files
`config-list.h` depends and thus needs to be rebuild if one of those
changes.

And the second section contains content like:

    Documentation/config.adoc:
    Documentation/git-config.adoc:
    Documentation/config/add.adoc:
    Documentation/config/advice.adoc:
    Documentation/config/alias.adoc:
    Documentation/config/am.adoc:
    Documentation/config/apply.adoc:
    ...

These rules exist to ensure Make won't fail with the following error if
one of the .adoc files is renamed or removed:

   make: *** No rule to make target 'Documentation/config.adoc', needed by 'config-list.h'.

With the no-op targets defined in `config-list.h.d`, Make knows there's
no work to be done to generate these files, so it doesn't error out if
it doesn't exist.

For the Makefile build system this works great. And since
ebeea3c471 (build: regenerate config-list.h when Documentation changes,
2026-02-24) this script is also called from the Meson build system.
Nevertheless, on AlmaLinux 8 the following build failure is seen:

    ninja: error: dependency cycle: config-list.h -> config-list.h

This version of this distro uses Ninja 1.8.2 and it seems to have some
issues with the format of the `config-list.h.d` file.

Ninja versions before 1.10.0 do not reset the depfile parser state on
newlines. This causes issues when the depfile has one dependency per
line, like we have in `config-list.h.d`:

    config-list.h: Documentation/config.adoc
    config-list.h: Documentation/config/add.adoc

The parser only recognizes the first "config-list.h:" as a target. On
subsequent lines it is still in dependency-parsing mode, so the repeated
output name is recorded as an input. This causes the error mentioned
above.

The bug in Ninja is fixed in 1.10, with commit
ninja-build/ninja@1daa7470ab7e (depfile_parser: remove restriction on
multiple outputs, 2019-11-20).

To be compatible with older versions of Ninja, add a fourth optional
argument to `generate-configlist.sh` that can be empty or "collapse".
When this argument is "collapse", there is a post-processing step on
`config-list.h.d` to put the dependencies for `config-list.h` on a
single line, like:

    config-list.h: Documentation/config.adoc Documentation/config/add.adoc ...

This works around the bug in older versions of Ninja.

In `meson.build`, the Ninja version is detected to determine if the
"collapse" argument needs to be provided to the script. Thus newer
versions of Ninja, and the Makefile build system still get dependencies
on separate lines in `config-list.h.d`.

In this post-processing, also the no-op targets are dropped because they
are simply not needed for Ninja.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
At GitLab we build images for various distros, including AlmaLinux 8.
On this distro we got this error while compiling Git.

    ninja: error: dependency cycle: config-list.h -> config-list.h

It seems this is caused by a bug in older versions of Ninja. There are
more details in the commit message, but here are a few simple steps to
reproduce:

docker run --rm -it -v $(pwd):/git -w /git almalinux:8 bash
    dnf -yq install epel-release
    dnf -yq install shadow-utils sudo make pkg-config gcc findutils \
        diffutils perl python3 gawk gettext zlib-devel expat-devel \
        openssl-devel curl-devel pcre2-devel cargo
    pip3 install --prefix=/usr meson ninja==1.8.2
    meson setup build --warnlevel 2 --werror
    ninja -C build config-list.h
    ninja -C build config-list.h   # fails with dependency cycle
---
 meson.build                  | 10 ++++++++++
 tools/generate-configlist.sh | 24 +++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 11488623bf..44e6f679c3 100644
--- a/meson.build
+++ b/meson.build
@@ -725,6 +725,15 @@ if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif
 
+configlist_gen_format = ''
+if get_option('backend') == 'ninja'
+  ninja = find_program('ninja', 'ninja-build', native: true)
+  ninja_version = run_command(ninja, '--version', check: true).stdout().strip()
+  if ninja_version.version_compare('<1.10.0')
+    configlist_gen_format = 'collapse'
+  endif
+endif
+
 builtin_sources += custom_target(
   output: 'config-list.h',
   depfile: 'config-list.h.d',
@@ -735,6 +744,7 @@ builtin_sources += custom_target(
     meson.current_source_dir(),
     '@OUTPUT@',
     '@DEPFILE@',
+    configlist_gen_format,
   ],
   env: script_environment,
 )
diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
index e28054f9e0..553fbfeb4b 100755
--- a/tools/generate-configlist.sh
+++ b/tools/generate-configlist.sh
@@ -3,10 +3,14 @@
 SOURCE_DIR="$1"
 OUTPUT="$2"
 DEPFILE="$3"
+FORMAT="${4}"
 
 if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
 then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE> [collapse]]"
+	echo >&2 ""
+	echo >&2 "  Pass 'collapse' to write all deps on a single line."
+	echo >&2 "  Ninja < 1.10.0 chokes on depfiles with multiple lines."
 	exit 1
 fi
 
@@ -49,4 +53,22 @@ then
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
 			sed -e 's/[# ]/\\&/g'
 	} >"$DEPFILE"
+
+	# Due to a bug in Ninja versions before 1.10.0 the depfile parser state
+	# is not reset on newlines, causing the target to be recorded as a
+	# dependency of itself when there is one dependency per line.
+	# The bug is fixed in ninja-build/ninja@1daa7470ab7e (depfile_parser:
+	# remove restriction on multiple outputs, 2019-11-20).
+	# But to work around the issue, do a "collapse" post-processing step
+	# if wanted.
+	if test "$FORMAT" = "collapse"
+	then
+		{
+			printf '%s: ' "$OUTPUT"
+			sed -n -e "s/^$QUOTED_OUTPUT: //p" "$DEPFILE" |
+				tr '\n' ' '
+			echo
+		} >"$DEPFILE.tmp"
+		mv "$DEPFILE.tmp" "$DEPFILE"
+	fi
 fi

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260421-toon-fix-almalinux8-102de9138294

