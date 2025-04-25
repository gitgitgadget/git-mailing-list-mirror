Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FC22A4F1
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559307; cv=none; b=c+i2aSY7Mpm2Db8J7PmGQJAHOSmHrNuuX1iaNqCiyItQaItDrZX8EWWAV+d96K4RaukgBuYGvB6IzTveeiaMkoKnjUcgFoZPaqSZ/WQAG66wGInE9J3Yw7bpFVxioiUQnfR6ypWcSozrjA900Dbn7QXxAABucZOY+FZRJx+LAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559307; c=relaxed/simple;
	bh=67g1+PW2+JWFggGeDh/RRZm9Wene8o1VXJ1kUrjxKrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQR07a+kFINGeq7olNz+R3+t5S6qqr/CQMShwrqVpJRVcSBajwQd7gFmEbUwWDB23z14f+LEDL0wwMoFxENlQ/d22fQoa0oJtt2zVWarpPf3WdknKEn5Dhl6lgTPnJEXSz6hSbwXsiAVNc9hfiVxudtru3/x0AsB2U2yZ27OVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 774C833BE00;
	Fri, 25 Apr 2025 05:35:04 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/6] meson: do a full usage-based compile check for sysinfo
Date: Fri, 25 Apr 2025 01:25:42 -0400
Message-ID: <20250425053345.17288-4-eschwartz@gentoo.org>
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

On Solaris, sys/sysinfo.h is a completely different file and doesn't
resemble the linux file at all. There is also a sysinfo() function, but
it takes a totally different call signature, which asks for:

- the field you wish to receive
- a `char *buf` to copy the data to

and is very useful IFF you want to know, say, the hardware provider. Or,
get *specific* fields from uname(2).

https://docs.oracle.com/cd/E86824_01/html/E54765/sysinfo-2.html

It is surely possible to do this manually via `sysconf(3)` without the
nice API. I can't find anything more direct. Either way, I'm not very
attached to Solaris, so someone who cares can add it. Either way, it's
wrong to assume that sysinfo.h contains what we are looking for.

Check that sysinfo.h defines the struct we actually utilize in
builtins/gc.c, which will correctly fail on systems that don't have it.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index e575231129..b21b191d25 100644
--- a/meson.build
+++ b/meson.build
@@ -1058,10 +1058,6 @@ if compiler.has_header('alloca.h')
   libgit_c_args += '-DHAVE_ALLOCA_H'
 endif
 
-if compiler.has_header('sys/sysinfo.h')
-  libgit_c_args += '-DHAVE_SYSINFO'
-endif
-
 # Windows has libgen.h and a basename implementation, but we still need our own
 # implementation to threat things like drive prefixes specially.
 if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
@@ -1267,6 +1263,10 @@ if host_machine.system() != 'windows'
   endif
 endif
 
+if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
+  libgit_c_args += '-DHAVE_SYSINFO'
+endif
+
 if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: '#include <sys/stat.h>')
   libgit_c_args += '-DUSE_ST_TIMESPEC'
 elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix: '#include <sys/stat.h>')
-- 
2.49.0

