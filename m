Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F315B130
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057186; cv=none; b=I7IKc2nFbAsgynI/A1VZscsuZg4HFS0Y2rDfmVDchXW3sPu8NOT2uG9oPYg/RUgQnwQu6VNIqaZD3OqfwSnZ5eL1K5tD69JYp5qVcZC6UZAt/UlNGJZJzOtXbnLe9esJyrCCsHMj2zezQ+jb8ynyanrKNmoFRk3t6vlM8/dJUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057186; c=relaxed/simple;
	bh=Vm6G5lnYLlrYWxJjreKzsAgYjgdzxQ+skm34pgbawGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGvfUflIhQmFqz7ssOEG5A791kYUYiM6HvpbpAHQtSa4yaGHjmaVv4Gt4HJktEUlzXh1f0X5kQv54CYNt6ShgQFvrBitks/F4I/pxhb10l8ruy+Blj5CpTPAiw1dWwfeg4V5kvOOXnR8qmPmQkr/JFuMUUB+4xXGAssNkYtV8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8701 invoked by uid 109); 19 Aug 2024 08:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 08:46:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17485 invoked by uid 111); 19 Aug 2024 08:46:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 04:46:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 04:46:14 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] run-command: fix detaching when running auto
 maintenance
Message-ID: <20240819084614.GA2955268@coredump.intra.peff.net>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <9befef7c1f7520d58af2b2db17174b8dbc493d56.1723804990.git.ps@pks.im>
 <20240817121424.GA2439299@coredump.intra.peff.net>
 <ZsLjcjhgI8Wk2tIV@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsLjcjhgI8Wk2tIV@tanuki>

On Mon, Aug 19, 2024 at 08:17:22AM +0200, Patrick Steinhardt wrote:

> >   2. Having racy background maintenance doesn't seem great for test
> >      robustness. At the very least, it might subject us to the "rm"
> >      problems mentioned elsewhere, where we fail to clean up. Annotating
> >      individual "git gc" or "git maintenance" calls with an extra
> >      descriptor isn't too bad, but in this case it's all happening under
> >      the hood via fetch. Is it a potential problem for every script,
> >      then? If so, should we disable background detaching for all test
> >      repos, and then let the few that want to test it turn it back on?
> 
> Might be a good idea to set `maintenance.autoDetach=false` globally,
> yes. The only downside is of course that it wouldn't cause us to detect
> failures like the above, where the concurrency itself causes failure.
> 
> Anyway, for now I'll:
> 
>   - Send a patch to fix the race in t7900.
> 
>   - Investigate the reftable concurrency issue.
> 
>   - _Not_ send a patch that sets `maintenance.autoDetach=false`.

That sounds like a good direction. I do suspect there are at least _two_
races in t7900:

  1. the detached maintenance that we run explicitly, which causes the
     "rm" cleanup to fail

  2. whatever earlier test is kicking off detached maintenance via "git
     fetch", which is causing the reftable concurrency issue.

Fixing (1) should be easy (and it looks like you've already sent a
series). Fixing the reftable code will stop us from segfaulting for (2),
but I wonder if that detached maintenance might cause similar "rm" style
problems elsewhere.

> The last one requires a bit more discussion first, and we have been
> running with `gc.autoDetach=true` implicitly in the past. Thinking a bit
> more about it, the reason why the above bug triggers now is that
> git-gc(1) itself runs git-pack-refs(1), but does that _synchronously_
> before detaching itself. Now we detach at a higher level in the
> hierarchy, which means that the previously-synchronous part now runs
> asynchronously, as well.

That makes sense. I guess we've perhaps been doing background gc for a
long time, then, just not in the refs? In practice most repos in the
test suite aren't big enough to trigger auto-gc anyway, so it may only
affect a handful of scripts.

Once the reftable issue is fixed, it's possible that the lingering
detached processes don't cause a problem in practice (because they're
not really writing much, and/or have finished by the time anybody else
gets to cleanup), and we can just live with them. But I'm worried that
sounds like wishful thinking. ;)

-Peff
