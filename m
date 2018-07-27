Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7746F1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 13:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeG0Of2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:35:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:32824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730766AbeG0Of2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:35:28 -0400
Received: (qmail 26722 invoked by uid 109); 27 Jul 2018 13:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 13:13:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26122 invoked by uid 111); 27 Jul 2018 13:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 09:13:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 09:13:34 -0400
Date:   Fri, 27 Jul 2018 09:13:34 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
Message-ID: <20180727131333.GC18599@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org>
 <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
 <20180724095843.GB3578@sigill.intra.peff.net>
 <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 10:20:05AM -0700, Stefan Beller wrote:

> So in my understanding we have a "common base pack" and specific
> packs on top for each "island".

Sort of. This is another hacky part. The islands themselves are
generally just about forbidding deltas, and not any particular kind of
layering.

But there's some magic layering only for the "core" island, which gets
to go first (and makes a sort of pseudo-pack at the front of the one
pack). And then everything else is written willy nilly. This is a hack
to try to make the "blit the pack bytes out" code path for cloning fast.
And that has to pick _one_ winner, so ideally you'd point it at the
thing that gets cloned the most, and everybody else gets to be a loser.

Again, this was designed for the current pack-reuse code we have
upstream, which we (GitHub) found to be pretty crappy (which I feel
justified in saying as one of the authors). I need to clean up and share
the alternative strategy we ended up with.

> Do you envision to have "groups of islands" (an atoll) for say all
> open source clones of linux.git, such that you can layer the packs?
> You would not just have the base pack + island pack, but have one
> pack that is common to most islands?

So no, we don't really layer in any sane way. If pack-objects were fed
the topological relationships between the forks, in theory we could
create a layered packfile that respects that.

But even that is not quite enough. At the time of forking, you might
imagine that torvalds/linux has the base pack, and then somebody forks
from them and contains all of those objects plus more, and somebody
forks from them, and so on. But that's just a snapshot. Later
torvalds/linux will get a bunch of new objects pushed to it. And some of
its forks will merge those objects, too. But some of them will just rot,
abandoned, as nobody ever touches them again.

So I don't think there's much to be gained by paying attention to the
external forking relationships. We have to discover afresh the
relationships between objects, and which refs (and thus which islands)
point to them.

One thing I don't think we ever tried was doubling down on the
islandCore concept and making the "root" fork as tightly packed as it
could be (with the assumption that _most_ people grab that). And then
just respect the islands for all the other objects (remember this is an
optimization, so the worst case is somebody asks for an object during a
fetch and we have to throw away its on-disk delta).

That would solve the problem that fetching torvalds/linux from GitHub
yields a bigger pack than fetching it from kernel.org. But again, it's
making that root fork weirdly magical. People who fetch solely from
other forks won't get any benefit (and may even see worse packs).

-Peff
