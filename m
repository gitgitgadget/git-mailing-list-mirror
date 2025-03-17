Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802BA47
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234767; cv=none; b=ICwCR54SmZl+C8OWJzEUkmlz+05/pgWhuTHgqR+VNeU0vz5xJWkNBYr78NK4zWzLPHwPaJ6rVJL+O902kfWKLCRKKN1rQclga+hdhLOsVSdpoWNuiApNr+1o25kWOn4DY4Vs29ERgz+GVzVFOzND2DtXxhSj13LQ9lKydmmPgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234767; c=relaxed/simple;
	bh=ijd+i03w6Udlzn1U24G2nLo7TlOnYnu++nMXw3DZ8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI7mQ1oEYwhRiaFIGZA/M/0BbwMtJggqYlTm1baGluMFyq9bWaCnpwRskyq/CRCB630KqAemQYO1m7jjtsoxOZh23QkhFYjHdDQCTYmNOdmPFha1WXNBa/iTMjclhWlkiUoSsrXKarIEdyYD69Cq+Q5kOzID1KwRtdgsQ16YtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gr8KCv9d; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gr8KCv9d"
Received: (qmail 21533 invoked by uid 109); 17 Mar 2025 18:06:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ijd+i03w6Udlzn1U24G2nLo7TlOnYnu++nMXw3DZ8C8=; b=Gr8KCv9dT9MDc2RKS1Vhov8+VCWOnfS4f/F1dIW1/PrDdp2AZ1F/Sj1UKYazwkc0ar0sw9b6TwY5JcFoGQNSOC8PW6+0pkmsz1HgwoPKhWAxenm3nXgUt2ZGGRxFtWOPmuyyuDrKv0G9zg735r9h2KRIZMm3FiHnbwDVPt5UpOIVJhrxck54qoHNwxqHYw1Zt4YirTAQFP72nZieY3kHfe70/ChPt7+MqVPAcb8H+UCJd7hVtLk+a2i9nYsQWEaRn0XzWxh3CRhbsOsxGhfsUKtbbBiS8DDkSljm9mwMr1VqZ9rq09m0lNP5gbtWsbEV9grl4IomLCIVdSOV00htkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Mar 2025 18:06:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28164 invoked by uid 111); 17 Mar 2025 18:06:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 14:06:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 14:06:04 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 8/9] fetch: avoid ls-refs only to ask for HEAD symref
 update
Message-ID: <20250317180604.GB704553@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309032016.GH2334191@coredump.intra.peff.net>
 <xmqq4izxq63y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4izxq63y.fsf@gitster.g>

On Thu, Mar 13, 2025 at 08:53:53AM -0700, Junio C Hamano wrote:

> > In other words, a fetch like this:
> >
> >   git fetch origin $exact_oid:refs/heads/foo
> >
> > can never update HEAD, because we will never have fetched (nor even see
> > the advertisement for) the ref that HEAD points to.
> 
> Good observation, and I actually think it would be counter-intuitive
> if remote HEAD gets updated by a fetch that does not even update the
> remote-tracking branches.
> 
> My preference is to keep the rule simple.
> 
>     If you fetch using the configured fetch refspec, i.e. "git fetch
>     [<remote>]" without any refspec command line arguments, that is
>     an operation to maintain your remote-tracking branches for that
>     remote up-to-date, hence we also try to flip remote-tracking
>     HEAD (if you told us to) during such a fetch.
> 
> If you are doing a single-object fetch (perhaps as a lazy-fill from
> promisor remote), I do not think I want to see anything else happen
> than that the single-object comes here.

That was my intuition, too, but there's a case in between. Doing:

  git fetch origin main

will update HEAD, too (with the current code). But if and only if it
points to "main"! Is that something we want to keep? It feels like it
could sometimes be useful, but it is awfully hard to explain.

So I could see going in two different directions:

  1. Only do the HEAD update when we are using the configured refspecs.

  2. Do the HEAD update even when we are not fetching its destination,
     but do not otherwise trigger ls-refs to discover it (so basically,
     not on object-only fetches). This kicks in for more cases, but is
     hard to explain.

Both are a user-visible divergence from how the feature behaves now (and
so I did not want to touch that in my series), but if we are all in
agreement, we can fix it on top. I do think option 1 (i.e., what you are
suggesting in your email) is how I would have done it if starting from
scratch. And the current rules are weird enough and the feature is new
enough that I think it is OK to change.

-Peff
