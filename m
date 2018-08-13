Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2920D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeHMWJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:09:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728763AbeHMWJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:09:03 -0400
Received: (qmail 12665 invoked by uid 109); 13 Aug 2018 19:25:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 19:25:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12947 invoked by uid 111); 13 Aug 2018 19:25:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 15:25:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 15:25:26 -0400
Date:   Mon, 13 Aug 2018 15:25:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
Message-ID: <20180813192526.GC10013@sigill.intra.peff.net>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180812081551.27927-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 10:15:48AM +0200, Nguyễn Thái Ngọc Duy wrote:

> We're going to optimize unpack_trees() a bit in the following
> patches. Let's add some tracing to measure how long it takes before
> and after. This is the baseline ("git checkout -" on webkit.git, 275k
> files on worktree)
> 
>     performance: 0.056651714 s:  read cache .git/index
>     performance: 0.183101080 s:  preload index
>     performance: 0.008584433 s:  refresh index
>     performance: 0.633767589 s:   traverse_trees
>     performance: 0.340265448 s:   check_updates
>     performance: 0.381884638 s:   cache_tree_update
>     performance: 1.401562947 s:  unpack_trees
>     performance: 0.338687914 s:  write index, changed mask = 2e
>     performance: 0.411927922 s:    traverse_trees
>     performance: 0.000023335 s:    check_updates
>     performance: 0.423697246 s:   unpack_trees
>     performance: 0.423708360 s:  diff-index
>     performance: 2.559524127 s: git command: git checkout -

Am I the only one who feels a little funny about us sprinkling these
performance probes through the code base?

On Linux, "perf" already does a great job of this without having to
modify the source, and there are tools like:

  http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html

that help make sense of the results.

I know that's not going to help on Windows, but presumably there are
hardware-counter based perf tools there, too.

I can buy the argument that it's nice to have some form of profiling
that works everywhere, even if it's lowest-common-denominator. I just
wonder if we could be investing effort into tooling around existing
solutions that will end up more powerful and flexible in the long run.

-Peff
