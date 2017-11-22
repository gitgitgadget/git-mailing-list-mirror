Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170D220954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbdKVV1O (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:27:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:38006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752269AbdKVV1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:27:13 -0500
Received: (qmail 3103 invoked by uid 109); 22 Nov 2017 21:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 21:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4908 invoked by uid 111); 22 Nov 2017 21:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 16:27:29 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 16:27:11 -0500
Date:   Wed, 22 Nov 2017 16:27:11 -0500
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
Message-ID: <20171122212710.GB2854@sigill>
References: <20171121234336.10209-1-phil.hord@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171121234336.10209-1-phil.hord@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 03:43:36PM -0800, Phil Hord wrote:

> With many thousands of references, a simple `git rev-parse HEAD` may take
> more than a second to return because it first loads all the refs into
> memory even though it will never use them.

The overall goal of lazy-loading seems reasonable, but I'm slightly
confused: how and why does "git rev-parse HEAD" load ref decorations?

Grepping around I find that we mostly load them only when appropriate
(when the "log" family sees a decorate option, when we see %d/%D in a
pretty format, or with --simplify-by-decoration in a traversal). And
poking at "rev-parse HEAD" in gdb seems to confirm that it does not hit
that function.

I have definitely seen "rev-parse HEAD" be O(# of refs), but that is
mostly attributable to having all the refs packed (and until v2.15.0,
the packed-refs code would read the whole file into memory). I've also
seen unnecessary ref lookups due to replace refs (we load al of the
packed refs to find out that no, there's nothing in refs/replace).

-Peff
