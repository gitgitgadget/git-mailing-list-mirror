Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7A29B793
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934539; cv=none; b=KdjQ4vmdI+Sgaxflv/tcanJt44QG8rIsnsbqzYC+xMduVOlZMsIZagDyZ7gDPapcxmKKAhPrJhV3EVCNl7vjyDksQ9hVyYKuqvc2wyGwsh9GAskycqcBsZ62STuw48mQ+geoKX5LyGxHUmmfNM9OTpZgp5Su1RHygtH9rTX/WRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934539; c=relaxed/simple;
	bh=eRYQ0asI6o5aFSZKOabudx150alPrMFJ7aUKeJ425fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9W1Eg0pe496/j424O3t/UIOpgIZEhyIRTMMM/qayVUWd+pJUP0bHbTccYOw8Mxf6ZxzANmDF0UKoseU/lKfBq31pksnU/MkX1FhG+TvlZeXag82jTU0gF74VAFeir6Ixv8XuVgiPDh0Q5xvGU/QohSw8nLH8Q1w0KwvQ3deYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TgQy9ex6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TgQy9ex6"
Received: (qmail 495358 invoked by uid 109); 12 Nov 2025 08:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eRYQ0asI6o5aFSZKOabudx150alPrMFJ7aUKeJ425fE=; b=TgQy9ex6SGePyrJRCJ9vCoW3ymnFZkga5PTxcj/+GUQrRrkddBWrohaE5GL38XmKkw3NyhGIj6k91KbbY8gxdnB6AsFKRuSZgSk9NH6h06p0cy88aeDMPHFQ8EGnjWDU3tIncERWxiqmQrxQAqA1eeNTPpLOpxWbcTCeMd1JBhQ8dJ466jIRiX00N70RA3w9gt1PehPxrjp1UrgMx37idPVaM/q/tWJTDb0K2Qkk9glqwXeyh58Lj1WxisQKAFYUGA/z5QKS93yU+toMeHv+MZ8a04GMg2HIFfju4REC3WKz0tvUG+Arj+BEGuuDBs2GKiMn0nHomUgVRjB7TmiZdA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786348 invoked by uid 111); 12 Nov 2025 08:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:02:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:02:15 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <20251112080215.GC979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

Git often uses mmap() to access on-disk files. This leaves a blind spot
in our SANITIZE=address builds, since ASan does not seem to handle mmap
at all. Nor does the OS notice most out-of-bounds access, since it tends
to round up to the nearest page size (so depending on how big the map
is, you might have to overrun it by up to 4095 bytes to trigger a
segfault).

The previous commit demonstrates a memory bug that we missed. We could
have made a new test where the out-of-bounds access was much larger, or
where the mapped file ended closer to a page boundary. But the point of
running the test suite with sanitizers is to catch these problems
without having to construct specific tests.

Let's enable NO_MMAP for our ASan builds by default, which should give
us better coverage. This does increase the memory usage of Git, since
we're copying from the filesystem into heap. But the repositories in the
test suite tend to be small, so the overhead isn't really noticeable
(and ASan already has quite a performance penalty).

There are a few other known bugs that this patch will help flush out.
However, they aren't directly triggered in the test suite (yet). So
it's safe to turn this on now without breaking the test suite, which
will help us add new tests to demonstrate those other bugs as we fix
them.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 7e0f77e298..0f44268405 100644
--- a/Makefile
+++ b/Makefile
@@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
+NO_MMAP = NeededForASAN
 SANITIZE_ADDRESS = YesCompiledWithIt
 endif
 endif
-- 
2.52.0.rc1.260.g3e4993586f

