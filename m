Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911A11F453
	for <e@80x24.org>; Mon, 29 Oct 2018 21:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJ3GlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 02:41:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727427AbeJ3GlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 02:41:25 -0400
Received: (qmail 4879 invoked by uid 109); 29 Oct 2018 21:50:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 21:50:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24041 invoked by uid 111); 29 Oct 2018 21:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 17:50:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 17:50:50 -0400
Date:   Mon, 29 Oct 2018 17:50:50 -0400
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029215049.GA24557@sigill.intra.peff.net>
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

> On Mon, Oct 29, 2018 at 09:48:02AM +0900, Junio C Hamano wrote:
> 
> > A real question is how much performance gain, relative to ".cloning"
> > thing, this approach gives us.  If it gives us 80% or more of the
> > gain compared to doing no checking, I'd say we have a clear winner.
> 
> I've tested Jeff's loose-object-cache patch and the performance is within error
> bounds of my .cloning patch. A git clone of the same repo as in my initial
> tests:
> 
>   .cloning -> 10m04
>   loose-object-cache -> 9m59
> 
> Jeff's patch does a little more work (256 readdir() calls, which in case of an
> empty repo translate into 256 LOOKUP calls that return NFS4ERR_NOENT) but that
> appears to be insignificant.

Yep, that makes sense. Thanks for timing it.

> I believe the loose-object-cache approach would have a performance regression
> when you're receiving a small pack file and there's many loose objects in the
> repo. Basically you're trading off
> 
>     MIN(256, num_objects_in_pack / dentries_per_readdir) * readdir_latency
>     
> against
> 
>     num_loose_objects * stat_latency

Should num_loose_objects and num_objects_in_pack be swapped here? Just
making sure I understand what you're saying.

The patch I showed just blindly reads each of the 256 object
subdirectories. I think if we pursue this (and it seems like everybody
is on board), we should cache each of those individually. So a single
object would incur at most one opendir/readdir (and subsequent objects
may, too, or they may hit that cache if they share the first byte).

So the 256 in your MIN() is potentially much smaller. We still have to
deal with the fact that if you have a large number of loose objects,
they may be split cross multiple readdir (or getdents) calls. The "cache
maximum" we discussed does bound that, but in some ways that's worse:
you waste time doing the bounded amount of readdir and then don't even
get the benefit of the cache. ;)

> On Amazon EFS (and I expect on other NFS server implementations too) it is more
> efficient to do readdir() on a large directory than to stat() each of the
> individual files in the same directory. I don't have exact numbers but based on
> a very rough calculation the difference is roughly 10x for large directories
> under normal circumstances.

I'd expect readdir() to be much faster than stat() in general (e.g., "ls
-f" versus "ls -l" is faster even on a warm cache; there's more
formatting going on in the latter, but I think a lot of it is the effort
to stat).

-Peff
