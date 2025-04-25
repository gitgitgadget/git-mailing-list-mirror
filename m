Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6F229B21
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559305; cv=none; b=hkuVhQQunvGXP5qfm1+OqHlMEI/qhq7B4fA/mnbpEC7WRFG2NapZpHbzjUa6PFp9M5NKa3B5IfVIoapaYUJMtvv4GWxQeaNiAIokE5IVgYIv8ghi0dv3JM7qV9x2pF5/rtu2Dks5g0PDosFhwGmurLmn7h/goq7IXvY/mkhrdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559305; c=relaxed/simple;
	bh=i1lkY0uUmkWVQRDSPnQhl/H6AKUa1jXx88t2ZX1goX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxS6p+CGPQ64K4Nc+RH6RlP/vD1HPeJJUzPzjpR1K295LpyXGDZc2biRhjnaA1/rrD8mE5aqc1ImbQcpCU6Nq2QFqQjXjH0ga8d4+rum3dEIXAk5KJ8vatd9W8bRX25A7ZhkzYp7QqNCpFA+t7kiNZqULAI4/NW/3OEyQk7ua7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D6864335D7B;
	Fri, 25 Apr 2025 05:35:02 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/6] meson: simplify and parameterize various standard function checks
Date: Fri, 25 Apr 2025 01:25:40 -0400
Message-ID: <20250425053345.17288-2-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425053345.17288-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425053345.17288-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is repetitive logic. We either want to use some -lc function, or if
it is not available we define it as -DNO_XXX and usually (but not
always) provide some custom compatibility impl instead.

Checking the intent of each block when reading through the file is slow
and not very DRY. Switch to taking an array of checkable functions
instead.

Not all functions are straightforward to move, since different macro
prefixes are used.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---

v3:
- use a dictionary for checkfuncs, and list the filenames
- now we can handle strtoumax too, so, do that
- pread was overlooked previously; move it down and handle it with the
  other function checks

 meson.build | 85 ++++++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 56 deletions(-)

diff --git a/meson.build b/meson.build
index c47cb79af0..ed0359b9c9 100644
--- a/meson.build
+++ b/meson.build
@@ -1133,11 +1133,6 @@ else
   build_options_config.set('NO_UNIX_SOCKETS', '1')
 endif
 
-if not compiler.has_function('pread')
-  libgit_c_args += '-DNO_PREAD'
-  libgit_sources += 'compat/pread.c'
-endif
-
 if host_machine.system() == 'darwin'
   libgit_sources += 'compat/precompose_utf8.c'
   libgit_c_args += '-DPRECOMPOSE_UNICODE'
@@ -1290,23 +1285,39 @@ if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#include <pwd.h
   libgit_c_args += '-DNO_GECOS_IN_PWENT'
 endif
 
-if compiler.has_function('sync_file_range')
-  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
-endif
+checkfuncs = {
+  'strcasestr' : ['strcasestr.c'],
+  'memmem' : ['memmem.c'],
+  'strlcpy' : ['strlcpy.c'],
+  'strtoull' : [],
+  'setenv' : ['setenv.c'],
+  'mkdtemp' : ['mkdtemp.c'],
+  'initgroups' : [],
+  'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
+  'pread' : ['pread.c'],
+}
 
-if not compiler.has_function('strcasestr')
-  libgit_c_args += '-DNO_STRCASESTR'
-  libgit_sources += 'compat/strcasestr.c'
+if host_machine.system() == 'windows'
+  libgit_c_args += '-DUSE_WIN32_MMAP'
+else
+  checkfuncs += {
+    'mmap' : ['mmap.c'],
+    # provided by compat/mingw.c.
+    'unsetenv' : ['unsetenv.c'],
+  }
 endif
 
-if not compiler.has_function('memmem')
-  libgit_c_args += '-DNO_MEMMEM'
-  libgit_sources += 'compat/memmem.c'
-endif
+foreach func, impls : checkfuncs
+  if not compiler.has_function(func)
+    libgit_c_args += '-DNO_' + func.to_upper()
+    foreach impl : impls
+      libgit_sources += 'compat/' + impl
+    endforeach
+  endif
+endforeach
 
-if not compiler.has_function('strlcpy')
-  libgit_c_args += '-DNO_STRLCPY'
-  libgit_sources += 'compat/strlcpy.c'
+if compiler.has_function('sync_file_range')
+  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
 endif
 
 if not compiler.has_function('strdup')
@@ -1314,53 +1325,15 @@ if not compiler.has_function('strdup')
   libgit_sources += 'compat/strdup.c'
 endif
 
-if not compiler.has_function('strtoumax')
-  libgit_c_args += '-DNO_STRTOUMAX'
-  libgit_sources += [
-    'compat/strtoumax.c',
-    'compat/strtoimax.c',
-  ]
-endif
-
-if not compiler.has_function('strtoull')
-  libgit_c_args += '-DNO_STRTOULL'
-endif
-
-if not compiler.has_function('setenv')
-  libgit_c_args += '-DNO_SETENV'
-  libgit_sources += 'compat/setenv.c'
-endif
-
 if not compiler.has_function('qsort')
   libgit_c_args += '-DINTERNAL_QSORT'
 endif
 libgit_sources += 'compat/qsort_s.c'
 
-# unsetenv is provided by compat/mingw.c.
-if host_machine.system() != 'windows' and not compiler.has_function('unsetenv')
-  libgit_c_args += '-DNO_UNSETENV'
-  libgit_sources += 'compat/unsetenv.c'
-endif
-
-if not compiler.has_function('mkdtemp')
-  libgit_c_args += '-DNO_MKDTEMP'
-  libgit_sources += 'compat/mkdtemp.c'
-endif
-
-if not compiler.has_function('initgroups')
-  libgit_c_args += '-DNO_INITGROUPS'
-endif
-
 if compiler.has_function('getdelim')
   libgit_c_args += '-DHAVE_GETDELIM'
 endif
 
-if host_machine.system() == 'windows'
-  libgit_c_args += '-DUSE_WIN32_MMAP'
-elif not compiler.has_function('mmap')
-  libgit_c_args += '-DNO_MMAP'
-  libgit_sources += 'compat/mmap.c'
-endif
 
 if compiler.has_function('clock_gettime')
   libgit_c_args += '-DHAVE_CLOCK_GETTIME'
-- 
2.49.0

