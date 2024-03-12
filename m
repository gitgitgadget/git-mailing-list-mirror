Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5E4AEEB
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281032; cv=none; b=EWtLNkp0VjSJZjdNXXUHz9yma+Q9Wt+jEsTPJ0p8XksiQgjTDK0/m03A4UWQWPe9/vLDOjvxAY7zDFRHajG0JKENHKDWHPQqLZcsww1wLz4Aivw0jEAgYf3CLeyouJJ+EkURdtvT1r9znFDMDEwHx+exTxQWvK4XsBvEM+XSgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281032; c=relaxed/simple;
	bh=z4ycqVcBWWRJWEB6m4iMrfEBqRCJ5OE0VHL7AHVt/MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/AXAPYfu/ns5YOsNEjV6XMrvIYodhPim9hnAKkBvfC18tT9siJqNhDc9hPiKnkLFmc9FT2qYoTqOF1Pbvno+Nerf3qeJmM+bR9r3DONryHx3ZecJNyUt17qnpaRiRlrg317Z85p9v8wMBBRGwwCcpWWNUvs+z/bXncXDfRtKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24111 invoked by uid 109); 12 Mar 2024 22:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 22:03:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1086 invoked by uid 111); 12 Mar 2024 22:03:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 18:03:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 18:03:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) avoid verifying
 submodules' OIDs
Message-ID: <20240312220341.GA106249@coredump.intra.peff.net>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
 <xmqqwmq8o36j.fsf@gitster.g>
 <20240312085901.GA69635@coredump.intra.peff.net>
 <xmqq1q8fl05r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q8fl05r.fsf@gitster.g>

On Tue, Mar 12, 2024 at 12:28:48PM -0700, Junio C Hamano wrote:

> > Or if you wanted to mix-and-match with other cat-file placeholders, you
> > can do:
> >
> >   git ls-tree --format='%(objectname) %(objectmode)' HEAD |
> >   git cat-file --batch-check='%(objectname) %(deltabase) %(rest)'
> >
> > That is a little less efficient (we look up the object twice), but once
> > you are working with hex object ids it is not too bad (cat-file is
> > heavily optimized here). Of course in the long run I think we should
> > move to a future where the formatting code is shared, and you can just
> > ask ls-tree for deltabase if you want to.
> 
> I was imagining more about a use case "cat-file --batch" was
> originally designed for---having a long-running single process
> and ask any and all questions you have about various objects in the
> object database by interacting with it.  So "yes, ls-tree can
> already give us that information", while it is true, shoots at a
> different direction from what I had in mind.

Ah, yeah, that is one thing that cat-file does that no other part of the
system will. I do wonder in the long term if it is easier to teach
cat-file everything that all of the other commands can do, or to teach
all of the other commands some way of handling multiple requests in a
single process. ;)

(All obviously orthogonal to this patch series).

-Peff
