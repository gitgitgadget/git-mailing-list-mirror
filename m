Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B3286897
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456392; cv=none; b=uElHwwlCxmpCyNhdz5kXMz/xMH8+cjH7GZ2tADI4uHtp2dSKpmTKdmU5UMEKPIkukcYxMgHP6d/YO1+5ZT45rcIAV1pFFBtFkvbqvJU3O1DeDJjzx/iR4uqzKaPVef+ikPtrq8W5JKGMXjvDcCkEpgNDPL1B7FR4pGUs45XF/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456392; c=relaxed/simple;
	bh=PPDrx4I5i7r2bt/Bq8gXHouux2LYslFvc5sY2Q9fs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ragg3wEt2gzVuQTwphTVgOjJrQwjeLC+EJo6Wy7TWOeYxkNdSiX5+QYXWFD811s1y1nJVWh1DGN+1u7MzrK2VLKth4I5b+xC18gUVSTsGwU9MezIuPXpN64y4gkB1cX4Kz9Pa3nqiNgekERBZJuL/qF/vfld5PpH9RiXkgvgQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EzmXpIpW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EzmXpIpW"
Received: (qmail 19545 invoked by uid 109); 18 Nov 2025 08:59:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PPDrx4I5i7r2bt/Bq8gXHouux2LYslFvc5sY2Q9fs74=; b=EzmXpIpWOjM/6869qAk6tcugB2eLkkqFpitgLmqoWFZX8yU1QrGwhABXo/Sj/KyZx7WQWSZbpfOOkxmtJEOfnpaJUq27i/grxDFXqrllHSkMpcLiQxZe5MoirCZxcELCr+hMYEPVMverRTV481eILWRHxhOiMWGmuy6VFSsjJFdozb6OfynJOuE5sqVQiO9jm7d+XA2ELMvzLvdwJKE8GOfpMkXuSqLn7Q1nn3eLTmsW+O9A5rU3JzBn4qRxhnKA3qNMEFXe9ILAmTDP19McBNb6qezBbA2LC5k7csKO4yz2JtIuYBrM9s1L2s9Dcv2FV3B+Qotz13b8FORaVHibBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 08:59:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27249 invoked by uid 111); 18 Nov 2025 08:59:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 03:59:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 03:59:49 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>
Subject: Re: [PATCH 2/9] pack-bitmap: handle name-hash lookups in incremental
 bitmaps
Message-ID: <20251118085949.GD4164207@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080151.GB979063@coredump.intra.peff.net>
 <aRVIh9R8Pnuk+yS0@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRVIh9R8Pnuk+yS0@nand.local>

On Wed, Nov 12, 2025 at 09:55:03PM -0500, Taylor Blau wrote:

> On Wed, Nov 12, 2025 at 03:01:51AM -0500, Jeff King wrote:
> > As always with the midx and bitmap code, I am left unsure of which
> > ordering it is correct to use (pseudo-pack order, or lexical oid order,
> > or how each splits across incremental files). I _think_ this is right
> > because it's matching the ordering that is already used for a single
> > midx. But clearly this area is under-tested, since even when we did not
> > go off the end of the array we were probably passing back junk
> > name-hashes (either from the .bitmap file's trailing checksum, or
> > zero-padding at the end of the mapped page).
> 
> Yeah, this is the right order. "index_pos" is a good hint that this is
> in lexical order. bitmap_writer_finish() has some oid_pos() lookups that
> use index directly without sorting, so bitmap_writer_finish() expects
> this array in lexical order.

OK, that matches my analysis. I guess I was just a little surprised that
the name hash is in lexical index order, and not pack order. But it
definitely is according to the documentation and the implementation. I
guess in the end it doesn't really matter that much either way, as you
tend to reverse the pack/bit position into a lexical index position
anyway to get the oid. So there is no situation where you don't have
both anyway.

> Commit c528e17966 (pack-bitmap: write multi-pack bitmaps, 2021-08-31)
> has a comment in (what is now) midx-write.c explaining this assumption
> in bitmap_writer_finish(), but it should probably be documented
> explicitly in pack-bitmap.h.

Maybe, but I think I may just have been overly paranoid that I got it
wrong.

> > +static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
> > +{
> > +	if (bitmap_is_midx(index)) {
> > +		while (index && pos < index->midx->num_objects_in_base)
> > +			index = index->base;
> 
> Looks good. It's too bad that we have to reimplement something very
> similar to midx_for_object(), but I agree with what you wrote in the
> patch message and this faithfully captures that. It might be worth doing
> something like:
> 
>     while (index && pos < index->midx->num_objects_in_base) {
>         ASSERT(bitmap_is_midx(index));
>         index = index->base;
>     }
> 
> , which should never trigger, but is a good sanity check. Definitely not
> worth re-rolling IMHO.

Yeah, I wondered the same thing while writing it. It would be a pretty
horrid bug to have mixed entries in the linked list. But that is also
what assertions are there for. ;) I added it for v2.

> > +		if (!index)
> > +			BUG("NULL base bitmap for object position: %"PRIu32, pos);
> > +
> > +		pos -= index->midx->num_objects_in_base;
> > +		if (pos >= index->midx->num_objects)
> > +			BUG("out-of-bounds midx bitmap object at %"PRIu32, pos);
> 
> midx_for_object() spells this portion slightly differently, but what you
> have here is still good.

Yes, there it's a die(). But elsewhere, like in pack_pos_to_midx() and
its reverse, the same situation is a BUG(). It's not clear to me we get
a bit or index position that is out of bounds here (is it truly a bug or
programming error, or might we get it from a corrupt on-disk file). So I
think it's mostly academic, at least until somebody can generate a real
corrupted case.

> > +	if (!index->hashes)
> > +		return 0;
> > +
> > +	return get_be32(index->hashes + pos);
> 
> We *could* double check that that offset is within bounds of
> index->map_size, and I think that is ultimately worth doing at some
> point. But I think that stopping where you did makes sense, since it
> does the minimal thing to fix this bug.

I don't think we need to. When we open the bitmap, we check that its
hash-cache size matches our expectation based on the number of objects
covered by the bitmap (using bitmap_num_objects(), so either from the
pack's count or the midx slice's count).

-Peff
