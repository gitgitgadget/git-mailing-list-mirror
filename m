Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A9C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D2961073
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbhERIND (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:13:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240590AbhERINC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:13:02 -0400
Received: (qmail 11999 invoked by uid 109); 18 May 2021 08:11:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 08:11:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5769 invoked by uid 111); 18 May 2021 08:11:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 04:11:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 04:11:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YKN2vT+zi/N6jUAN@coredump.intra.peff.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
 <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
 <32e5852f-f94b-e169-de1c-8cc9a534c93c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32e5852f-f94b-e169-de1c-8cc9a534c93c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 12:25:02PM -0400, Derrick Stolee wrote:

> > Here's the same scenario failing without using bitmaps at all:
> > 
> ...
> >   # ...and then we fetch both the object we need _and_ that second
> >   # commit. That causes pack-objects to traverse from base..more.
> >   # The boundary is at "base", so we mark its tree and blob as
> >   # UNINTERESTING, and thus we _don't_ send them.
> >   cd clone
> >   git fetch origin $(git rev-parse HEAD:file) HEAD
> 
> This is the critical reason why this isn't failing in practice: it
> is very rare to ask for a commit and a blob at the same time. Usually,
> a blob request comes when something like 'git checkout' is actually
> navigating to a commit, and then it only asks for missing blobs.

Yes, I think that may be part of it. But more fundamentally, the request
done by "git checkout" does not send any "have" lines at all, so it
could never trigger this bug, even if it did try to ask for a commit.

> > So I guess the first question is: is this supposed to work? Without
> > bitmaps, it often will. Because we walk commits first, and then only
> > mark trees uninteresting at the boundary; so if there were more commits
> > here, and we were asking to get a blob from one of the middle ones, it
> > would probably work. But fundamentally the client is lying to the server
> > here (as all partial clones must); it is saying "I have that first
> > commit", but of course we don't have all of the reachable objects.
> 
> It _should_ work. We should be specifying the blob:none filter, so when
> we say "we have these commits" it should apply that filter to those
> commits for the "haves".

I guess my "should it work" was more about: are filter requests that
feed arbitrary combinations to git-fetch, including "haves", something
we want to support?

I think the world is a better place if we do. But what I'm wondering is
if there was some intentional choice to avoid triggering this
(especially in the way that the on-demand fetcher uses the "noop"
negotiation algorithm).

And yes, we do specify the blob:none filter. BTW, I saw an interesting
side-behavior here.  If the server _stops_ supporting filters and then
we try to fetch with it, we will happily say "oh well, the other side
doesn't support filters, so I won't bother sending my filter spec". And
then all hell breaks loose, as the other side has no clue that we are a
partial clone.

In practice I think it's an unlikely failure mode for a server you
partial-cloned from to turn off filters, so it's probably not that
important. I hit it because a test script used test_config to enable
them, and then the follow-on test I added to run git-fetch got quite
confused. A more likely scenario is that you might see it a
misconfigured load-balanced pool of servers.

I do wonder how hitting a third-party server should work, though. E.g.,
I partial clone from A, and then ask B to fetch some related history
built on top. Do I tell B that I'm a partial clone and might be missing
some objects? Or do I behave as normal, and expect to fault in objects
that it assumes I have (e.g., a delta base)? And if the latter, does
that work (if it does, then why doesn't the same logic kick in for this
fetch?).

Anyway, that's maybe orthogonal to the bug at hand (and my questions
above are all sincere; it might well work just fine, but I haven't dug
into it further).

> > If this is supposed to work, I think we need to teach the traversal code
> > to "add back" all of the objects that were explicitly given when a
> > filter is in use (either explicitly, or perhaps just clearing or
> > avoiding the UNINTERESTING flag on user-given objects in the first
> > place). And my earlier patch does that for the bitmap side, but not the
> > regular traversal.
> 
> This gets more complicated if we were in a treeless clone, for example.
> We could explicitly ask for a tree and really need all of its reachable
> trees and blobs. It's not enough to just isolate that single object.

Good point. That really requires walking any objects that were listed to
"add back", but _only_ the ones that would have been filtered. In the
treeless clone case, that's easier. But if I say "don't give me any
trees deeper than X", how do I even know which ones those are?

> I wouldn't spend too much time optimizing for the treeless clone case,
> as I believe the client will self-recover by asking for those reachable
> trees when it walks to them.

Yes, I think as long as the on-demand fetch kicks in, then it becomes an
optimization problem, not a correctness one. So perhaps the first fix
should focus on that, even for the blob case being discussed. Then it
_works_, just with an extra round-trip for the on-demand fetch.

-Peff
