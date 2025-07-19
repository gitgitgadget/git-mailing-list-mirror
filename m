Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C3F9E8
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908270; cv=none; b=TwDNrQ8YaPNWNyR2m51LMcKxSigYVz33rq7pwX23yG6+XMGiUQgYlNJ6YyMgL5UksQMef1V81mbPEDbzHPxqJ+y2lVkCxgp17NOjH0hP95YgSRbjV7TIDCuDQhd2PSjlamZQoPICX9KRNgFHk1MqrptoB545LAGAzOIoE/IZMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908270; c=relaxed/simple;
	bh=GLF8sy4PEm6r9pxAYD33NLsKwKyYyg26Hzy6et3LbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP0s2xmuyYLxaLuibRghTUxzpgQAJf48K6+KJWJuWBUPqXZS5zb9i8ZFCJXjZHJOooVs50E1iEaEqNWFZ+G6agLIyWOY9IfussMIc0K0D0r5BworpUelXfCBGdg/umI+0PxSIhr4RTzsfrcX6ibNyyAhQr4JtFcwlHmUGFecGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=adhQWpVk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="adhQWpVk"
Received: (qmail 27194 invoked by uid 109); 19 Jul 2025 06:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GLF8sy4PEm6r9pxAYD33NLsKwKyYyg26Hzy6et3LbvY=; b=adhQWpVkcKPKHZsfaEfbM2SFNeMRE+lkn0PtYMerbgMlOSz3t5Q9VdRAXjF7YvV4+7OhLcwNC9kfsu4/Pg6mc1IgcTmVht+mZcRC5XUSVUODrGxgknDSzK/Anr0qYwYssFSK6hvrc8utO+uVIXn/Oe2LxWczLpsSw+KyfN9+jFwchvW4d9Y96JzrfmYdj/IbNeS9BDsCeBg1tvio2Hy/3RAAw/HajFP0Fx+aBS+EgQTArpcTmA0u9e6j2J+jlNm9DCr5IYw44owuamo6NcmPFG4oZc07Rqa/zm4nzHTmIu63IyMLFe6lssTLQNgSDv0GxfV+yISbqwtCfbcHxQoEuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 06:57:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4614 invoked by uid 111); 19 Jul 2025 06:57:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 02:57:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 02:57:32 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250719065732.GE705356@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
 <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
 <20250719065558.GD705356@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250719065558.GD705356@coredump.intra.peff.net>

On Sat, Jul 19, 2025 at 02:55:58AM -0400, Jeff King wrote:

> > That is not a coincidence.  I had a look at that series and tried to
> > reach its goals while keeping rev_info.commits a commit_list.  Why?
> > Mostly being vaguely uncomfortable with prio_queue' memory overhead,
> > lack of type safety and dual use as a stack.  I still used it, but only
> > as local variable, not in the central struct rev_info.
> 
> Hmm, I would have thought prio_queue had less memory overhead. You're
> spending one pointer per entry in a packed array, versus list nodes. But
> it's true that it doesn't shrink as items are removed (though that is
> something we _could_ implement).
> 
> The dual use as a stack actually came in handy for my series, IIRC.
> There are spots which use a commit_list but care about a specific order,
> and my list/prio_queue conversion helpers use that to create a non-heap
> prio_queue that just returns the items in the original order (it's
> actually FIFO, but we can get that by reversing).
> 
> I dunno. That's kind of horrible when I say it out loud, but it did make
> things work. I'm surprised that your attempt ended up with a performance
> hit when mine did not. Mine tried not to be clever, and even leaves in
> place a few spots where we convert between the two representations to
> satisfy various interfaces (with the goal that we'd probably eventually
> switch to prio_queue everywhere).

Oh, re-reading what you wrote again: you left rev_info.commits as a
list, so presumably you were paying more conversion overhead as you
walked (whereas I think in mine the prio_queue becomes the data
structure for the hot path during traversal).

-Peff
