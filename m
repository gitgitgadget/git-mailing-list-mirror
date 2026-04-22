Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F711370D43
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842490; cv=none; b=G7T0jjdrJRZx7hEv9yKVrTen/SpSssv/Cz5ysS7qHz3e1KYSwiyMsrxBzwPRAWVHjkjtB6wa72ufmnrN4ppfFHNVyb2bX9Q9SX18Nf3AJY13eeQqAU3pjpgC0+135sAeoMfFIUrmV5tguI6dIZSOdoIqFjBIRDk+0S3sOWE+ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842490; c=relaxed/simple;
	bh=UWwDN7s5iv+8aT8DSfdgUMAoyKGoOxEItzhAfJIBerw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=pnaPxx/qlth9Dc5nak8mDv/FPw5had9yDx80Uuk9CjxGUAX3bsnQkcE7JMiWv0ahQcRYcRLNw//hVdVQKslCpP1Dh5aMLhkjyRqcd6Uxfk5TmMuEmvXjzJCNyqHfJDu5R/wOkpJurvfPEsjc4yxCjWIkI1LhsHXBce6K2oGF3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=L3nD11V4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="L3nD11V4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1776842486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeiFQVSZ3qaNwMJfEV9jZ0KNJAl+lnH+1rm+XcO9N0U=;
	b=L3nD11V4dc8NSeKG/NXfSYP1ZVmZQ4Zo9Y8BK4QCyDjOblwSD7OPwuE/yHWfb55WY+INrr
	Caz8t4Yht6cpjkkEAIrUngjrWpQJAHQxKgQXW73iV7TR2L7uu+Y1jTFyWXOqo1pHV/fpaF
	aUqOZRIPrzgfDJS0LXvuI3IQl0Tw8l0=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 22 Apr 2026 09:21:20 +0200
Subject: [PATCH v2] generate-configlist: collapse depfile for older Ninja
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RimogFX3sOwqO0oY7A1bSEYw
 t0tuHf5kvffnyFyEI5wLmYIPEoU7zKoXQGm0+7BKDYzqFKdykoRJu8d3mVC3b90L26YaqRSWW7
 oUKumgrx8B87GVr22P47D7ckmranV6CQmHz7b7Uir9/9hJCTUbMgeK22t5Yv4ZPq98S9ol2X5A
 stJgbbIAAAA
X-Change-ID: 20260421-toon-fix-almalinux8-102de9138294
In-Reply-To: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
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

To be compatible with older versions of Ninja, collapse the dependencies
for `config-list.h` into a single line like:

    config-list.h: Documentation/config.adoc Documentation/config/add.adoc ...

This works around the bug in older versions of Ninja, and is fully
compatible Make and with more recent versions of Ninja. And while the
no-op targets are not needed for Ninja, they also don't do any harm.

Helped-by: Patrick Steinhardt <ps@pks.im>
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
Changes in v2:
- Simplify the changes *a lot* by doing the collapsing unconditionally.
- Link to v1: https://patch.msgid.link/20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com
---
 tools/generate-configlist.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
index e28054f9e0..f5f42492c6 100755
--- a/tools/generate-configlist.sh
+++ b/tools/generate-configlist.sh
@@ -44,7 +44,9 @@ then
 	{
 		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
-			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
+			sed -e 's/[# ]/\\&/g' |
+			tr '\n' ' ' |
+			sed -e "s/^/$QUOTED_OUTPUT: /" -e 's/ $/\n/'
 		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
 			sed -e 's/[# ]/\\&/g'

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260421-toon-fix-almalinux8-102de9138294

