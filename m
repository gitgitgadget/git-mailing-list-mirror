Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D714F1F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 09:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCVJcR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 05:32:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:38548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753171AbeCVJcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 05:32:15 -0400
Received: (qmail 5612 invoked by uid 109); 22 Mar 2018 09:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 09:32:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18078 invoked by uid 111); 22 Mar 2018 09:33:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 05:33:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 05:32:12 -0400
Date:   Thu, 22 Mar 2018 05:32:12 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180322093212.GB28907@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 04:59:19PM +0100, Duy Nguyen wrote:

> > I hate to be a wet blanket, but am I the only one who is wondering
> > whether the tradeoffs is worth it? 8% memory reduction doesn't seem
> > mind-bogglingly good,
> 
> AEvar measured RSS. If we count objects[] array alone, the saving is
> 40% (136 bytes per entry down to 80). Some is probably eaten up by
> mmap in rss.

Measuring actual heap usage with massif, I get before/after peak heaps
of 1728 and 1346MB respectively when repacking linux.git. So that's ~22%
savings overall.

Of the used heap after your patches:

 - ~40% of that is from packlist_alloc()
 - ~17% goes to "struct object"
 - ~10% for the object.c hash table to store all the "struct object"
 - ~7% goes to the delta cache
 - ~7% goes to the pack revindex (actually, there's a duplicate 7%
       there, too; I think our peak is when we're sorting the revindex
       and have to keep two copies in memory at once)
 - ~5% goes to the packlist_find() hash table
 - ~3.5% for the get_object_details() sorting list (this is only held
	 for a minute, but again, our peak comes during this sort, which
	 in turn loads the revindex)

So 27% of the total heap goes away if you switch to a separate rev-list.
Though it's mostly just going to a different process, it does help peak
because that process would have exited by the time we get to the
revindex bits.

I suspect you could get the same effect by just teaching pack-objects to
clear obj_hash and all of the allocated object structs. I think that
should be safe to do as long as we clear _all_ of the objects, so there
are no dangling pointers.

> About the 16k limit (and some other limits as well), I'm making these
> patches with the assumption that large scale deployment probably will
> go with custom builds anyway. Adjusting the limits back should be
> quite easy while we can still provide reasonable defaults for most
> people.

I think this 16k limit is the thing I _most_ dislike about the series.
If we could tweak that case such that we always made forward progress, I
think I'd be a lot less nervous. I responded elsewhere in the thread
(before seeing that both Junio and you seemed aware of the issues ;) ),
but I think it would be acceptable to have git-repack enforce the limit.

That would still mean you could get into a broken state for serving
fetches, but you could at least get out of it by running "git repack".

-Peff
