Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D12AF17
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723891424; cv=none; b=kM11xGUtgTg+xQsaiGFiIH52sk4hyZA8xS0COXxfVqhhhNDn7T8FYPGiHhba1jCcDNZXctJZwlXMIwYbVpCrABPp0Zb7TXPgoIUn306S/0ZWsJ3k/d5NwytNrZLYvUBisn5gcZvXorrqilyCTX85sPHoqphG9BbK1a2F8sz5ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723891424; c=relaxed/simple;
	bh=y+J9vFQyMPZc+/fe6rdSkO0IY4EDOUAQrV1ns/D2GSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP4bOKN4qG9h8R06o9VGhgPsYKirshIgLnP3bmJ5Yy14OUr7pzRYHznriGWC5BygfVTyWFsXrbCRIYejkFR5Qbqm+fALFxeXjinNPRL+cooGFDE9ev41FXMHKUzF4s/a/Cb7ACQx11x3M3rOmNsuryhXxpsJ8mV3nZUSTvHvrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25949 invoked by uid 109); 17 Aug 2024 10:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 10:43:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29101 invoked by uid 111); 17 Aug 2024 10:43:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 06:43:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 06:43:41 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] pseudo-merge.c: ensure pseudo-merge groups are closed
Message-ID: <20240817104341.GD551779@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
 <c9a64b1d2a9d6b3fe1f5fb0a7303e043114fcd8f.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9a64b1d2a9d6b3fe1f5fb0a7303e043114fcd8f.1723743050.git.me@ttaylorr.com>

On Thu, Aug 15, 2024 at 01:31:20PM -0400, Taylor Blau wrote:

> Rectify this by ensuring that the commits which are pseudo-merge
> candidates can only be so if they appear somewhere in the packing order.
> 
> This is sufficient, since we know that the original packing order is
> closed under reachability, so if a commit appears in that list as a
> potential pseudo-merge candidate, we know that everything reachable from
> it also appears in the list (and thus the candidate is a good one).

Right, good explanation.

> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 6422be979c..7ec9d4c51c 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -217,6 +217,8 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  	c = lookup_commit(the_repository, oid);
>  	if (!c)
>  		return 0;
> +	if (!packlist_find(writer->to_pack, oid))
> +		return 0;
>  
>  	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, oid);
>  

And the patch looks good. I wondered about checking the packlist before
calling lookup_commit(), but the latter is really not very expensive (it
is not reading the object, but just creating a struct).

> +test_expect_success 'pseudo-merge closure' '
> +	git init pseudo-merge-closure &&
> +	(
> +		cd pseudo-merge-closure &&
> +
> +		test_commit A &&
> +		git repack -d &&
> +
> +		test_commit B &&
> +
> +		# Note that the contents of A is packed, but B is not. A
> +		# (and the objects reachable from it) are thus visible
> +		# to the MIDX, but the same is not true for B and its
> +		# objects.
> +		#
> +		# Ensure that we do not attempt to create a pseudo-merge
> +		# for B, depsite it matching the below pseudo-merge
> +		# group pattern, as doing so would result in a failure
> +		# to write a non-closed bitmap.
> +		git config bitmapPseudoMerge.test.pattern refs/ &&
> +		git config bitmapPseudoMerge.test.threshold now &&
> +
> +		git multi-pack-index write --bitmap &&

OK, clever. In the real world, I think this would happen racily, because
you'd usually suck up all of the loose objects into a pack to feed into
the midx. And the problem is new objects (whether packed or not) that
are referenced after that step.

But here we just skip that step and generate the midx directly, which
lets us do it deterministically.

-Peff
