Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95E1F7569
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357398; cv=none; b=MrRvlwA4KeyWmmCBFbqZefmDDG304zpwEOCOEMTYg85KAhuXHk3Tvzd9pNz2IYtoIkyiRuidvkK7x0TBLagwkx+bPshK+NZY2zwMnF6PiA++WVnT/DWZ8pHg0+vI9XhjCUlOrSJA8QlhwEsn10igy2jTfqqcGJXGHW339IGznmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357398; c=relaxed/simple;
	bh=+M9SWUgRVYRg1kBGn1ZoHhwQ86k0vpdfdVMttvuIUos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQJPddHlOIQkV4FOO3tUSQPtTfKEDkohBMLCw30QvVc2GsgsUyp+15whzIH5VU4T1AeRLvHoorFdsLTcDPZC7OMwFLQvZ5QW7uY5MPPuC0CCoX0a6z6qVUBPclWOwKkbDczL+Ik/83CMS695f1TL37bzKaWYjkoAOKewfP5J/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=kXXXmcdW; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="kXXXmcdW"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTP id D4D2840755F0;
	Mon,  8 Sep 2025 18:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D4D2840755F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1757357389;
	bh=m+Xks2tQ3rY0lAhqxLgf/PnsQL3IYkwNgdXkoJukEzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXXXmcdW++I4C/tMS0ViuMgFjNnNtzdRDfB6fYEVAr70jvmQwqorsD0JCVJeKs4cm
	 mOPyJ8JeSzng20mO1hSM0hq8I0rGKVK1KA/AadYhKBMxFUL5zbI8DLQdqCwhAT/n9O
	 4LrQoiW4NAQFjZjY1rajYLWfYEELmvbN8qpeDTTw=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v2 3/4] xdiff: move hashing functions to a separate header
Date: Mon,  8 Sep 2025 21:49:38 +0300
Message-ID: <20250908184939.16338-3-amonakov@ispras.ru>
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

Move xdl_hash_record to a separate header file, and expose
xdl_hash_record_verbatim as an inline function to avoid call overhead
for short strings.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 xdiff-interface.c |  1 +
 xdiff/xhash.h     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xinclude.h  |  1 +
 xdiff/xutils.c    | 13 ------------
 xdiff/xutils.h    |  9 --------
 5 files changed, 54 insertions(+), 22 deletions(-)
 create mode 100644 xdiff/xhash.h

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4971f722b3..e21a7aa0c9 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -12,6 +12,7 @@
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
 #include "xdiff/xutils.h"
+#include "xdiff/xhash.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_hunk_fn hunk_fn;
diff --git a/xdiff/xhash.h b/xdiff/xhash.h
new file mode 100644
index 0000000000..27da4288c8
--- /dev/null
+++ b/xdiff/xhash.h
@@ -0,0 +1,52 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003  Davide Libenzi
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
+ *
+ *  Davide Libenzi <davidel@xmailserver.org>
+ *
+ */
+
+#if !defined(XHASH_H)
+#define XHASH_H
+
+
+
+unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
+
+static inline unsigned long xdl_hash_record_verbatim(char const **data, char const *top)
+{
+	unsigned long ha = 5381;
+	char const *ptr = *data;
+
+	for (; ptr < top && *ptr != '\n'; ptr++) {
+		ha += (ha << 5);
+		ha ^= (unsigned long) *ptr;
+	}
+	*data = ptr < top ? ptr + 1: ptr;
+
+	return ha;
+}
+
+static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
+{
+	if (flags & XDF_WHITESPACE_FLAGS)
+		return xdl_hash_record_with_whitespace(data, top, flags);
+	else
+		return xdl_hash_record_verbatim(data, top);
+}
+
+#endif /* #if !defined(XHASH_H) */
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index a4285ac0eb..68b2d9f1f1 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -31,6 +31,7 @@
 #include "xprepare.h"
 #include "xdiffi.h"
 #include "xemit.h"
+#include "xhash.h"
 
 
 #endif /* #if !defined(XINCLUDE_H) */
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index e070ed649f..0fff5b26a0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -294,19 +294,6 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
-
-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
-	}
-	*data = ptr < top ? ptr + 1: ptr;
-
-	return ha;
-}
-
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
 
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 13f6831047..f51336fce1 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -34,15 +34,6 @@ void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top);
-unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
-static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
-{
-	if (flags & XDF_WHITESPACE_FLAGS)
-		return xdl_hash_record_with_whitespace(data, top, flags);
-	else
-		return xdl_hash_record_verbatim(data, top);
-}
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-- 
2.49.1

