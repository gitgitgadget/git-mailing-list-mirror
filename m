Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6C14372E
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767798; cv=none; b=idlUi2O7ARUTziocZYDTOxHheKJzpdvPm8JmItatjYNhK+Ex5vN07v3vx7MVfKtzHXB2usr4OjaLHvQak0z0rwBV7KuqArsy4vPNVf9EaEG28D5b44b8Hw2Rr5B4FSzBHIuQloE2y7tG9lSTVHSj/pj43kGHJcwdH5IQOTn7Ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767798; c=relaxed/simple;
	bh=rZxJ3L9MaVVQxMTlEmkLH+4D0d4q6RW/4Y6zh2pwiBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP+q+2y4h9EwAT47b8XxePFzvuYUrjlxgY80c2+oTo9r6+9nE6sb73S5rQb9ROr845AKb7IcTb6KyRfR/f+d/7kHD5EcrlI9UPexUIIlHLA5qyPL47Ixa6QisxpGvtiOMrlIXaYQDtmsoVUqJGWFyorIT3wIMc0oUjk3WJo6mKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23278 invoked by uid 109); 23 Jul 2024 20:49:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jul 2024 20:49:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3151 invoked by uid 111); 23 Jul 2024 20:49:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2024 16:49:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jul 2024 16:49:53 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.46.0-rc0 test failures on cygwin
Message-ID: <20240723204953.GA6779@coredump.intra.peff.net>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
 <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
 <20240718005723.GA675057@coredump.intra.peff.net>
 <Zp-GQ0MQmuIyAear@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zp-GQ0MQmuIyAear@tanuki>

On Tue, Jul 23, 2024 at 12:30:27PM +0200, Patrick Steinhardt wrote:

> > So my biggest question is just whether there is any downside to doing
> > the release/init pair rather than trying to reuse the existing struct.
> 
> There shouldn't be any downside, but it is wasted effort. The main ref
> store should always be accessed via `get_main_ref_store()`, and that
> function knows to lazily initialize the refdb as required. So instead, I
> think the preferable fix is to release the new ref store after we have
> populated it and set the main ref store of the repository to `NULL`
> instead of re-initializing it.

Ah, that is even better. I'm not too worried about wasted effort (this
is a one-time thing during the ref backend migration), but I think we
are better off leaving as much to the "regular" ref code as possible.

> So the following should be sufficient:
> [...]

Yeah, that looks nice.

> > I do think it probably causes a small memory leak. The "init" function
> > allocates the actual ref_store struct, but the "release" function
> > doesn't seem to free it. So we are probably leaking the store that
> > points to the temp directory. But that is also true of "old_refs", or of
> > "new_refs" if we hit an error. So I think the solution is probably for
> > init/release to be symmetric, and for the latter to clean up everything.
> > But again, I'd prefer to get input from Patrick there.
> 
> Yeah, we'd have to free the new ref store struct, as well. I wouldn't
> make `release()` free the structure as that would be uncustomarily
> named.

We usually don't free in the release() function because it was not
allocated on the init() side in the first place. The real sin here is
that the init/release pair is not symmetric, regardless of what they are
named.

In the patch above you worked around it by just doing a manual free() of
the struct. That's crossing the abstraction barrier a little bit, but I
think is OK in this instance. We don't generally expect a ref stores to
be created and released a lot. If this were a general purpose data
structure like a strbuf that gets used everywhere, I'd be more
concerned.

-Peff
