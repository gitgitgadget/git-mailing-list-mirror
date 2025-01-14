Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2020F960
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853348; cv=none; b=oEt1zw/RCwtfZ6zw+Q6bMzVPmE9XAsqMkMl1FQTY4Lqd7unsjd9azDHNvHztwrVYdLTglZ0sJL8a186j1Xa+/7i0oUm45uE4+9IjXUZeqF+Kgq2KiGPdRhdPH0c5czEOwC+wzFpfRz+ityCQiLNS60S5iL8V/Is2Y9WEyBVaH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853348; c=relaxed/simple;
	bh=53fOaEUPKt3KbRmbAF56TL3tF7G2qE24X6ow4c7/0t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=kZXRy0hboV/i9pHDdwOwY4CSAb7aYtClL1cKuDTuGRslqEhBJpooVVG8eGLzOHH/uBZe1nkh4eiD7HWu2E2MXVRfgBxIAQ84WpX8ob1csg9KwSBkDfkMWkndkx3/qsKGhz9MpC1mhsNqTuECiNNjDHMirYB6DpAXa27GTzxiAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gNk1UZuj; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gNk1UZuj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736853336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DHxK6PGZwxhMl3kYoXvcQw24WwAu0IFdA7DfESXK5A=;
	b=gNk1UZujZ3mMZK6hNAiilYYZXuT/Xc2dlwzNvHlQ66pRG8sXykFGOsM7PNtcNRjvnKl4g/
	62eecv+IZntQt6zgZclkfoRE+OcUrgLLF2sp8MSXOdd+HQYDlLQq6v/3CYMfJOMuljcKke
	kC7Bp9dATrTBM6VAZWMlRN+mYIR/RLw=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 14 Jan 2025 12:15:23 +0100
Subject: [PATCH v2] meson: ensure correct version-def.h is used
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-toon-fix-meson-version-v2-1-66ddb1a82c28@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAEpHhmcC/4WNSw7CMAxEr1J5jVET8xGsuAfqoiQutUQblEQRq
 MrdcXsBdn6jmecFEkfhBNdmgchFkoRZwe4acGM/PxnFK4Nt7bE1hjCHMOMgH5w46VU4rhMkf/B
 Eg+8fTKDjd2QtbeJ7pzxKyiF+tz/FrOlfZTFo8HKiM1uVWqabhOxeexcm6GqtP+8RQqC8AAAA
X-Change-ID: 20250113-toon-fix-meson-version-3d4d33fdabe3
In-Reply-To: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

To build the libgit-version library, Meson first generates
`version-def.h` in the build directory. Then it compiles `version.c`
into a library. During compilation, Meson tells to include both the
build directory and the project root directory.

However, when the user previously has compiled Git using Make, they will
have a `version-def.h` file in project root directory as well. Because
`version-def.h` is included in `version.c` using the #include directive
with double quotes, some preprocessors will look for the header file in
the same directory as the source file. This will cause compilation of
`version.c` ran by Meson to include `version-def.h` previously made by
Make, which might be out of date.

To explicitly tell the preprocessor which `version-def.h` to use, pass
the absolute path of this file as macro GIT_VERSION_H to the
preprocessor using option `-D` and have `version.c` `#include
GIT_VERSION_H`. To remain working with other build systems than Meson,
include "version-def.h" if that macro is not defined.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
This is version 2 of the patch trying to ensure the Meson build does not
include `version-def.h` created by Make.
---
Changes in v2:
- Instead of copying `version.c` to the Meson build directory, define a
  macro with the absolute path of `version-def.h` to include.
- Link to v1: https://lore.kernel.org/r/20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com
---
Range-diff versus v1:

1:  fad8163ff8 ! 1:  c1ca203451 meson: ensure correct version-def.h is used
    @@ Commit message
         However, when the user previously has compiled Git using Make, they will
         have a `version-def.h` file in project root directory as well. Because
         `version-def.h` is included in `version.c` using the #include directive
    -    with double quotes, some compilers will look for the header file in the
    -    same directory as the source file. This will cause compilation of
    +    with double quotes, some preprocessors will look for the header file in
    +    the same directory as the source file. This will cause compilation of
         `version.c` ran by Meson to include `version-def.h` previously made by
         Make, which might be out of date.
     
    -    Copy `version.c` to the build directory before compiling it to ensure
    -    `version-def.h` from the build directory is used.
    +    To explicitly tell the preprocessor which `version-def.h` to use, pass
    +    the absolute path of this file as macro GIT_VERSION_H to the
    +    preprocessor using option `-D` and have `version.c` `#include
    +    GIT_VERSION_H`. To remain working with other build systems than Meson,
    +    include "version-def.h" if that macro is not defined.
     
    +    Co-authored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## meson.build ##
    -@@ meson.build: version_def_h = custom_target(
    -   env: version_gen_environment,
    +@@ meson.build: libgit_version_library = static_library('git-version',
    +     'version.c',
    +     version_def_h,
    +   ],
    +-  c_args: libgit_c_args,
    ++  c_args: libgit_c_args + [
    ++    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
    ++  ],
    +   dependencies: libgit_dependencies,
    +   include_directories: libgit_include_directories,
      )
    +
    + ## version.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "version.h"
    +-#include "version-def.h"
    + #include "strbuf.h"
      
    -+# Because most compilers prefer header files in the same directory as the source
    -+# file, copy version.c to the build directory.
    -+version_c = fs.copyfile(meson.current_source_dir() / 'version.c', 'version.c')
    ++#ifndef GIT_VERSION_H
    ++# include "version-def.h"
    ++#else
    ++# include GIT_VERSION_H
    ++#endif
     +
    - # Build a separate library for "version.c" so that we do not have to rebuild
    - # everything when the current Git commit changes.
    - libgit_version_library = static_library('git-version',
    -   sources: [
    --    'version.c',
    -+    version_c,
    -     version_def_h,
    -   ],
    -   c_args: libgit_c_args,
    + const char git_version_string[] = GIT_VERSION;
    + const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
    + 
---
 meson.build | 4 +++-
 version.c   | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 0064eb64f546a6349a8694ce251bd352febda6fe..db27afa99986598aab22ada718f76a7a49238f24 100644
--- a/meson.build
+++ b/meson.build
@@ -1493,7 +1493,9 @@ libgit_version_library = static_library('git-version',
     'version.c',
     version_def_h,
   ],
-  c_args: libgit_c_args,
+  c_args: libgit_c_args + [
+    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+  ],
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
 )
diff --git a/version.c b/version.c
index 4d763ab48dd76c0445e5ea390ff4c1f35c1a4b12..4786c4e0a54093ca947da27f8b712bd1ea351203 100644
--- a/version.c
+++ b/version.c
@@ -1,8 +1,13 @@
 #include "git-compat-util.h"
 #include "version.h"
-#include "version-def.h"
 #include "strbuf.h"
 
+#ifndef GIT_VERSION_H
+# include "version-def.h"
+#else
+# include GIT_VERSION_H
+#endif
+
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 

---

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
change-id: 20250113-toon-fix-meson-version-3d4d33fdabe3

Thanks
--
Toon

