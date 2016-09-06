Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DB01F859
	for <e@80x24.org>; Tue,  6 Sep 2016 06:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbcIFG60 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 02:58:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:38629 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750721AbcIFG6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 02:58:25 -0400
Received: (qmail 12767 invoked by uid 109); 6 Sep 2016 06:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 06:58:23 +0000
Received: (qmail 24789 invoked by uid 111); 6 Sep 2016 06:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 02:58:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 02:58:21 -0400
Date:   Tue, 6 Sep 2016 02:58:21 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
Message-ID: <20160906065821.bxwitnk72rpn3xhl@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:44:57PM +0200, Johannes Schindelin wrote:

> The problem with that: mmap()ed memory is *not* NUL-terminated, yet the
> pickaxe code calls regexec() on it just the same.
> 
> This problem has been reported by my colleague Chris Sidi.
> 
> Please note that this patch series is a hot fix I applied to Git for
> Windows (the bug does not trigger a segmentation fault for me on Linux,
> strangely enough, but it is really a problem on Windows).

This has come up before, and I think somebody mentioned that on Linux,
you are OK unless the buffer ends right at a page boundary (i.e., the
buffer size is a multiple of the page size). I don't know if that's true
or not.

> So at least I have a workaround in place. Ideally, though, we would
> NUL-terminate the buffers only when needed, or somehow call regexec() on
> ptr/size parameters instead of passing a supposedly NUL-terminated
> string to it?

There's some discussion in:

  http://public-inbox.org/git/20121030121747.GA4231@sigill.intra.peff.net/#r

and the thread below it. The quickest way to fix regexec() would be to
have everybody use the built-in GNU regex in compat/. People seemed
somewhat positive on that direction, but we never followed up.

-Peff
