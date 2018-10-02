Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3481F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJCCDz (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:03:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:38934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727403AbeJCCDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:03:55 -0400
Received: (qmail 11828 invoked by uid 109); 2 Oct 2018 19:19:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 19:19:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31174 invoked by uid 111); 2 Oct 2018 19:18:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 15:18:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 15:19:00 -0400
Date:   Tue, 2 Oct 2018 15:19:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20181002191900.GA2014@sigill.intra.peff.net>
References: <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
 <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
 <20180827230314.GB10402@sigill.intra.peff.net>
 <9e2440cc-39a6-f51b-9aee-8536020ed033@web.de>
 <20181001202605.GB10234@sigill.intra.peff.net>
 <d2421f36-563c-92ac-3fc9-29306d94b6fd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2421f36-563c-92ac-3fc9-29306d94b6fd@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 09:05:32PM +0200, René Scharfe wrote:

> > The reason hashmap.c was added was to avoid open addressing. ;)
> Because efficient removal of elements is easier to implement with
> chaining, according to 6a364ced49 (add a hashtable implementation that
> supports O(1) removal).  khash.h deletes using its flags bitmap.  We
> didn't compare their performance when entries are removed so far.

I think it may depend on your workload. Open-addressing generally uses a
tombstone, so you're still dealing with the "deleted" entries until the
next table resize. I suspect that's fine in most cases, but I also am
sure you could find a benchmark that favors the chained approach (I
think in most cases we actually never delete at all -- we simply fill up
a table and then eventually clear it).

> > So yeah, I think it could perhaps be improved, but in my mind talking
> > about "hashmap.c" is fundamentally talking about chained buckets.
> 
> Admittedly I wouldn't touch hashmap.c, as I find its interface too
> complex to wrap my head around.  But perhaps I just didn't try hard
> enough, yet.

FWIW, it's not just you. ;)

> > Yeah. And if it really does perform better, I think we should stick with
> > it in the code base. I wonder if we could stand to clean up the
> > interfaces a little.  E.g., I had a hard time declaring a hash in one
> > place, and then defining it somewhere else.
> 
> You can't use KHASH_DECLARE and KHASH_INIT together, as both declare
> the same structs.  So I guess the idea is to have a header file with
> KHASH_DECLARE and a .c file with KHASH_INIT, the latter *not* including
> the former, but both including khash.h.  I didn't actually try that,
> though.

Yeah, that seems weird. You'd want to include one from the other to make
sure that they both match.

By the way, if you do want to pursue changes, I have no problem at all
hacking up khash into something that can't be merged with its upstream.
It's nice that it's a well-used and tested library, but I'd much rather
have something that we on this project understand (and that matches our
conventions and style).

> > This is kind of a layering violation, too. You're assuming that struct
> > assignment is sufficient to make one kh struct freeable from another
> > pointer. That's probably reasonable, since you're just destroying them
> > both (e.g., some of our FLEX structs point into their own struct memory,
> > making a hidden dependency; but they obviously would not need to free
> > such a field).
> 
> Fair enough.  How about this on top?  (The khash.h part would go in
> first in a separate patch in a proper series.)

Yes, much nicer, and the khash change wasn't too painful.

-Peff
