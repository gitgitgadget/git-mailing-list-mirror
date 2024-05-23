Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589513CF98
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460803; cv=none; b=iTF49lgBH86thshCeZ4yzVUr+htgr/tmaFCE/rpN5oSMIE8/ZGfDpDkWl8yl5QzlWX2ywXvD6AajOeXRLznkpt8wyHUbjpGUC1iZ9n05QIlz1OMX14UBznsPOH4kGMUUObwn0VxGqQ3g0ru1qKFqt59H6KQ3bKZwp5otbkouQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460803; c=relaxed/simple;
	bh=iO/klw/QK7KGvSmerJhpQatOfpz+B+nWM+xUDvJ3USA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNvkRPQtQddwbjRIdowtta4WqCAN8iCEVBt/tu9VSjLmijbaJkAoNoTg9/g1Q4JwPfolA6EudnoRYmGfcW7Uesgh6lzbIuub7pqEr/NsoGjRE6ilGEjDKh8yZkWing9K/5LTQaLQFH8IDX4aZXKKJDE92GOIgr54aH3Z/Ka7mAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31304 invoked by uid 109); 23 May 2024 10:40:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:40:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29201 invoked by uid 111); 23 May 2024 10:40:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:40:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:40:00 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/30] pseudo-merge: implement support for reading
 pseudo-merge commits
Message-ID: <20240523104000.GC1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <8ba0a9c5402fb154bc316768a8fbb016e302a686.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ba0a9c5402fb154bc316768a8fbb016e302a686.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:02:48PM -0400, Taylor Blau wrote:

> These functions are all documented in pseudo-merge.h, but their rough
> descriptions are as follows:
> 
>   - pseudo_merge_bitmap() reads and inflates the objects EWAH bitmap for
>     a given pseudo-merge
> 
>   - use_pseudo_merge() does the same as pseudo_merge_bitmap(), but on
>     the commits EWAH bitmap, not the objects bitmap
> 
>   - apply_pseudo_merges_for_commit() applies all satisfied pseudo-merge
>     commits for a given result set, and cascades any yet-unsatisfied
>     pseudo-merges if any were applied in the previous step
> 
>   - cascade_pseudo_merges() applies all pseudo-merges which are
>     satisfied but have not been previously applied, repeating this
>     process until no more pseudo-merges can be applied

OK, so I think this commit is getting into the meat of how the new
bitmaps will be used. Just to restate it from a high-level to make sure
I understand, I think it is:

  1. When we are traversing (or even before we traverse and just know
     our tips), we can always say "hey, I have a commit in the bitmap;
     does this satisfy any pseudo-merges?". Where "satisfy" is "all of
     the commits pseudo-merged for that bitmap are already in our
     result". And if so, then we can use the pseudo-merge bitmap by
     OR-ing it in.

     And that's apply_pseudo_merges_for_commit().

  2. That "OR" operation may likewise open up new options, so we
     recurse. And that's the "cascade" function.

This commit is not yet adding the calls into this code for part (1). I
think there's an open question there of overhead; i.e., how expensive it
is to check whether each pseudo-merge is satisfied. And whether it makes
sense to just do it once at the beginning of the traversal (with the
provided tips) or to keep checking as we traverse (more expensive, but
it makes it more likely to use an older pseudo-merge bitmap that's had
new history built on top of some of its commits).

But those calls should come later, so let's read on.

> +static int pseudo_merge_ext_at(const struct pseudo_merge_map *pm,
> +			       struct pseudo_merge_commit_ext *ext, size_t at)
> +{
> +	if (at >= pm->map_size)
> +		return error(_("extended pseudo-merge read out-of-bounds "
> +			       "(%"PRIuMAX" >= %"PRIuMAX")"),
> +			     (uintmax_t)at, (uintmax_t)pm->map_size);
> +
> +	ext->nr = get_be32(pm->map + at);
> +	ext->ptr = pm->map + at + sizeof(uint32_t);
> +
> +	return 0;
> +}

I was happy to see the boundary check here. Do we need a length check,
too? We'd need at least four bytes here for the uint32_t. Does map_size
include the trailing hash? If not, then it might provide a bit of slop
(we'd read garbage, but never go outside the mmap).

I guess the ">=" in the size check implies that we have at least one
byte, but I don't think anything promises that we're correctly 4-byte
aligned.

The rest of the length check is here:

> +struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
> +					struct pseudo_merge *merge)
> +{
> +	if (!merge->loaded_commits)
> +		BUG("cannot use unloaded pseudo-merge bitmap");
> +
> +	if (!merge->loaded_bitmap) {
> +		size_t at = merge->bitmap_at;
> +
> +		merge->bitmap = read_bitmap(pm->map, pm->map_size, &at);
> +		merge->loaded_bitmap = 1;
> +	}
> +
> +	return merge->bitmap;
> +}

When we call read_bitmap(), it knows where the end is, and it's
careful to avoid reading past it. Good.

-Peff
