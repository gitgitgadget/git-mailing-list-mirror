Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB038F92F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000478; cv=none; b=SVC4CdTb9vaeCEQjxqkBLaYRnBKey66gdd5ZVdT1AcufOAYBCHbxqIBPuw3uFJ5G4bQcqsZPOB4Sgk/4pfOp7L9VVTqxRFYRRBEr23MGdcYD80wGjsx3KOFgQpgH5oZsPXmDfonZw5GDONUF2tkqK4osPqfEIBhI1uBDMu50gQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000478; c=relaxed/simple;
	bh=8qMkHkZN0qeDTFLWWgIDoF1pEjeTQ1I1SxGZKkxQ6eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG4/vfXYW2xZ4bF3AXWCkRmhb6r0QV+d46Zj8O2aTaIo6LVld9dEDCEBni1Sm2U/xNit+GIiIsysMzCqwN2KSmoLOnsEK+PPG7mu/WcXB0Ycnkf+EuzKShjIn7tp0ofZUrz7U3JEnKvL+it08IYQiBB8mR/6vQvSDdtXr+9STvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ie5YGbhd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ie5YGbhd"
Received: (qmail 206585 invoked by uid 106); 31 Mar 2026 23:41:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8qMkHkZN0qeDTFLWWgIDoF1pEjeTQ1I1SxGZKkxQ6eM=; b=Ie5YGbhdukYlWBgVOeAUn8OPeEkQzAKBgjN35rfnXwLuMPCuaafThdsGcZbAbAvl/aRSeV1F7MVaNtH0G+miKMjDUVBj8zSuALZtDCAdyBbjE5YiaxOw2hFavCnTjOGf1drb8LxSvJR7vMGvfAnsTAyFv+8hKVfXbt70BcLplcQ0EejAQMaceRaaO9cUlAtNs6+VOPjaijM86xt6zGGc3MvqVzSveurbisMq36qY2K/aKGNgZrvX2HMLziiAEOLzZuk7ryCr1XAra6PM3hZcX3nCnCz/q6GBvFbP045/7SQS/tucH6/f/pAVSqYz/bJf3juWaM7sV+QTMDj+qyoAgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:41:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326411 invoked by uid 111); 31 Mar 2026 23:41:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:41:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:41:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 01/12] convert: add const to fix strchr() warnings
Message-ID: <20260331234115.GA2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

C23 versions of libc (like recent glibc) may provide generic versions of
strchr() that match constness between the input and return value. The
idea being that the compiler can detect when it implicitly converts a
const pointer into a non-const one (which then emits a warning).

There are a few cases here where the result pointer does not need to be
non-const at all, and we should mark it as such. That silences the
warning (and avoids any potential problems with trying to write via
those pointers).

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index a34ec6ecdc..eae36c8a59 100644
--- a/convert.c
+++ b/convert.c
@@ -1168,7 +1168,8 @@ static int ident_to_worktree(const char *src, size_t len,
 			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
-	char *to_free = NULL, *dollar, *spc;
+	char *to_free = NULL;
+	const char *dollar, *spc;
 	int cnt;
 
 	if (!ident)
-- 
2.53.0.1136.gd760fbd4a0

