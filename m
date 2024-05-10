Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E4317E
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370088; cv=none; b=HDJmaGg0G6mcRC6mCldtPQAnAHhWx+ZoarEn21vywO0hmL4XpndGW33NvP2KCqOjms+mpcZ6acKnqrrznEdQ50fePK3EdQq+aZWw0rHjSA/8eGQ/QKX+8D2p9y4/1CTxE5LFuu1k+H1C4rkFB49Ao7nWwIft5NQ/BaIaggcn93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370088; c=relaxed/simple;
	bh=xfl0cIL5zbw7xvBc7dSn0DB2PlWOPTLMn1J8Ct1s3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXTH1cdNuDxkc1haF2kMKArOQKD3w4vZfhi96BhMZ6oPelk45aFECpPUycm6MiIFc0DSiePLYZf6y4AVTk72n6WwPm4H6Xht5j4l0J8nDM+NGK+ye4UxQ5VMt+5D/91/IsyATEvXZC8sgxPCa7XzxmN/Cps4Gt5lASHC52DR5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18889 invoked by uid 109); 10 May 2024 19:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 19:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11823 invoked by uid 111); 10 May 2024 19:41:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 15:41:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 15:41:18 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, git@jeffhostetler.com,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] trace2: intercept all common signals
Message-ID: <20240510194118.GA1954863@coredump.intra.peff.net>
References: <20240510172243.3529851-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510172243.3529851-1-emilyshaffer@google.com>

On Fri, May 10, 2024 at 10:22:43AM -0700, Emily Shaffer wrote:

> From: Emily Shaffer <nasamuffin@google.com>
> 
> We already use trace2 to find out about unexpected pipe breakages, which
> is nice for detecting bugs or system problems, by adding a handler for
> SIGPIPE which simply writes a trace2 line. However, there are a handful
> of other common signals which we might want to snoop on:
> 
>  - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command in
>    frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
>  - SIGHUP, when the network closes unexpectedly (indicating there may be
>    a problem to solve)
> 
> There are lots more signals which we might find useful later, but at
> least let's teach trace2 to report these egregious ones. Conveniently,
> they're also already covered by the `_common` variants in sigchain.[ch].

I think this would be a useful thing to have, but having looked at the
trace2 signal code, this is almost certain to cause racy deadlocks.

The exact details depend on the specific trace2 target backend, but
looking at the various fn_signal() methods, they rely on allocations via
strbufs. This is a problem in signal handlers because we can get a
signal at any time, including when other code is inside malloc() holding
a lock. And then further calls to malloc() will block forever on that
lock.

We should be able to do a quick experiment. Try this snippet, which
repeatedly kills "git log -p" (which is likely to be allocating memory)
and waits for it to exit. Eventually each invocation will stall on a
deadlock:

-- >8 --
doit() {
	me=$1
	i=0
	while true; do
		GIT_TRACE2=1 ./git log -p >/dev/null 2>&1 &
		sleep 0.1
		kill $!
		wait $! 2>/dev/null
		i=$((i+1))
		echo $me:$i
	done
}

for i in $(seq 1 64); do
	doit $i &
done
-- >8 --

I didn't have the patience to wait for all of them to stall, but if you
let it run for a bit and check "ps", you'll see some git processes which
are hanging. Stracing shows them stuck on a lock, like:

  $ strace -p 1838693
  strace: Process 1838693 attached
  futex(0x7facf02df3e0, FUTEX_WAIT_PRIVATE, 2, NULL^Cstrace: Process 1838693 detached
   <detached ...>

This problem existed before your patch. I imagine it was much less
likely (or perhaps even impossible) with SIGPIPE though, because we'd
see that signal only when in a write() syscall, which implies we're not
in malloc(). Whereas we can get SIGTERM, etc, any time.

Obviously the script above is meant to exacerbate the situation, and
most runs would be fine. But over the course of normal use across many
users and many runs, I think we would see this in practice. I think your
test won't because it triggers the signal only from raise().

So I think before doing this, we'd need to clean up the trace2 signal
code to avoid any allocations.

-Peff
