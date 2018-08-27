Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713A31F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1Cv7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:51:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:58056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727058AbeH1Cv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:51:59 -0400
Received: (qmail 8191 invoked by uid 109); 27 Aug 2018 23:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 23:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26885 invoked by uid 111); 27 Aug 2018 23:03:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 19:03:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 19:03:14 -0400
Date:   Mon, 27 Aug 2018 19:03:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20180827230314.GB10402@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
 <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 01:37:41PM +0200, René Scharfe wrote:

> Am 14.08.2018 um 03:58 schrieb Jeff King:
> > Your suggestion can be implemented using khash (my patch below).
> > 
> >> Before:
> >> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
> >>
> >>   Time (mean ± σ):     269.5 ms ±  26.7 ms    [User: 247.7 ms, System: 21.4 ms]
> >>
> >>   Range (min … max):   240.3 ms … 339.3 ms
> >>
> >> After:
> >> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
> >>
> >>   Time (mean ± σ):     224.2 ms ±  18.2 ms    [User: 201.7 ms, System: 22.1 ms]
> >>
> >>   Range (min … max):   205.0 ms … 259.0 ms
> > 
> > Yeah. My best-of-five dropped from 300ms to 247ms. That 300 was using
> > the memory pool, though khash's deletion strategy isn't all that
> > different (the wasted memory hangs around until the next hash resize,
> > but if you're evenly dropping and adding, you likely won't need to
> > resize).
> 
> With your khash patch:
> 
> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
> 
>   Time (mean ± σ):     159.1 ms ±  20.5 ms    [User: 140.3 ms, System: 18.5 ms]
> 
>   Range (min … max):   140.0 ms … 214.0 ms
> 
> So it seems worth it.

Hmm, that really does. Which is a shame, because I hoped that one day we
could get rid of the nasty macro-infestation that is khash.h. But it
really is a lot faster than the alternatives.

> [...]

I agree with all of your comments here. What I posted was just trying to
do the least amount of work to get something we could time.

Do you want to pick up this topic and carry it forward?

-Peff
