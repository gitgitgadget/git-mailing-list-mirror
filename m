Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19594168DC
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772309; cv=none; b=Kqsnph01lg388D9817ZFX63UGqJARIrKh8cfJ6nBkciEON6g4CbVzh3TmEA07KYL6TAQnQW/08G+nc8hqvWc/o1GTeCwobH3c+8PI0jBDCf5odkm1tSlJNcahRDEBEUG4ALi2lm8frUkplCVZu0rHmRGe5W6PWJ1vSwSXZecCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772309; c=relaxed/simple;
	bh=eQjuB7gB9/CFDDOuvhQZQ4bW2UlaHO9tphlxSgnD1sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH1wRx6VV/ZLjU34k9yoc2XkTKsHBi0+4gzm4NdMNbJMZ5nrJKeDx5syJ0NnQIsTtbn2XoUofKLchLt9BbZQi4G0o3PZKQwKz95Oq7l2BgsRgiNA8R/UbCOS2iHRpnf9ok+Ywx+BamPiIQCuqlKl3aVcaJIYALu0qngqXAzs9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15605 invoked by uid 109); 10 Apr 2024 18:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Apr 2024 18:05:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18349 invoked by uid 111); 10 Apr 2024 18:05:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Apr 2024 14:05:07 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Apr 2024 14:05:05 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/24] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <20240410180505.GB2260545@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <1347571ef4ca6329de58394bfea71927c8e08151.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1347571ef4ca6329de58394bfea71927c8e08151.1710972293.git.me@ttaylorr.com>

On Wed, Mar 20, 2024 at 06:05:08PM -0400, Taylor Blau wrote:

> In order to know whether a given pseudo-merge (comprised of a "parents"
> and "objects" bitmaps) is "satisfied" and can be OR'd into the bitmap
> result, we need to be able to quickly determine whether the "parents"
> bitmap is a subset of the current set of objects reachable on either
> side of a traversal.
> 
> Implement a helper function to prepare for that, which determines
> whether an EWAH bitmap (the parents bitmap from the pseudo-merge) is a
> subset of a non-EWAH bitmap (in this case, the results bitmap from
> either side of the traversal).
> 
> This function makes use of the EWAH iterator to avoid inflating any part
> of the EWAH bitmap after we determine it is not a subset of the non-EWAH
> bitmap. This "fail-fast" allows us to avoid a potentially large amount
> of wasted effort.

Makes sense, as we have an expanded bitmap_is_subset() already, and this
should be more efficient.

> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index ac7e0af622a..5bdae3fb07b 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -138,6 +138,49 @@ void bitmap_or(struct bitmap *self, const struct bitmap *other)
>  		self->words[i] |= other->words[i];
>  }
>  
> +int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other)

It wasn't immediately obvious to me if we were checking that "other" is
a subset of "self" or vice versa. I wonder if we could use different
names here to make it more clear (though really it matters more in the
declaration, not the implementation).

I think bitmap_is_subset() suffers from the same issue (and is even more
confusing because the two have the same type!). Maybe just a header file
comment would help?

> +{
> +	struct ewah_iterator it;
> +	eword_t word;
> +	size_t i;
> +
> +	ewah_iterator_init(&it, self);
> +
> +	for (i = 0; i < other->word_alloc; i++) {
> +		if (!ewah_iterator_next(&word, &it)) {
> +			/*
> +			 * If we reached the end of `self`, and haven't
> +			 * rejected `self` as a possible subset of
> +			 * `other` yet, then we are done and `self` is
> +			 * indeed a subset of `other`.
> +			 */
> +			return 1;
> +		}
> +		if (word & ~other->words[i]) {
> +			/*
> +			 * Otherwise, compare the next two pairs of
> +			 * words. If the word from `self` has bit(s) not
> +			 * in the word from `other`, `self` is not a
> +			 * proper subset of `other`.
> +			 */
> +			return 0;
> +		}
> +	}

OK, so we expand the ewah as we go, comparing words, and then quit early
if we can. That's the best we can do when comparing to a regular bitmap.
I suspect we could do more clever things for ewah-to-ewah (like saying
"oh, they both have a run of 10,000 zeroes" without expanding), but
that wouldn't be helpful here, as your use case will be comparing
against a bitmap we're building in memory.

I think your use of the phrase "proper subset" is a little confusing
here, as it is not a subset at all, let alone the distinction between a
regular and proper one (in the mathematical definitions).

> +	/*
> +	 * If we got to this point, there may be zero or more words
> +	 * remaining in `self`, with no remaining words left in `other`.
> +	 * If there are any bits set in the remaining word(s) in `self`,
> +	 * then `self` is not a proper subset of `other`.
> +	 */
> +	while (ewah_iterator_next(&word, &it))
> +		if (word)
> +			return 0;

OK, so here we keep expanding to see if there are any bits set, meaning
we may read past a bunch of 0-words that we don't care about. I suspect
this could be optimized to just ask the ewah "are there any bits left?"
but I don't think we have an easy function for that. And it's not clear
to me that it would produce measurable speedups anyway, so probably not
worth worrying about.

As above, ditto on the use of "proper subset" here.

-Peff
