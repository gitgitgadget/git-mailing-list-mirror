Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE327081F
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261250; cv=none; b=GywcC3ddbyZi2G80d7qbGNT40ryuLxLqlmRoh4zclJw0dDNUpQbqou6TjRjAv1Yq+UWl0gNE2nG6pZBqVsT+AAba7PIH3wXPyj1Say8pjWrtsJs0rEc/SbEMytXLB4/QHnyDT8LSUJ0JjID4HASar1iZCAgC+p5ienlH9zoLSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261250; c=relaxed/simple;
	bh=dvhfEYXMv5mLMxMcZFyKBC8pWzbyv58mOC4mQBHwWZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6RbruB7axkCz1tFK8KeEhqKg1RcTIjEYSRU83prHiCc85NPq2Jrw3rDnvnY92K5emUf/X6q1xP3bT+KrJhTaGSW1N3NDdYglntCISWG2wngJa29IjZa8a4+QFt5DAW1CUcq3ZsHQBZvRzN+Eshy+HQdRCEWaqhXQPwMrA1NjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XK06xTjB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XK06xTjB"
Received: (qmail 26352 invoked by uid 109); 18 Mar 2025 01:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dvhfEYXMv5mLMxMcZFyKBC8pWzbyv58mOC4mQBHwWZo=; b=XK06xTjB0DvVx+nBzRFZ9ADRCr9Pmaq4MjMXoC0rBQ1tmuHoC7iQjK98M2EmI3wcNS6lb9U8Irdk5aglhTh/0XziQDCJCJeIKAsiwRbQ+j0AeMgWWKccWwEsj8Em0uKisUwY0Ebl6S3cRnUCiU3BMgVFpNl4GHUilYcl79XuZ65CMCiXcXpGEQfElerCyJXcaQ9kSFZiy5Dfa6cKgCvN6jtfj18LKPeNUyaw9RyhBO+pTgYwKUKKE97OqTNb57I5OHuRY+Z3eQ35QDAhscWvDGfIF9ayFNtGwpmiaR1Y0EizUKtRbfgjx5hDzc0tKM5wfmxMSCDWOLADwy5UeTosOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 01:27:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3165 invoked by uid 111); 18 Mar 2025 01:27:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 21:27:27 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 21:27:26 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <20250318012726.GB1471939@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:24PM -0400, Taylor Blau wrote:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6406953d32..c26d85b5db 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>  	return read_bitmap(index->map, index->map_size, &index->map_pos);
>  }
>  
> +static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
> +{
> +	if (index->midx) {
> +		struct multi_pack_index *m = index->midx;
> +		return m->num_objects + m->num_objects_in_base;
> +	}
> +	return index->pack->num_objects;
> +}

I understand why we need to account for the objects in the base to
offset our total size.

Similar to Patrick's comments on v3, I wondered about why we couldn't
just modify bitmap_num_objects() here, and why some callers would be
left with the other.

I guess sometimes we still need to consider a single layer. We can't
quite just access m->num_objects there, because we still need the midx
vs pack abstraction layer. I just thought there'd be more discussion
here, but it looks the same as v3.

I wonder if it is worth renaming bitmap_num_objects() to indicate that
it is a single layer (and make sure other callers are examined). I
dunno.

I also suspect from previous forays into bitmap indexing that it will be
easy to mix up positions in various units (local to the layer vs in the
global pseudo-pack ordering, for example). In theory we could use types
to help us with this, but they're kind of weak in C (unless we wrap all
of the ints in structs). Maybe not worth it.

-Peff
