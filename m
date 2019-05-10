Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5201F45F
	for <e@80x24.org>; Fri, 10 May 2019 21:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfEJVD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 17:03:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727677AbfEJVD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 17:03:27 -0400
Received: (qmail 1044 invoked by uid 109); 10 May 2019 21:03:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 May 2019 21:03:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15859 invoked by uid 111); 10 May 2019 21:04:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 May 2019 17:04:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2019 17:03:24 -0400
Date:   Fri, 10 May 2019 17:03:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I made a flame graph renderer for git's trace2 output
Message-ID: <20190510210324.GA30947@sigill.intra.peff.net>
References: <87zhnuwdkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhnuwdkp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 05:09:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As noted in TODOs in the script there's various stuff I'd like to do
> better, and this also shows how we need a lot more trace regions to get
> granular data.

Hmm. My gut reaction was: doesn't "perf record -g make test" already
give us that granular data? I know "perf" isn't available everywhere,
but the idea of the FlameGraph repo is that it takes input from a lot of
sources (though I don't know if it supports any Windows-specific formats
yet, which is presumably a point of interesting to trace-2 authors).

But having generated such a flamegraph, it's not all that helpful. It
mainly tells us that we spend a lot of time on fork/exec. Which is no
surprise, since the test suite is geared not towards heavy workloads,
but lots of tiny functionality tests.

TBH, I'm not sure that flame-graphing the test suite is going to be all
that useful in the long run. It's going to be heavily weighted by the
types of things the test suite does. Flamegraphs are good for
understanding where your time is going for a particular workload, but
the workload of the test suite is not that interesting.

And once you do have a particular workload of interest that you can
replay, then I think the granular "perf" results really can be helpful.

I think the trace2 flamegraph would be most useful if you were
collecting across a broad spectrum of workloads done by a user. You
_can_ do that with perf or similar tools, but it can be a bit awkward.
I do wonder how painful it would be to alias "git" to "perf record git"
for a day or something.

-Peff
