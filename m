Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A62E1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 02:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcFYCxD (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 22:53:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38646 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbcFYCxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 22:53:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13DF1FE4E;
	Sat, 25 Jun 2016 02:53:00 +0000 (UTC)
Date:	Sat, 25 Jun 2016 02:53:00 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] gc: correct gc.autoPackLimit documentation
Message-ID: <20160625025300.GA29053@dcvr.yhbt.net>
References: <20160625011450.GA14293@dcvr.yhbt.net>
 <20160625020620.GA31290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160625020620.GA31290@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sat, Jun 25, 2016 at 01:14:50AM +0000, Eric Wong wrote:
> 
> > I'm not sure if this is the best approach, or if changing
> > too_many_packs can be done without causing problems for
> > hosts of big repos.
> > 
> > -------8<-----
> > Subject: [PATCH] gc: correct gc.autoPackLimit documentation
> > 
> > I want to ensure there is only one pack in my repo to take
> > advantage of pack bitmaps.  Based on my reading of the
> > documentation, I configured gc.autoPackLimit=1 which led to
> > "gc --auto" constantly trying to repack on every invocation.
> 
> I'm not sure if you might be misinterpreting earlier advice on bitmaps
> here. At the time of packing, bitmaps need for all of the objects to go
> to a single pack (they cannot handle a case where one object in the pack
> can reach another object that is not in the pack). But that is easily
> done with "git repack -adb".
> 
> After that packing, you can add new packs that do not have bitmaps, and
> the bitmaps will gracefully degrade. E.g., imagine master was at tip X
> when you repacked with bitmaps, and now somebody has pushed to make it
> tip Y.  Somebody then clones, asking for Y. The bitmap code will start
> at Y and walk backwards. When it hits X, it stops walking as it can fill
> in the rest of the reachability from there.

Ah, thanks, makes sense.  I was misinterpreting earlier advice
on bitmaps.

> That's neither here nor there for the off-by-one in gc or its
> documentation, of course, but just FYI.

I'm now inclined to fix the problem in gc and leave the
documentation as-is (unless it cause other problems...)
