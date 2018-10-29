Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D431F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJ3AJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726763AbeJ3AJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:09:39 -0400
Received: (qmail 22639 invoked by uid 109); 29 Oct 2018 15:20:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 15:20:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18486 invoked by uid 111); 29 Oct 2018 15:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 11:19:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 11:20:33 -0400
Date:   Mon, 29 Oct 2018 11:20:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Jansen, Geert" <gerardu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029152032.GK17668@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 09:48:02AM +0900, Junio C Hamano wrote:

> > Of course any cache raises questions of cache invalidation, but I think
> > we've already dealt with that for this case. When we use
> > OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
> > accuracy/speed tradeoff (which does a similar caching thing with
> > packfiles).
> >
> > So putting that all together, could we have something like:
> 
> I think this conceptually is a vast improvement relative to
> ".cloning" optimization.  Obviously this does not have the huge
> downside of the other approach that turns the collision detection
> completely off.
> 
> A real question is how much performance gain, relative to ".cloning"
> thing, this approach gives us.  If it gives us 80% or more of the
> gain compared to doing no checking, I'd say we have a clear winner.

My test runs showed it improving index-pack by about 3%, versus 4% for
no collision checking at all. But there was easily 1% of noise. And much
more importantly, that was on a Linux system on ext4, where stat is
fast. I'd be much more curious to hear timing results from people on
macOS or Windows, or from Geert's original NFS case.

-Peff
