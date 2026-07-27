Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B953EEAD2
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145162; cv=none; b=YvJ9Mg+8X40n2cK9g1mNGbwnK5oqIQf3U1nuFnIZ5Z3T0bsskfLRktLjiynvkpDxjc4lGTK/j1KUjs5k342NWhowoCkjBJIIwNKq47+I7k7ltuzRSHYrN+50gaPCtXqoiDE1BNPvl46GeBUnFGKl4LEJNXtq+47aS0mfQlKWjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145162; c=relaxed/simple;
	bh=6PKF9G58Zl0lNkO6sGkGKRmi/3HnqptHtXFShi91UXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZOnpXMqsCBrz+7ZuLFELGP2TxEkFK9q/YVqupQ4/dhr3h2Fm1lQcZJiD4XK80IP3hOT5KKssFleXOGHJTtTc+avCxx19GbWZCfdYk6QzaT6tIY9qvNf01ij89HR6c8bi6d3lClS8serz7E/a1sZk0A8vKAWErJ3R9txV/areS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wnr3tCMZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wnr3tCMZ"
Received: (qmail 68943 invoked by uid 106); 27 Jul 2026 09:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6PKF9G58Zl0lNkO6sGkGKRmi/3HnqptHtXFShi91UXU=; b=Wnr3tCMZM8hzlgpdkxwChWv995v67VK1ScDsLGd5G7IV6mIcIoLIcL1LCuXOEtHmhPUQay07bgmKrUV+Y6K5NFTJqoUzfmyQMThLlkyskALNqlFU2joU2mBzCM2kbBACsxoVD6+fhJvmwIBDDfWbb4oBz1yIR2fRg2V/78/Bz+yBtkSLO57wyONidQF/Nw5SVwecugz+Gb08n0dsT8f6WFUZgocCRNYE8FCET/DjHJri3BK4F8rViiZloecY0dv4cVLH6OIrMCS7t0N7E9ln9cnL5WvZkGGkcXj3bIMa05VV3PNgKz2CNxEFLEJEDoABBCm3Ylwq/AQI7uT/E1DCCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2026 09:39:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77528 invoked by uid 111); 27 Jul 2026 09:39:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2026 05:39:17 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Jul 2026 05:39:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-lib: skip paths outside prefix in oneway_diff()
Message-ID: <20260727093912.GA591426@coredump.intra.peff.net>
References: <20260726084550.GC2366012@coredump.intra.peff.net>
 <20260726084705.GB3529698@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726084705.GB3529698@coredump.intra.peff.net>

On Sun, Jul 26, 2026 at 04:47:05AM -0400, Jeff King wrote:

> diff --git a/diff-lib.c b/diff-lib.c
> index 95f920a9a0..9986f5b141 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -528,6 +528,11 @@ static int oneway_diff(const struct cache_entry * const *src,
>  	if (tree == o->df_conflict_entry)
>  		tree = NULL;
>  
> +	if (revs->diffopt.prefix &&
> +	    strncmp((idx ? idx : tree)->name, revs->diffopt.prefix,
> +		    revs->diffopt.prefix_length))
> +		return 0;
> +

BTW, Coverity complains here that "tree" could be NULL (because we set
it that way in the lines above due to a D/F conflict).

I _think_ it is fine. We only look at "tree" if idx is NULL, and I think
idx is only NULL when we have a deletion. So that implies either:

  1. unpack_trees() passed us both entries as NULL, which doesn't make
     sense. There was no entry to delete!

  2. We set tree to NULL due to a D/F conflict. But a conflict with
     what? There is nothing at the path in the index to conflict.

So AFAICT this is OK and it's just a false positive from Coverity
(though an understandable one; the semantics of the relationship between
"idx" and "tree" are not represented in the code).

Possibly adding:

  if (!idx && !tree)
	BUG("oneway diff with no endpoints");

would help static analysis, but I don't know if that makes things more
or less clear to a human.

-Peff
