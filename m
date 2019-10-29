Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F391F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfJ2NwW (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:52:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:32886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388804AbfJ2NwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:52:22 -0400
Received: (qmail 31670 invoked by uid 109); 29 Oct 2019 13:52:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 13:52:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9779 invoked by uid 111); 29 Oct 2019 13:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 09:55:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 09:52:21 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of
 unbuffered one
Message-ID: <20191029135221.GB2843@sigill.intra.peff.net>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
 <20191029103842.GV4348@szeder.dev>
 <nycvar.QRO.7.76.6.1910291334210.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910291334210.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 01:38:49PM +0100, Johannes Schindelin wrote:

> > > Let's avoid this predicament altogether by rendering the entire message,
> > > including the prefix and the trailing newline, into the buffer we
> > > already have (and which is still fixed size) and then write it out via
> > > `write_in_full()`.
> >
> > s/write_in_full/xwrite/ perhaps?  Both the cover letter and the patch
> > below use xwrite().
> 
> Excellent eyes! I had originally used `write_in_full()` before realizing
> that `xwrite()` would be more appropriate.

What's your reasoning there? We wouldn't expect xwrite() to ever return
with a partial write. But if it did for whatever reason, surely we'd
prefer to keep trying to print the rest of the error rather than leave
it truncated? We might see an error on the subsequent write(), but it's
worth calling it to find out, I'd think.

-Peff
