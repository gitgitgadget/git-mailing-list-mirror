Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F4D20705
	for <e@80x24.org>; Wed,  7 Sep 2016 07:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbcIGHxu (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 03:53:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:39150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756482AbcIGHxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 03:53:50 -0400
Received: (qmail 8768 invoked by uid 109); 7 Sep 2016 07:53:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 07:53:48 +0000
Received: (qmail 1051 invoked by uid 111); 7 Sep 2016 07:53:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 03:53:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 03:53:46 -0400
Date:   Wed, 7 Sep 2016 03:53:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: [RFC/PATCH 0/2] more patch-id speedups
Message-ID: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael and I found a case where the "format-patch --cherry-pick A...B"
command for a rebase took over 7 minutes to run with git v2.9.3. Yikes.

Switching to v2.10 dropped that to a bit over 3 minutes (due to the
kw/patch-ids-optim topic). Better, but not great.

The culprit turned out to be merge commits; the patch-id code will
happily diff a merge against its first parent, and ignore the rest. This
_seems_ like a bad idea, but maybe there is something clever going on
that I don't know about. I couldn't find anything useful in the history,
and given that this code was adapted from rebase, my guess is that it
was never really intended to handle merge commits in the first place (of
course we weren't trying to rebase merge commits; but it has to generate
patch-ids for everything that happened on "A" to compare against).

Dropping the computation of the merge commits got it down to about 4
seconds. I also noticed that it was doing rename detection (which also
seems like a bad idea). Disabling renames dropped another half second or
so.

This is marked as "RFC" because I don't feel entirely confident that I'm
not missing some clever need for these options. But in both cases my gut
feeling is that they are simply unintended effects that nobody ever
noticed, because it would be very rare that they would affect the
output. And that if they _did_ affect the output, they would probably be
doing the wrong thing.

-peff
