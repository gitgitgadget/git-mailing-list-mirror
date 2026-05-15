Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EEF413D90
	for <git@vger.kernel.org>; Fri, 15 May 2026 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874653; cv=none; b=IzrAvrGCdAQWTe5YdEYKxxV7u5H3V1/+MpmyommpxanyBhfrQuWdBauekbge7qHzGExFuInumfTLnv1Y5QSCH9nnPG2qSH+/TL1IzSkg7EYnIbqx2kQb5FeR8O4j0Q9bEZX9x/Zg/hxeW6hbyiy8wcR6oy+NFJKhIO85+9w5bTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874653; c=relaxed/simple;
	bh=pRxD8MSvvbr1pENJZ1sZJkhINVIQ1Uj71/oREnPOjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFieBGNBHrVGvzO/NmUBydUhGazhI7NADnV+wHZSYjQ+617+uvlR1IrrC4m/EP+2au5LfmXT1UqBX3THu77PqEdc5LLPKnuO6a/dniAFa1CK5p6iLVBToYWQ1uApWS0CdmNz7tBUNZ4Hnc9dHH3RmBVnS0BbjTif/bAyRr8BbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UQsEWL+t; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UQsEWL+t"
Received: (qmail 56915 invoked by uid 106); 15 May 2026 19:50:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=pRxD8MSvvbr1pENJZ1sZJkhINVIQ1Uj71/oREnPOjPY=; b=UQsEWL+tXDB03f3MnI0hzlBi/EWzHOwA1yGDLA1TnkdCR9nWKmLzkHlstONUolvKxjCrVBZmy+ceSgW3Ms2I25k9tJJZMn1gKKTkct2No6pCJIziVbsBZwMD9TKIA/C2bi62w3PmTi/B9NCJFAPCribm8x7ljDXl8iVP3uSDMjqgT42U6oBmiEmsGBAO/zvo46F8eyptxl1bNVF8LEYaN6NGepdRHJYmvYXxTrqEU7I0zMZvdfeT1uumIJY7kIOT4+VnSGrUHZLlC+DG8Y0Iabcj6o4k7DuL++QXL+wZsJt1uDzLROCcRLW0+kVlAYRB8ceXzM4tlUkwwosw2UjC9Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 19:50:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 105811 invoked by uid 111); 15 May 2026 19:50:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 15:50:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 15:50:49 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
Message-ID: <20260515195049.GA149960@coredump.intra.peff.net>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
 <20260515190818.GA98370@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515190818.GA98370@coredump.intra.peff.net>

On Fri, May 15, 2026 at 03:08:18PM -0400, Jeff King wrote:

> On Fri, May 15, 2026 at 08:16:50PM +0200, René Scharfe wrote:
> 
> > +		size_t alloc_grow_new_alloc_; \
> > +		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
> > +			alloc = alloc_grow_new_alloc_; \
> > +			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
> >  		} \
> 
> What happens if a caller passes in an argument that isn't a size_t?
> We'll check for overflow in the size_t space, and then truncate it when
> we assign to alloc, I think.
> 
> I think we generally try to hold allocations in size_t these days, but
> I'd be surprised if there weren't a few "int" holdouts. Grepping around,
> alloc_node() seems to be an example.
> 
> BTW, non-size_t arguments nullifies my earlier hand-waving around "nr +
> 1 overflowing implies we've filled up the address space". But we are
> still protected in the existing code by the:
> 
>   if (alloc_nr(alloc) < (nr))
> 	alloc = (nr);
> 
> logic. But with your patch, that all happens in the size_t space, so I
> think it would actually introduce possible array overflows when the
> caller is using a smaller type.

Hmm, playing with it and looking a little closer, I think we don't end
up overflowing the buffer because you use the size_t for
REALLOC_ARRAY(). So the result is big, but then "alloc" is truncated.

And then on the next call, we think "oh no, the allocation is way too
small" because we are using the truncated value. So we try to size up
for every single allocation, even though it's actually big enough, and
the program slows to a crawl. ;)

For reference, IU was using this hack to play around and demonstrate:

diff --git a/git.c b/git.c
index 5a40eab8a2..638bbc69e4 100644
--- a/git.c
+++ b/git.c
@@ -969,6 +969,19 @@ int cmd_main(int argc, const char **argv)
 
 	cmd = argv[0];
 
+	if (!strcmp(cmd, "foo")) {
+		unsigned char *buf = NULL;
+		unsigned nr = 0, alloc = 0;
+		for (unsigned i = 0; i < UINT_MAX; i++) {
+			ALLOC_GROW(buf, nr + 1, alloc);
+			if (i % 313370 == 0)
+				warning("at i=%u, alloc=%u, nr=%u", i, alloc, nr);
+			buf[nr++] = i % 256;
+		}
+		printf("done, final nr=%u, alloc=%u\n", nr, alloc);
+		return 0;
+	}
+
 	/*
 	 * We use PATH to find git commands, but we prepend some higher
 	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH


The same problem exists in several places in actual code, but I'm not
sure how practical it is to trigger. The alloc_node() is counting not
just objects, but blocks of objects. So you'd need 2*31 * 1024 objects
of one type, which is probably going to run afoul of other limitations.
Other cases are similar; for example "yes | git fetch-pack --stdin foo"
will grow an array indefinitely, but at one strbuf per line it starts
swapping on my 64GB machine at only 350M entries.

I think as long as the behavior remains "slow, but we do not overflow
any buffers" when you reach these limits, that's OK. Nobody is going to
do it in practice, and we just want to make sure that malicious inputs
cannot get out-of-bounds writes. It might be worth adding a comment,
though, to make sure nobody ever swaps "alloc_grow_new_alloc_" for
"alloc" in that macro.

-Peff
