Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513291F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeKLXGD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:06:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:35496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726717AbeKLXGC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:06:02 -0500
Received: (qmail 25668 invoked by uid 109); 12 Nov 2018 13:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 13:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10494 invoked by uid 111); 12 Nov 2018 13:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 08:12:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 08:12:47 -0500
Date:   Mon, 12 Nov 2018 08:12:47 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
Message-ID: <20181112131247.GL3956@sigill.intra.peff.net>
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
 <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
 <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 01:03:25PM +0100, Johannes Schindelin wrote:

> > oi.disk_size is off_t; do we know "long long" 
> > 
> >    (1) is available widely enough (I think it is from c99)?
> > 
> >    (2) is sufficiently wide so that we can safely cast off_t to?
> > 
> >    (3) will stay to be sufficiently wide as machines get larger
> >        together with standard types like off_t in the future?
> > 
> > I'd rather use intmax_t (as off_t is a signed integral type) so that
> > we do not have to worry about these questions in the first place.
> 
> You mean something like
> 
> 			v->s = xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_size);

I think elsewhere we simply use PRIuMAX for printing large sizes via
off_t; we know this value isn't going to be negative.

I'm not opposed to PRIdMAX, which _is_ more accurate, but...

> P.S.: I wondered whether we have precedent for PRIdMAX, as we used to use
> only PRIuMAX, but yes: JeffH's json-writer uses PRIdMAX.

That's pretty recent. I won't be surprised if we have to do some
preprocessor trickery to handle that at some point. We have a PRIuMAX
fallback already. That comes from c4001d92be (Use off_t when we really
mean a file offset., 2007-03-06), but it's not clear to me if that was
motivated by a real platform or an over-abundance of caution.

I'm OK with just using PRIdMAX as appropriate for now. It will serve as
a weather-balloon, and we can #define our way out of it later if need
be.

-Peff
