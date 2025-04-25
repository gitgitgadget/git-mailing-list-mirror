Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2625569
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540456; cv=none; b=n6/Y1N9TacT6ofYsMtIvI1Z9ngr/WbuMH4xDhYYiN9vuIn/yb8EqZTphob/CqdrDAt/rV4yyaUNUSu8w2XBSi/K/lYVu3HruT4zplhfwRmZq97QoktA5ctWSMeONPzGf3e/hMPpkFrw+Kr+xxWDz6+qf/KN3aTqXafQDbrru/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540456; c=relaxed/simple;
	bh=yloAfB7RGO6eo3+L/iKFPFVQ4fcFqfV+Se5tk+aJ5ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9yPqqZd+gY1arr2QFvipxmUqdLYsNe3jlEUO8xf6r90d+mswqlYitf1qqoGRic61IT2QtMjnPmTefK9iHKwD20LHMKxAAx4uhmQarTdZrPTb858qE+jgwrwy5VM2SKt0Hje92L9JxGJvggqpvaykDWftK8MLRlJFwdCdZ/8GeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3BF88342FB5;
	Fri, 25 Apr 2025 00:20:53 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] meson: add a couple missing networking dependencies
Date: Thu, 24 Apr 2025 20:13:33 -0400
Message-ID: <20250425002017.246985-5-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425002017.246985-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425002017.246985-1-eschwartz@gentoo.org>
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
index ea0722a216..ff65d36cac 100644
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

