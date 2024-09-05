Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5862189522
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526829; cv=none; b=KJdDVrWrb3m43RVA9fW2F+J/dWC5uNgmJf1RkBBtf5z6cMY8YYbRZowqfGwOd9LsSVuS+KcSyeQMvcNLvrKgkafzu0ND8sS9rysAlij1q0p+VjgN5a0NlHCFhIkizrBQPfwMeIuAeTnyq1WkxaIeJLpyPFwukdiHyf0KtdSSz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526829; c=relaxed/simple;
	bh=mm7yl2j2ITmdSkllzBmILvmFUrk0mOzkgxFNFyQbLoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3sGTARJA5QZIPlI6lBitz+SpJ3UtZ7tLZ6WkHbwxtrubXOlD0yr9d5QKyxLFOcJ7CazLzC+TLu2vFUpnsO0pruqgp/Dv24j8+liRNovHkCW2o/JO7DMq+mlqNJa6IEeU2HxeJiw9LCGmGERTecvowyW8J0QD3MWwa09AuUP9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5778 invoked by uid 109); 5 Sep 2024 09:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 09:00:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7141 invoked by uid 111); 5 Sep 2024 09:00:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 05:00:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 05:00:24 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] pack-bitmap: tag bitmapped packs with their
 corresponding MIDX
Message-ID: <20240905090024.GA2556395@coredump.intra.peff.net>
References: <cover.1724793201.git.me@ttaylorr.com>
 <1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
 <xmqqplpt5wrt.fsf@gitster.g>
 <ZtDEy/teamtXMAbn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtDEy/teamtXMAbn@nand.local>

On Thu, Aug 29, 2024 at 02:58:19PM -0400, Taylor Blau wrote:

> On Tue, Aug 27, 2024 at 05:14:14PM -0700, Junio C Hamano wrote:
> > > diff --git a/midx.c b/midx.c
> > > index ca98bfd7c6..67e0d64004 100644
> > > --- a/midx.c
> > > +++ b/midx.c
> > > @@ -496,6 +496,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
> > >  				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
> > >  				 sizeof(uint32_t));
> > >  	bp->pack_int_id = pack_int_id;
> > > +	bp->from_midx = m;
> >
> > Do multi_pack_index objects live as long as bitmapped_pack objects
> > that point at them live?  If m later goes away without letting the
> > bitmapped_pack know about it, the borrowed pointer in from_midx
> > would become dangling, which is not what we want to see.
> >
> > "None of these objects are released or relocated while we are
> > running pack-objects, so once the .from_midx member is assigned
> > here, it will always be pointing at a valid multi_pack_index object"
> > is a satisfactory answer, I guess.
> 
> Good question, and good answer ;-).
> 
> This is only relevant in a read-only path where we're generating a new
> pack from existing packs and not altering those pack or rewriting /
> deleting the MIDX attached to them. So I think we're OK here and don't
> have any lifetime/scope issues.

Do we ever close/reopen the midx? For example, if a simultaneous process
wrote a new one and we triggered reprepare_packed_git()?

I think the answer is "no"; we might read a new midx, but we never ditch
the old one (just like we do for packed_git structs). Which I suspect is
needed even before this patch, since various other parts of the bitmap
code (and probably others) rely on the struct staying in place across as
we read many objects.

-Peff
