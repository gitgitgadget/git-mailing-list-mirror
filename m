Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227061922C4
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635497; cv=none; b=Q+6mLoqbTabeT6yNnihFlAMN4092WgeNb0377xyE9rUFZO66cfqzvPiHT2SkzOYcazjsFY89clhyqchMJ/gdtTOYVBsV+J2QHViN93WRvlrzpQVLzPXwYWealsJc1cJa/YUORe2GNUwKgwMXLbHpDmOlcQApq5EMaSW1/NsHoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635497; c=relaxed/simple;
	bh=WdBwDxhppCIvNEGVyoCJXn2SvE2S+rXRgkE+A4fJMOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ditBxpjiuSbhwb59bVECeWX9pxAnQPuMDfJ9p3u+GlRN/qvAqyCnowARRHAZex1XcsMSxug+oPIfYCVGxFVvOkeO44B2AJ/UEv+bzu3IOWY5wnGnn6vTSjCCNfF3VIT5s/s8GYFhehPgIeMdjqKFrdY2PYNRN4w2BMl9icKkivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DMKG3w5g; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DMKG3w5g"
Received: (qmail 5828 invoked by uid 109); 11 Oct 2024 08:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WdBwDxhppCIvNEGVyoCJXn2SvE2S+rXRgkE+A4fJMOA=; b=DMKG3w5g0jZs7XVOf8iWIvQ+QiTV3Yhbl186mu6Rknuwrl2S30LvEInin0YSFjjPtFaPYewmTwUqUEIn7rZn2VmPJj3cO5yk5E49adDVnvW++fcKLLhMYcZWe7gI858MzJqaG8qwvC8hto7SaNM1dofwOSMrWU/vVQie0V9pSaFDmindwpx2cZp4h5dUeTBosFp+sM/HDNZa9hhnm5yxQEmZp62XRT301TC53tzA6cj1iwFBCchQdiynBgqwKcNghsnjuMqBe5KGJHoPN8IirzcgRf1Jd4ReQzj0i7Rxmq8dkchPtULtRwyW87Yv3/uZGwDZmFJSpKcktE0ldXfPkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:31:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17761 invoked by uid 111); 11 Oct 2024 08:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:31:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:31:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 09/11] pack-bitmap: enable cross-pack delta reuse
Message-ID: <20241011083134.GG18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <ca3a916cd6e93aaa09ccff9f77fc127254222068.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca3a916cd6e93aaa09ccff9f77fc127254222068.1728505840.git.me@ttaylorr.com>

On Wed, Oct 09, 2024 at 04:31:28PM -0400, Taylor Blau wrote:

> In order to do this, the pack-reuse code within pack-bitmap.c marks
> bits in a separate bitmap called 'reuse_as_ref_delta'. Objects whose
> bits are marked in that bitmap must be converted from OFS_DELTAs to
> REF_DELTAs.
> 
> To mark bits in that bitmap, we adjust find_base_bitmap_pos() to
> return the bitmap position of any delta object's base regardless of
> whether or not it came from the same pack. This is done by:
> 
>   1. First converting the base object's into a pack position (via
>      `offset_to_pack_pos()`).
> 
>   2. Then converting from pack position into into lexical order (via
>      `pack_pos_to_index()`).
> 
>   3. Then into an object ID (via `nth_packed_object_id()`).
> 
>   4. Then into a position in the MIDX's lexical order of object IDs
>      (via `bsearch_midx()`).
> 
>   5. And finally into a position in the MIDX's pseudo-pack order (via
>      `midx_pair_to_pack_pos()`).
> 
> If we can find that base object in the MIDX, then we use its position
> in the MIDX's pseudo-pack order to determine whether or not it was
> selected from the same pack. If it is, no adjustment is necessary.
> Otherwise, we mark the delta object's position in the new
> `reuse_as_ref_delta` bitmap, and convert accordingly from within
> `write_reused_pack_one()`.

OK, that makes sense. It does feel like a non-trivial amount of work to
do for each delta we're going to (potentially) reuse from a midx'd pack.
Can we recognize the common case that the base is in the same pack and
also being sent/reused without doing the full conversion to oid and the
resulting bsearch?

> @@ -1182,10 +1188,24 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
>  	if (pos >= end)
>  		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
>  
> -	while (pos < end &&
> -	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
> +	while (pos < end) {
> +		size_t wpos = pos / BITS_IN_EWORD;
> +		eword_t reuse;
> +
> +		reuse = reuse_packfile_bitmap->words[wpos];
> +		if (reuse_as_ref_delta_packfile_bitmap) {
> +			/*
> +			 * Can't reuse verbatim any objects which need
> +			 * to be first rewritten as REF_DELTAs.
> +			 */
> +			reuse &= ~reuse_as_ref_delta_packfile_bitmap->words[wpos];
> +		}
> +
> +		if (reuse != (eword_t)~0)
> +			break;
> +
>  		pos += BITS_IN_EWORD;
> -
> +	}

This is accessing reuse_as_ref_delta_packfile_bitmap->words directly
using pos/end as limits. But those come from reuse_packfile_bitmap. Are
we guaranteed to have zero-extended the reuse_as_ref_delta bitmap as far
as the original went?

Could we just be calling bitmap_get() here, which would do the length
check for us? Though I guess we would miss out on some whole-word magic
it is doing. So maybe we need to just do that length check ourselves.

-Peff
