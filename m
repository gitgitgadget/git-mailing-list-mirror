Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8ED1EA7DB
	for <git@vger.kernel.org>; Fri, 15 May 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834566; cv=none; b=eqCTOMtngkMbVe8eNdaCSp+64dP9Obpo1//wnn5UoQzTTbTt+Uu5O6z0hneKhNLstpuD0H1CkEGfmLlOKoaFF+3qlITPLQitrQMyppsVKHlj5GFwhsAbXiRSw2xhK3xq9ROISjC3k4pTJyYqR7qMLUkhjKYa7Xdx7meri+VLUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834566; c=relaxed/simple;
	bh=qU/BULo75FHoH6oN4Rz5efxd19H2JWRsH++Kkg6IgvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=BSG17TunBBTjdhF41RUoMemfQQSif6h3zQ7b4WekLZ2S0JxzlipK50KL9s+KzF7xR+4VThCrdNKndtkySfDhiJGhC1/bRqYGcT+BkYxmHf6OYE+9fxF5fjfGmOKFrditb2GE3N8Xmd3sIkoIiEeFUZ9v/xSzFslX7e7gCnx59RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5rD0udeL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5rD0udeL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778834559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg24UOdK1bGiqYQNNUieUbEeaB3bydwJWjyXvzpj3i4=;
	b=5rD0udeLjGq0GpfbuItbAbsjpQE7CE0GByNpcizB3YvhQREizpvL3nc6gO0rB1UQ5BLnTe
	jtFoNqumIBlUA17W4/yu7x8TfALEwoIbypB7F/TfgBlLvxRwB+44f9mv0UXaOd86Ju8Xfi
	iNyWNHHeHPmvQ9pcY0qOVgyBnysG2+A=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 15 May 2026 10:42:26 +0200
Subject: [PATCH v3] generate-configlist: collapse depfile for older Ninja
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBQFr9KwFtNPqbauvIdxgfC1mBYMUFLT9
 O5C3XRhXE4yb95MPDqNnpyKmTiM2mtrElS7gshOmAdSrRITVrJDyRnQYK2hdz1R0Q+i12acGgo
 lU9hC1bCWk7R8OUzGWr1cv+zH2xNlyKlsdNoH697rbYTs/X+IQIEKlKBqLpRSeNY2yH4v7UDyQ
 2TbBvvdYKnBa9XwI6Aqsd02lmX5AOiigGIMAQAA
X-Change-ID: 20260421-toon-fix-almalinux8-102de9138294
In-Reply-To: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
References: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
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
Changes in v3:
- Stop using \n in sed(1) replacement strings because it is not
  portable.
- Link to v2: https://patch.msgid.link/20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com

Changes in v2:
- Simplify the changes *a lot* by doing the collapsing unconditionally.
- Link to v1: https://patch.msgid.link/20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com
---
 tools/generate-configlist.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
index e28054f9e0..d1d2ba4bb7 100755
--- a/tools/generate-configlist.sh
+++ b/tools/generate-configlist.sh
@@ -42,9 +42,12 @@ if test -n "$DEPFILE"
 then
 	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
 	{
+		printf '%s' "$QUOTED_OUTPUT: "
 		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
-			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
+			sed -e 's/[# ]/\\&/g' |
+			tr '\n' ' '
+		printf '\n'
 		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
 			"$SOURCE_DIR"/Documentation/config/*.adoc |
 			sed -e 's/[# ]/\\&/g'

---
base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
change-id: 20260421-toon-fix-almalinux8-102de9138294

