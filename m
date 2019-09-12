Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA2E1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 01:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfILBTx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 21:19:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728224AbfILBTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 21:19:53 -0400
Received: (qmail 27062 invoked by uid 109); 12 Sep 2019 01:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 01:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3268 invoked by uid 111); 12 Sep 2019 01:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2019 21:21:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Sep 2019 21:19:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: don't queue root trees unless
 revs->tree_objects is set
Message-ID: <20190912011952.GA23637@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912001846.GA31370@sigill.intra.peff.net>
 <20190912011137.GA23412@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912011137.GA23412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 09:11:37PM -0400, Jeff King wrote:

> Let's try it after running "git commit-graph write":
> 
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.458 s ±  0.011 s    [User: 1.199 s, System: 0.259 s]
>     Range (min … max):    1.447 s …  1.481 s    10 runs
> 
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.126 s ±  0.023 s    [User: 896.5 ms, System: 229.0 ms]
>     Range (min … max):    1.106 s …  1.181 s    10 runs
> 
> Now that's more like it. We saved over 22% of the total time. Part of
> that is because the runtime is shorter overall, but the absolute
> improvement is also much larger. What's going on?

Another thing I noticed is that rev-list line-buffers when we're writing
to /dev/null. This is actually the doing of glibc's stdio, as it
consider the character device special enough to turn off full buffering
(we also do our own manual flush after each commit).

I think it's probably a fairer test to time it that way (quite often
you'd be writing to a pipe, which would have the same behavior). But our
improvement is even better as a percentage when writing to a file:

  [before]
  Benchmark #1: git -C linux rev-list HEAD >file
  Time (mean ± σ):      1.046 s ±  0.017 s    [User: 922.7 ms, System: 104.3 ms]
  Range (min … max):    1.031 s …  1.087 s    10 runs

  [after]
  Benchmark #1: git -C linux rev-list HEAD >file
  Time (mean ± σ):     741.4 ms ±  14.1 ms    [User: 644.8 ms, System: 75.9 ms]
  Range (min … max):   721.2 ms … 766.8 ms    10 runs

That's a 29% improvement instead of 22% (and shows that write() syscalls
are wasting close to 30% of our runtime, a well).

I wonder if it would be worth teaching rev-list a --buffer option. Or
just kicking it in automatically when we're just printing single oids.
Once upon a time the single-record flushing was useful for:

  git rev-list HEAD -- <pathspec> | git diff-tree ...

to feed incremental results as soon as we have them (imagine we see one
commit which touches the pathspec, then go through 100,000 that don't).
But these days "git log" does that at all internally (and typically
outputs quite a bit more between each flush, though one could argue that
"log --oneline" might want the same behavior).

I dunno. Maybe it's not worth micro-optimizing too hard, but I was
surprised how big a difference it made.

-Peff
