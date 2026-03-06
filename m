Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EC36A034
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814316; cv=none; b=hNfrat1JmTOcP1AscMyCY1H5NrO4rbzgmaJTvJ9T9ORcOqsWf5lHvtQuGN1vgBj3NN2zdtW7SgduevcLZyv/zeqdD3tZ77rXL0W9Cr5KiscmBzH0f5PZ1f5aSyLl1FHPBDBjbPgR8lB5QXtKuDza/EUqPgne92h2tGRm5Oo56tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814316; c=relaxed/simple;
	bh=okpBrLEbTTj285AK81NxUAsZYtwgb+S5D3KjhNqJAx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyuORUzUHCHya71FQbLL/EbvRHJHtOC3mRlt/5HdFK6Tg8GADlvq40Lkq878r4eK5dV6QYYOS43oOxVflvjyi/KO8LrSZEgoOAZYc8IonMZh5+Rv6v8Hg5vgSm+nX5BI9D/HcikBX8Xvuc9rXse8Q0jJAs4L8C/QCe/8MXo5pvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U7R9VQWG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U7R9VQWG"
Received: (qmail 10753 invoked by uid 106); 6 Mar 2026 16:25:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=okpBrLEbTTj285AK81NxUAsZYtwgb+S5D3KjhNqJAx8=; b=U7R9VQWG2OP64znPF4NaE1Mfjbq9WkolC5+9OproaDE7xS7gwcTFCsY3n8Zm/2bTLLMj5t4TnMrmmXVV00bBHYP4rXeMY8hubELSVYhl8tBzjC0JJGs1WbkrjjTMv/jnWb1rX81yodDYpA5EBQXpmEFhYtA23W1uqj4BrvYGuXX2jlhcrJ1jjo0/XS8syn5UgukSZlG82m/fPICKMX1zhcFnuIApIRdez/HIAqK49PGsw/cCtCYCC768FOuue9/XdDyBlkrWYXDr+rAvcg1zAxK2ITn1dwXT+CNg5sLTj/w6ICiV0vKTDEnVIh6SOKb2Jro7Gmq1lUXLAaTC9+Vwuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Mar 2026 16:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 405625 invoked by uid 111); 6 Mar 2026 16:25:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Mar 2026 11:25:14 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Mar 2026 11:25:13 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 5/4] meson: turn on NO_MMAP when building with LSan
Message-ID: <20260306162513.GB3483423@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
 <20260305231305.GD2901305@coredump.intra.peff.net>
 <796110ee-d795-4445-9d82-7026370a88cf@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <796110ee-d795-4445-9d82-7026370a88cf@intel.com>

On Fri, Mar 06, 2026 at 01:17:24AM -0800, Jacob Keller wrote:

> > diff --git a/Makefile b/Makefile
> > index f3264d0a37..4cf1afd395 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1600,6 +1600,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
> >  endif
> >  ifneq ($(filter leak,$(SANITIZERS)),)
> >  BASIC_CFLAGS += -O0
> > +NO_MMAP = CatchMapLeaks
> >  SANITIZE_LEAK = YesCompiledWithIt
> >  endif
> >  ifneq ($(filter address,$(SANITIZERS)),)
> 
> Should this patch also affect the meson.build?

Ugh, yes.

I don't think we use meson in the CI sanitizer builds (which is where
I'd guess most leak-checking happens), but the two systems should remain
consistent.

Patch below (that can go on top or be squashed into 4/4).

> Also I think this might be somewhat less flexible than Make since you
> can't forcibly enable mmap even with sanitizers enabled. I suppose thats
> not a big deal since enabling sanitizers already has a high cost.

I don't pay much attention to the meson support, but yeah, it looks like
there's no equivalent to tweak the NO_MMAP knob independently there. I
doubt anybody is clamoring for it.

-- >8 --
Subject: [PATCH] meson: turn on NO_MMAP when building with LSan

The previous commit taught the Makefile to turn on NO_MMAP in this
instance. We should do the same with meson for consistency. We already
do this for ASan builds, so we can just tweak one conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
Tested and confirmed this finds the test failures fixed by the earlier
patches.

 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4b536e0124..4e13afbb41 100644
--- a/meson.build
+++ b/meson.build
@@ -1426,7 +1426,7 @@ else
     'getpagesize' : [],
   }
 
-  if get_option('b_sanitize').contains('address')
+  if get_option('b_sanitize').contains('address') or get_option('b_sanitize').contains('leak')
     libgit_c_args += '-DNO_MMAP'
     libgit_sources += 'compat/mmap.c'
   else
-- 
2.53.0.791.g8baeb4ea4d

