Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4B22AE65
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559309; cv=none; b=IYX8M8rKsdqYmFOo2mS4p/O9EC0xf3gzOsLP/acda63p/MW0/5BnVByLWGYll0HGGP+cxWrUZrCyYMNpnMb/4hjHXH6keO0OHrWT6H0/tE9u8Y6XNsA25aUVHOMNqeGi0e5AJ97VJWuU8D7c89jIuYYDn2wQVrGm/4TnSL7f7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559309; c=relaxed/simple;
	bh=qKOJ84SoZJ5AdpJd6ES+nSAva2HJP6PoReF3U3gvBfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl1gdrNTONSXivAZOwB0EpnpI4kZOR/AByZbJw/rp2NFAOpcfRqzjm6v3vOxeFu6syVT9rXmOb2PTUYybmOiPLpQC8/05RyqmwpA2QAdQIoRorcXdgG0Gtodou8sXgWzV92GHrnrQksaKVMWi6Gt9JGwaRjCFo54oiGZhfmGlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 00D92335CB4;
	Fri, 25 Apr 2025 05:35:06 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] meson: only check for missing networking syms on non-Windows; add compat impls
Date: Fri, 25 Apr 2025 01:25:45 -0400
Message-ID: <20250425053345.17288-7-eschwartz@gentoo.org>
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

These are added in the Makefile, but not in meson. They probably won't
work well on systems without them.

CMake adds them, but only on non-Windows. Actually, it only performs
compiler checks for hstrerror, but excludes that check on Windows with
the note that it is "incompatible with the Windows build". This seems to
be misleading -- it is not incompatible, it simply doesn't exist. Still,
the compat version should not be used.

I interpret this cmake logic to mean we shouldn't even be checking for
symbol availability on Windows. In addition to making it simple to add
compat definitions, this also probably shaves off a second or two of
configure time on Windows as no compiler check needs to be performed.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 25bac8d89f..fbe43be949 100644
--- a/meson.build
+++ b/meson.build
@@ -1088,11 +1088,14 @@ else
 endif
 libgit_dependencies += networking_dependencies
 
-foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
-  if not compiler.has_function(symbol, dependencies: networking_dependencies)
-    libgit_c_args += '-DNO_' + symbol.to_upper()
-  endif
-endforeach
+if host_machine.system() != 'windows'
+  foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
+    if not compiler.has_function(symbol, dependencies: networking_dependencies)
+      libgit_c_args += '-DNO_' + symbol.to_upper()
+      libgit_sources += 'compat/' + symbol + '.c'
+    endif
+  endforeach
+endif
 
 has_ipv6 = compiler.has_function('getaddrinfo', dependencies: networking_dependencies)
 if not has_ipv6
-- 
2.49.0

