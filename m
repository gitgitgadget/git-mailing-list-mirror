Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C282FC881
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366198; cv=none; b=b/BvQJMJ5UX/NMCJcCYJAnp4gZ2gGU+PI76nCwaAFP9clM57TT6aKfsUj4XSM0Ny4UX7TvYTAv+EtPeo6ltu0Nnfb9X5nyf2XJKYifpxyJkPyd1qzRXm0ZOfkcorddvnsCkVyWfl0O6WKXSDCCH7xy3lcxAeOV74Fo+rZCzTtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366198; c=relaxed/simple;
	bh=gUcDf7nrSIbSuaovKIYywnqcCOIp89h/Ur9d9C3JPnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulZ6I+/kN6jEcCuocPP2DtZOEX1rNiKDWNk1LZpGht2g8B3RyR3x+VqZpxDhNP/442uE4cpCM0OapncQN01DquvUiBSnUl1Zs2q38JY5UyA5hqlAS1ZWFcOgNwl2z5ndNwZz6H8SHgN3kF2MKmtuS9gRIpgDF+JRchUPy0jv9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C00y/V7W; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C00y/V7W"
Received: (qmail 95386 invoked by uid 106); 13 Mar 2026 01:43:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gUcDf7nrSIbSuaovKIYywnqcCOIp89h/Ur9d9C3JPnI=; b=C00y/V7WXYW8aXKUZcELvFahbJUkxhpSAIVd9BH92iiojzqYy5v9L5VwejpMUuq+EdebVZs6llkWkkEAHj/Pt7rF0hvlAXrUzdT0PrY1mGLiB5uIbotV9amwP9Fqjk5AFqBQ0wh9oEn7LtUmCyxN1sbVN2gjbmp6Q1X5mBjrkTqeqxXpUdj3Jvp9ezzpK8bbZAij9t/j5Qjk6s3Zwz6kcQwskXeWADFrzi/maAxSefw4OJST0U48LOb8K3n+hhkQ5Pwd2Ozx/qQpKgtbSLpyjFmUUwVhLTg+2pODzftRyLzAwfAmpw/Y2TFiPrmH/fJa+vfFm9r/31ho0kf+FjR/0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 01:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 518301 invoked by uid 111); 13 Mar 2026 01:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 21:43:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 21:43:15 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Paul Tarjan <paul@paultarjan.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com, christian.couder@gmail.com,
	hanxin.hx@bytedance.com
Subject: Re: [PATCH v2] promisor-remote: prevent lazy-fetch recursion in
 child fetch
Message-ID: <20260313014315.GA3201544@coredump.intra.peff.net>
References: <abFJhFhHLhS4qdrM@pks.im>
 <20260311141846.12315-1-github@paulisageek.com>
 <abJqySqfdFoY8cEu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abJqySqfdFoY8cEu@pks.im>

On Thu, Mar 12, 2026 at 08:27:05AM +0100, Patrick Steinhardt wrote:

> > > Note that I'm not arguing that we shouldn't have protection on the
> > > client, too. But I'd first like to understand whether there is a bug
> > > lurking somewhere that causes us to send invalid packfiles.
> > 
> > Agreed, there may well be a server-side bug here. Regardless, the
> > client should fail fast rather than consume unbounded resources.
> 
> Probably, yes. What I'm trying to figure out is whether there are edge
> cases here where it's _valid_ for the server to send a thin pack with a
> REF_DELTA. Because if so, unconditionally disabling the lazy fetches
> would break such edge cases.
> 
> I don't think there are such cases, but I wouldn't consider myself an
> expert with partial clones.
> 
> Cc'd Peff, as he's implemented a couple fixes in this area a couple
> years ago.

Hmm, I'm not sure I have much wisdom. Here's the most plausible scenario
I could come up with.

A backfill fetch like this is going to have a noop negotiation
algorithm. So the server does not have any idea what the client has, and
therefore shouldn't be sending any thin deltas against it.

But it _can_ send deltas against objects which are part of the backfill
itself. Normally we'd send those as OFS_DELTA, because they're both in
the same output pack. But there are cases where we might not:

  - if the client did not tell us it understands ofs-deltas; this would
    not be true for any version of Git in the last 15+ years, but maybe
    there is a bug in sending or parsing the capability? Or an alternate
    Git implementation on the client side which forgets to send it?

  - the verbatim pack-reuse code will sometimes rewrite ofs-delta into
    ref-delta. I don't remember all of the cases where this might
    happen. Certainly if the client hasn't claimed to support
    ofs-deltas, but I think maybe some other cases? I'd have to dig into
    it.

Now there's a catch: the pack is not really thin, and so index-pack
should not need to do an extra backfill request in order to get the base
object. But depending how index-pack is written, it might try to do so
anyway. If X is a delta against base Y, but Y is itself a delta, we
might not have resolved it yet. And so when we try to resolve X, we
think "aha, let us see if we have Y", and then eagerly attempt a
backfill fetch (probably triggered from odb_has_object() or similar).
When in fact the right thing to do is to queue X, resolve everything we
can, and see if we ended up with Y (actually index-pack works from the
bases up in the final resolution phase, but the effect is the same).

If that's what is happening, then I _think_ Paul's patch will do the
right thing. We'd say "no, we don't have that object" without doing the
backfill, and then eventually find it as part of the final resolution.

It would be nice to confirm that's what's going on, though (and it isn't
really a thin pack). If the problem can be reproduced, I don't suppose
we have a GIT_TRACE_PACKET output from a failing instance? That would
confirm that we're correctly using the noop negotiation.

-Peff
