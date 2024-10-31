Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571571386C9
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395225; cv=none; b=UlSauKxxBelriChpRIKkXYykWYRUo2Rgn6+zpvtWgXyr38sKRD8l+AcuFDXqE/q7PyEc1b3eLY60U46+IyBKTkrNXM/0DvUYTINdEC0QyRYCp4NBDmy1zTufX+geeKpfg2vphLJC7kiZhTtRtSzNqJ6DQBBfn5ZqmcNqh2qRrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395225; c=relaxed/simple;
	bh=v/QfXzB7u4EqBGV5Qt3+i6uK2S3HruRQLTs/+IniJCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INlKkmMCWgteiLhtnne/Uh+qgy+hWfIXMSz33D1zqp9yLfRn+tmGNaOjpZEOmjX8VZgt/ZauaMSKOPFH4kkMq2C8GpOr2ynUCHej+CARHz7d/O25TlblvD+XFOqb74OTogIQHad8H1oc/gUy7cUiqGezf3lo0p2E3jlQ3UwibNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=haCv2pBe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="haCv2pBe"
Received: (qmail 20271 invoked by uid 109); 31 Oct 2024 17:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v/QfXzB7u4EqBGV5Qt3+i6uK2S3HruRQLTs/+IniJCQ=; b=haCv2pBeUio5DOAfhnb9mJtsgSR8lAqnxJyC4JRClZCMvVOjWQ48l9fXAoGZSqJ6D4e3E1M122vLdoIkeOxMfc7S2gqngYTMiRfiR9JbvS5U8tpZ+tjGVNgpgeUnMM4xW3vMgVn2cbF/xwlvLgriRBQCyqgBlgoAXETG2/TSjvi4makGWIfraUtbTHgsjbY3U5FEWt6iPVDDGO8WcPtD3AV+SbMyYwPIF8eFYki1oR1dkjzbM4aRhVR0Fr+WSf/jgdEoTVI9XiBYVd3mzGD1BHia9mdEUShKUnBC6cmBkKIS434FI4Bhfjoc3ESwGhchx47ZJt/W6zSb+dc+AwlKdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 17:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3862 invoked by uid 111); 31 Oct 2024 17:20:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 13:20:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 13:20:21 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, git@vger.kernel.org,
	rohitner1@gmail.com
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031172021.GB2277590@coredump.intra.peff.net>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
 <469d82f8-4883-4c87-b681-288a0520e745@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <469d82f8-4883-4c87-b681-288a0520e745@app.fastmail.com>

On Thu, Oct 31, 2024 at 05:14:01PM +0100, Kristoffer Haugsbakk wrote:

> On Thu, Oct 31, 2024, at 12:47, Jeff King wrote:
> >   git commit-graph write --reachable
> >
> > That reduces the slow case for me by a factor of 10. And likewise other
> > traversal operations should get faster.
> >
> > I think we'll build the commit graph file by default these days when you
> > run "git gc". But we don't build it immediately after cloning. Perhaps
> > we should change that.
> >
> > -Peff
> 
> There was this thread from last year where Rohit cloned Linux and the
> command took more than twelve seconds.  Then git-commit-graph(1) fixed
> it.
> 
> https://lore.kernel.org/git/CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com/

Yeah, there's discussion in the linked thread there about running "git
gc" after clone. If "gc --auto" was pruned down to run some minimal
bits, that might be OK. What we definitely _don't_ want to do is run
"git repack", because it's very expensive to do the full object graph
walk (and buys nothing on a freshly cloned repo unless you do the even
more expensive "-f").

So the simplest path forward, but which is a little messy, is to just
run "commit-graph write" after the clone. In fact, we already have
fetch.writeCommitGraph (though it does still default to "false"). I'd
expect that to work with clone (since it's conceptually init+fetch), but
it doesn't seem to. Looks like the code to trigger it is directly in
builtin/fetch.c, and clone triggers the fetch itself internally.

But I don't think factoring that out and calling it from both places
would be too hard.

It's a bigger question whether people might be annoyed by some extra
computation at clone time. But I suspect it's OK in practice. Even
ignoring the cost of moving it over the network, my 8-core machine takes
almost 3 minutes to index the linux.git packfile on clone. Building the
commit graph after that takes about 13 seconds.

-Peff
