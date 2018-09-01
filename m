Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9AB1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 08:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeIAMOY (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 08:14:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:36154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726435AbeIAMOY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 08:14:24 -0400
Received: (qmail 24946 invoked by uid 109); 1 Sep 2018 08:03:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 08:03:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11656 invoked by uid 111); 1 Sep 2018 08:03:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 04:03:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 04:03:16 -0400
Date:   Sat, 1 Sep 2018 04:03:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
Message-ID: <20180901080316.GA25852@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
 <20180901074813.GB25461@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901074813.GB25461@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 01, 2018 at 03:48:13AM -0400, Jeff King wrote:

> Commit 6a1e32d532 (pack-objects: reuse on-disk deltas for
> thin "have" objects, 2018-08-21) taught pack-objects a new
> optimization trick. Since this wasn't meant to change
> user-visible behavior, but only produce smaller packs more
> quickly, testing focused on t/perf/p5311.
> 
> However, since people don't run perf tests very often, we
> should make sure that the feature is exercised in the
> regular test suite. This patch does so.

This, by the way, is the crux of how such an obvious and severe bug made
it to 'next'.

The original series was tested quite extensively via t/perf and in
production at GitHub. When I re-rolled v2, the only change was the
addition of the assertion, so I didn't bother re-doing the perf tests,
since they're slow and there wouldn't be a measurable impact.

I did run the normal test suite (as I'm sure Junio did, too) as a
double-check for correctness, but as we noticed, the code wasn't
actually exercised there.

Nor had I yet backported the revised series to the version we run at
GitHub, so it hadn't been run there, either.

And all of that coupled with the fact that it only triggers with
bitmaps, so day-to-day use of the buggy Git (like Junio trying to push
out the result ;) ) wouldn't show it.

Anyway. Not that exciting, and kind of obviously dumb in retrospect. But
I think it was worth analyzing to see what went wrong. If there's an
immediate lesson, it is probably: add tests even for changes that aren't
really user-visible to make sure the code is exercised.

There may be a larger lesson about tracking code coverage, but I don't
know that most general code coverage tools would have helped (any
overall percentage number would be too large to move). A tool that
looked at the diff and said "of the N lines you added/touched, this
percent is exercised in the test suite" might have been useful.

-Peff
