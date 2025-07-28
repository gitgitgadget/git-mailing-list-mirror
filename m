Received: from flyer.ispras.ru (flyer.ispras.ru [83.149.199.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DD218AC4
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729539; cv=none; b=ZML6DxIYIGdxQJpcRQGHHXLv5jExxohhBIfRf04bcltqLqmHYUZMv5Tsy3VcGOjXz54Y8cZ2b3JnMxwxMIXmOtM5U41OhgY2VjPAsHLsnQ3DRQLOa96Juo5ZyBC1eky0Nh9GkKyGBZkL7NdkpJZlFJLhCdtTldSdoaS9eeekP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729539; c=relaxed/simple;
	bh=KOFJmN7OdpgO7UiYD316rP7B3bdqSDF7Qpk1U5UeVho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0nYyBeQG68Ca2/oRFEDMh9o5kn5C/wBZ1kPS1Msh5E3cy77ybFrvLovbNxtPVrOSa09wq9d+li4w7nzOzmiAiVtpWAK6OwUtdclf7CpGFMjp5bk3dwxxtPebWvRgjRavzP9uO/fdolQywV8jliNHeGdHdXDKc/TSQpJnRoVhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nM0T3D7h; arc=none smtp.client-ip=83.149.199.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nM0T3D7h"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by flyer.ispras.ru (Postfix) with ESMTP id 0021C140704A;
	Mon, 28 Jul 2025 22:05:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 flyer.ispras.ru 0021C140704A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753729531;
	bh=dPfF0dfcs3Mz9yiuSpvOeww/Cr/q3EE5W3neZKtFUqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nM0T3D7hCWBBU/MTTY40UgE7RsShr1FL7Y+V9TXU/ieBprzeGux+yYXyN0wqQ1w9T
	 WSIeC/56S63u8/0PrFmOAKS/svaN09SKDJISfp9OuHnLZJEVyiorjRULFKYgL11sG/
	 4Ty7dC+7kNlQwsPZAv0BMsOIudoLX9IXZarBszNs=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
Date: Mon, 28 Jul 2025 22:05:20 +0300
Message-ID: <20250728190520.10962-3-amonakov@ispras.ru>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20250728190520.10962-1-amonakov@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdl_hash_record_verbatim uses modified djb2 hash with XOR instead of ADD
for combining. The ADD-based variant is used as the basis of the modern
("GNU") symbol lookup scheme in ELF. Glibc dynamic loader received an
optimized version of this hash function thanks to Noah Goldstein [1].

Switch xdl_hash_record_verbatim to additive hashing and implement
an optimized loop following the scheme suggested by Noah.

Timing 'git log --oneline --shortstat v2.0.0..v2.5.0' under perf, I got

version | cycles, bn | instructions, bn
---------------------------------------
A         6.38         11.3
B         6.21         10.89
C         5.80          9.95
D         5.83          8.74
---------------------------------------

A: baseline (git master at e4ef0485fd78)
B: plus 'xdiff: refactor xdl_hash_record()'
C: and plus this patch
D: with 'xdiff: use xxhash' by Phillip Wood

The resulting speedup for xdl_hash_record_verbatim itself is about 1.5x.

[1] https://inbox.sourceware.org/libc-alpha/20220519221803.57957-6-goldstein.w.n@gmail.com/

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 xdiff/xutils.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index e070ed649f..b1f8273f0f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -294,16 +294,67 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
+/*
+ * Compiler reassociation barrier: pretend to modify X and Y to disallow
+ * changing evaluation order with respect to following uses of X and Y.
+ */
+#ifdef __GNUC__
+#define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
+#else
+#define REASSOC_FENCE(x, y)
+#endif
+
 unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
-	unsigned long ha = 5381;
+	unsigned long ha = 5381, c0, c1;
 	char const *ptr = *data;
-
+#if 0
+	/*
+	 * The baseline form of the optimized loop below. This is the djb2
+	 * hash (the above function uses a variant with XOR instead of ADD).
+	 */
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha += (unsigned long) *ptr;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
-
+#else
+	/* Process two characters per iteration. */
+	if (top - ptr >= 2) do {
+		if ((c0 = ptr[0]) == '\n') {
+			*data = ptr + 1;
+			return ha;
+		}
+		if ((c1 = ptr[1]) == '\n') {
+			*data = ptr + 2;
+			c0 += ha;
+			REASSOC_FENCE(c0, ha);
+			ha = ha * 32 + c0;
+			return ha;
+		}
+		/*
+		 * Combine characters C0 and C1 into the hash HA. We have
+		 * HA = (HA * 33 + C0) * 33 + C1, and we want to ensure
+		 * that dependency chain over HA is just one multiplication
+		 * and one addition, i.e. we want to evaluate this as
+		 * HA = HA * 33 * 33 + (C0 * 33 + C1), and likewise prefer
+		 * (C0 * 32 + (C0 + C1)) for the expression in parenthesis.
+		 */
+		ha *= 33 * 33;
+		c1 += c0;
+		REASSOC_FENCE(c1, c0);
+		c1 += c0 * 32;
+		REASSOC_FENCE(c1, ha);
+		ha += c1;
+
+		ptr += 2;
+	} while (ptr < top - 1);
+	*data = top;
+	if (ptr < top && (c0 = ptr[0]) != '\n') {
+		c0 += ha;
+		REASSOC_FENCE(c0, ha);
+		ha = ha * 32 + c0;
+	}
+#endif
 	return ha;
 }
 
-- 
2.44.2

