Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365661F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 18:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdH2Sxo (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 14:53:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751186AbdH2Sxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 14:53:44 -0400
Received: (qmail 1433 invoked by uid 109); 29 Aug 2017 18:53:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 18:53:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13210 invoked by uid 111); 29 Aug 2017 18:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 14:54:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 14:53:41 -0400
Date:   Tue, 29 Aug 2017 14:53:41 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 06:51:52PM +0100, Lars Schneider wrote:

> I set $TOOL_OPTIONS in valgrind.sh: to 
> '--leak-check=full --errors-for-leak-kinds=definite'
> 
> ... but I also had to adjust t/test-lib-functions.sh:test_create_repo
> as I ran into the error "cannot run git init -- have you built things yet?".

Yeah, this is a general problem with run-time analyzers. If we're not
mostly error free than the setup code often breaks before you even get
to the interesting part of the test.

It looks like the config code has a minor-ish leak. Patch to follow.

> What if we run a few selected tests with valgrind and count all files that
> valgrind mentions (a single leak has multiple file mentions because of
> the stack trace and other leak indicators). We record these counts and let 
> TravisCI scream if one of the numbers increases.
> 
> I wonder how stable/fragile such a metric would be as a simple refactoring 
> could easily change these numbers. Below I ran valgrind on t5510 before and
> after Martin's patch. The diff below clearly shows the pkt-line leak.
> 
> Would it make sense to pursue something like this in TravisCI to avoid 
> "pkt-line" kind of leaks in the future?

I don't think that would work, because simply adding new tests would
bump the leak count, without the code actually growing worse.

But think about your strategy for a moment: what you're really trying to
do is say "these existing leaks are OK because they are too many for us
to count, but we want to make sure we don't add _new_ ones". We already
have two techniques for distinguishing old ones from new ones:

  1. Mark existing ones with valgrind suppressions so they do not warn
     at all.

  2. Fix them, so that the "existing" count drops to zero.

Option (2), of course, has the added side effect that it's actually
fixing potential problems. :)

-Peff
