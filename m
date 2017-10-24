Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013FC1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdJXTpK (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:45:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751618AbdJXTpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:45:10 -0400
Received: (qmail 29863 invoked by uid 109); 24 Oct 2017 19:45:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 19:45:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14922 invoked by uid 111); 24 Oct 2017 19:45:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 15:45:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 12:45:08 -0700
Date:   Tue, 24 Oct 2017 12:45:08 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix an error-handling path when locking refs
Message-ID: <20171024194507.h4xduhx3pq2y2yyw@sigill.intra.peff.net>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1508856679.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 05:16:23PM +0200, Michael Haggerty wrote:

> But in fact the problem is more general; it can happen whenever a
> reference deletion within a transaction is processed successfully, and
> then another reference update in the same transaction fails in
> `lock_ref_for_update()`. In such a case the failed update and any
> subsequent ones could be silently ignored.

Thanks for digging this down to the root cause. It sounds like this
might not be all that hard to trigger for users of "push --atomic", then
(most of the rest of the code is saved by the fact that it still uses
one ref per transaction, which I think can't trigger this).

> There is a longer explanation in the second patch's commit message.
> 
> The tests that I added probe a bunch of D/F update scenarios, which I
> think should be characteristic of the scenarios that would trigger
> this bug. It would be nice to have tests that examine other types of
> failures (e.g., wrong `old_oid` values).

What you added makes sense to me for now. I do admit I was a little
surprised that we didn't have better test coverage for partial
transaction failures. I think in general our test suite is weak on
checking failures, and covering more cases (like old_oid) would be
welcome. Those will be valuable especially as we started playing with
more storage backends.

I also agree that those tests can come post-release.

> While looking at this code again, I realized that the new code
> rewrites the `packed-refs` file more often than did the old code.
> Specifically, after dc39e09942 (files_ref_store: use a transaction to
> update packed refs, 2017-09-08), the `packed-refs` file is overwritten
> for any transaction that includes a reference delete. Prior to that
> commit, `packed-refs` was only overwritten if a deleted reference was
> actually present in the existing `packed-refs` file. This is even the
> case if there was previously no `packed-refs` file at all; now any
> reference deletion causes an empty `packed-refs` file to be created.
> 
> I think this is a conscionable regression, since deleting references
> that are purely loose is probably not all that common, and the old
> code had to read the whole `packed-refs` file anyway. Nevertheless, it
> is obviously something that I would like to fix (though maybe not for
> 2.15? I'm open to input about its urgency.)

I agree it's not nearly as urgent as the fix you have here. It might
show up on a busy system as increased lock contention over packed-refs.
Or if you have really gigantic packed-refs files, a possible performance
regression. But as you say, it should be a pretty rare case.

So I'd be OK with leaving it to post-2.15. OTOH, I suspect it's a pretty
small patch. If you happen to produce it quickly, it might be worth
seeing before evaluating.

-Peff
