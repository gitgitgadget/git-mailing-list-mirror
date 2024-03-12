Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D703236
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229526; cv=none; b=G2g2dPzOcb/dqsUSE5Qi6aG0fPAaiUvuYQJ1e800CPlBWk6VtVsyUIFJyAaI0y0pjJ99aCy/I46LV7b9Qk2ZqNxZSc30tua5wpy4J0IjzENXJEPpE6rMY+9fzPTnDMUrOKA2OgbXtz68sH6WnKpBYnKcK1eBx2/wysPGtEbhO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229526; c=relaxed/simple;
	bh=05f5Gf1pQSokn80bEdQVsWJISc3uLVsNSl17x2E6kHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkSuwN1Ixu8uwlpTs+I9DYbaj+qii+wSO+WuCIsl+vmMfR25pgqOvXm7a+jqG9vUrlngP6rVjMqHIeOmwXoAevk/vJHv7FQ/uLRgsFYav9n6XN1utg00mwi1WUogje0snoO2p0CEege0l+BkRvkK0m+8yXNKZsrA8ueYEOCNwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14218 invoked by uid 109); 12 Mar 2024 07:45:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 07:45:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27409 invoked by uid 111); 12 Mar 2024 07:45:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 03:45:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 03:45:13 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <20240312074513.GA47852@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>

On Thu, Mar 07, 2024 at 10:20:16PM +0000, brian m. carlson wrote:

> > As I discussed in patch 1, remote-curl does handle the "true" thing
> > correctly. And that's really the helper that matters in practice (it's
> > possible some third party helper is looking for the explicit "true", but
> > presumably they'd have reported their confusion to the list). So we
> > could probably just start tacking on the "true" in transport-helper.c
> > and leave that part of the documentation untouched.
> > 
> > I'm less sure of the specific-algorithm thing, just because it seems
> > like remote-curl would never make use of it anyway (preferring instead
> > to match whatever algorithm is used by the http remote). But maybe there
> > are pending interoperability plans that depend on this?
> 
> It was designed to allow indicating that we know how to support both
> SHA-1 and SHA-256 and we want one or the other (so we don't need to do
> an expensive conversion).  However, if it's not implemented, I agree we
> should document what's implemented, and then extend it when interop
> comes.

I guess my reservation is that when it _does_ come time to extend, we'll
have to introduce a new capability. The capability "object-format" has a
documented meaning now, and what we send is currently a subset of that
(sort of[1]). If we later start sending an explicit algorithm, then in
theory they're supposed to handle that, too, if they implemented against
the docs.

Whereas if we roll back the explicit-algorithm part of the docs, now we
can't assume any helper claiming "object-format" will understand it. And
we'll need them to say "object-format-extended" or something. That's
both more work, and delays adoption for helpers which implemented what
the current docs say.

So I guess my question was more of: are we thinking this explicit
algorithm thing is coming very soon? If so, it might be worth keeping it
in the docs. But if not, and it's just a hypothetical future, it may be
better to clean things up now. And I ask you as the person who mostly
juggles possible future algorithm plans in his head. ;) Of course if the
answer is some combination of "I don't really remember what the plan
was" and "I don't have time to work on it anytime soon" that's OK, too.

-Peff

[1] In the above I'm really just talking about the explicit-algorithm
    part. The "sort of" is that we claim to send "object-format true"
    but actually just send "object-format". There I'm more inclined to
    just align the docs with practice, as the two are equivalent.
