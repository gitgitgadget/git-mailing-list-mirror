Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A414402BA1
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571048; cv=none; b=N7heirgyXo/reALm+KwR1KgO4BWnnaN+SYNvlRjpBZhRVVgwVxIvfdvVll8WG9D9R7XQGjpt3eH5nnMOmmjPRnHBy9fqfR0rLFscFsbVGpnevikDnZiwnFbm90pEow7/1epR+uJB865b4Hx8p7YpL97EVH+xm47XIdP8DXWVE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571048; c=relaxed/simple;
	bh=WNZH0k8wwFwiLjp1ENHVX55+fC5daiujpjynmHRovWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0daXZMMzIQ7LKFCQBmNcViDsDzLWuNtFAaKYrE+yQreGz1KmsvYG+bklA7IXHRZslp3aJr3zUh3zLgr+aqUrd7C/Zq1nvwH1j9ochovdenDWnMBIc1boGKvBUZxbrz8tt5dHmlOuesl+3xSuU2zD2juSleVjflxJ7a90lmIWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zo8dY3c7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zo8dY3c7"
Received: (qmail 44893 invoked by uid 106); 12 Aug 2026 21:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WNZH0k8wwFwiLjp1ENHVX55+fC5daiujpjynmHRovWc=; b=Zo8dY3c7+q/8tROwhagnymSAEKChTWi3oprxpe30jlZhqml1PVfAlljlCTE/AbyDPheSyrAWg2AY4BqGZ6ds/aInV0BPbOnj+/MWE72moxYMlyeC0vLWeKNvdjk842sE/10LDYm105nsivCVYZdmf4iH4Ms/tN25JeAbAEDb0BZOSr1BB4LwZsXEXqnLcMhBIgfXrR7Ho5EPPNGBl/rosuJ6cZnDwvay0NJ4/vvtbpSfKihGtPcz3/yksxJ1JP/A7rFHkFI8z1eVkdEgsIdLAKGOxoZeYfM3uWVZUVDRZTPw8xzSSg9yPuxbs2uTw87QfKODa+N23PClE3ionlHyOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2026 21:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31602 invoked by uid 111); 12 Aug 2026 21:44:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2026 17:44:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Aug 2026 17:44:03 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Can we do better than "git checkout/add -p"
Message-ID: <20260812214403.GD152730@coredump.intra.peff.net>
References: <xmqq8q6ih924.fsf@gitster.g>
 <21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de>

On Wed, Aug 12, 2026 at 10:40:08AM +0200, Johannes Schindelin wrote:

> > My current workaround is not to use "git checkout -p" and instead
> > (e)dit an undesirable hunk into a no-op hunk.  This is serviceable,
> > but with two caveats:
> > 
> >  - The underlying 'apply' machinery does not see a truly no-op,
> >    context-only hunk.  You'd need to pretend removing an existing
> >    line and adding the same line back.
> > 
> >  - (e)dit applies the edited hunk right away without giving the user
> >    a chance to proofread and approve or reedit.
> 
> I, too, often find myself in exactly that kind of need. That's why I was
> *so* disappointed when
> https://lore.kernel.org/git/20260325075055.354709-1-luizedc1@gmail.com/
> was shot down unceremoniously. I still think that would be a good
> addition. I even opened https://github.com/gitgitgadget/git/issues/1828
> and sketched
> https://github.com/git/git/compare/master...dscho:git:add-p-stash-mode to
> the same extent.
> 
> Maybe it is time to revisit that verdict, and see whether there is really
> no way to accept that clearly needed functionality.

Thanks for digging up that link. After reading Junio's message that
started this thread, I _thought_ we had discussed this a dozen times
already, but after searching the archive could only come up with this
thread:

  https://lore.kernel.org/git/20161102223705.qycdo3j2bvndi7ev@sigill.intra.peff.net/

But the one you linked is another example, and nicely links back
recursively to at least two other instances. ;)

I see I am quoted in one of them as "it's a little weird for add -p to
change the working tree", but I want to make clear that I _don't_ oppose
a feature like this. I think it would be super useful. We may find a way
to avoid that "weird" property (e.g., by putting the "combined"
stash/add mode under a different command's "-p"), or we may just accept
it.

-Peff
