Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83913DBA4
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768623; cv=none; b=KDRjj2PxTj4V4X/OqfgRn/vjUwOibSXh+6+nE5SwHohR7C8PhyV07RdracBCnKTlHSUjgbjeF0kuPF4p18ArxbcOyA2fHXoju68Z+ScOGKTIRqqgst4X+zugesxYOzSpg/53c1f6gJtaWnqGMQMoMq/7E1ih0ooc/hnzwEe38yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768623; c=relaxed/simple;
	bh=R3n8BXVa37wL0zeYUhUBh/7mhPJ9F8Ud/DPT3ciDD34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ3n4CG9OIyfq9bWr7U0m+rMqqyyXSOo8FUJPff9gv0Wz2F4Yj24QMtIK+qtDmznnojwd0E8FS9mOZ2OnanLCHP+O+O0csF1iLRF1yynNIeRcksp5ftGKUx+v0XxiF0TQFxnWNrmc3sABImKd9/8m26Q3+tWPHP5/fXx5/qGueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23352 invoked by uid 109); 23 Jul 2024 21:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jul 2024 21:03:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3258 invoked by uid 111); 23 Jul 2024 21:03:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2024 17:03:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jul 2024 17:03:39 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t0613: mark as leak-free
Message-ID: <20240723210339.GD6779@coredump.intra.peff.net>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
 <Zp4gILfskdpc6RUk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zp4gILfskdpc6RUk@tanuki>

On Mon, Jul 22, 2024 at 11:02:24AM +0200, Patrick Steinhardt wrote:

> > I'd noticed it, too, while doing recent leak fixes. But since Patrick
> > has been working on leaks and is the go-to person for reftables, I
> > assumed he had already seen it and there was something clever going on. ;)
> 
> Nah, you assumed too much :) I just forgot to mark this as leak-free and
> the topic crossed with my memory-leak-fix topics, so I didn't yet find
> the time to fix it.

Ah, OK. :) Then I think we did the right thing in your absence.

> It does highlight an issue though: I think memory leak checks should be
> opt-out rather than opt-in by now. Most of our tests run just fine with
> the memory leak checker enabled, and that's also where we want to be
> headed. So making tests opt-out would likely raise more eyebrows when
> new tests are being added that explicitly opt out.
> 
> The only reason I didn't send a patch like this yet is that it would of
> course create quite a bit of churn in our tests. I'm not sure whether
> that churn is really worth it, or whether we should instead just
> continue fixing tests until we can get rid of this marking altogether
> because all of our tests pass.

I could see arguments in both directions. I'd worry that by switching
the default to "assume leak free", it may end up with misalignment
between who introduces the bug and who deals with the fallout.

Right now, if I introduce a test that is leak free but don't mark it,
somebody working on leaks later runs in check mode and says "yay, it
passes. Let's mark it". It becomes their task to do, but it's an
easy-ish task.

If we go the other way, then a new test that _does_ leak means that
either:

  1. The original author notices the CI leaks job failing.

     a. They introduced the leak, and it was caught early. Yay!

     b. The leak is in some random part of Git that their test happened
	to trigger. Now they spend effort proving it was not their fault
	before they annotate the test with "does not pass leak".

  2. The original author does not notice. Somebody notices later when
     doing leak-checking (or I guess just running their own CI, if we
     are hitting these by default). Now they are stuck with doing (1a)
     or (1b) themselves, even though they do not care about the original
     topic.

So I dunno. If we think people are paying attention to CI on their
topics, and we think that we are close enough to leak-free that (1b)
won't come up a lot, it might make sense. I'm not quite sure we're there
yet on the latter, but it's mostly gut feeling (and I know things have
gotten a bit better recently, too).

I guess the only way to know is to try it, but as you noted, it is a bit
of churn to switch between the two states.

-Peff
