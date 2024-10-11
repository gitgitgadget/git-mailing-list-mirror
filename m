Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC96EBE
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634579; cv=none; b=ZSNEHmQUMG5qTkylplfpNOygFr1wY5aLXrAYbaTezfU6460799wbUvkjhIG9Ik6/xhUkMzWbQ0pyEeqmCljCNROmKybHINg/red3NhFO+IwBF2jnv+tKBPs1wzUzs/ox4nAlaXW1iguJhZWeyqAiS0j+ENS6FdMru6e440I3U/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634579; c=relaxed/simple;
	bh=RVBYgtcO38r2I7tAbvqEbdFaiYiEDqecV8JAU3xBWGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3yusEYRAbGhEFpVw9fAIhG9uRD5UXkLYO5uii00qYqJnHsZ5JBoQPl2CjYQ66GOpfpyiD/HUe4MQPNtjn45hI7dEBFdnLsvGakuguQu+TmZxg0x0ZjGx7PcTpMVj8WevmRXFN/0fU8IyMKcx2sqBDAhze/eXAk/ZonDEtLXiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YskA7eQB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YskA7eQB"
Received: (qmail 5601 invoked by uid 109); 11 Oct 2024 08:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RVBYgtcO38r2I7tAbvqEbdFaiYiEDqecV8JAU3xBWGM=; b=YskA7eQBZQqZJrqBWSvp2Rgafae2qI7y96O6n+ougirqYcpD06zfvDEVjLfhX4mbNbkSRZZ3twwFkaYdgesnvAIAOKOM7/uEALKkEezYx0bOIniZtYYbnVs/miYWgcxfeGZSCfApKUiextmg204o+rJkNSUShJiy3NVIs2m4XGWKZ78rRmNiZQP4ckIXXOLCyMEyPLzkh9fQSOw+ckM3GuZexQiRoWta5p9frDmo4H+CriGcn5SRqWehFiEy1PFL3r26lZnWFJSYRZbNWTCMCDQIe8dfA2RF36FzQIythMzfnQDCFt6EM12lVGfyWTbxKi0ctv1Iug+ZT5THWH4c0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:16:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17633 invoked by uid 111); 11 Oct 2024 08:16:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:16:15 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:16:15 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 07/11] write_reused_pack_one(): translate bit positions
 directly
Message-ID: <20241011081615.GE18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <94e5c96f6859479e0206d6d775eacf54b3639ee5.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e5c96f6859479e0206d6d775eacf54b3639ee5.1728505840.git.me@ttaylorr.com>

On Wed, Oct 09, 2024 at 04:31:21PM -0400, Taylor Blau wrote:

> +static uint32_t bitmap_to_pack_pos(struct packed_git *reuse_packfile,
> +				   size_t pos)
> +{
> +	if (bitmap_is_midx(bitmap_git)) {
> +		/*
> +		 * When doing multi-pack reuse on a
> +		 * non-preferred pack, translate bit positions
> +		 * from the MIDX pseudo-pack order back to their
> +		 * pack-relative positions before attempting
> +		 * reuse.
> +		 */
> +		struct multi_pack_index *m = bitmap_midx(bitmap_git);
> +		uint32_t midx_pos, pack_pos;
> +		off_t pack_ofs;
> +
> +		if (!m)
> +			BUG("non-zero bitmap position without MIDX");

The text of this BUG() seems weird: we haven't asserted a non-zero
bitmap position. We're really only checking that bitmap_is_midx() and
bitmap_midx() agree that there is a midx. I was going to suggest that
the former could be implemented with a NULL-check on the latter, but
really, that is already how it works (except that it accesses
bitmap_index->midx directly).

So yes, it truly would be a surprising BUG() to see them disagree. :)

I do not mind keeping the BUG() there if you want to be extra careful,
but I just found the message text confusing.

Ah...hmm. This is all being copied from the earlier function. So I think
the culprit may be patch 6, which swaps:

  if (reuse_packfile->bitmap_pos)

for:

  if (bitmap_is_midx(bitmap_git))

which is what makes the BUG() text confusing. But then, what about this:

> +	} else {
> +		/*
> +		 * Can use bit positions directly, even for MIDX
> +		 * bitmaps. See comment in try_partial_reuse()
> +		 * for why.
> +		 */
> +		return pos;
> +	}
> +}

This "even for MIDX" is not really accurate, as we know this else block
is for the non-midx case. Are we losing the optimization that the first
pack in the midx can be treated the same as the single-pack case (we
know that its pack positions and the start of the midx bit positions are
identical, which is what the comment it mentions explains)?

-Peff
