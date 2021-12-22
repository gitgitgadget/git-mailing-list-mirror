Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52242C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhLVVMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:12:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:56500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhLVVL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:11:58 -0500
Received: (qmail 18420 invoked by uid 109); 22 Dec 2021 21:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Dec 2021 21:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31367 invoked by uid 111); 22 Dec 2021 21:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Dec 2021 16:11:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Dec 2021 16:11:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer
 overflow
Message-ID: <YcOUl4lIMRy7rzK8@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
 <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
 <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2112222143080.347@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2112222143080.347@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 09:50:50PM +0100, Johannes Schindelin wrote:

> To raise the limits you would have to understand the purpose of the
> calculations so that you can understand the range their data type needs to
> handle. The weights of the Hungarian Algorithm are distinctly _not_
> pointers, therefore using `size_t` is most likely the wrong thing to do.
> 
> Of course you can glance over the details and try to avoid digging into
> the algorithm to understand what it does before changing the data types
> and introducing `st_mult()`-like functions and macros, but that only makes
> it "relatively easy", at the price of "maybe incorrect". That would be in
> line with what I unfortunately have had to come to expect of your patches.

:( Whether you're frustrated with this topic or not, can we please stick
to technical critiques? Either proposed changes are the right thing or
not, and we can talk about that.

I know it can get hard if the review is "gee, it looks like this is
going in the wrong direction, but I don't have time to dig in and tell
you _exactly_ how it is wrong right now". And I think that is an OK
thing to express, but your response here has a bit more bite to it than
I think is strictly necessary.

> The _actual_ "relatively easy" way is to imitate the limits we use in
> xdiff (for similar reasons). As I said before.

I had a similar thought at first, too. But because one of the array
sizes we compute is (nr_a + nr_b)^2, I fear the limits end up pretty low
(e.g., my 32767 by 32767 example). That's a pretty big range diff, but
it doesn't seem like an outrageous input to throw at the system
(especially if most of the entries end up finding a match and showing
one line of equality).

It may be that there are multiple limits to consider, though. E.g., the
square of the sum of the sides, as above, is one. But there may be some
benefit to making that work (by using size_t and st_add) but putting a
hard limit like 2^30 on the number of commits on one side (e.g., for
ranking scores). And that's where understanding exactly what the
algorithm is doing becomes necessary.

-Peff
