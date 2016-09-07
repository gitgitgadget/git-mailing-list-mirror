Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F871F859
	for <e@80x24.org>; Wed,  7 Sep 2016 19:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756401AbcIGTAI (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:00:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753990AbcIGTAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:00:08 -0400
Received: (qmail 17869 invoked by uid 109); 7 Sep 2016 19:00:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 19:00:07 +0000
Received: (qmail 6706 invoked by uid 111); 7 Sep 2016 19:00:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 15:00:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 15:00:04 -0400
Date:   Wed, 7 Sep 2016 15:00:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
Message-ID: <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
 <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net>
 <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 11:39:57AM -0700, Junio C Hamano wrote:

> > Can we do some signaling with fifos to tell the hook when it is safe to
> > exit? Then we would just need to `wait` for its parent process.
> 
> Is fifo safe on Windows, though?

No clue. We seem to use mkfifo unconditionally in lib-daemon, but
perhaps people do not run that test on Windows. Other invocations seem
to be protected by the PIPE prerequisite. But...

> With v2 that explicitly kills, I guess we can make the sleep longer
> without slowing down in the optimistic case?

Yeah, I think the v2 one is non-racy (I thought at first we might race
with the "echo", but it should be synchronous; the hook will not exit
until we have written the pid file, and git will not exit until the hook
is done running).

I agree that the sleep could be made longer, to make the test less racy.
However, the racy failure mode is that it might pass while testing
nothing (i.e., the sleep ends anyway before the hook returns), so I
don't think it's a high priority.

-Peff
