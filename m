Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B798D1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfJ2Ocr (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:32:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:32964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388871AbfJ2Ocr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:32:47 -0400
Received: (qmail 31928 invoked by uid 109); 29 Oct 2019 14:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 14:32:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10156 invoked by uid 111); 29 Oct 2019 14:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 10:35:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 10:32:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of
 unbuffered one
Message-ID: <20191029143246.GA3683@sigill.intra.peff.net>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
 <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
 <20191029134932.GA2843@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910291510330.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910291510330.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 03:13:39PM +0100, Johannes Schindelin wrote:

> > I'd recommend xsnprintf() here. If we have a prefix longer than our
> > vreportf() buffer, I think a BUG() is the right outcome.
> 
> But BUG_fl() calls vreportf(). I am worried about an infinite
> recursion...

Good point. I think it would be OK in practice (BUG() gives its own
length-limited prefix), but it's probably a good idea to err on the side
of caution inside vreportf.

> > I'd disagree here. Any caller sending an arbitrarily-large prefix is
> > holding it wrong, and we'd probably want to know as soon as possible
> > (and a BUG() is our best bet there).
> 
> How about truncating already inside the prefix, then? It would miss the
> entire error message... but at least it would print _something_...

Yeah, that might be OK. Hopefully missing the whole rest of the error
message would cause some tests to fail.

You could also abort() after having written if we want to be more
BUG()-like.

-Peff
