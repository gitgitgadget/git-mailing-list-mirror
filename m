Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36706C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F56D20702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHURvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:51:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgHURvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:51:54 -0400
Received: (qmail 18975 invoked by uid 109); 21 Aug 2020 17:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:51:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30070 invoked by uid 111); 21 Aug 2020 17:51:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:51:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:51:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] index-pack threading defaults
Message-ID: <20200821175153.GA3263018@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I decided to revisit index-pack's hard-coded default of 3 threads. And
it turns out that higher numbers perform much better. :)

That value was determined experimentally in 2012. I'm not sure of the
exact reason it's different now (modern processors are better at
parallelism, or modern git is better at parallelism, or the original
experiment was just a fluke). But regardless, I can get on the order of
a two-to-one speedup by bumping the thread count. See the final patch
for timings and more specific discussion.

The first two patches are just perf-test improvements (actually, the
slowness to value ratio of p5302 from the first patch is why I was
looking at this at all).

  [1/3]: p5302: disable thread-count parameter tests by default
  [2/3]: p5302: count up to online-cpus for thread tests
  [3/3]: index-pack: adjust default threading cap

 builtin/index-pack.c       | 19 ++++++++++++---
 t/perf/README              |  9 ++++++++
 t/perf/p5302-pack-index.sh | 47 +++++++++++++++++++-------------------
 t/perf/perf-lib.sh         |  2 ++
 4 files changed, 51 insertions(+), 26 deletions(-)

-Peff
