Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772039FDA
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625776; cv=none; b=levJDtnnHJFqxcDGwTms01xykRhwp+UTcu9gujFbKoaHBGQFZgsmTOm0ZWex+qnfToXtLUUbCiW26AVl+816EhnXAn5Eor56tc7HDdLHHPToHGUgdEMCN10KzceHING+MEMCBrniIm+DGE7rhB5/GAWO7lGhc3z1ivT27i/OF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625776; c=relaxed/simple;
	bh=tSymiP/I0cZwo+i1RieuCi9VXYq0gpifyGqX0qjN5Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbKed7FKz02F/rHZovmRaNQwVB/0/e+iAlvdImp7pBbdVpUSFIFxFj9zwm8SbtCm0EngMNQiO7z4ynpjIUSdVsIfRJIR4CZ/1nVu/imBNsSRbg1y9D9e8Dep6myJ8xnZwLzrULwkCmpybkZr0sEhlg6a33Hwjq46Gp4MejdyICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31178 invoked by uid 109); 13 May 2024 18:42:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 May 2024 18:42:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13686 invoked by uid 111); 13 May 2024 18:42:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 May 2024 14:42:48 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 May 2024 14:42:46 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <20240513184246.GA2675586@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>

On Mon, Apr 29, 2024 at 04:43:15PM -0400, Taylor Blau wrote:

> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 9bc41a9e145..fef02cd745a 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -24,7 +24,7 @@ struct bitmapped_commit {
>  	struct ewah_bitmap *write_as;
>  	int flags;
>  	int xor_offset;
> -	uint32_t commit_pos;
> +	unsigned pseudo_merge : 1;
>  };

The addition of the bit flag here makes sense, but dropping commit_pos
caught me by surprise. But...it looks like that flag is simply unused
cruft even before this patch?

It might be worth noting that in the commit message, or better still,
pulling its removal out to a preparatory patch.

> +static inline int bitmap_writer_selected_nr(void)
> +{
> +	return writer.selected_nr - writer.pseudo_merges_nr;
> +}

OK, so now most spots should use this new function instead of looking at
writer.selected_nr directly. But if anybody accidentally uses the old
field directly, it is presumably disastrous. Is it worth renaming it to
make sure we caught all references?

The downside would be that spots which _do_ want the complete
selected_nr would need to be updated to use the new name. It doesn't
look like there are that many, though. OTOH, that means that it's also
easy to inspect them and see that you covered all of the relevant cases
(as far as I can see). I guess the biggest value in changing the field
name would be catching any topics in flight (or long-running forks).

-Peff
