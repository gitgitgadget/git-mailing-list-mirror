Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38F31C599
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357399; cv=none; b=fUOLZr+hcPad0L1ErPb/m1uRWc9zPf0gR6StfEbFNmY0H3jSkJ+eNOvB4SwLFHwyKWK8NjzKjYz16l4P7F++z+uQ9K+Oh3XBOx757qdg+LeHe9vnjVQDAstUR0nEMdeMENj7Dbbl7EYfMPPCXjp2BClBeY2lrf7BxCMCZBmF1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357399; c=relaxed/simple;
	bh=11ufnovvgQ2ZCPiVRGOEQf1UndR1mJLFy8ZxQGJrBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaxCcpm6XquM4sVUegxwo04oadRvY2oXArG7M40TZoNzG8pKep72qiQajByu54TooQCJ7IEfHB+9Ml0Gal1WtUPExfufn3LO7mhXNBpfkM517JLGfJlk5rFNuO2SEuATooGfBsiyONPXGHgHbAlJ663mg6EpYFCs2S6rZRm4Sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=LnV5L5N3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="LnV5L5N3"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTP id 23E4640748C7;
	Mon,  8 Sep 2025 18:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 23E4640748C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1757357389;
	bh=guCS07oNuv+XwEYQeUumxQfXjqIZ/Ljrp6uH96VcJPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnV5L5N3x4ZRaajuVxh6D/xeeHQQP8fzev5eug0J+1HgPzDyPg8VupfAZTZhB/aM/
	 nyHaftU8Gt/mdiNyxrqr51hscoYnfQ+3Xzc76Xw5c2QyoJIsvzufwueO7YnKRR/5gy
	 ++5UaG3pnNpwr4WIGNot1EtE3UbPW3wA8OaT2Quo=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v2 2/4] xdiff: annotate unlikely branch
Date: Mon,  8 Sep 2025 21:49:37 +0300
Message-ID: <20250908184939.16338-2-amonakov@ispras.ru>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250908184939.16338-1-amonakov@ispras.ru>
References: <20250908184939.16338-1-amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDL_ALLOC_GROW is used in a hot loop in xdl_prepare_ctx. Inform the
compiler that branching to the reallocation helper happens rarely
to improve code layout.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 xdiff/xmacros.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 8487bb396f..d892e022d4 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -23,8 +23,11 @@
 #if !defined(XMACROS_H)
 #define XMACROS_H
 
-
-
+#if __GNUC__ >= 3
+#define XDL_LIKELY(e) __builtin_expect((e), 1)
+#else
+#define XDL_LIKELY(e) (e)
+#endif
 
 #define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
 #define XDL_MAX(a, b) ((a) > (b) ? (a): (b))
@@ -64,8 +67,8 @@ do { \
  * elements) as necessary. Frees p and returns -1 on failure, returns
  * 0 on success
  */
-#define XDL_ALLOC_GROW(p, nr, alloc)	\
-	(-!((nr) <= (alloc) ||		\
+#define XDL_ALLOC_GROW(p, nr, alloc)	    \
+	(-!(XDL_LIKELY((nr) <= (alloc)) ||  \
 	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
 
 #endif /* #if !defined(XMACROS_H) */
-- 
2.49.1

