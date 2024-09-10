Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CE1CD2A
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949732; cv=none; b=PARHdMG4pmJf6rsqA4mBBb8w+TFQWWWAofIa5OGj0Z7R3FCwz2mTRETKBM8DabyoUv3v+sCMLSq8NuYz9ev+vc1BgLhh7gVQ3hSK1W/7bw0VomUcKnQn1BN4NmiKzBnLfa+ApK5mQ4Ta3xK+vHMIZuj1dwUyilyP6ijFLhO1H60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949732; c=relaxed/simple;
	bh=17g6dD5PmDSaZBK7lF5dFRUnmC0Rs2slwJfrTPFlonM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaTHkl71HDVbuk3g7T+KlWbq3GY4oxRbCmhFwycJGluPxSGBzapIg+pvKIiRfYTSmrvFV95fzo5oJc5X93kXjtPsaUNXRQgdxKiOcHTvd0eXe7TJMPwtyhoEZSxsL9z/epXompEzqYMndjxoG3fS+Ikpxysiww8Rd/DeCexNILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3222 invoked by uid 109); 10 Sep 2024 06:28:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:28:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29027 invoked by uid 111); 10 Sep 2024 06:28:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:28:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:28:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 3/9] ref-filter: strip signature when parsing tag trailers
Message-ID: <20240910062848.GB1459778@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231445.GC921834@coredump.intra.peff.net>
 <Zt_id3Fm6IXMhODF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt_id3Fm6IXMhODF@pks.im>

On Tue, Sep 10, 2024 at 08:08:55AM +0200, Patrick Steinhardt wrote:

> > diff --git a/ref-filter.c b/ref-filter.c
> > index 0f5513ba7e..e39f505a81 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2008,9 +2008,17 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
> >  			v->s = strbuf_detach(&s, NULL);
> >  		} else if (atom->u.contents.option == C_TRAILERS) {
> >  			struct strbuf s = STRBUF_INIT;
> > +			const char *msg;
> > +			char *to_free = NULL;
> > +
> > +			if (siglen)
> > +				msg = to_free = xmemdupz(subpos, sigpos - subpos);
> > +			else
> > +				msg = subpos;
> >  
> >  			/* Format the trailer info according to the trailer_opts given */
> > -			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
> > +			format_trailers_from_commit(&atom->u.contents.trailer_opts, msg, &s);
> > +			free(to_free);
> >  
> >  			v->s = strbuf_detach(&s, NULL);
> >  		} else if (atom->u.contents.option == C_BARE)
> 
> I've been surprised that we use `subpos` as the starting point here,
> which includes the whole message including its subject. I would have
> thought that it was sufficient to only pass the message body as input,
> which saves allocating some bytes. At least `trailer_info_get()` does
> not seem to care about the subject at all.
> 
> In any case this would be a micro-optimization anyway, it just left me
> scratching my head for a second or two.

Yeah, I suspect it would be fine to start at "bodypos" instead (and then
you could just use "nonsiglen" directly as the length). But there may be
corner cases for instances where there's no subject/body at all (though
having _just_ trailers feels weird).

At any rate, I was just following the existing code, which passed in the
whole contents starting from subpos, to avoid any unexpected changes.

-Peff
