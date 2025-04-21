Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2F139CF2
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257984; cv=none; b=ua4fhIQYNFEhOmdoy8UGcOn6MjEpaTRJeYPTIbvlv8s1oA9SoqJRq8maGWqlp1sw/n6wpUrDFaRi79uivXQt2DfE+H90LbYykXn2VGS+MyEq/Q4AomdilJrXWva7UkFtlpfMjDIJJx2AU4A6/auoyCOC+9lQbBpv3mwE2GpDV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257984; c=relaxed/simple;
	bh=PpgoqPCET8zcJMFW9uhfxJz0vU/JcT9KOySEseaMId8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGfSSqJa9tS/sUitFRKcwPni8Rin1NBpZyDyorW+oP6AeK/THen3IP31m2cIjg2VOwSGgMpBRHOrXcO69SKdUsv9tw/ESInymhuFedaEzM1e1f/oMHOwp1eZAXvTWv2Lro/lpoQhBrHTZO0nd4QpmGFIhXOnc/pcRSVZAbf5Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 35138342FB5;
	Mon, 21 Apr 2025 17:53:02 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/6] meson: simplify and parameterize various standard function checks
Date: Mon, 21 Apr 2025 13:51:45 -0400
Message-ID: <20250421175247.240971-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
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
 meson.build | 73 ++++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/meson.build b/meson.build
index c47cb79af0..6c147c22a4 100644
--- a/meson.build
+++ b/meson.build
@@ -1290,23 +1290,40 @@ if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#include <pwd.h
   libgit_c_args += '-DNO_GECOS_IN_PWENT'
 endif
 
-if compiler.has_function('sync_file_range')
-  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
-endif
+checkfuncs = [
+  'strcasestr',
+  'memmem',
+  'strlcpy',
+  # no compat
+  'strtoull',
+  'setenv',
+  'mkdtemp',
+  # no compat
+  'initgroups',
+]
 
-if not compiler.has_function('strcasestr')
-  libgit_c_args += '-DNO_STRCASESTR'
-  libgit_sources += 'compat/strcasestr.c'
+if host_machine.system() == 'windows'
+  libgit_c_args += '-DUSE_WIN32_MMAP'
+else
+  checkfuncs += [
+    'mmap',
+    # unsetenv is provided by compat/mingw.c.
+    'unsetenv',
+  ]
 endif
 
-if not compiler.has_function('memmem')
-  libgit_c_args += '-DNO_MEMMEM'
-  libgit_sources += 'compat/memmem.c'
-endif
+foreach func: checkfuncs
+  if not compiler.has_function(func)
+    libgit_c_args += '-DNO_' + func.to_upper()
+    impl = 'compat/' + func + '.c'
+    if fs.exists(impl)
+      libgit_sources += impl
+    endif
+  endif
+endforeach
 
-if not compiler.has_function('strlcpy')
-  libgit_c_args += '-DNO_STRLCPY'
-  libgit_sources += 'compat/strlcpy.c'
+if compiler.has_function('sync_file_range')
+  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
 endif
 
 if not compiler.has_function('strdup')
@@ -1322,45 +1339,15 @@ if not compiler.has_function('strtoumax')
   ]
 endif
 
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

