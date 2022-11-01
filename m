Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A827FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 09:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKAJA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAJA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 05:00:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34660DF
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 02:00:23 -0700 (PDT)
Received: (qmail 5402 invoked by uid 109); 1 Nov 2022 09:00:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 09:00:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20982 invoked by uid 111); 1 Nov 2022 09:00:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 05:00:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 05:00:22 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2DgJi6foPyBhycU@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 04:42:19PM +0200, Patrick Steinhardt wrote:

>     - A client shouldn't assume objects to exist that have not been part
>       of the reference advertisement. But if it excluded an object from
>       the packfile that is reachable via any ref that is excluded from
>       the reference advertisement due to `transfer.hideRefs` we'd have
>       accepted the push anyway. I'd argue that this is a bug in the
>       current implementation.

Like others, I don't think this is a bug exactly. We'd never introduce a
corruption. We're just more lenient with clients than we need to be.

But I don't think your scheme changes that. In a sense, the tips used by
"rev-list --not --all" are really an optimization. We will walk the
history from the to-be-updated ref tips all the way down to the roots if
we have to. So imagine that I have object X which is not referenced at
all (neither hidden nor visible ref). We obviously do not advertise it
to the client, but let's further imagine that a client sends us a pack
with X..Y, and a request to update some ref to Y.

Both before and after your code, if rev-list is able to walk down from Y
until either we hit all roots or all UNINTERESTING commits, it will be
satisfied. So as long as the receiving repo actually has all of the
history leading up to X, it will allow the push, regardless of your
patch.

If we wanted to stop being lenient, we'd have to actually check that
every object we traverse is either reachable, or came from the
just-pushed pack.


There's also a subtle timing issue here. Our connectivity check happens
after we've finished receiving the pack. So not only are we including
hidden refs, but we are using the ref state at the end of the push
(after receiving and processing the incoming pack), rather than the
beginning.

From the same "leniency" lens this seems like the wrong thing. But as
above, it doesn't matter in practice, because these tips are really an
optimization to tell rev-list that it can stop traversing.

If you think of the connectivity check less as "did the client try to
cheat" and more as "is it OK to update these refs without introducing a
corruption", then it makes sense that you'd want to do read the inputs
to the check as close to the ref update as possible, because it shrinks
the race window which could introduce corruption.

Imagine a situation like this:

  0. We advertise to client that we have commit X.

  1. Client starts pushing up a pack with X..Y and asks to update some
     branch to Y.

  2. Meanwhile, the branch with X is deleted, and X is pruned.

  3. Server finishes receiving the pack. All looks good, and then we
     start a connectivity check.

In the current code, that check starts with the current ref state (with
X deleted) as a given, and makes sure that we have the objects we need
to update the refs. After your patches, it would take X as a given, and
stop traversing when we see it.

That same race exists before your patch, but it's between the time of
"rev-list --not --all" running and the ref update. After your patch,
it's between the advertisement and the ref update, which can be a long
time (hours or even days, if the client is very slow).

In practice I'm not sure how big a deal this is. If we feed the
now-pruned X to rev-list, it may notice that X went away, though we've
been reducing the number of checks there in the name of efficiency
(e.g., if it's still in the commit graph, we'd say "OK, good enough"
these days, even if we don't have it on disk anymore).

But it feels like a wrong direction to make that race longer if there's
no need to.

So all that said...

>     - Second, by using advertised refs as inputs instead of `git
>       rev-list --not --all` we avoid looking up all refs that are
>       irrelevant to the current push. This can be a huge performance
>       improvement in repos that have a huge amount of internal, hidden
>       refs. In one of our repos with 7m refs, of which 6.8m are hidden,
>       this speeds up pushes from ~30s to ~4.5s.

I like the general direction here of avoiding the hidden refs. The
client _shouldn't_ have been using them, so we can optimistically assume
they're useless (and in the case of races or other weirdness, rev-list
just ends up traversing a bit further).

But we can split the two ideas in your series:

  1. Feed the advertised tips from receive-pack to rev-list.

  2. Avoid traversing from the hidden tips.

Doing (1) gets you (2) for free. But if we don't want to do (1), and I
don't think we do, we can get (2) by just teaching rev-list to narrow
the check.

I see some discussion in the other part of the thread, and we may need a
new rev-list option to do this, as mentioned there. However, you _might_
be able to do it the existing --exclude mechanism. I.e., something like:

  rev-list --stdin --not --exclude 'refs/hidden/*' --all

The gotchas are:

  - I'm not 100% sure that --exclude globbing and transfer.hideRefs
    syntax are compatible. You'd want to check.

  - these would have to come on the command line (at least with the
    current code). Probably nobody has enough hiderefs patterns for that
    to be a problem (and remember we are passing the glob pattern here,
    not the 6.8M refs themselves). But it could bite somebody in a
    pathological case.

-Peff
