Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF643202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbdIHHiT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:38:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:60572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750850AbdIHHiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:38:18 -0400
Received: (qmail 23433 invoked by uid 109); 8 Sep 2017 07:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:38:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6466 invoked by uid 111); 8 Sep 2017 07:38:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:38:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:38:16 -0400
Date:   Fri, 8 Sep 2017 03:38:16 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/10] files_ref_store: use a transaction to update
 packed refs
Message-ID: <20170908073816.lnlq6lpabtiu7rra@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <25b38730abe97c29d04116b4b2c6067934dfca14.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25b38730abe97c29d04116b4b2c6067934dfca14.1503993268.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 10:20:32AM +0200, Michael Haggerty wrote:

> First, the old code didn't obtain the `packed-refs` lock until
> `files_transaction_finish()`. This means that a failure to acquire the
> `packed-refs` lock (e.g., due to contention with another process)
> wasn't detected until it was too late (problems like this are supposed
> to be detected in the "prepare" phase). The new code acquires the
> `packed-refs` lock in `files_transaction_prepare()`, the same stage of
> the processing when the loose reference locks are being acquired,
> removing another reason why the "prepare" phase might succeed and the
> "finish" phase might nevertheless fail.

That means we're holding the packed-refs lock for a slightly longer
period. I think this could mean worse lock contention between otherwise
unrelated transactions over the packed-refs file. I wonder if the
lock-retry timeout might need to be increased to accommodate this. On
the other hand, it looks like we take it after getting the individual
locks, which I'd think would be the expensive part.

Are there other callers who take the packed-refs and individual locks in
the reverse order? I think git-pack-refs might. Could we "deadlock" with
pack-refs? There are timeouts so it would resolve itself quickly, but I
wonder if we'd have a case that would deadlock-until-timeout that
otherwise could succeed.

I guess such a deadlock would exist today, as well, if we take the
packed-refs lock before giving up the individual loose ref locks.

> Second, the old code deleted the loose version of a reference before
> deleting any packed version of the same reference. This left a moment
> when another process might think that the packed version of the
> reference is current, which is incorrect. (Even worse, the packed
> version of the reference can be arbitrarily old, and might even point
> at an object that has since been garbage-collected.)
> 
> Third, if a reference deletion fails to acquire the `packed-refs` lock
> altogether, then the old code might leave the repository in the
> incorrect state (possibly corrupt) described in the previous
> paragraph.

And to think I had the hubris to claim a few weeks ago that we had
probably weeded out all of the weird packed-refs inconsistency and
race-condition bugs. :)

Good find.

-Peff
