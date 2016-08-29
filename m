Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B3F1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755942AbcH2VbH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:35090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754688AbcH2VbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:31:06 -0400
Received: (qmail 14625 invoked by uid 109); 29 Aug 2016 21:31:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 21:31:05 +0000
Received: (qmail 23973 invoked by uid 111); 29 Aug 2016 21:31:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 17:31:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2016 17:31:01 -0400
Date:   Mon, 29 Aug 2016 17:31:01 -0400
From:   Jeff King <peff@peff.net>
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reducing CPU load on git server
Message-ID: <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
 <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 12:16:20PM -0700, W. David Jarvis wrote:

> > Do you know which processes are generating the load? git-upload-pack
> > does the negotiation, and then pack-objects does the actual packing.
> 
> When I look at expensive operations (ones that I can see consuming
> 90%+ of a CPU for more than a second), there are often pack-objects
> processes running that will consume an entire core for multiple
> seconds (I also saw one pack-object counting process run for several
> minutes while using up a full core).

Pegging CPU for a few seconds doesn't sound out-of-place for
pack-objects serving a fetch or clone on a large repository. And I can
certainly believe "minutes", especially if it was not serving a fetch,
but doing repository maintenance on a large repository.

Talk to GitHub Enterprise support folks about what kind of process
monitoring and accounting is available. Recent versions of GHE can
easily tell things like which repositories and processes are using the
most CPU, RAM, I/O, and network, which ones are seeing a lot of
parallelism, etc.

> rev-list shows up as a pretty active CPU consumer, as do prune and
> blame-tree.
> 
> I'd say overall that in terms of high-CPU consumption activities,
> `prune` and `rev-list` show up the most frequently.

None of those operations is triggered by client fetches. You'll see
"rev-list" for a variety of operations, so that's hard to pinpoint. But
I'm surprised that "prune" is a common one for you. It is run as part of
the post-push, but I happen to know that the version that ships on GHE
is optimized to use bitmaps, and to avoid doing any work when there are
no loose objects that need pruning in the first place.

Blame-tree is a GitHub-specific command (it feeds the main repository
view page), and is a known CPU hog. There's more clever caching for that
coming down the pipe, but it's not shipped yet.

> On the subject of prune - I forgot to mention that the `git fetch`
> calls from the subscribers are running `git fetch --prune`. I'm not
> sure if that changes the projected load profile.

That shouldn't change anything; the pruning is purely a client side
thing.

> > Maybe. If pack-objects is where your load is coming from, then
> > counter-intuitively things sometimes get _worse_ as you fetch less. The
> > problem is that git will generally re-use deltas it has on disk when
> > sending to the clients. But if the clients are missing some of the
> > objects (because they don't fetch all of the branches), then we cannot
> > use those deltas and may need to recompute new ones. So you might see
> > some parts of the fetch get cheaper (negotiation, pack-object's
> > "Counting objects" phase), but "Compressing objects" gets more
> > expensive.
> 
> I might be misunderstanding this, but if the subscriber is already "up
> to date" modulo a single updated ref tip, then this problem shouldn't
> occur, right? Concretely: if ref A is built off of ref B, and the
> subscriber already has B when it requests A, that shouldn't cause this
> behavior, but it would cause this behavior if the subscriber didn't
> have B when it requested A.

Correct. So this shouldn't be a thing you are running into now, but it's
something that might be made worse if you switch to fetching only single
refs.

> See comment above about a long-running counting objects process. I
> couldn't tell which of our repositories it was counting, but it went
> for about 3 minutes with full core utilization. I didn't see us
> counting pack-objects frequently but it's an expensive operation.

That really sounds like repository maintenance. Repacks of
torvalds/linux (including all of its forks) on github.com take ~15
minutes of CPU. There may be some optimization opportunities there (I
have a few things I'd like to explore in the next few months), but most
of it is pretty fundamental. It literally takes a few minutes just to
walk the entire object graph for that repo (that's one of the more
extreme cases, of course, but presumably you are hosting some large
repositories).

Maintenance like that should be a very occasional operation, but it's
possible that you have a very busy repo.

> > There's nothing in upstream git to help smooth these loads, but since
> > you mentioned GitHub Enterprise, I happen to know that it does have a
> > system for coalescing multiple fetches into a single pack-objects. I
> > _think_ it's in GHE 2.5, so you might check which version you're
> > running (and possibly also talk to GitHub Support, who might have more
> > advice; there are also tools for finding out which git processes are
> > generating the most load, etc).
> 
> We're on 2.6.4 at the moment.

OK, I double-checked, and your version should be coalescing identical
fetches.

Given that, and that a lot of the load you mentioned above is coming
from non-fetch sources, it sounds like switching anything with your
replica fetch strategy isn't likely to help much. And a multi-tiered
architecture won't help if the load is being generated by requests that
are serving the web-views directly on the box.

I'd really encourage you to talk with GitHub Support about performance
and clustering. It sounds like there may be some GitHub-specific things
to tweak. And it may be that the load is just too much for a single
machine, and would benefit from spreading the load across multiple git
servers.

-Peff
