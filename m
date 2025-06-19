Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865A634
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304279; cv=none; b=VUekjcXddvJcMGTito+eTTlkS4XeZU6QqsQfwqXqnbweGZY+dbZ4HRk2eOvMvnP1ww51lQ5hDh8jlEZglAUe4OU5nQZ9vENwlCm8H+rpRaNlRIsrzjXMSVjfVWLmQCGT0WtwMeKxvs/6mNTCBNNUnp2JnjEE0rrVsPPZRin+MYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304279; c=relaxed/simple;
	bh=KftJ4z3GPEvAHi2zb6LzpV6jKhfeQ2F/DZG21XLboYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7+i+RXS1NWPJLp7oVpfzjyqqX1bdyBEC4W8G7Io3xo9mszML7vPAYQdGda1cNs85uWDQKQdJQGYb5tSEQC1blYRlc7UqDIymk+G0gZcaCkn2D3WTqgmltQX/HKcn7AXFHrdxdyEiPT4oWCwvqB1kTvUUlCkL8rUVB3kU+WexAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hQ1/4/Vy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hQ1/4/Vy"
Received: (qmail 18936 invoked by uid 109); 19 Jun 2025 03:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KftJ4z3GPEvAHi2zb6LzpV6jKhfeQ2F/DZG21XLboYE=; b=hQ1/4/VyS0JO229UpVLW0ZBV3Ppdy/v6+NA1SgWxcptQmhdViDLEyYxx+bCVhS38iJGrGJIzGkiDWwXxhcJNLR8VwQtwEd+MDKQuOtwu6OiS3EQEAqHZZIHPRrvvgiPrYw5tmklX1IksmtjWkoXFioGqRx92RsuZI76RHU4Xj3Aj98aTF3HkoEnm5xIhNMI4ByCjQdtv1dyMq3hAohVezBUtRWvUUdd/u7torgFafJGPpD3LfjyaOZT9/fxMeTIuWITeNYZBb0XCPi7cmwiWYAAA59jJmv7BgxPeI8faDyt+kXKPGIjsdsnBZlq2fHysEcLnY6yGP1kn2Gig7OXx0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jun 2025 03:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9966 invoked by uid 111); 19 Jun 2025 03:37:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jun 2025 23:37:50 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Jun 2025 23:37:46 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] fetch --prune performance problem
Message-ID: <20250619033746.GA1801319@coredump.intra.peff.net>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <9cc42f04-856b-4967-8668-a47271af061c@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cc42f04-856b-4967-8668-a47271af061c@intel.com>

On Wed, Jun 18, 2025 at 04:15:03PM -0700, Jacob Keller wrote:

> On 6/18/2025 2:08 PM, Phil Hord wrote:
> > My patch fixes this for fetch, but it affects the command's output order.
> > Currently the results look like this:
> > 
> >      - [deleted]     (none) -> origin/bar
> >        (origin/bar has become dangling)
> >      - [deleted]     (none) -> origin/baz
> >      - [deleted]     (none) -> origin/foo
> >        (origin/foo has become dangling)
> >      - [deleted]     (none) -> origin/frotz
> > 
> > After my change, the order will change so the danglers are reported at the end.
> > 
> >      - [deleted]     (none) -> origin/bar
> >      - [deleted]     (none) -> origin/baz
> >      - [deleted]     (none) -> origin/foo
> >      - [deleted]     (none) -> origin/frotz
> >        (origin/bar has become dangling)
> >        (origin/foo has become dangling)
> 
> Personally, I like the later output. I have no idea why anyone would be
> specifically scripting something that depends on the ordering being such
> that dangling messages are printed immediately.

I think the original ordering tells you which deletion caused the ref to
become dangling. Phil's example is a little confusing here:

    - [deleted]     (none) -> origin/bar
      (origin/bar has become dangling)

because the name is the same in both cases. A more likely output is that
origin/HEAD becomes dangling (since it's the only symref Git ever
automatically points at a tracking ref). E.g., in this:

  git init repo
  cd repo
  
  git commit --allow-empty -m foo
  git branch some
  git branch other
  git branch branches
  
  git clone . child
  cur=$(git symbolic-ref --short HEAD)
  git checkout some
  git branch -d other branches $cur
  
  cd child
  git fetch --prune

The final fetch output looks like:

   - [deleted]         (none)     -> origin/branches
   - [deleted]         (none)     -> origin/main
     (refs/remotes/origin/HEAD has become dangling)
   - [deleted]         (none)     -> origin/other

and we can see that the deletion of "main" is what caused the dangling.

That said, I'm not sure I care that much. I didn't even know we had this
dangling message, and it's been around for over 15 years!

If we did want to preserve the ordering, it could be done by taking two
passes (the first to create a reverse map of deletions to danglers, and
then the second to print each ref).

Alternatively, the dangling message could just mention where it the
now-dangling symref points at, something like:

   - [deleted]         (none)     -> origin/branches
   - [deleted]         (none)     -> origin/main
   - [deleted]         (none)     -> origin/other
     (refs/remotes/origin/HEAD points to the now-deleted origin/main)

I dunno. I guess anybody who really cares can run "git symbolic-ref
origin/HEAD" themselves to get that information.

-Peff
