Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDFCB1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKTUNG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:13:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:45454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726365AbeKTUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:13:06 -0500
Received: (qmail 21228 invoked by uid 109); 20 Nov 2018 09:44:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 09:44:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26990 invoked by uid 111); 20 Nov 2018 09:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 04:44:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 04:44:51 -0500
Date:   Tue, 20 Nov 2018 04:44:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/3] delta-island fixes
Message-ID: <20181120094451.GA21725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few bugs in the cc/delta-islands topic: one major, and two
minor.

Sadly, the major one was not caught by our test suite, and I'm not sure
how to remedy that. The problem is a memory management one, and happens
only when you have a reasonably large number of objects. So it triggers
readily when run on a real repository, but not on the toy one in t5320.
Creating a much larger repository there would make the test suite more
expensive.

In cases like this I think it's often a good idea to have a perf test.
Those are expensive anyway, and we'd have the double benefit of
exercising the code and showing off the performance improvement. But the
delta-island code only makes sense on a very specialized repo: one where
you have multiple related but diverging histories.  You could simulate
that by picking two branches in a repository, but the effect is going to
be miniscule.

Anyway, here are the fixes without tests. We should at least apply these
before v2.20 ships with the bugs.

  [1/3]: pack-objects: fix tree_depth and layer invariants
  [2/3]: pack-objects: zero-initialize tree_depth/layer arrays
  [3/3]: pack-objects: fix off-by-one in delta-island tree-depth computation

 builtin/pack-objects.c | 4 +++-
 git-compat-util.h      | 1 +
 pack-objects.h         | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

