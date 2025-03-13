Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A912F399
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844808; cv=none; b=mXC8oMSHXf3Ncd4WnPrAy5JV/pBz9C+OhgmyPfZVi2uCcGVpAZ03k0wqX4nGVMlyisKfJKrbTzG08gWbb/RRrC2nbQP2KbcM5YpsDvcS7A7IkU1+7IcsMo8mIK/0tgg1To4cUD4EwLyhiHQXMx5WjAbpSMgnEvKXNMAZD9RflDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844808; c=relaxed/simple;
	bh=+hnz5rTkcvCkPQwMXVajixnB6TvF2y+tjTOgps6FwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLe/r8nGCC9HqB60gZf8TfrLfobzs4Gcqc9fnpKmI1i9tHIDTLJMXsDGw2lvMKrPmzV5IPt1PjO/nGbtAiEXP4oNfQmBr1Dj6XWck4kDcRuUYXCXiebbRcNlqhFjg4dq+emrRmo3gaECiEHu2dr2TwBbQyl7DvD7Ad3Ozc63uX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZduOYIH5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZduOYIH5"
Received: (qmail 20988 invoked by uid 109); 13 Mar 2025 05:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+hnz5rTkcvCkPQwMXVajixnB6TvF2y+tjTOgps6FwlI=; b=ZduOYIH5vR1EhjfaMGxPPxLkzQ5ZllbIFy2oq0C/0othhH0A0aD1K2HDsH6+sb+2yxAhL+5+XdGcQcrCxPg74uLedMh/T/baVFh6wBpBcbS82x57+biAhz8GLAG+H1zBlez4MZpzvc6ZkoTIGNlX1jRMvhB9dP3oN2M9+ujX7CVerQhM/093QFWvdHn5jwpDUbi/RDMfQmtuR+DDlaTc2lrmpJP2EhteYXBp/EmmNSdtejHm7m2nPWLUfpq6bEjdvYWmxxlcWjVIwNlG4wbLzm4Qc9ZrMC9pAtiXqag4FyuMG9TxZmhjdnVaIU0eeYkMTc2pYaPU4Q+ytoI9oT1kcA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:46:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11700 invoked by uid 111); 13 Mar 2025 05:46:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:46:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:46:44 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 6/9] fetch: ask server to advertise HEAD for config-less
 fetch
Message-ID: <20250313054644.GF94015@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030847.GF2334191@coredump.intra.peff.net>
 <Z9H//JHtYTGqHI3n@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9H//JHtYTGqHI3n@nand.local>

On Wed, Mar 12, 2025 at 05:43:24PM -0400, Taylor Blau wrote:

> > Note that we'll add "HEAD" to the list of prefixes, and later code for
> > updating "refs/remotes/<remote>/HEAD" may likewise do so. In theory this
> > could cause duplicates in the list, but in practice these can't both
> > trigger. We hit our new case only if there are no refspecs, and the
> > "<remote>/HEAD" feature is enabled only when we are fetching from a
> > remote with configured refspecs. We could be defensive with a flag, but
> > it didn't seem worth it to me (the absolute worse case is a useless
> > redundant ref-prefix line sent to the server).
> 
> Yeah, I think that we already do this in some instances that you and I
> talked about off-list, but I can't remember exactly what I did to
> provoke it. In either case, the server responds correctly, so I don't
> think it's so urgent to deal with ATM.

Yeah, I thought we did, too, but after looking at the code, I doubt it.
I think we were always playing with exact-oid refspecs, so we'd always
hit the "if (rs->nr)" side of that conditional.

In order to hit the case touched by this patch, you can't have refspecs,
but still need to somehow get a true answer out of
uses_remote_tracking().

> > +test_expect_success 'set up parent for prefix tests' '
> > +	git init prefix-parent &&
> > +	git -C prefix-parent commit --allow-empty -m foo &&
> 
> Any reason to use a bona-fide "commit" here instead of "test_commit"?
> 
> Not a big deal either way, of course, I'm just curious.

Nope, I mostly just reach for "git commit" without thinking because
that's what I naturally do while debugging or exploring.

But since you asked...;)

I do find test_commit a bit bloated in general.  It takes several
commands versus one, leaves cruft files in the working tree (that you
need to care about not using again, lest your commit fail with "no
changes"), and by default makes tags that sometimes cause confusion
about fetching, reachability, and so on.

The one thing it does do that git-commit doesn't is increment test_tick.
That sometimes is important (if you care about traversal ordering), but
usually doesn't.

So I dunno. Maybe I am a bad person for not using test_commit by default
and we should have a style suggestion there.

-Peff
