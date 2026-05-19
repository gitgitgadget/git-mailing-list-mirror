Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321151F0995
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151313; cv=none; b=GuNJbvnddnT4jfkzLHqTtM9O4C3VF2OM3EvSBO6afUhJINnD9QcziYD0rAJz3nNO8hj1OMbeG9LhuZJIzeocDVxWZsV7kgHHsv84ntfNhVGzyXOAidn4kZbHkTaFC0yYYbBMdISoKVPC+gS7KsLuPbyZuQB+1nMm5OVovS0SH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151313; c=relaxed/simple;
	bh=lDFAuwYyvCeufxz53oeCGG0OgG+KYL2opPlOXj42S1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtLan+VEe2R4FjzIsyJqDAXkUiC/CzreNRc0ldGysSyEpW7savtX5LdEuOQlLbVRn1yMCJeeYrp7zb5JajTEITsu1o/nz/UHlG8/g8wJ62+CmjJ71qlbJwiruzHsB+GkSCCUBQdGU3CIG9ogHACj9baAx1mwC5uDayc8UQ55B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DUHqgeGN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DUHqgeGN"
Received: (qmail 15611 invoked by uid 106); 19 May 2026 00:41:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lDFAuwYyvCeufxz53oeCGG0OgG+KYL2opPlOXj42S1U=; b=DUHqgeGNanNd/uqCERBAGdMuQUddA9F0w+9GqDsFjkAZl5I9laTdP6xhB+Y7MoMAt4FuBWhZiASBoDlYzZQnhm2AzOc++P/n2ndZTSli7KccnZYPBvXb3icAC+4sNE0oPHkPjYHhWzBHo6Whp+3QH70xmf48bw9e543xf7+e/0dE85Ib+JE33HfLStV5yUESNQJlZ0l/pmFRqSXlZrBKanxb633zNJf95RovJbm4h1iUpg5bNW+I+qjzjZEn/2w0QirZ671bj8nWjV0h33FHtPHAUrHb21OTzc29+gcZG6LhtbwbVeb2uU4W84WRNlOPYRpEHddWKXHRVH14KZKMSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 00:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38246 invoked by uid 111); 19 May 2026 00:41:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 20:41:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 20:41:43 -0400
From: Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
Message-ID: <20260519004143.GA1612961@coredump.intra.peff.net>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
 <20260515190818.GA98370@coredump.intra.peff.net>
 <20260515195049.GA149960@coredump.intra.peff.net>
 <9ce768d4-0cbf-4494-a1d3-55fd3b05b61e@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ce768d4-0cbf-4494-a1d3-55fd3b05b61e@kdbg.org>

On Sat, May 16, 2026 at 08:55:54AM +0200, Johannes Sixt wrote:

> > Hmm, playing with it and looking a little closer, I think we don't end
> > up overflowing the buffer because you use the size_t for
> > REALLOC_ARRAY(). So the result is big, but then "alloc" is truncated.
> 
> Protect against double-evaluation of "alloc", too, using
> 
> 	size_t *palloc = &(alloc);
> 
> and use *palloc in the two places, then all callers are forced to work
> with a size_t as third argument. Don't know what the damage would be,
> though.

I think it would be nice if all ALLOC_GROW() callers used a size_t, and
then we checked the size_t computation for overflow. But from a rough
guess (taking your suggestion and trying to compile) we'd need to adjust
~200 callers.

And it's not just a straight conversion:

  1. Sometimes the ability to represent a negative value is important,
     and each site has to be audited. If we could agree on a "as big as
     size_t but signed" type, that might help.

  2. Changing the alloc variable type without the matching "nr" can
     actually make things worse. We tend to catch overflow-by-1 for
     signed types incidentally because it results in a stupidly large
     allocation request. But if made our allocations correct, then we
     might overflow on "nr" and start writing to some huge negative
     offset before the array.

So I think it would be a fair bit of work, though I would feel better
about the resulting state.

-Peff
