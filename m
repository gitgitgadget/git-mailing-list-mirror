Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73DC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A431920753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCUFA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 01:00:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:45944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725440AbgCUFA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 01:00:26 -0400
Received: (qmail 8027 invoked by uid 109); 21 Mar 2020 05:00:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Mar 2020 05:00:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14797 invoked by uid 111); 21 Mar 2020 05:10:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2020 01:10:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Mar 2020 01:00:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200321050025.GA1438317@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 09:44:23PM -0600, Taylor Blau wrote:

> In my testing environment, this improves the time to "merge" a split
> commit-graph containing all reachable commits in the kernel by
> re-writing the same commit-graph (effectively measuring the time it
> takes to check that all of those commits still exist) from:
> 
>   Attempt 1: 9.614
>   Attempt 2: 10.984
>   Attempt 3: 10.39
>   Attempt 4: 9.14
>   Attempt 5: 9.439
> 
>   real	0m9.140s
>   user	0m8.207s
>   sys	0m0.602s
> 
> to:
> 
>   Attempt 1: 9.12
>   Attempt 2: 8.904
>   Attempt 3: 9.361
>   Attempt 4: 9.288
>   Attempt 5: 9.677
> 
>   real	0m8.904s
>   user	0m8.208s
>   sys	0m0.596s
> 
> yielding a modest ~2.6% improvement in the best timings from each run,
> and ~7.4% improvement on average.

That still seems really slow to me. If we were truly eliding the load of
most of the commit objects, I'd expect an order of magnitude or so
improvement. For example, with a fully constructed commit graph in
linux.git, I get:

  $ time git -c core.commitGraph=1 rev-list HEAD | wc -l
  886922

  real	0m1.088s
  user	0m0.659s
  sys	0m1.161s

  $ time git -c core.commitGraph=0 rev-list HEAD | wc -l
  886922

  real	0m7.185s
  user	0m6.729s
  sys	0m1.882s

Obviously not the same operation, but that should give us a rough idea
that commit graph lookups are 6-7 times cheaper than loading the actual
objects. I don't remember the details of the case that originally led us
towards this patch. Can you share more of the setup you used to generate
the numbers above (which repo, but more importantly the commands to
create the initial state and then time the test).

The patch otherwise still makes sense to me, but I suspect there are
other similar optimizations nearby that we'll need to do in tandem.

-Peff
