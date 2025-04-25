Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD122A7F8
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559307; cv=none; b=SIQTVCDjK4YpFTNp6sp2PwBzSVxttvqJ60j/H1mGv6lCrZM/u4tMrt6thAAPgw/iPDeU/8qVPcSF9eZi+NBkmUvaji9y/DsDowtCEFsJWSADjQT7rvEnUDD4JJIsMlr+f4542ve8ijbr3PCN+YninElxOAO+MIJJyKAApxpDdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559307; c=relaxed/simple;
	bh=W/wzn7A3vvKkDPK2ioCuQNgRiD+HsMDmcNAOB72NuJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiAIk83t1NFoTgm8erzZqsnieA/MUkeXjeR3q0h/yyuCZdvLGzNib3hfHPo/mr5sfEbxskaCpekBNvPLhvD/62I6aeF0jlqoQzu5MNOkvNf7ux9dklNHuKyN4oeOhtFXxWjJHDPoJZFbJUCPVPM/OPtpiiEjZTs7J+L4KhwnCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5E484335D10;
	Fri, 25 Apr 2025 05:35:05 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/6] meson: add a couple missing networking dependencies
Date: Fri, 25 Apr 2025 01:25:43 -0400
Message-ID: <20250425053345.17288-5-eschwartz@gentoo.org>
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

As evidenced in config.mak.uname and configure.ac, there are various
possible scenarios where these libraries are default-enabled in the
build, which mainly boils down to: SunOS. -lresolv is simply not the
only library that, when it exists, probably needs to be linked to for
networking.

Check for and add -lnsl -lsocket as well.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index b21b191d25..66b69f2471 100644
--- a/meson.build
+++ b/meson.build
@@ -1080,10 +1080,11 @@ if host_machine.system() == 'windows'
     networking_dependencies += winsock
   endif
 else
-  libresolv = compiler.find_library('resolv', required: false)
-  if libresolv.found()
-    networking_dependencies += libresolv
-  endif
+  networking_dependencies += [
+    compiler.find_library('nsl', required: false),
+    compiler.find_library('resolv', required: false),
+    compiler.find_library('socket', required: false),
+  ]
 endif
 libgit_dependencies += networking_dependencies
 
-- 
2.49.0

