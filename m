Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D629720954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdKVXso (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:48:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751494AbdKVXsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:48:43 -0500
Received: (qmail 8154 invoked by uid 109); 22 Nov 2017 23:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 23:48:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5889 invoked by uid 111); 22 Nov 2017 23:48:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 18:48:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 18:48:41 -0500
Date:   Wed, 22 Nov 2017 18:48:41 -0500
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
Message-ID: <20171122234841.GD8577@sigill>
References: <20171121234336.10209-1-phil.hord@gmail.com>
 <20171122212710.GB2854@sigill>
 <CABURp0rq9pwFWuBbrSB-FNUQ6B-7V8uL=Drw6O1-151u_cRKww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0rq9pwFWuBbrSB-FNUQ6B-7V8uL=Drw6O1-151u_cRKww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 03:21:06PM -0800, Phil Hord wrote:

> Hm. I think I was confused.
> 
> I wrote v1 of this patch a few months ago. Clearly I was wrong about
> rev-parse being afflicted.  We have a script that was suffering and it
> uses both "git log --format=%h" and "git rev-parse" to get hashes; I
> remember testing both, but I can't find it in my $zsh_history; my
> memory and my commit-message must be faulty.

OK, that makes more sense (that log would see it).

> However, "git log" does not need any --decorate option to trigger this lag.
> 
>     $ git for-each-ref| wc -l
>     24172
>     $ time git log --format=%h -1
>     git log --format=%h -1   0.47s user 0.04s system 99% cpu 0.509 total
>
> I grepped the code just now, too, and I see the same as you, though;
> it seems to hold off unless !!decoration_style.  Nevertheless, gdb
> shows me decoration_style=1 with this command:
> 
>     GIT_CONFIG=/dev/null cgdb --args git log -1 --format="%h"
> 

Right, the default these days is "auto decorate", so it's enabled if
your output is to a terminal. So "git log --no-decorate" should be cheap
again (or you may want to set log.decorate=false in your config).

And lazy-load wouldn't help you there for a normal:

  git log

But what's interesting in your command is the pretty-format. Even though
decoration is turned on, your format doesn't show any. So we never
actually ask "is this commit decorated" and the lazy-load helps.

So I think your patch is doing the right thing, but the explanation
should probably cover that it is really helping non-decorating formats.

> Here are timing tests on this repo without this change:
> 
>     git log --format=%h -1             0.54s user 0.05s system 99% cpu
> 0.597 total
>     git log --format=%h -1 --decorate  0.54s user 0.04s system 98% cpu
> 0.590 total
>     git log --format=%h%d -1           0.53s user 0.05s system 99% cpu
> 0.578 total
> 
> And the same commands with this change:
> 
>     git log --format=%h -1              0.01s user 0.01s system 71%
> cpu 0.017 total
>     git log --format=%h -1 --decorate   0.00s user 0.01s system 92%
> cpu 0.009 total
>     git log --format=%h%d -1            0.53s user 0.09s system 88%
> cpu 0.699 total

Yeah, that's consistent with what I'd expect.

> > I have definitely seen "rev-parse HEAD" be O(# of refs), but that is
> > mostly attributable to having all the refs packed (and until v2.15.0,
> > the packed-refs code would read the whole file into memory).
> 
> Hm.  Could this be why rev-parse was slow for me?  My original problem
> showed up on v1.9 (build machine) and I patched it on v2.14.0-rc1.
> But, no; testing on 1.9, 2.11 and 2.14 still doesn't show me the lag
> in rev-parse.  I remain befuddled.

Doing "rev-parse HEAD" would still have to load the packed refs if the
thing that HEAD points to is in there. Perhaps your current HEAD is
detached, or you have a loose ref for the current branch? Try "git
pack-refs --all --prune" and then re-time.

-Peff
