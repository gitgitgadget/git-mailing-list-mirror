Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65C1E2852
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257988; cv=none; b=Ih7Sn5956K5xZgADORm6EUm2hIJSy0oqf7a+OJJQEb1mpzIdstallmDjoY1MM/KP8SOmoGssYiIvCmDBw4RV/0iDeFxQJ8AXItRrELMH1Ug44j9x2ZKfTWvPgPBoBMfeU3j6GIQO/KDVRFPV9SxOhxroQiSA0FNGBHqlNp1EqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257988; c=relaxed/simple;
	bh=nL+H1tP9NnugzV5eSTfU+Ip+tc1VPWM2H317lzUXTxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFlb6KeSb6oA3ojs6WCDIiBrCj6HKhO0sqRL74pZQUUcQx0XC2sk0k2e7p2PlEOxhvlAuBCS5nqpbBDHa+e4GRlcpH0xzL50kIfyHWFHuqIN51VkKIittRPiKJI94d+aRmQQicotz6AHH4uag2DfI4PiNNPpXj+kCfzQn/WduE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4D106343019;
	Mon, 21 Apr 2025 17:53:06 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/6] meson: do a full usage-based compile check for sysinfo
Date: Mon, 21 Apr 2025 13:51:47 -0400
Message-ID: <20250421175247.240971-3-eschwartz@gentoo.org>
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
index f5d9ffcd7f..8037e536dd 100644
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
@@ -1272,6 +1268,10 @@ if host_machine.system() != 'windows'
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

