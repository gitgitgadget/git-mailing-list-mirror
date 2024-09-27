Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902223B0
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408828; cv=none; b=Cas5eDSofhL4NCuDQEdH3R5CS9cMiobCVzkSNV7FjpvG6zuONC4CCMUYht7WhZiauYejehO6dyL0Uu/PYfrAbXx1wPRjd3GF1Eiq/o/I0YEhcN554XFc8xYSSBmyhR5IYa+BAEnlhFOKbLeO/L1C9mh6myeDiiLOWBLfU4CR3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408828; c=relaxed/simple;
	bh=aFeQ07/jVY0GZbfbdq3ETFhk5ZZ4BX8aFS7qWOgOmkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spKY2bo6zjy64v7qH1Hk+9neqvhUb5GjFOkxB3N4R8S7XZGfljBHvTmtnfi9U6BUuAH2BwuE/EvLDeI2BZwFkVb58Gn1qMED29EeANxx+CspLcy/srhK85RPI2nF0CeMxSwjBj+2Y3n1/mynuBFZd0H5N4P1/jnCYd9J/s9YudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4828 invoked by uid 109); 27 Sep 2024 03:47:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:47:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8989 invoked by uid 111); 27 Sep 2024 03:47:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:47:05 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:47:04 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/28] send-pack: free cas options before exit
Message-ID: <20240927034704.GB567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215539.GH1143820@coredump.intra.peff.net>
 <ZvVmkXDIyCqpYKZm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmkXDIyCqpYKZm@pks.im>

On Thu, Sep 26, 2024 at 03:50:09PM +0200, Patrick Steinhardt wrote:

> On Tue, Sep 24, 2024 at 05:55:39PM -0400, Jeff King wrote:
> > diff --git a/remote.c b/remote.c
> > index 390a03c264..e291e8ff5c 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2544,7 +2544,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
> >  /*
> >   * Compare-and-swap
> >   */
> > -static void clear_cas_option(struct push_cas_option *cas)
> > +void clear_cas_option(struct push_cas_option *cas)
> >  {
> >  	int i;
> >  
> > diff --git a/remote.h b/remote.h
> > index a58713f20a..ad4513f639 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -409,6 +409,7 @@ struct push_cas_option {
> >  };
> >  
> >  int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
> > +void clear_cas_option(struct push_cas_option *);
> 
> Nit: I was wondering whether we'd also want to fix up this functions
> name to conform to our style guide, which says this should be called
> `push_cas_option_clear()` instead. But I don't mind it much, so please
> feel free to ignore this nit.

I'd prefer to punt on that for now, as the whole suite of "methods" for
this struct would need to be renamed to match that style. If we were
making a too-short name into a public symbol, I'd be worried about
addressing that now, but I think this is purely about style and can
wait.

-Peff
