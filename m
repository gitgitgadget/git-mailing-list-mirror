Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B033CFC
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975406; cv=none; b=l+a9oYHIFsqrqkHu4LkaTLjVg/3HcRL6V5lWhPfUGl4U7EOWg/Q1Vr5D6Gu7nmi0Iz9SHbgdk3QOn6U/q1ayCcsjI88Bwq59tDNwIL+bP0Cr8oqy0POSB5dSCgj7BXLGDjNVZWyALNIxxzBL2rDpUA8GcRX1rF8Q5yEYBw2OeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975406; c=relaxed/simple;
	bh=SWlPbwA/3OL3J+Ukm7eyhFYn8aPf5lzZCzHFGQO+Q8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THDSFfywaBbUDl12PbuaWHTWH+OjYhQqECts2Y9iNoZStzxes5hUEIS8rm6xw376wDIAf5dnLfh0iuPRrLFsLOmamMs9ExBLo1qfu/S1qdaFw6G0dU+n42IYQVpSDRSCByY80/w8FAR/8RlAIP1NdIZ4pieWAE0UqWr/LFbGZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11508 invoked by uid 109); 29 May 2024 09:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 09:36:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18426 invoked by uid 111); 29 May 2024 09:36:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 05:36:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 05:36:43 -0400
From: Jeff King <peff@peff.net>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
Subject: Re: [PATCH] promisor-remote: add promisor.quiet configuration option
Message-ID: <20240529093643.GE1098944@coredump.intra.peff.net>
References: <20240523131926.1959245-1-tom@compton.nu>
 <20240525052946.GD1895047@coredump.intra.peff.net>
 <1b10454e-c5ad-4ce3-a724-27306ee8824c@compton.nu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b10454e-c5ad-4ce3-a724-27306ee8824c@compton.nu>

On Sat, May 25, 2024 at 11:29:13AM +0100, Tom Hughes wrote:

> > I'm not at all opposed to providing a way to suppress this, but I feel
> > like in the long run, the more fundamental issue is that git-blame kicks
> > off a zillion fetches as it traverses. That's not only ugly but it's
> > also horribly inefficient.
> 
> This is true. One thing I found that makes things a lot more
> efficient if you're using ssh as the transport is to enable
> persistent multiplexing in .ssh/config with something like:
> 
> Host git.example.com
>   ControlMaster auto
>   ControlPath /run/user/%i/ssh/control.%C
>   ControlPersist 1m
>   SendEnv GIT_PROTOCOL
> 
> which avoids each fetch having to setup and authenticate a
> new ssh session.

Good point. That is sort of the opposite approach of my suggestion. That
is, I was suggesting that git-blame batch everything to make a single
efficient request. But if we could reduce the cost of making individual
requests, then we wouldn't need to batch (which is quite a lot simpler).

The ssh session is going to be one source of latency and overhead. But
just spawning the fetch and remote upload-pack are another (especially
if you have to authenticate, and especially with the v2 protocol, which
has an extra round-trip for capabilities upgrade).

If there was a long-running mode to git-fetch where it kept open a v2
session to the server and just said "hey, send me object X" and then
"OK, now send me object Y" that would eliminate all of that overhead
(and even for http, under the hood curl is good at keeping the session
open between requests).

You'd still have some extra latency (while you're talking to the server,
the local blame process is paused), but I suspect it would be a lot more
tolerable.

And now your progress question is re-opened again. You might want a
more succinct progress for something like blame that still does all of
its fetching before generating output. E.g., you might want a single
progress line with the current state (fetching or not), the count of
fetched objects, the speed, and so on. And for something like "git log
-p", where the progress would be interspersed with actual output, you
might want to suppress it entirely.

So yeah, I have no real objection to what your patch is doing. Depending
on how future work unfolds it might be more or less useful than it is
now, but even in the worst case it probably won't be a bad thing to have
in our toolbox.

-Peff
