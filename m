Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E71020248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCCRYb (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:24:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:36660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfCCRYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:24:31 -0500
Received: (qmail 13584 invoked by uid 109); 3 Mar 2019 17:24:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:24:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16581 invoked by uid 111); 3 Mar 2019 17:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:24:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:24:29 -0500
Date:   Sun, 3 Mar 2019 12:24:29 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190303172428.GE23811@sigill.intra.peff.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 09:25:28PM +0100, Johannes Schindelin wrote:

> > This bug has survived because there was never a test that would have
> > caught it. The old test used 'test_decode_color', which checks that its
> > input begins with a color, but stops parsing once it has parsed a single
> > color successfully. In this case, it was ignoring the trailing '\n'.
> 
> Isn't the reason rather that our test compared the output to an expected
> text *with a newline*? IOW:
> [...]
> This should do the right thing if you write
> 
> 	printf "<RED>" >expect

No, there are actually two problems that cancel each other out. Because
test_decode_color() is implemented in awk, it doesn't see if there's
actually a newline or not in each record. So it _always_ adds a newline
after printing out the line (and I don't think Taylor's explanation
above is quite right; it does have a loop to handle multiple colors).

So regardless of whether git-config is sending the newline or not, the
"actual" file will always have a newline in it.

And then to match that, we used "echo" which of course has a newline,
and matches the test_decode_color output.

So you're right that we need to switch to printf. But doing so without
dropping test_decode_color() would mean the test would always fail. We
have to printf the raw bytes, which is what the new test does.

-Peff
