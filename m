Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D491F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbcIFH1M (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:27:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:38689 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933086AbcIFH1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:27:11 -0400
Received: (qmail 14679 invoked by uid 109); 6 Sep 2016 07:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 07:27:10 +0000
Received: (qmail 25383 invoked by uid 111); 6 Sep 2016 07:27:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 03:27:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 03:27:07 -0400
Date:   Tue, 6 Sep 2016 03:27:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash
 directory
Message-ID: <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net>
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 09:03:48PM +0200, Johannes Sixt wrote:

> The process spawned in the hook uses the test's trash directory as CWD.
> As long as it is alive, the directory cannot be removed on Windows.
> Although the test succeeds, the 'test_done' that follows produces an
> error message and leaves the trash directory around. Insert a delay to
> give the hook time to go away.

Ugh. I'd love it if we could avoid inserting a sleep, which wastes time
in the optimistic case and is insufficient in the pessimistic one.

The fact that the hook is already using sleep is even nastier, as it
that's a potential race on a loaded system.

Can we do some signaling with fifos to tell the hook when it is safe to
exit? Then we would just need to `wait` for its parent process.

-Peff
