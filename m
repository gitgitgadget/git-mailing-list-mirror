Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C1C1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfHPSLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 14:11:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:46132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727451AbfHPSLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 14:11:05 -0400
Received: (qmail 21114 invoked by uid 109); 16 Aug 2019 18:11:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Aug 2019 18:11:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9033 invoked by uid 111); 16 Aug 2019 18:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Aug 2019 14:12:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Aug 2019 14:11:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Thursday, Aug 15)
Message-ID: <20190816181103.GA13894@sigill.intra.peff.net>
References: <6dd8797a-289d-cabb-d4c3-761b9f9d3ca0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd8797a-289d-cabb-d4c3-761b9f9d3ca0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 10:01:04PM -0400, Derrick Stolee wrote:

> Here is today's test coverage report.

Are the scripts you use to generate these available somewhere?

I think it's useful to look at uncovered code, but I often struggle to
figure out whether the parts attached to my name are relevant. In
particular, I think two changes to the report format might help:

  1. Include names alongside commit ids when listing uncovered lines. I
     know that will end up with some overly-long lines, but it makes it
     easy to grep for one's name to find relevant sections of the file
     (as opposed to finding your name at the bottom and
     cross-referencing with actual content lines).

     Seeing that an uncovered line is a BUG(), for example, makes it
     easy to know that it's not really an interesting uncovered case in
     the code.

  2. Include more context. Just taking a random example from this email:

> builtin/rebase.c
> e191cc8b 129) strbuf_addstr(&buf, strategy_opts);

We know what the uncovered line was trying to do, but more interesting
is likely the conditional that causes it to be uncovered. In this case
the surrounding code is:

          if (opts->ignore_whitespace) {
                  struct strbuf buf = STRBUF_INIT;
  
                  if (strategy_opts)
                          strbuf_addstr(&buf, strategy_opts);
  
                  strbuf_addstr(&buf, " --ignore-space-change");
                  free(strategy_opts);
                  strategy_opts = strbuf_detach(&buf, NULL);
          }

even the usual 3 lines of diff context would make it a lot quicker to
understand what's going on (it only kicks in when multiple strategy
options are used).

(As an aside, this code leaks the newly allocated buffer and leaves a
dangling pointer in opts->strategy_opts, but that's all orthogonal to
the uncovered line; I'll send a separate message to the original
author).


Anyway, I wonder if we could adjust the output of the script to make
reading it that way a bit easier.

-Peff
