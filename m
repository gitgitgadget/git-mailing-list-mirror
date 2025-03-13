Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D72E3395
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844471; cv=none; b=EgDTrmVzwZT6K8+mPf3NzzxmwjobIUrhlCV8XLl79iSnnREiGvLi8oAUId2R7gfBFG9qRWN+GxTWsNvknFXa3StpPGNzmygstF+xs4aBDggLmuIkEzTfZUCtOmZpTPqT680eXcVOZW91ctqVb1FVD+4IvA4hRRyubeFijqbO8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844471; c=relaxed/simple;
	bh=UtUd8GcYgBP22ZeTUSDdA1A4qTtBYKXM5UDj5XOx3fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju8EU5s4JbE8VmReP/7kd89CYv9qqsQGnpxJsi95gkT5YpG18lnoLb6kd1Tu+mDKOYx/KSQn7EddM1KURUvWzynUzPWwdVfiUOMD5rHfb6L79wLC98pPUCmUByAV/MHLx1wVt9/8H+dCN1xcEFvHrBAm3aBS9+Ao9Kgz1qRzjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fXNylool; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fXNylool"
Received: (qmail 20855 invoked by uid 109); 13 Mar 2025 05:41:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UtUd8GcYgBP22ZeTUSDdA1A4qTtBYKXM5UDj5XOx3fA=; b=fXNyloolkfSersIqzFN9kXabiLeVQtV7E/aT+H5wjXeynnIwthvW2W9ZgwgqxYpTdEEgfq+wo97e4IqIFNtCjMxF6FxWQH7BjElazvYl3GlNrLpVjBEr+EV3umWwZy8bS6Mgcd8Be1OM+EbK11zU9WObWbhT4bx2E/Lii5s2ZWNOuDlmXyyluvKzyql71+nHol+1n6a2g2B6zt/Tbzoqq3ao0xYKINNZhlo0HJk4FDFzDPZi4CPJyzucMM5Raop9LHhBf55kwPh9H9QM47m5XZoELOUYnp09BDYTAhzwxH6xgdJNPPsVIkCHj0LEmm0Cp7DQTDS5iwMcsb+pt7NCoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:41:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11665 invoked by uid 111); 13 Mar 2025 05:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:41:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:41:07 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
Message-ID: <20250313054107.GE94015@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030706.GE2334191@coredump.intra.peff.net>
 <Z9H+vWHFkATWNLxt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9H+vWHFkATWNLxt@nand.local>

On Wed, Mar 12, 2025 at 05:38:05PM -0400, Taylor Blau wrote:

> On Sat, Mar 08, 2025 at 10:07:06PM -0500, Jeff King wrote:
> > The point of refspec_ref_prefixes() is to look over the set of refspecs
> > and set up an appropriate list of "ref-prefix" strings to send to the
> > server.
> 
> While we're cleaning things up, I wonder if it is worth (slightly)
> renaming this function to something more descriptive, like:
> 
>     refspecs_to_ref_prefixes()
> 
> , where we pluralize "refspec" and add "to" to make it clear that we're
> converting from one to the other.

I think a "struct refspec" is plural (despite the name). The singular is
"refspec_item".

And...

> > diff --git a/refspec.c b/refspec.c
> > index 4cb80b5208..c6ad515f04 100644
> > --- a/refspec.c
> > +++ b/refspec.c
> > @@ -246,14 +246,24 @@ void refspec_ref_prefixes(const struct refspec *rs,
> >  		const struct refspec_item *item = &rs->items[i];
> >  		const char *prefix = NULL;
> >
> > -		if (item->exact_sha1 || item->negative)
> > +		if (item->negative)
> >  			continue;
> > -		if (rs->fetch == REFSPEC_FETCH)
> > -			prefix = item->src;
> > -		else if (item->dst)
> > -			prefix = item->dst;
> > -		else if (item->src && !item->exact_sha1)
> > +
> > +		if (rs->fetch == REFSPEC_FETCH) {
> 
> Do you think it'd be worth handling rs->fetch in a switch/case block? At
> least that would allow us to catch unknown values more easily, though it
> seems unlikely we'd ever add any :-).

...this whole thing is badly named. It is called "fetch", but the only
two values are true/false. But for some reason we named them
REFSPEC_FETCH and REFSPEC_PUSH. Surely it should be "type" or
"operation" or something if we were going to use an enum and switch?

I tried to limit the extent of my changes on opinionated matters like
this. I almost dropped the patch entirely, but I did enough
head-scratching to find that latent bug that I didn't want to lose it.

If you want to fix the name and other clarity issues on top, I don't
mind, though. ;)

-Peff
