Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7D29A9
	for <git@vger.kernel.org>; Thu, 16 May 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715843894; cv=none; b=aCliWEhWh6oBcRubQDZzMwuzIXnzQzTIyAgAat796UVAkkG/y/uOPl7blPy794CflNGhX8TJvoZc1qSn7gNYde69wlTUEH9DE4uuyqC+pmGupB7iuuHekHDJTedh/n82GwMtOVU/cK724qyWSXpt+PURH+wxEFbCDXGzJU99RJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715843894; c=relaxed/simple;
	bh=1TuxCbL6S7c1I4v26BF5N7fLaFluUdt4b4eakX/7xiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okha9V7dqoZtaWqNXcsmBwv1dEbg/Jo63o+1z0YKr+4WPe5GrQYti7TdL5qy8uIVPwnOcmqqdYW1XW9WKS8LVrcm1dHwksB+hE6UeKxIiyqrKu8RV2wp516xCjI+sYBlpnQ1T/1c6xcsb35kDZ7lfmwA1rsJ6Xhhjop7+vOGXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28469 invoked by uid 109); 16 May 2024 07:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 May 2024 07:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11507 invoked by uid 111); 16 May 2024 07:11:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 May 2024 03:11:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 May 2024 03:11:27 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240516071127.GA83658@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
 <20240510194118.GA1954863@coredump.intra.peff.net>
 <CAJoAoZmdU281buNTm+K0wHMunsbzbZ6NXFdqh=PkDUwQKfpYEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZmdU281buNTm+K0wHMunsbzbZ6NXFdqh=PkDUwQKfpYEg@mail.gmail.com>

On Mon, May 13, 2024 at 09:21:54AM -0700, Emily Shaffer wrote:

> I started to look into doing this, and it's actually really tricky.
> I've got a sample diff here
> (https://github.com/git/git/commit/bf8a5084ede2b9c476e0cf90b7f198c52573fba7);
> I'll need to do it for the other two trace formats as well. But, the
> entire trace2 library relies heavily on strbuf, which doesn't have a
> stack-allocated form. I'm also not sure how we can guarantee the
> no-alloc-ness of these - maybe there's some flag we can give to one of
> the analyzers or something? - so I'm worried about backsliding in the
> future.

Looking briefly over that patch, a few thoughts:

  - rather than try to make the generic trace2 printing functions handle
    both the alloc and fixed-buffer cases, if the signal handlers only
    need a limited set of functions, it might be easier to just let them
    live in a totally parallel universe. For the simple printing case
    that's not too much extra code, and then the complications are
    limited to the signal-handling functions themselves. It's a bit more
    tricky with json, but we might be able to get away with just
    hand-forming it into a buffer, given the relative simplicity of it.

    In some cases you might need to precompute and stash buffers ahead
    of time that could be used by the signal handler (e.g., the whole
    tr2_sid thing).

  - the opposite approach might be: stop using any allocating functions
    in the trace2 code. There's a certain simplicity there, even for
    non-signal functions, that we know we're just touching a few
    fixed-size buffers, and you can never create a weird DoS by tweaking
    the tracing code. But it would mean rewriting a lot of it (including
    json formatting stuff) without many of our usual strbuf niceties.

    This is more or less the approach we take with error(), die(), etc,
    which are built on vreportf() and its fixed buffer.

  - you probably don't want to use xsnprintf(). That function is for
    cases where it's a bug to truncate, and we're just asserting that
    everything fit as expected. For your purposes, you probably want
    regular snprintf(). Again, see vreportf().

I don't think there's an easy static analysis solution here. It's more
than just allocation, too. Anything that holds a lock is a potential
problem (e.g., stdio streams), and likewise anything that looks at
global state that might be in the middle of being mutated.

So overall it is a pretty thorny problem, and for the most part we've
just tried to keep what we do inside signal handlers to a minimum
(usually cleanup, but even there we have to be careful not to do things
like build up allocated paths for recursive removal).

> Anyway, I won't have time to work on these again until the end of next
> week. If this looks like a reasonable direction I'll pick it up again
> then; otherwise, maybe it makes sense for the fn_signal() dispatcher
> to just time out if the handler process doesn't terminate in, say, 1s?

The timeout would help with locks, but not other weird logic bugs you
can get into. Fundamentally you really want to do as little as possible
from a signal handler.

-Peff
