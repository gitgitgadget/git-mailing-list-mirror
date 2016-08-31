Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304201FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 06:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbcHaGCq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 02:02:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751302AbcHaGCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 02:02:46 -0400
Received: (qmail 8668 invoked by uid 109); 31 Aug 2016 06:02:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 06:02:45 +0000
Received: (qmail 3582 invoked by uid 111); 31 Aug 2016 06:02:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 02:02:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 02:02:41 -0400
Date:   Wed, 31 Aug 2016 02:02:41 -0400
From:   Jeff King <peff@peff.net>
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reducing CPU load on git server
Message-ID: <20160831060240.xg6axpqnlclys7ic@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
 <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
 <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
 <CAFMAO9zfMtF6Vc+Uyt+UdgOVf4hzOqMN3o8QLf8pRHx3_U4DPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFMAO9zfMtF6Vc+Uyt+UdgOVf4hzOqMN3o8QLf8pRHx3_U4DPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 03:41:59PM -0700, W. David Jarvis wrote:

> We have an open support thread with the GHE support folks, but the
> only feedback we've gotten so far on this subject is that they believe
> our CPU load is being driven by the quantity of fetch operations (an
> average of 16 fetch requests per second during normal business hours,
> so 4 requests per second per subscriber box). About 4,000 fetch
> requests on our main repository per day.

Hmm. That might well be, but I'd have to see the numbers to say more. At
this point I think we're exhausting what is useful to talk about on the
Git list.  I'll point GHE Support at this thread, which might help your
conversation with them (and they might pull me in behind the scenes).

I'll try to answer any Git-specific questions here, though.

> > None of those operations is triggered by client fetches. You'll see
> > "rev-list" for a variety of operations, so that's hard to pinpoint. But
> > I'm surprised that "prune" is a common one for you. It is run as part of
> > the post-push, but I happen to know that the version that ships on GHE
> > is optimized to use bitmaps, and to avoid doing any work when there are
> > no loose objects that need pruning in the first place.
> 
> Would regular force-pushing trigger prune operations? Our engineering
> body loves to force-push.

No, it shouldn't make a difference. For stock git, "prune" will only be
run occasionally as part of "git gc". On GitHub Enterprise, every push
kicks off a "sync" job that moves objects from a specific fork into
storage shared by all of the related forks. So GHE will run prune more
often than stock git would, but force-pushing wouldn't have any effect
on that.

There are also some custom patches to optimize prune on GHE, so it
shouldn't generally be very expensive. Unless perhaps for some reason
the reachability bitmaps on your repository aren't performing very well.

You could try something like comparing:

  time git rev-list --objects --all >/dev/null

and

  time git rev-list --objects --all --use-bitmap-index >/dev/null

on your server. The second should be a lot faster. If it's not, that may
be an indication that Git could be doing a better job of selecting
bitmap commits (that code is not GitHub-specific at all).

> >> I might be misunderstanding this, but if the subscriber is already "up
> >> to date" modulo a single updated ref tip, then this problem shouldn't
> >> occur, right? Concretely: if ref A is built off of ref B, and the
> >> subscriber already has B when it requests A, that shouldn't cause this
> >> behavior, but it would cause this behavior if the subscriber didn't
> >> have B when it requested A.
> >
> > Correct. So this shouldn't be a thing you are running into now, but it's
> > something that might be made worse if you switch to fetching only single
> > refs.
> 
> But in theory if we were always up-to-date (since we'd always fetch
> any updated ref) we wouldn't run into this problem? We could have a
> cron job to ensure that we run a full git fetch every once in a while
> but I'd hope that if this was written properly we'd almost always have
> the most recent commit for any dependency ref.

It's a little more complicated than that. What you're really going for
is letting git reuse on-disk deltas when serving fetches. But depending
on when the last repack was run, we might be cobbling together the fetch
from multiple packs on disk, in which case there will still be some
delta search. In my experience that's not _generally_ a big deal,
though. Small fetches don't have that many deltas to find.

> Our primary repository is fairly busy. It has about 1/3 the commits of
> Linux and about 1/3 the refs, but seems otherwise to be on the same
> scale. And, of course, it both hasn't been around for as long as Linux
> has and has been experiencing exponential growth, which means its
> current activity is higher than it has ever been before -- might put
> it on a similar scale to Linux's current activity.

Most of the work for repacking scales with the number of total objects
(not quite linearly, though).  For torvalds/linux (and its forks),
that's around 16 million objects. You might try "git count-objects -v"
on your server for comparison (but do it in the "network.git" directory,
as that's the shared object storage).

-Peff
