Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854AC1FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 05:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdBJFaX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 00:30:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:52784 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdBJFaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 00:30:21 -0500
Received: (qmail 32661 invoked by uid 109); 10 Feb 2017 05:02:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 05:02:41 +0000
Received: (qmail 22887 invoked by uid 111); 10 Feb 2017 05:02:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 00:02:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 00:02:37 -0500
Date:   Fri, 10 Feb 2017 00:02:37 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
Message-ID: <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 11:27:49PM +0100, Johannes Schindelin wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Use OpenSSL's SHA-1 routines rather than builtin block-sha1 routines.
> This improves performance on SHA1 operations on Intel processors.
> 
> OpenSSL 1.0.2 has made considerable performance improvements and
> support the Intel hardware acceleration features.  See:
> https://software.intel.com/en-us/articles/improving-openssl-performance
> https://software.intel.com/en-us/articles/intel-sha-extensions
> 
> To test this I added/staged a single file in a gigantic
> repository having a 450MB index file.  The code in read-cache.c
> verifies the header SHA as it reads the index and computes a new
> header SHA as it writes out the new index.  Therefore, in this test
> the SHA code must process 900MB of data.  Testing was done on an
> Intel I7-4770 CPU @ 3.40GHz (Intel64, Family 6, Model 60) CPU.

I think this is only half the story. A heavy-sha1 workload is faster,
which is good. But one of the original reasons to prefer blk-sha1 (at
least on Linux) is that resolving libcrypto.so symbols takes a
non-trivial amount of time. I just timed it again, and it seems to be
consistently 1ms slower to run "git rev-parse --git-dir" on my machine
(from the top-level of a repo).

1ms is mostly irrelevant, but it adds up on scripted workloads that
start a lot of git processes. Whether it's a net win or not depends on
how much sha1 computation you do in your workload versus how many
processes you start.

I don't know what that means for Windows, though. My impression is that
process startup is so painfully slow there that the link time may just
be lost in the noise. It may just always be a win there. So not really
an objection to your patch, but something you may want to consider.

(Of course, it would in theory be possible to have the best of both
worlds either by static-linking openssl, or by teaching block-sha1 the
same optimizations, but both of those are obviously much more complex).

-Peff
