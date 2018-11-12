Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEFF1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeKMA2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:28:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:35616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727185AbeKMA2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:28:03 -0500
Received: (qmail 28727 invoked by uid 109); 12 Nov 2018 14:34:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:34:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11074 invoked by uid 111); 12 Nov 2018 14:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:33:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:34:30 -0500
Date:   Mon, 12 Nov 2018 09:34:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, gerardu@amazon.com,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181112143429.GB9913@sigill.intra.peff.net>
References: <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <87d0re5pt3.fsf@evledraar.booking.com>
 <CACsJy8BvD6eSaxu1KyXawMcBCQGMQ5DywQpsycTTjKusioZZuQ@mail.gmail.com>
 <87a7mh58r0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7mh58r0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 03:04:35PM +0100, Ævar Arnfjörð Bjarmason wrote:

> d) As shown in the linked E-Mails of mine you sometimes pay a 2-3 second
>    *fixed* cost even for a very small (think ~100-200 objects) push/fetch
>    that would otherwise take milliseconds with Jeff's version of this
>    optimization (and not with mine). This can be a hundred/thousands of
>    percent slowdown.
> 
>    Is that a big deal in itself in terms of absolute time spent? No. But
>    I'm also thinking about this from the perspective of getting noise
>    out of performance metrics. Some of this slowdown is also "user
>    waiting for the terminal to be usable again" not just some machine
>    somewhere wasting its own time.

IMHO the ultimate end-game in this direction is still "don't have a
bunch of loose objects".

Right now this can legitimately happen due to unreachable-but-recent
objects being exploded out (or never packed in the first place). But I
hope in the long run that we'll actually put these into packs. That will
make this case faster _and_ avoid extra work during gc _and_ fix the
"whoops, we just ran gc but you still have a lot of objects" problem.

Which doesn't invalidate your other four points, of course. ;)

-Peff
