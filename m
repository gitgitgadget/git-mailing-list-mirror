Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C678C2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 06:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCCGxg (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 01:53:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:37723 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbdCCGwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 01:52:01 -0500
Received: (qmail 10330 invoked by uid 109); 3 Mar 2017 06:45:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:45:13 +0000
Received: (qmail 25298 invoked by uid 111); 3 Mar 2017 06:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 01:45:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 01:45:12 -0500
Date:   Fri, 3 Mar 2017 01:45:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t/perf: export variable used in other blocks
Message-ID: <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
 <20170302195041.1699-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302195041.1699-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 11:50:41AM -0800, Jonathan Tan wrote:

> In p0001, a variable was created in a test_expect_success block to be
> used in later test_perf blocks, but was not exported. This caused the
> variable to not appear in those blocks (this can be verified by writing
> 'test -n "$commit"' in those blocks), resulting in a slightly different
> invocation than what was intended. Export that variable.

Thanks, this is obviously the right thing to do, and the mistake is mine
from ea97002fc (t/perf: time rev-list with UNINTERESTING commits,
2014-01-20). This is not the first time I've been confused by missing
variables in t/perf scripts, since it behaves differently than the
normal test suite. I wonder if we should turn on "set -a" during t/perf
setup snippets. That's a bit of a blunt tool, but I suspect it would
just be easier to work with.

I was curious that the tests added by ea97002fc showed something useful
even with the bug you're fixing here. But it's because the actual slice
of history we meant to traverse isn't important. It's intentionally
tiny to show off the time spent dealing with the UNINTERESTING commits.
So in effect we were traversing no commits instead of a tiny set, but
the timing results were the same.

I repeated the tests over fbd4a703 given in the commit message of
ee9a7002fc and confirmed that it behaves the same with your fixed
version of the test. I did have to tweak a few other things to get the
test to run against such an old version of git, though. I'll follow-up
with a patch.

-Peff
