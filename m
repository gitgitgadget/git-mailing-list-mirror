Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F72A1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbcIIJ7x (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 05:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:40590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753705AbcIIJ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 05:59:50 -0400
Received: (qmail 31994 invoked by uid 109); 9 Sep 2016 09:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 09:59:49 +0000
Received: (qmail 22430 invoked by uid 111); 9 Sep 2016 09:59:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 05:59:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 05:59:47 -0400
Date:   Fri, 9 Sep 2016 05:59:47 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Introduce a function to run regexec() on
 non-NUL-terminated buffers
Message-ID: <20160909095946.ejwyjriomtaezef2@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <cover.1473319844.git.johannes.schindelin@gmx.de>
 <94ee698b2736929d37640012a1b1735b134dd3d6.1473319844.git.johannes.schindelin@gmx.de>
 <20160908080447.adquu2e5d7bbeorn@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609091140420.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609091140420.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 11:45:01AM +0200, Johannes Schindelin wrote:

> > I mentioned elsewhere that I'd prefer we just push people into using
> > compat/regex if they don't have REG_STARTEND. But if we _do_ keep this
> > fallback, note that the above has a buffer overflow (think what happens
> > when "size" is the maximum value for a size_t).  You can avoid it by
> > using xmallocz().
> 
> That buffer overflow does not exist: If size were the maximum value for
> size_t, then buf->ptr would point at a buffer that occupies the entire
> available memory, meaning that there is no space left for buf->ptr, let
> alone for buf.

True. I fixed quite a lot of these last summer, but they are only really
dangerous when we have not already allocated the buffer.

> But I get your point. It is better to be consistent and use the same logic
> for *all* allocations.

Yep. Also, it is easier to audit if you do not have to trace back and
see that even though we do overflow the argument to malloc, it can't
happen because of memory constraints (this one is fairly obvious, but
quite a few that I fixed previously involved complicated reasoning about
how much RAM you could use).

-Peff
