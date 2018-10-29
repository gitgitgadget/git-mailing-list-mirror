Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8116A1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 22:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJ3HSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 03:18:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727696AbeJ3HSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 03:18:25 -0400
Received: (qmail 6240 invoked by uid 109); 29 Oct 2018 22:27:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 22:27:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24375 invoked by uid 111); 29 Oct 2018 22:26:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 18:26:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 18:27:42 -0400
Date:   Mon, 29 Oct 2018 18:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029222742.GB24557@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
 <20181029213453.GA8325@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029213453.GA8325@amazon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 09:34:53PM +0000, Geert Jansen wrote:

> As an example, this means that when you're recieving a pack file with 1K
> objects in a repository with 10K loose objects that the loose-object-cache
> patch has roughly the same performance as the current git. I'm not sure if this
> is something to worry about as I'm not sure people run repos with this many
> loose files. If it is a concern, there could be a flag to turn the loose object
> cache on/off.

So yeah, that's the other thing I'm thinking about regarding having a
maximum loose cache size.

10k objects is only 200KB in memory. That's basically nothing. At some
point you run into pathological cases, like having a million objects
(but that's still only 20MB, much less than we devote to other caches,
though of course they do add up).

If you have a million loose objects, I strongly suspect you're going to
run into other problems (like space, since you're not getting any
deltas).

The one thing that gives me pause is that if you have a bunch of unused
and unreachable loose objects on disk, most operations won't actually
look at them at all. The majority of operations are only looking for
objects we expect to be present (e.g., resolving a ref, walking a tree)
and are fulfilled by checking the pack indices first.

So it's possible that Git is _tolerable_ for most operations with a
million loose objects, and we could make it slightly worse by loading
the cache. But I find it hard to get too worked up about spending an
extra 20MB (and the time to readdir() it in) in that case. It seems like
about 400ms on my machine, and the correct next step is almost always
going to be "pack" or "prune" anyway.

-Peff
