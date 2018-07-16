Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531511F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPVEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:04:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728290AbeGPVEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:04:45 -0400
Received: (qmail 14280 invoked by uid 109); 16 Jul 2018 20:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 20:35:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15267 invoked by uid 111); 16 Jul 2018 20:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 16:35:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 16:35:39 -0400
Date:   Mon, 16 Jul 2018 16:35:39 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716203539.GD25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716191923.GC11513@aiede.svl.corp.google.com>
 <CABPp-BGN4NeH2QAP0WMyuOdr2GYq+hpt9584wdn2jHHinEAgDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGN4NeH2QAP0WMyuOdr2GYq+hpt9584wdn2jHHinEAgDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:21:40PM -0700, Elijah Newren wrote:

> > My understanding is that exploding the objects is intentional behavior,
> > to avoid a race where objects are newly referenced while they are being
> > pruned.
> >
> > I am not a fan of that behavior.  It's still racy.  But when we've
> > brought it up in the past, the consensus seems to have been that it's
> > better than nothing.  Documentation/technical/hash-function-transition.txt
> > section "Loose objects and unreachable objects" describes a way to
> > eliminate the race.
> 
> Ah, that's good to know and at least makes sense.  It seems somewhat
> odd, though; loose objects that are two weeks old are just as
> susceptible to being referenced anew by new commits, so the default of
> running 'git prune --expire=2.weeks.ago' as gc currently does would
> also be unsafe, wouldn't it?  Why is that any more or less unsafe than
> pruning objects only referenced by reflog entries that are more than
> 90 days old?

The 2-week safety isn't primarily about things which just became
unreferenced.  It's about things which are in the act of being
referenced.

Imagine a "git commit" racing with a "git prune". The commit has to
create an object, and then it will update a ref to point to it. But
between those two actions, prune may racily delete the object!
The mtime grace period is what makes that work.

Using 2 weeks is sort of ridiculous for that. But it also helps with
manual recovery (e.g., imagine a blob added to the index but never
committed; 3 days later you may want to try to recover your old work).

And you're correct that a new git-commit may still reference an old
object (e.g., a blob that's 5 seconds shy of being 2 weeks old that
you're including in a new commit). That's why we retain non-fresh
objects that are referenced from fresh ones (so as long as you made the
new commit recently, it transitively infers freshness on the old blob),
and why we fresh mtimes when we elide a write for an existing object.

That's _still_ not race-proof, because none of these operations is
atomic. git-prune can decide the blob is unfresh at the exact moment
you're creating the commit object.

-Peff
