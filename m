Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2900E1F859
	for <e@80x24.org>; Mon, 29 Aug 2016 05:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbcH2Frc (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 01:47:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750786AbcH2Fra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 01:47:30 -0400
Received: (qmail 19866 invoked by uid 109); 29 Aug 2016 05:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 05:47:30 +0000
Received: (qmail 17089 invoked by uid 111); 29 Aug 2016 05:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 01:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2016 01:47:26 -0400
Date:   Mon, 29 Aug 2016 01:47:26 -0400
From:   Jeff King <peff@peff.net>
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Reducing CPU load on git server
Message-ID: <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2016 at 12:42:52PM -0700, W. David Jarvis wrote:

> The actual replication process works as follows:
> 
> 1. The primary git server receives a push and sends a webhook with the
> details of the push (repo, ref, sha, some metadata) to a "publisher"
> box
> 
> 2. The publisher enqueues the details of the webhook into a queue
> 
> 3. A fleet of "subscriber" (replica) boxes each reads the payload of
> the enqueued message. Each of these then tries to either clone the
> repository if they don't already have it, or they run `git fetch`.

So your load is probably really spiky, as you get thundering herds of
fetchers after every push (the spikes may have a long flatline at the
top, as it takes time to process the whole herd).

> 1. We currently run a blanket `git fetch` rather than specifically
> fetching the ref that was pushed. My understanding from poking around
> the git source code is that this causes the replication server to send
> a list of all of its ref tips to the primary server, and the primary
> server then has to verify and compare each of these tips to the ref
> tips residing on the server.

Yes, though I'd be surprised if this negotiation is that expensive in
practice. In my experience it's not generally, and even if we ended up
traversing every commit in the repository, that's on the order of a few
seconds even for large, active repositories.

In my experience, the problem in a mass-fetch like this ends up being
pack-objects preparing the packfile. It has to do a similar traversal,
but _also_ look at all of the trees and blobs reachable from there, and
then search for likely delta-compression candidates.

Do you know which processes are generating the load? git-upload-pack
does the negotiation, and then pack-objects does the actual packing.

> My hypothesis is that moving to fetching the specific branch rather
> than doing a blanket fetch would have a significant and material
> impact on server load.

Maybe. If pack-objects is where your load is coming from, then
counter-intuitively things sometimes get _worse_ as you fetch less. The
problem is that git will generally re-use deltas it has on disk when
sending to the clients. But if the clients are missing some of the
objects (because they don't fetch all of the branches), then we cannot
use those deltas and may need to recompute new ones. So you might see
some parts of the fetch get cheaper (negotiation, pack-object's
"Counting objects" phase), but "Compressing objects" gets more
expensive.

This is particularly noticeable with shallow fetches, which in my
experience are much more expensive to serve.

Jakub mentioned bitmaps, and if you are using GitHub Enterprise, they
are enabled. But they won't really help here. They are essentially
cached information that git generates at repack time. But if we _just_
got a push, then the new objects to fetch won't be part of the cache,
and we'll fall back to traversing them as normal.  On the other hand,
this should be a relatively small bit of history to traverse, so I'd
doubt that "Counting objects" is that expensive in your case (but you
should be able to get a rough sense by watching the progress meter
during a fetch).

I'd suspect more that delta compression is expensive (we know we just
got some new objects, but we don't know if we can make good deltas
against the objects the client already has). That's a gut feeling,
though.

If the fetch is small, that _also_ shouldn't be too expensive. But
things add up when you have a large number of machines all making the
same request at once. So it's entirely possible that the machine just
gets hit with a lot of 5s CPU tasks all at once. If you only have a
couple cores, that takes many multiples of 5s to clear out.

There's nothing in upstream git to help smooth these loads, but since
you mentioned GitHub Enterprise, I happen to know that it does have a
system for coalescing multiple fetches into a single pack-objects. I
_think_ it's in GHE 2.5, so you might check which version you're
running (and possibly also talk to GitHub Support, who might have more
advice; there are also tools for finding out which git processes are
generating the most load, etc).

> In other words, let's imagine a world in which we ditch our current
> repo-level locking mechanism entirely. Let's also presume we move to
> fetching specific refs rather than using blanket fetches. Does that
> mean that if a fetch for ref A and a fetch for ref B are issued at
> roughly the exact same time, the two will be able to be executed at
> once without running into some git-internal locking mechanism on a
> granularity coarser than the ref? i.e. are fetch A and fetch B going
> to be blocked on the other's completion in any way? (let's presume
> that ref A and ref B are not parents of each other).

Generally no, they should not conflict. Writes into the object database
can happen simultaneously. Ref updates take a per-ref lock, so you
should generally be able to write two unrelated refs at once. The big
exception is that ref deletion required taking a repo-wide lock, but
that presumably wouldn't be a problem for your case.

I'm still not convinced that the single-ref fetching will really help,
though.

> The ultimate goal for us is just figuring out how we can best reduce
> the CPU load on the primary instance so that we don't find ourselves
> in a situation where we're not able to run basic git operations
> anymore.

I suspect there's room for improvement and tuning of the primary. But
barring that, one option would be to have a hierarchy of replicas. Have
"k" first-tier replicas fetch from the primary, then "k" second-tier
replicas fetch from them, and so on. Trade propagation delay for
distributing the load. :)

-Peff
