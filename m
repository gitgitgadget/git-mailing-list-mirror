Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4121FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbdIKSI1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:08:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:34674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750782AbdIKSI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:08:27 -0400
Received: (qmail 23133 invoked by uid 109); 11 Sep 2017 18:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 18:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29576 invoked by uid 111); 11 Sep 2017 18:09:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 14:09:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2017 14:08:25 -0400
Date:   Mon, 11 Sep 2017 14:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Test name-rev with small stack
Message-ID: <20170911180824.gf6jecxpx7d3d4a7@sigill.intra.peff.net>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
 <cover.1504792601.git.git@grubix.eu>
 <20170907145423.wz3iqxxz2yvxq5lm@sigill.intra.peff.net>
 <9b3275a2-7b47-9ed8-6f1f-dac999c3b46a@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b3275a2-7b47-9ed8-6f1f-dac999c3b46a@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 02:33:35PM +0200, Michael J Gruber wrote:

> Looking at it more closely, the solution in cbc60b6720 ("git tag
> --contains: avoid stack overflow", 2014-04-24) seems to be a bit "ad
> hoc" to me:
> 
> First of all, there is more than "tag --contains" that may exceed the
> stack by recursion. So I would expect the solution to be more general,
> and not localised and specialised to builtin/tag.c

At the time, tag was the only one using this depth-first contains
algorithm. It's since been adapted to ref-filter.c, but of course the
stack handling went with it.

Most traversals have a date-sorted queue, so are effectively doing a
breadth-first iteration with no recursion.

> Second, this is a walk, so I'm wondering whether our revision walk
> machinery should be the place to add missing functionality (if any).
> That way, everything would benefit from possible or existing
> improvements there. For example, I think some of our "extra walkers"
> don't heed object replacements. (I need to test more.)

It's possible that name-rev could make better use of the existing
traversal machinery. It's often tough to do so, though, because that
machinery gives you a linearized ordering of the commits. Whereas
something like name-rev really cares about the order that it visits the
commits, because it's building up the names.

It's the same for this "tag --contains" traversal. It _used_ to be a
series of merge-base computations. But by doing a custom traversal, we
can cache incremental results through the graph and avoid walking over
the same bits multiple times. There actually is a way to do it with the
regular breadth-first traversal, but you have to store one bit per ref
you're checking for each commit.

I played around with that a bit a while ago, and it did seem to work. I
can dig up the patches if you're interested. But one downside is that
one bit per ref per commit adds up if you have a lot of refs. A large
number of those bitfields will be the same, so you could probably get by
with a copy-on-write scheme, but I never implemented that.

Of course somebody may have a more clever algorithm, too. I don't claim
the above is a proof. ;)

-Peff
