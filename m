Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B905219315
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559304; cv=none; b=tT8Nwbg7ih/Cy6bx4E25fTc4ym2WUv+5Xvw/IfdE1kKWG3ujX1X6ZfaY1wFMF9vpSwkR42amIox5MvaiWjiDGmxW+WoC34vuIFCN9lzYezaKcUiF+iivyT9E4ixtRffdfgp7/iN3oQexm3muWqqTrxLP+ajrZ7pj9TMacZosB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559304; c=relaxed/simple;
	bh=8qXFkD3DRwuEzPDKd5f3Q3Cxhi4Z1QJgR9NZYxRWJsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/BnDN/DQMRaQQaIt8MJHlgoDLHr69xF5eL0iJhqUNLcPFs2Bpkno0wJN4LqegmXHK3cvTwUkrBH4GMYPLzpcb+9N4bHuqm+1Ux54+YIJnmgPk6rPgPxWzHca5qqeFdFkuBIfXoDNLTYxxOQ0HJzMpcE5QdsbwU1367+3oWQyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1376D335D10;
	Fri, 25 Apr 2025 05:35:01 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] meson: miscellaneous system detection fixes
Date: Fri, 25 Apr 2025 01:25:39 -0400
Message-ID: <20250425053345.17288-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Principally motivated to handle an issue where these were failing to
detect the system properly, on Solaris.

Changes:

v2: getpagesize check moved to !windows
v3: style fixes, pass source files in

Eli Schwartz (6):
  meson: simplify and parameterize various standard function checks
  meson: check for getpagesize before using it
  meson: do a full usage-based compile check for sysinfo
  meson: add a couple missing networking dependencies
  meson: fix typo in function check that prevented checking for
    hstrerror
  meson: only check for missing networking syms on non-Windows; add
    compat impls

 meson.build | 117 +++++++++++++++++++++-------------------------------
 1 file changed, 48 insertions(+), 69 deletions(-)

Range-diff against v2:
1:  e137afaff2 ! 1:  037d2f8610 meson: simplify and parameterize various standard function checks
    @@ Commit message
         prefixes are used.
     
      ## meson.build ##
    +@@ meson.build: else
    +   build_options_config.set('NO_UNIX_SOCKETS', '1')
    + endif
    + 
    +-if not compiler.has_function('pread')
    +-  libgit_c_args += '-DNO_PREAD'
    +-  libgit_sources += 'compat/pread.c'
    +-endif
    +-
    + if host_machine.system() == 'darwin'
    +   libgit_sources += 'compat/precompose_utf8.c'
    +   libgit_c_args += '-DPRECOMPOSE_UNICODE'
     @@ meson.build: if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#include <pwd.h
        libgit_c_args += '-DNO_GECOS_IN_PWENT'
      endif
    @@ meson.build: if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#i
     -if compiler.has_function('sync_file_range')
     -  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
     -endif
    -+checkfuncs = [
    -+  'strcasestr',
    -+  'memmem',
    -+  'strlcpy',
    -+  # no compat
    -+  'strtoull',
    -+  'setenv',
    -+  'mkdtemp',
    -+  # no compat
    -+  'initgroups',
    -+]
    ++checkfuncs = {
    ++  'strcasestr' : ['strcasestr.c'],
    ++  'memmem' : ['memmem.c'],
    ++  'strlcpy' : ['strlcpy.c'],
    ++  'strtoull' : [],
    ++  'setenv' : ['setenv.c'],
    ++  'mkdtemp' : ['mkdtemp.c'],
    ++  'initgroups' : [],
    ++  'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
    ++  'pread' : ['pread.c'],
    ++}
      
     -if not compiler.has_function('strcasestr')
     -  libgit_c_args += '-DNO_STRCASESTR'
    @@ meson.build: if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#i
     +if host_machine.system() == 'windows'
     +  libgit_c_args += '-DUSE_WIN32_MMAP'
     +else
    -+  checkfuncs += [
    -+    'mmap',
    -+    # unsetenv is provided by compat/mingw.c.
    -+    'unsetenv',
    -+  ]
    ++  checkfuncs += {
    ++    'mmap' : ['mmap.c'],
    ++    # provided by compat/mingw.c.
    ++    'unsetenv' : ['unsetenv.c'],
    ++  }
      endif
      
     -if not compiler.has_function('memmem')
     -  libgit_c_args += '-DNO_MEMMEM'
     -  libgit_sources += 'compat/memmem.c'
     -endif
    -+foreach func: checkfuncs
    ++foreach func, impls : checkfuncs
     +  if not compiler.has_function(func)
     +    libgit_c_args += '-DNO_' + func.to_upper()
    -+    impl = 'compat/' + func + '.c'
    -+    if fs.exists(impl)
    -+      libgit_sources += impl
    -+    endif
    ++    foreach impl : impls
    ++      libgit_sources += 'compat/' + impl
    ++    endforeach
     +  endif
     +endforeach
      
    @@ meson.build: if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#i
      endif
      
      if not compiler.has_function('strdup')
    -@@ meson.build: if not compiler.has_function('strtoumax')
    -   ]
    +@@ meson.build: if not compiler.has_function('strdup')
    +   libgit_sources += 'compat/strdup.c'
      endif
      
    +-if not compiler.has_function('strtoumax')
    +-  libgit_c_args += '-DNO_STRTOUMAX'
    +-  libgit_sources += [
    +-    'compat/strtoumax.c',
    +-    'compat/strtoimax.c',
    +-  ]
    +-endif
    +-
     -if not compiler.has_function('strtoull')
     -  libgit_c_args += '-DNO_STRTOULL'
     -endif
2:  3c4918a7b3 ! 2:  291ac2579f meson: check for getpagesize before using it
    @@ Commit message
     
      ## meson.build ##
     @@ meson.build: else
    -     'mmap',
    -     # unsetenv is provided by compat/mingw.c.
    -     'unsetenv',
    -+    # no compat, is provided by compat/mingw.c
    -+    'getpagesize',
    -   ]
    +     'mmap' : ['mmap.c'],
    +     # provided by compat/mingw.c.
    +     'unsetenv' : ['unsetenv.c'],
    ++    # provided by compat/mingw.c.
    ++    'getpagesize' : [],
    +   }
      endif
      
3:  2c19f04f3e = 3:  9af41a0c23 meson: do a full usage-based compile check for sysinfo
4:  e62057094f = 4:  041859574f meson: add a couple missing networking dependencies
5:  a6a7bdacd1 = 5:  6e20afb77f meson: fix typo in function check that prevented checking for hstrerror
6:  15f48b8991 = 6:  a60c55bb02 meson: only check for missing networking syms on non-Windows; add compat impls
-- 
2.49.0

