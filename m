Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.6 required=3.0 tests=AWL,BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7BC1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 02:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcFYCGY (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 22:06:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:60329 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbcFYCGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 22:06:23 -0400
Received: (qmail 23760 invoked by uid 102); 25 Jun 2016 02:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 22:06:23 -0400
Received: (qmail 25585 invoked by uid 107); 25 Jun 2016 02:06:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 22:06:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 22:06:20 -0400
Date:	Fri, 24 Jun 2016 22:06:20 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] gc: correct gc.autoPackLimit documentation
Message-ID: <20160625020620.GA31290@sigill.intra.peff.net>
References: <20160625011450.GA14293@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160625011450.GA14293@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 01:14:50AM +0000, Eric Wong wrote:

> I'm not sure if this is the best approach, or if changing
> too_many_packs can be done without causing problems for
> hosts of big repos.
> 
> -------8<-----
> Subject: [PATCH] gc: correct gc.autoPackLimit documentation
> 
> I want to ensure there is only one pack in my repo to take
> advantage of pack bitmaps.  Based on my reading of the
> documentation, I configured gc.autoPackLimit=1 which led to
> "gc --auto" constantly trying to repack on every invocation.

I'm not sure if you might be misinterpreting earlier advice on bitmaps
here. At the time of packing, bitmaps need for all of the objects to go
to a single pack (they cannot handle a case where one object in the pack
can reach another object that is not in the pack). But that is easily
done with "git repack -adb".

After that packing, you can add new packs that do not have bitmaps, and
the bitmaps will gracefully degrade. E.g., imagine master was at tip X
when you repacked with bitmaps, and now somebody has pushed to make it
tip Y.  Somebody then clones, asking for Y. The bitmap code will start
at Y and walk backwards. When it hits X, it stops walking as it can fill
in the rest of the reachability from there.

So you do have to walk X..Y the old-fashioned way, but that's generally
not a big problem for a few pushes.

IOW, I think trying to repack on every single push is probably overkill.
Yes, it will buy you a little savings on fetch requests, but whether it
is worthwhile to pack depends on:

 - how big the push was (e.g., 2 commits versus thousands; the bigger
   it is, the more you save per fetch

 - how big the repo is (the bigger it is, the more it costs to do the
   repack; packing is linear-ish effort in the number of objects in the
   repo)

 - how often you get fetches versus pushes (your cost is amortized
   across all the fetches)

There are numbers where it can be worth it to pack really aggressively,
but I doubt it's common. At GitHub we use a combination of number of
packs (and we try to keep it under 50) and size of objects not in the
"main" pack (I did a bunch of fancy logging and analysis of object
counts, bytes in packs, etc, at one point, and we basically realized
that for the common cases, all of the interesting metrics are roughly
proportional to the number of bytes that could be moved into the main
pack).

That's neither here nor there for the off-by-one in gc or its
documentation, of course, but just FYI.

-Peff
