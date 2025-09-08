Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2631C576
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357397; cv=none; b=gv0dGSTAGz/iOAOw3LEboWkZf0FaBqBVNztKjQmJi87fE4baN/W3oiQ6+inDJtuk4Fp8aBrbg1FLkV9/AH7/pfecrUu/mBihLnmy2IRfnrEhDcMiGvNgE0kUFj3RZPgCxkcPEUxploL8EC5fIfcm88zgYAUD0/Y8uqJ9ufYrKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357397; c=relaxed/simple;
	bh=qhaxaXTmdmDAc3ZZ5ZEaBVFT/Gaj+O0sVWfWezsWZ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJhG9v2X68rp0lJeDBy0kMYkjmJNMPsr6xc3GzgrLJcC6CoBNEE+K9HPUWWuZ16NpJ+LOMvTM3fHMgysTctCrY/SkEUIYqf5Gli7Wj5s3r9Er/V6xitRVfxP4OztIy7rDz/45J8nncgtxsZ4F+hYVunL6VeLCA/sGGkRlY7QXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=DwR5ov56; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="DwR5ov56"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTP id 7491C4076182;
	Mon,  8 Sep 2025 18:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7491C4076182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1757357390;
	bh=qji09z4T1F8bY4LDfbE9O+Xo5odtaWRO3RUzYhqLMa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwR5ov56LpDoskkywQJXaF5FY/r0EGQZ9g5r0PhH3SmcsVR5R7LmjcFbqo44hnZ/N
	 WlzanG+Pv3xynNkwtbTS3f9mbt1fXFArVyhGAicgDv8nkZMZSFo0p+6uejD+oAP/Zm
	 k8aM7jBmLVlUKGBP9ttlfdKNs40fWRdJDX6mztJc=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v2 4/4] xdiff: use a faster hash in xdl_hash_record_verbatim
Date: Mon,  8 Sep 2025 21:49:39 +0300
Message-ID: <20250908184939.16338-4-amonakov@ispras.ru>
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

Reimplement xdl_hash_record_verbatim such that it computes two djb2
hashes for even and odd characters independently, each at latency two
per character. The new loop is expected to be issue and execution
port throughput bound at three cycles per a pair of characters. The
more efficient ways to evaluate such hashes involve use of
multiplication and higher interleaving factors. The scheme used here
is expected to be a reasonable compromise for lines of source code
(i.e. not very long strings).

Due to interleaving, the new function does not produce the same hash
values as the original. Given values H0 for even characters and H1
for odd characters, we combine them to produce the final hash value
as 'H1 * 257 + H0'. The factor 257 is chosen to approximately match
the original in quality (collision count in xdiff hashtable).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 xdiff/xhash.h | 62 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/xdiff/xhash.h b/xdiff/xhash.h
index 27da4288c8..1e9e13cc45 100644
--- a/xdiff/xhash.h
+++ b/xdiff/xhash.h
@@ -29,16 +29,64 @@ unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top
 
 static inline unsigned long xdl_hash_record_verbatim(char const **data, char const *top)
 {
-	unsigned long ha = 5381;
 	char const *ptr = *data;
-
-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+#if 0
+	/*
+	 * djb2 hash (below) is latency-bound; on x86, this baseline form cannot
+	 * run faster than two cycles per iteration, and to achieve that it is
+	 * neccessary to arrange for 'ha * 32' to be computed in parallel with
+	 * 'ha + ch'. To avoid being latency-bound, we run two independent djb2
+	 * hashes over even and odd characters, then combine them in the end.
+	 * The resulting hash is not equivalent to the original djb2.
+	 */
+	unsigned long ha = 5381, ch;
+	while (ptr < top) {
+		if ((ch = *ptr++) == '\n')
+			break;
+		ha = ha * 33 + ch;
 	}
-	*data = ptr < top ? ptr + 1: ptr;
-
+	*data = ptr;
 	return ha;
+#else
+#ifdef __GNUC__
+/*
+ * Compiler reassociation barrier: pretend to modify X and Y to disallow
+ * changing evaluation order with respect to following uses of X or Y.
+ */
+#define REASSOC_FENCE(x, y) __asm__("" : "+r"(x), "+r"(y))
+#else
+#define REASSOC_FENCE(x, y)
+#endif
+	unsigned long h0 = 5381, h1 = 0, ch;
+	/* Process two characters per iteration. */
+	if (top - ptr >= 2) do {
+		if ((ch = *ptr++) == '\n') {
+			*data = ptr;
+			h0 += h1;
+			REASSOC_FENCE(h0, h1);
+			return h1 * 256 + h0;
+		}
+		ch += h0;
+		REASSOC_FENCE(ch, h0);
+		h0 = h0 * 32 + ch;
+
+		if ((ch = *ptr++) == '\n') {
+			*data = ptr;
+			h0 += h1;
+			REASSOC_FENCE(h0, h1);
+			return h1 * 256 + h0;
+		}
+		ch += h1;
+		REASSOC_FENCE(ch, h1);
+		h1 = h1 * 32 + ch;
+
+	} while (ptr < top - 1);
+	*data = top;
+	if (ptr < top && (ch = *ptr++) != '\n')
+		h0 = h0 * 33 + ch;
+	return h1 * 257 + h0;
+#undef REASSOC_FENCE
+#endif
 }
 
 static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
-- 
2.49.1

