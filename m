Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B65154425
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263278; cv=none; b=cUkfpS4/YovsQabdoFSxJLAFx6xmx9gJ7U0GhojzT5XYWrTwo4wdxOkta0dJkGTE0tIJkN+ANcN5tNOsRU1wj9/c9kh1hhd3nTRHpDJF7gGa2amz8qzNrZSgni/k3u8FBsw2j6mvL36/Ah0ziL+zzZ1b9ja06NaWxbxpQlvB7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263278; c=relaxed/simple;
	bh=IEI5/r60LEm1ewTFClL6xXIy012sdRaVKNemOEG31OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeOWYaM2PDAH7ZMS1eGSHot1dYqAKk2vlz8QbsJXc/dqY4WIcLOW1qg4601Nyz5E2erNdVQKR8saFIsaahlga+GTvG/YvO2h1m9YXTZx2pXWsJRXVa9NW0sYWECPzK7314mnsSSx/OjZKBcpNQP+EZ+klXY00Adc/FaEdvEgdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LzF07+ff; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LzF07+ff"
Received: (qmail 26686 invoked by uid 109); 18 Mar 2025 02:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IEI5/r60LEm1ewTFClL6xXIy012sdRaVKNemOEG31OU=; b=LzF07+ffILvNRaLiq9S0hJ/ssh6TK11wkAzHt/Qv0d5u0Bufxs4WSj7z+NZX6NYPdJC4kLPlKgKkxO1cxLFL10OUoZK6B25mM3IWe3HFWcq6RtqNr1lWjs1ARPd3gFMZ2BxBCu6obOtwscnziZ9/zr2/QxJx/GJvlACgSrWvjnTsjychZkhcLTMcbb+TIQlExFAw731leXOb61K+xPXeItdPiBwJttogerVLK8eCXbX8hP/j/+Rnqi5dbMrGMMxsfdrYbcSZiCiIJXmYr4zfdRzaJUJwXIFfllGcwhgsFgiIR1uM+Jq7rcmQwnT5jY3HAGgBSfQnk9jTNLTDigau4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 02:01:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3783 invoked by uid 111); 18 Mar 2025 02:01:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 22:01:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 22:01:13 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <20250318020113.GA1473033@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:53PM -0400, Taylor Blau wrote:

> @@ -81,6 +81,24 @@ struct bitmap_index {
>  	struct ewah_bitmap *blobs;
>  	struct ewah_bitmap *tags;
>  
> +	/*
> +	 * Type index arrays when this bitmap is associated with an
> +	 * incremental multi-pack index chain.
> +	 *
> +	 * If n is the number of unique layers in the MIDX chain, then
> +	 * commits_all[n-1] is this structs 'commits' field,
> +	 * commits_all[n-2] is the commits field of this bitmap's
> +	 * 'base', and so on.
> +	 *
> +	 * When either associated either with a non-incremental MIDX, or
> +	 * a single packfile, these arrays each contain a single
> +	 * element.
> +	 */
> +	struct ewah_bitmap **commits_all;
> +	struct ewah_bitmap **trees_all;
> +	struct ewah_bitmap **blobs_all;
> +	struct ewah_bitmap **tags_all;

OK, so these are valid only for the top-level of the chain? I guess
there would not be much point in having the lower levels know about
their incremental versions.

> -static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
> +static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
> +{
> +	struct bitmap_index *curr = bitmap_git;
> +	size_t i = bitmap_git->base_nr;
> +
> +	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
> +	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
> +	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
> +	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr + 1);
> +
> +	while (curr) {
> +		bitmap_git->commits_all[i] = curr->commits;
> +		bitmap_git->trees_all[i] = curr->trees;
> +		bitmap_git->blobs_all[i] = curr->blobs;
> +		bitmap_git->tags_all[i] = curr->tags;
> +
> +		curr = curr->base;
> +		if (curr && !i)
> +			BUG("unexpected number of bitmap layers, expected %"PRIu32,
> +			    bitmap_git->base_nr + 1);
> +		i -= 1;
> +	}
> +}

It looks like we always allocate these. For the non-incremental case, I
think you could just do:

  bitmap_git->commits_all = &bitmap_git->commits;

and so forth. But I doubt that micro-optimization really matters, and it
introduces complications when you have to decide whether to free them or
not.

(And if you really cared about micro-optimizing, probably trying to
prevent the extra pointer-chase in the first place would be a more
productive path).

-Peff
