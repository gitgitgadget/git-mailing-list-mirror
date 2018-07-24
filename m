Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AA21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbeGXLWO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:22:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:57254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388260AbeGXLWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:22:14 -0400
Received: (qmail 9565 invoked by uid 109); 24 Jul 2018 10:16:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:16:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25970 invoked by uid 111); 24 Jul 2018 10:16:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:16:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:16:28 -0400
Date:   Tue, 24 Jul 2018 06:16:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] Add delta islands support
Message-ID: <20180724101627.GC3578@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180722054836.28935-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 07:48:31AM +0200, Christian Couder wrote:

> I kept Peff as the author and took the liberty to add his
> Signed-off-by to all the patches.

Yes, that's fine. This is a topic I've been meaning to upstream for a
long time, so I'm happy to see it progressing in that direction.

A few reasons I've been hesitant:

 - this produces worse packs for people cloning. The packs we serve at
   GitHub for heavily-forked repositories can be significantly larger
   than what you could get by repacking in isolation.

   I think this is inherent in the scheme (we're losing some delta
   opportunities). But I think it's also made worse because the delta
   window gets clogged with candidates that are forbidden by the island
   config. Repacking with a big --window helps (and doesn't take as long
   as it otherwise might because we can reject some object pairs based
   on islands before doing any computation on the content).

   I also haven't done much modeling on how this scheme progresses over
   time. Imagine users tend to create forks at random points in time and
   then let them get stale. You're going to accumulate a bunch of
   islands that increasingly don't overlap with each other. And as time
   goes on, your delta opportunities get worse and worse.

   Which isn't to say the scheme doesn't work to some degree. It has
   been running in production at GitHub for several years. But it's very
   cobbled together, and I had always hoped to give it some more careful
   thought before sending it upstream. ;) That may be "the perfect is
   the enemy of the good" though (or at least the enemy of the
   mediocre).

 - the whole regex island-naming configuration feels complicated and
   hacky to me. I haven't been able to come up with a better solution,
   though.

 - the whole islandCore thing is it's own weirdness (more below)

> The patches look good to me except perhaps that "pack.islandCore" is
> not documented. Maybe something could be added in
> Documentation/technical/ too, or maybe improving commit messages could
> be enough.

So basically what islandCore does is make one island "special", and we
write all of its objects out first in the packfile. The idea here was
that it would interact well with the pack-reuse code which tries to send
the early part of the pack out verbatim. And if you could pick the fork
which is most-often cloned, then that would be a win (so you'd pick
torvalds/linux.git here).

But:

 - the pack-reuse code we have upstream is crap; it doesn't kick in for
   this instance anyway, because it's too concerned with whether you're
   sending all of the pack. So if you have a 10GB pack and the "core"
   island is the entire first 1GB, you should be able to ship out that
   first GB easily. But the code says "well, that's only 10%!", which is
   not enough to trigger.

   I have replacement code (which we have been running in production)
   that is more clever about the threshold, and also can handle gaps in
   the continuity (so we might realize we need to send objects 1-5000,
   then skip a few, then 5037-8000, and so on). And after that, it's not
   at all clear to me if the islandCore thing is actually still helpful.

 - it's hard to configure, because it may actually change over time
   (whereas all the other island config is basically static and just impacts
   how we consider the refs that are there)

 - there may actually be _multiple_ forks that are "special". In
   torvalds/linux, for example, there's a fair bit of hierarchy, and
   there are people who forked Linus and have their own active
   sub-community. The actual island concept handles this kind of
   layering OK, but the islandCore thing is pretty static.

So I'm not sure if islandCore is even needed or not. But somebody would
have to do some experiments to figure it out (and obviously I should
share the replacement pack-reuse patches).

-Peff
