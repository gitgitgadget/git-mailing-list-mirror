Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB291F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfDVVbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 17:31:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727386AbfDVVbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 17:31:16 -0400
Received: (qmail 6871 invoked by uid 109); 22 Apr 2019 21:31:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 21:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3121 invoked by uid 111); 22 Apr 2019 21:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 17:31:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 17:31:14 -0400
Date:   Mon, 22 Apr 2019 17:31:14 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v4] clone: do faster object check for partial clones
Message-ID: <20190422213113.GB4728@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <b4a285e2a199ea059c165aa344d037374797fa40.1555707373.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4a285e2a199ea059c165aa344d037374797fa40.1555707373.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 02:00:13PM -0700, Josh Steadmon wrote:

> For partial clones, doing a full connectivity check is wasteful; we skip
> promisor objects (which, for a partial clone, is all known objects), and
> enumerating them all to exclude them from the connectivity check can
> take a significant amount of time on large repos.
> 
> At most, we want to make sure that we get the objects referred to by any
> wanted refs. For partial clones, just check that these objects were
> transferred.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> This is an update of the original V1 approach (skipping the fully
> connectivity check when doing a partial clone) with updated commit
> message and comments to address the review concerns.

This looks OK to me. Just trying to think of ways it could bite us, the
obvious line of thinking is where "--reference" is used. If we tell the
other side we already have object X, it will not be sent to us, and we
are relying on our local non-promisor alternate to have all of the
required objects. But I think this is OK:

  - for it to be mentioned in a ref, then the server must have been
    advertising it. Which means that it should similarly be on the hook
    for providing it to us via the promisor mechanism. That's a little
    hand-wavy, but then so is the entire promisor concept. We're
    inherently at the server's mercy, so if they're lying to us about
    what they're willing or able to provide, there's not much we can do
    anyway.

  - if we sent it as a "have" to the server, that means that our
    alternate was advertising it from a ref tip. Which means that unless
    it's corrupted, we're fine (which is no different than the
    connectivity promise we'd make for our own refs). I actually think
    that the connectivity check should "--not" any advertised alternate
    tips. I even have a patch to do that, but I need to polish it a
    little.

So I think this optimization will yield correct results. If we later
figure out a better way for rev-list to optimize this case itself, then
we can rip this out.

I think you had dug up some numbers to put in the commit message after
the last discussion? Likewise, is there a t/perf test which shows this
off (and will help us catch regressions)? If not, it might be worth
adding one (AFAICT a simple no-blobs partial-clone would be enough).

-Peff
