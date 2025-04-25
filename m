Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA502557A
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540456; cv=none; b=tXEj40PwEuEsFWLy3XUcX8thDOaXfYjBxPQ/UtskDqdVkh0iuppQs0Lh1fejzwx9TVJ+MoPK5USxihefj/4eAMr4kY5pi1+RZp9dlCLWotMkIB7Vp/AZZxPOZ138MGWcf/qiJt6YNzZnJt/wIvoFi1oK6k4OuHVRWGIsGYH6R2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540456; c=relaxed/simple;
	bh=Qa0p+u79S443nsaFngzfcxNvyJQcjjsSq58yWYVRj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzK2Ak6dkq97vvl6p3EWk3ypdWda9ZdJN7EBd0nooCcLUI07Ba8PwInfpz8M6UFoWUP2fAfXmuMDMIw1timkPoxvaujb3c9eWz7yBAK+iFnS2DAJCIBVWCeOqvbz9TNUBRwn9dbu6Efj66tVynKCDKLIy/RhygzJ7vJdlKcmPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 103BA342FB6;
	Fri, 25 Apr 2025 00:20:53 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] meson: fix typo in function check that prevented checking for hstrerror
Date: Thu, 24 Apr 2025 20:13:34 -0400
Message-ID: <20250425002017.246985-6-eschwartz@gentoo.org>
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

Nowhere in the codebase do we otherwise check for strerror. Nowhere in
the codebase do we make use of -DNO_STRERROR. `strerror` is not a
networking function at all.

We do utilize `hstrerror` though, which is a networking function we
should have been checking here.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ff65d36cac..7927c54dc3 100644
--- a/meson.build
+++ b/meson.build
@@ -1088,7 +1088,7 @@ else
 endif
 libgit_dependencies += networking_dependencies
 
-foreach symbol : ['inet_ntop', 'inet_pton', 'strerror']
+foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
   if not compiler.has_function(symbol, dependencies: networking_dependencies)
     libgit_c_args += '-DNO_' + symbol.to_upper()
   endif
-- 
2.49.0

