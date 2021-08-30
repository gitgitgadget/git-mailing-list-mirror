Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2B0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD04260ED4
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhH3Uip (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:38:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:34222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhH3Uip (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:38:45 -0400
Received: (qmail 1248 invoked by uid 109); 30 Aug 2021 20:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 20:37:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10157 invoked by uid 111); 30 Aug 2021 20:37:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 16:37:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 16:37:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <YS1Bni+QuZBOgkUI@coredump.intra.peff.net>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
 <20210830182845.pnv7ywnc364jnblt@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830182845.pnv7ywnc364jnblt@box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 09:28:45PM +0300, Kirill A. Shutemov wrote:

> > I can't reproduce the problem here, using core.gitproxy with a script
> > identical to what you showed above. I tried both cloning, and fetching
> > via both git-fetch and git-fetch-pack.
> 
> Could you try with a kernel repo?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> I found that not all repos on kernel.org trigger the issue.

Thanks, I was able to reproduce there (but not with git.git). That makes
me wonder if it's a race condition of some sort. My reproduction was
just:

  git init
  git config core.gitproxy /path/to/proxy/script
  git fetch-pack \
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
    refs/heads/master

In the meantime, a workaround is:

  git -c protocol.version=0 fetch-pack ...

> > If you can reproduce it at will and it fails on 2.33 but not earlier,
> > then bisecting might be helpful.
> 
> I did. See my other mail.

Yeah, looks like you found ae1a7eefff (fetch-pack: signal v2 server that
we are done making requests, 2021-05-19). I suspected that might be the
case.

I strace'd the underlying socat, and it does this (numbers on the left
are my annotations):

     select(6, [0 5], [1], [], NULL)         = 2 (in [0], out [1])
     recvfrom(3, 0x7ffee69f1f50, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
     recvfrom(3, 0x7ffee69f19d0, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
[0]  read(0, "", 8192)                       = 0
     recvfrom(3, 0x7ffee69f19d0, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
[1]  shutdown(5, SHUT_WR)                    = 0
     recvfrom(3, 0x7ffee69f1f50, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
[2]  select(6, [5], [], [], {tv_sec=0, tv_usec=500000}) = 0 (Timeout)
     recvfrom(3, 0x7ffee69f1f50, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
[3]  shutdown(5, SHUT_RDWR)                  = 0
     recvfrom(3, 0x7ffee69f2240, 519, MSG_DONTWAIT, NULL, NULL) = -1 EAGAIN (Resource temporarily unavailable)
     exit_group(0)                           = ?

Here descriptors 0/1 are the pipes from/to Git, and 5 is the TCP socket
connected to the server. The recvfrom() is just noise, I think; socat
opens a dgram socketpair(), but doesn't seem to do anything with it.

So in [0] we see that Git has hung up half of the pipe, due to the new
code in ae1a7eefff. socat then correctly relays the half-duplex shutdown
to the server in [1]. At this point it should wait for the server to
send the data, and relay it to stdout. And indeed, it does call select()
in [2]. But then when it hits the half-second timeout, it shuts down
completely!

I'm not that familiar with socat, but I've seen the same thing with
older versions of netcat: it wants to quit after seeing EOF on stdin.
This is useful to prevent deadlock if the server doesn't respond to a
half-duplex shutdown. But it's quite the wrong thing to do for a more
intelligent protocol.

That explains why you see the problem sometimes but not others. It
depends how long the server takes before it produces any output, which
in turn may depend on things like repo size. You said you didn't see it
when fetching from GitHub, but I suspect it is simply that GitHub's
server responds a little bit more quickly.

In netcat, the fix is to use "-q" (though at least some versions of
netcat will wait forever by default these days, so it's not a problem).
In socat, it looks like "-t" does the same thing. And indeed, switching
the proxy to:

  socat -t 10 - "TCP:$1:$2"

makes the problem go away for me. The 10-second timeout might seem
arbitrary, but it should be reliable. Git's server-side has a keep-alive
mechanism that sends a packet every 5 seconds, even if no output has
been produced yet. So even if the request takes a long time to generate
any output, it should be plenty to tell socat that the connection is
still live.

I am sympathetic that this used to work, and now doesn't. But this proxy
case is affected by the problem that ae1a7eefff was solving. The root of
the issue is just that "socat" in its default form is not doing the
right thing. So I'd prefer not to try to make any change to Git's
behavior here. But one option would be to limit it only to ssh, and not
git:// proxies (we already don't do that half-duplex shutdown for raw
TCP git://, for reasons discussed in that commit message).

-Peff
