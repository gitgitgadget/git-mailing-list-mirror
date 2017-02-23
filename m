Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCE92022D
	for <e@80x24.org>; Thu, 23 Feb 2017 22:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdBWWtq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 17:49:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:32911 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbdBWWtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 17:49:45 -0500
Received: (qmail 24480 invoked by uid 109); 23 Feb 2017 22:43:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 22:43:04 +0000
Received: (qmail 20875 invoked by uid 111); 23 Feb 2017 22:43:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 17:43:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 17:43:02 -0500
Date:   Thu, 23 Feb 2017 17:43:02 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
References: <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1702231428540.30435@i7.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 02:38:29PM -0800, Linus Torvalds wrote:

> > Thanks, I hadn't seen that yet. That doesn't look like it should be hard
> > to integrate into Git.
> 
> Here's a *very* ugly patch that is absolutely disgusting and should not be 
> used. But it does kind of work (I tested it with a faked-up extra patch 
> that made git accept the broken pdf as a loose object).
> 
> What do I mean by "kind of work"? It uses that ugly and slow checking 
> SHA1 routine from the collision detection project for the SHA1 object 
> verification, and it means that "git fsck" ends up being about twice as 
> slow as it used to be.

Heh. I was just putting the finishing touches on a similar patch. Mine
is much less gross, in that it actually just adds a new USE_SHA1DC knob
(instead of, say, BLK_SHA1).

Here are the timings I came up with:

  - compute sha1 over whole packfile
    before: 1.349s
     after: 5.067s
    change: +275%

  - rev-list --all
    before: 5.742s
     after: 5.730s
    change: -0.2%

  - rev-list --all --objects
    before: 33.257s
     after: 33.392s
    change: +0.4%

  - index-pack --verify
    before: 2m20s
     after: 5m43s
    change: +145%

  - git log --no-merges -10000 -p
    before: 9.532s
     after: 9.683s
    change: +1.5%

So overall the sha1 computation is about 3-4x slower. But of
course most operations do more than just sha1. Accessing
commits and trees isn't slowed at all (both the +/- changes
there are well within the run-to-run noise). Accessing the
blobs is a little slower, but mostly drowned out by the cost
of things like actually generating patches.

The most-affected operation is `index-pack --verify`, which
is essentially just computing the sha1 on every object. It's
a bit worse than twice as slow, which means every push and
every fetch is going to experience that.

> For example, I suspect we could use our (much cleaner) block-sha1 
> implementation and include just the ubc_check.c code with that, instead of 
> the truly ugly C sha1 implementation that the sha1collisiondetection 
> project uses. 
> 
> But to do that, somebody would have to really know how the unavoidable 
> bit conditions check works with the intermediate hashes. I have only a 
> "big picture" mental model of it (read: I'm not competent to do that).

Yeah. I started looking at that, but the ubc check happens after the
initial expansion. But AFAICT, block-sha1 mixes that expansion in with
the rest of the steps for efficiency. So perhaps somebody who really
understands sha1 and the new checks could figure it out, but I'm not at
all certain that adding it in wouldn't lose some of block-sha1's
efficiency (on top of the time to actually do the ubc check).

-Peff
