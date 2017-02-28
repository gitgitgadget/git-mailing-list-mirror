Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D2E202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdB1Vbb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:31:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:36033 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbdB1Vba (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:31:30 -0500
Received: (qmail 24918 invoked by uid 109); 28 Feb 2017 21:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 21:31:24 +0000
Received: (qmail 31160 invoked by uid 111); 28 Feb 2017 21:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 16:31:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 16:31:22 -0500
Date:   Tue, 28 Feb 2017 16:31:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
Message-ID: <20170228213122.kk6mrbbqer6o7rd6@sigill.intra.peff.net>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
 <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702282149160.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702282149160.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 09:54:58PM +0100, Johannes Schindelin wrote:

> > Right now, they may be able to have future timestamps ranging to
> > year 2100 and switching to time_t would limit their ability to
> > express future time to 2038 but they would be able to express
> > timestamp in the past to cover most of 20th century.  Given that
> > these 32-bit time_t software platforms will die off before year 2038
> > (either by underlying hardware getting obsolete, or software updated
> > to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
> > would not be too big a deal to warrant additional complexity.
> 
> You seem to assume that time_t is required to be signed. But from my
> understanding that is only guaranteed by POSIX, not by ISO C.

I wonder how common that is in practice, and whether it is worth
treating it as a quality-of-implementation issue. IOW, to say "your
platform time_t doesn't handle negative times, so you get Jan 1 1970 for
any dates before then. Complain to your platform vendor".

I'm not sure how much complexity it would add to the code.  Either way,
when we parse an ascii-decimal timestamp from an object, we need to do
bounds checking. Whether that bound is at "0" or "LONG_MIN", I don't
think that it changes much.

Meanwhile, if we were to have a negative timestamp_t but the system
time_t is unsigned, we have to do a bounds-check any time we use a
system function like gmtime(), or risk funny wrap-around bugs.

-Peff
