Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6EB202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbdGMSkz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:40:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752525AbdGMSky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:40:54 -0400
Received: (qmail 927 invoked by uid 109); 13 Jul 2017 18:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 18:40:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3224 invoked by uid 111); 13 Jul 2017 18:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:41:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 14:40:52 -0400
Date:   Thu, 13 Jul 2017 14:40:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
Message-ID: <20170713184051.fcwg76o6ovnsjjbm@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
 <xmqqeftkxkax.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeftkxkax.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 11:29:10AM -0700, Junio C Hamano wrote:

> > So then I think your config file primarily becomes about defining the
> > properties of each run. I'm not sure if it would look like what you're
> > starting on here or not.
> 
> Yeah, I suspect that the final shape that defines the matrix might
> have to become quite a bit different.

I think it would help if the perf code was split better into three
distinct bits:

  1. A data-store capable of storing the run tuples along with their
     outcomes for each test.

  2. A "run" front-end that runs various profiles (based on config,
     command-line options, etc) and writes the results to the data
     store.

  3. A flexible viewer which can slice and dice the contents of the data
     store according to different parameters.

We're almost there now. The "run" script actually does store results,
and you can view them via "aggregate.pl" without actually re-running the
tests. But the data store only indexes on one property: the tree that
was tested (and all of the other properties are ignored totally; you can
get some quite confusing results if you do a "./run" using say git.git
as your test repo, and then a followup with "linux.git").

I have to imagine that somebody else has written such a system already
that we could reuse.  I don't know of one off-hand, but this is also not
an area where I've spent a lot of time.

We're sort of drifting off topic from Christian's patches here. But if
we did have a third-party system, I suspect the interesting work would
be setting up profiles for the "run" tool to kick off. And we might be
stuck in such a case using whatever format the tool prefers. So having a
sense of what the final solution looks like might help us know whether
it makes sense to introduce a custom config format here.

-Peff
