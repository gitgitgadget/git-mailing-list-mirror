Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250A1F60A
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132659; cv=none; b=GKd449l3GCfzaybifvOQq9KPCsYhY+3c/PhEY4Z4Hl03068SeW85tr/0NWm3+ipyah60WhiV5XFzqCM20gPXU2Gxf/2a3uLZBTlGoqieF63Tg6prbG5rEd8W35kr2YETX/X7yYKmWNUuE0Tiq5LAXZAuRL3fQ4w5o+Oel+hmFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132659; c=relaxed/simple;
	bh=gmeadvseD2zHTXl7ajHjboVZ7NNGZHJB+RL3roWky8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+3lPA+mpehToPnANgJxd4UjFGrOjfsf/9IjHnroi+V25LDXjyL8ooMsSmv1S+LYEjM/uZU/VMr+IdBf7muIL6gBrEtCvCtzE6zVleTiyJbMcukL5jV3RAYmr45fYKkiLlrCodYcC1Hpx9qccNFFeSfWL0+G2JlvHTapIPySEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lx4LvFMS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lx4LvFMS"
Received: (qmail 22923 invoked by uid 109); 17 Oct 2024 02:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gmeadvseD2zHTXl7ajHjboVZ7NNGZHJB+RL3roWky8E=; b=Lx4LvFMSh3vTQAb/nNRiRsmVNGUkI3mK13dbnPwzkAvZXs9E5o4eI10p/5TDIclNAmNr15BIn4sjYMbG/NaHGKdGtqJ2FlnO3q0hnOcAE4/sTmGwkzQQ5BA4Kb0Adbb/KI2DnZ4Kv4SE+dwPgoY/0abTrh1F4OZHybJYOCNV921YgNX+MC4Eny/33suBpi4OgzX7V7YT86esVVPlVqHvOZGSx8A478z7eDwvEtCUzkrxjqbGfUo1GBNbINC9NLQH8cJbKsu0RgKXdhjeGn5vfUS0o21JJnytbSC7KGr01uJ3BcMz+SbTVAGYSh+qqw7K6ceCQ260RuyMcojGmp8HuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Oct 2024 02:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27289 invoked by uid 111); 17 Oct 2024 02:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2024 22:37:36 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Oct 2024 22:37:35 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>,
	Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <20241017023735.GB1858436@coredump.intra.peff.net>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxAttC1dQUllR76m@nand.local>

On Wed, Oct 16, 2024 at 05:18:44PM -0400, Taylor Blau wrote:

> > diff --git a/upload-pack.c b/upload-pack.c
> > index 6d6e0f9f980..cf99b228719 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -53,6 +53,7 @@ enum allow_uor {
> >  	/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
> >  	ALLOW_REACHABLE_SHA1 = 0x02,
> >  	/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
> > +	/* As this flag implies other two flags, be careful when it must be disabled. */
> >  	ALLOW_ANY_SHA1 = 0x07
> >  };
> >
> > @@ -1368,7 +1369,7 @@ static int upload_pack_config(const char *var, const char *value,
> >  		if (git_config_bool(var, value))
> >  			data->allow_uor |= ALLOW_ANY_SHA1;
> >  		else
> > -			data->allow_uor &= ~ALLOW_ANY_SHA1;
> > +			data->allow_uor &= ~(ALLOW_ANY_SHA1 -(ALLOW_TIP_SHA1|ALLOW_REACHABLE_SHA1));
> 
> Subtracting the result of a bitwise-OR feels a little odd to me.
> 
> Since ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1 are defined as 0x1 and
> 0x2, respectively, I think the end result is as you described it, but
> the route to get there feels a little odd to me.
> 
> I think it would probably make more sense to write this as:
> 
>     data->allow_uor &= ~(ALLOW_ANY_SHA1 ^ (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));

I think we have to treat them as a complete unit, as we don't know which
bits were set by independent config lines and which were OR-ed in by
ALLOW_ANY.

So this case:

> Stepping back a moment, I suppose this is handling the case where a user
> writes:
> 
>     [uploadpack]
>         allowTipSHA1InWant = true
>         allowReachableSHA1InWant = true
>         allowAnySHA1InWant = false
> 
> and is surprised when the final "uploadPack.allowAnySHA1InWant" unsets
> the previous two options.

is the one that Piotr is thinking about. But what about:

  [uploadpack]
  allowAnySHA1InWant = true
  allowAnySHA1InWant = false

Right now that pair is a noop, which is what I'd expect. But after the
proposed patch, it quietly enables ALLOW_TIP_SHA1 and
ALLOW_REACHABLE_SHA1.

So I think the code has to stay the same, but we perhaps should document
that "allow any" has the user-visible side effect of enabling/disabling
the other two.

-Peff
