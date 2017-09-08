Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE1C2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 12:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbdIHM5g (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 08:57:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755523AbdIHM5g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 08:57:36 -0400
Received: (qmail 7654 invoked by uid 109); 8 Sep 2017 12:57:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 12:57:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8376 invoked by uid 111); 8 Sep 2017 12:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 08:58:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 08:57:33 -0400
Date:   Fri, 8 Sep 2017 08:57:33 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/10] files_ref_store: use a transaction to update
 packed refs
Message-ID: <20170908125733.afpo66vbummuaalg@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <25b38730abe97c29d04116b4b2c6067934dfca14.1503993268.git.mhagger@alum.mit.edu>
 <20170908073816.lnlq6lpabtiu7rra@sigill.intra.peff.net>
 <21ec2708-e8e2-8503-fe90-48a70c802cc6@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21ec2708-e8e2-8503-fe90-48a70c802cc6@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 02:44:57PM +0200, Michael Haggerty wrote:

> > That means we're holding the packed-refs lock for a slightly longer
> > period. I think this could mean worse lock contention between otherwise
> > unrelated transactions over the packed-refs file. I wonder if the
> > lock-retry timeout might need to be increased to accommodate this. On
> > the other hand, it looks like we take it after getting the individual
> > locks, which I'd think would be the expensive part.
> 
> That was my thinking, yes. While the packed-refs lock is held, the
> references being created/updated have their reflogs written and are
> renamed into place. I don't see how that can be shortened without
> compromising on correctness (in particular, that we want to process
> creates/updates before deletions to try to preserve reachability as much
> as possible during the transaction). As an added optimization, the
> packed-refs lock is not acquired at all if no references are being deleted.

Makes sense.  I guess in theory a process could do significant unrelated
work between the "prepare" and "finish" steps, while holding the lock.
But I don't know why it would, and arguably that itself is a bug.

> The packed-refs file and loose references are never locked at the same
> time during pack-refs, so no deadlock is possible.
> 
> But you are right to assume that it *should* be so. The algorithm
> written above is a tiny bit unsafe (and has been for years). It is
> possible, though admittedly very unlikely, for the following to happen
> in the gap between steps 5 and 6:

Thanks for explaining (and I think that your "should" is why I thought
it was so; we've discussed this race before).

> This would leave "foo" at the obsolete value "B" (i.e., the value
> written to the `packed-refs` file for it by the nested `pack-refs` process.
> 
> I think that fixing this problem would require the `packed-refs` lock to
> be held while `pack-refs` is pruning the loose references. But given how
> unlikely that chain of events seems, and that fixing it would increase
> contention on the `packed-refs` file and allow the deadlock that you
> described, I lean towards leaving it as-is. Though admittedly,
> contention over a loose reference lock could make the race more likely
> to be hit.

Agreed. It's a pretty unlikely sequence of events. And IMHO the real
solution is a new storage format that's easier to reason about.

-Peff
