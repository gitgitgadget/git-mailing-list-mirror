Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD534C92
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752388; cv=none; b=EshOqb4eCTynVdFSB5J0bv85WBdlktB5y2zj4tK6zKZv/Ke9eS2smilteQw4pSusOJgx9ZsTIshlZKfMC4vazY2G1t/af9ov3Uw6HHFEX85ctocf567jNjHk9mTXBQSeX0Vi73Iairpy+3yw0+scdP9UZuch4aEAikhAEv3GYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752388; c=relaxed/simple;
	bh=npTwwYo/zDbG/Z/D7jQOTU2YgpyKF2TxtTwQqgMGD30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec6hYfM+3E5PKEOLWT6LWw23aXYNP3ug5M9Gcrx6VgmVu1XxRmzr6kjv6s2BKZPIDOB1Uk3YEEvtCZq1bFZsjKHBBYHeohEr1RQubqa8lzftPseOYpwx603zG7Vf7QJLp3O/B/lwmMWKw+n7VjHdOUBEmWe3TW5ViRTUXD8CTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QGlLgMN3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QGlLgMN3"
Received: (qmail 2702 invoked by uid 106); 5 Mar 2026 23:13:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=npTwwYo/zDbG/Z/D7jQOTU2YgpyKF2TxtTwQqgMGD30=; b=QGlLgMN3A2BGJ+NCs8+Zrb39NbU5Dd3zrh312dxJbXSXfW1ydpURxB34O0ss5Zkf4WIEiCaS6dLlCc2q44KvBG3Hp+OgKvDgqhy7r/boA8EA6kMUAqIq0167qrgAdm4OV2pY0VBfOQym+4j1SZAw2j1xzhWEoauz8Q6ujGLmdd/PLHVAOXKqMpL7g2TNS2bQZfPooFPRK7qHvrdfNimxQ5WIDNZCKz1rZAxbZ28lV5EnMjnLLdaOjFv0mJYh7Ue19AfAl1V3Nwhio5AElALff4YCcJvjuW27WmtPklgckQDFj3Q8d9cgDwwR3ckDeMqj0N628z8i17FqAwd36UNJig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 23:13:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393543 invoked by uid 111); 5 Mar 2026 23:13:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 18:13:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 18:13:05 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 4/4] Makefile: turn on NO_MMAP when building with LSan
Message-ID: <20260305231305.GD2901305@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305230315.GA2354983@coredump.intra.peff.net>

The past few commits fixed some cases where we leak memory allocated by
mmap(). Building with SANITIZE=leak doesn't detect these because it
covers only heap buffers allocated by malloc().

But if we build with NO_MMAP, our compat mmap() implementation will
allocate a heap buffer and pread() into it. And thus Lsan will detect
these leaks for free.

Using NO_MMAP is less performant, of course, since we have to use extra
memory and read in the whole file, rather than faulting in pages from
disk. But LSan builds are already slow, and this doesn't make them
measurably worse. Getting extra coverage for our leak-checking is worth
it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index f3264d0a37..4cf1afd395 100644
--- a/Makefile
+++ b/Makefile
@@ -1600,6 +1600,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -O0
+NO_MMAP = CatchMapLeaks
 SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
-- 
2.53.0.786.g466665faa3
