Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEE1A267
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508555; cv=none; b=t64IkVe4hBbOyuCkxefM4UaO8JBlGqV9ZUHzguC03aZ39cf5WB/m0vC2eIZI3eu7XFJZj5hKFELdwm1LDMZmZ1Xa0irXz/9pj/nNxYGFHq2E1v0AA5PAIRevivO0anjz5kLKhAsRpOV1I55DpcVv5gD5XcRjfUPNSNFScX3yhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508555; c=relaxed/simple;
	bh=1nqaAQk7iQLaAj2gYAoopgY/6QF2WstQHZRoMCnbGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqh3V5QngssWkwTrmlg2FwvliUaY9xDC2L1kyGwurGI+SHg7/wp2NOZq9mnSYZbGI+mJxRjNJQYFnxvgsg6SV6KLZLVnkOSr8+sM02+ut5mX5sSc5ZYu8JT3H6IGkXMHrR1lUhdNUyFLCNIyGBY51zFoChivWiNob54ivR1BgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ccmMXbb8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ccmMXbb8"
Received: (qmail 170864 invoked by uid 109); 30 Nov 2025 13:15:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1nqaAQk7iQLaAj2gYAoopgY/6QF2WstQHZRoMCnbGwc=; b=ccmMXbb8w5EmJTUnIMAC5QEXqGM1OhZxqVq3UKTntcsBJ5FZnNafOCkEGOHzZvM1wLC3lif04YoOplK91frKuzyWeGlUxBJrUEIAifekVJOfuKRCENAU6V1CIMiEB22JTkKnyLNRe/NtZfiK8eeykVmHvEfNlDWFqF8YHLphucdyVs/5vVLd9zTCP1vYvU5yvfJ1vUhiShOyicYeSm3uu4gBy940H8yD+bn5Flyt7s8Z959vvMX3K2VlNREM9q5QRQajWyP41O/SJqBwGk/GdNQKvKrxph0gs3+qkLPNttzHAWc/1wJwug21FptBjCHJLlUykfaHnmY465ubsj2e/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:15:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 254799 invoked by uid 111); 30 Nov 2025 13:15:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:15:52 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:15:51 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/4] cache-tree: use parse_int_from_buf()
Message-ID: <20251130131551.GC199335@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130131351.GA198697@coredump.intra.peff.net>

In c4c9089584 (cache-tree: avoid strtol() on non-string buffer,
2025-11-18) we wrote an ad-hoc integer parser which did not detect
overflow. This wasn't too big a problem, since the original use of
strtol() did not do so either. But now that we have a more robust
parsing function, let's use that. It reduces the amount of code and
should catch more cases of malformed entries.

I kept our local parse_int() wrapper here, since it handles management
of our ptr/len pair (rather than doing it inline in the entry parser of
read_one()).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache-tree.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2d8947b518..f8fb290443 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -16,6 +16,7 @@
 #include "promisor-remote.h"
 #include "trace.h"
 #include "trace2.h"
+#include "parse.h"
 
 #ifndef DEBUG_CACHE_TREE
 #define DEBUG_CACHE_TREE 0
@@ -550,32 +551,13 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 
 static int parse_int(const char **ptr, unsigned long *len_p, int *out)
 {
-	const char *s = *ptr;
-	unsigned long len = *len_p;
-	int ret = 0;
-	int sign = 1;
-
-	while (len && *s == '-') {
-		sign *= -1;
-		s++;
-		len--;
-	}
-
-	while (len) {
-		if (!isdigit(*s))
-			break;
-		ret *= 10;
-		ret += *s - '0';
-		s++;
-		len--;
-	}
+	const char *ep;
 
-	if (s == *ptr)
+	if (!parse_int_from_buf(*ptr, *len_p, &ep, out))
 		return -1;
 
-	*ptr = s;
-	*len_p = len;
-	*out = sign * ret;
+	*len_p -= ep - *ptr;
+	*ptr = ep;
 	return 0;
 }
 
-- 
2.52.0.413.gf695cdb9bd

