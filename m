Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CB2AF17
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890844; cv=none; b=Fbzw8o9Me7UyMcDmV+kXhGPElpS/nv74f/+Mzh1Vkhknmek1umybUY1DLzaRGB5k2ttsVhsMgSGFLDCDyHE1L6RUBU01pO2Tj9qS6DJyM2bUyIwitwMKT5wOt7WNreiUQNOumeBvMJGw+egUJL8hE8mvx/WyQlxWrdMCfv6L3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890844; c=relaxed/simple;
	bh=+ejD+3bQdzQgrhtHP4r19D9Q4OOrhoPqFJ9pYXfOqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL8+Sucd00EJmLGY0nbVC1FTl6ViqPmZLhadfr61ETeLJbHOk2qKG9Sw5tKEDlTUd3jM+BFNlMCdIc87hIxKrofS7+rwqK0X+h8M09GicMo2x9UOOGO4R3gWqTtIPoXr4bMmo2+2gm7UZRM9GKHs3keP/oAL0g+UOO3+29kQE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25902 invoked by uid 109); 17 Aug 2024 10:34:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 10:34:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28817 invoked by uid 111); 17 Aug 2024 10:34:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 06:34:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 06:34:01 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] pack-bitmap-write.c: select pseudo-merges even for
 small bitmaps
Message-ID: <20240817103401.GB551779@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
 <0fea7803d86ca17451af408e1bf93c32690edc44.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fea7803d86ca17451af408e1bf93c32690edc44.1723743050.git.me@ttaylorr.com>

On Thu, Aug 15, 2024 at 01:31:12PM -0400, Taylor Blau wrote:

> Ordinarily, the pack-bitmap machinery will select some subset of
> reachable commits to receive bitmaps. But when there are fewer than 100
> commits indexed in the first place, they will all receive bitmaps as a
> special case.
> 
> When this happens, pseudo-merges are not generated, making it impossible
> to test pseudo-merge corner cases with fewer than 100 commits.
> 
> Select pseudo-merges even for bitmaps with fewer than 100 commits to
> make such testing easier. In practice, this should not make a difference
> to non-testing bitmaps, as they are unlikely to be used when a
> repository has so few commits to begin with.

I think you could argue that if there are fewer than 100 commits in the
history that pseudo-merge bitmaps are overkill, so it does not matter
much either way. But I think being consistent with our behavior (i.e.,
generating them if asked) is important for testing and debugging.

> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 346fb29513..923f793cec 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -694,6 +694,10 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
>  	if (indexed_commits_nr < 100) {
>  		for (i = 0; i < indexed_commits_nr; ++i)
>  			bitmap_writer_push_commit(writer, indexed_commits[i], 0);
> +
> +		select_pseudo_merges(writer, indexed_commits,
> +				     indexed_commits_nr);
> +

I of course just posted a series which drops the latter two arguments
from this function. It's a semantic conflict, not a textual one, so
we'll have to fix it up when the two are merged (but the compiler will
easily notice to remind us).

-Peff
