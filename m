Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257B4209FA
	for <e@80x24.org>; Thu, 13 Apr 2017 16:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754764AbdDMQo4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 12:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:32979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752689AbdDMQo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 12:44:56 -0400
Received: (qmail 21209 invoked by uid 109); 13 Apr 2017 16:44:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 16:44:55 +0000
Received: (qmail 24590 invoked by uid 111); 13 Apr 2017 16:45:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 12:45:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 12:44:52 -0400
Date:   Thu, 13 Apr 2017 12:44:51 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCHv2.1] t6500: wait for detached auto gc at the end of the
 test script
Message-ID: <20170413164451.quvt7xdzsm64lntp@sigill.intra.peff.net>
References: <20170412220717.7357-1-szeder.dev@gmail.com>
 <20170413103138.12717-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170413103138.12717-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:31:38PM +0200, SZEDER Gábor wrote:

> Note, that this fd trickery doesn't work on Windows, because due to
> MSYS limitations the git process only inherits the standard fds 0, 1
> and 2 from the shell.  Luckily, it doesn't matter in this case,
> because on Windows daemonize() is basically a noop, thus 'git gc
> --auto' always runs in the foreground.
> 
> And since we can now continue the test reliably after the detached gc
> finished, check that there is only a single packfile left at the end,
> i.e. that the detached gc actually did what it was supposed to do.
> Also add a comment at the end of the test script to warn developers of
> future tests about this issue of long running detached gc processes.

The whole thing looks nicely explained, and I'm happy that we're able to
reliably add this extra check at the end of the test.

I did wonder what will happen if Windows learns to daemonize() the
auto-gc. I don't think we'll get an immediate test failure, but this
test will become racy again. But this time we'll actually notice the
racy failure, because the "ls" will report extra packs if it runs before
the background gc does. At which point we can revisit this.

It would be nice if there were a non-racy way to detect whether we
daemonized or not, and complain on Windows when we do. Then we'll be
notified immediately when daemonize() changes by the test failure,
rather than waiting for a racy failure.

I guess we could probably grep for the "in the background" message from
the parent gc. OTOH, maybe it is not even worth it. The racy version
should fail reasonably promptly, I think, and the comments you've left
would point any investigator in the right direction.

-Peff
