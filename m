Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA231F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbeALNgQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:36:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:42098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933508AbeALNgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:36:15 -0500
Received: (qmail 4425 invoked by uid 109); 12 Jan 2018 13:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:36:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30747 invoked by uid 111); 12 Jan 2018 13:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:36:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:36:14 -0500
Date:   Fri, 12 Jan 2018 08:36:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/4] run-command.c: print env vars when GIT_TRACE is
 set
Message-ID: <20180112133613.GF27499@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180112095607.18293-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 04:56:03PM +0700, Nguyễn Thái Ngọc Duy wrote:

> v3 turns a single patch into a series. Changes from v2
> 
> - env var quoting is now done correctly (from shell syntax perspective)
> - the program name is prepended in git_cmd mode
> - cwd is now printed too (because I have too, see 4/4)
> - we don't blindly print the env delta anymore but print the actual
>   differences compared to parent env
> - which means we also print "unset XXX" statements in $GIT_TRACE

Overall I like it, though I raised on corner case in 4/4.

> The new output on git.git looks like this
> 
>     trace: run_command: cd 'sha1collisiondetection'; unset GIT_PREFIX; GIT_DIR='.git' git 'status' '--porcelain=2'
> 
> a bit longer than I would like, but that's because of
> sha1collisiondetection and it's not long enough for me to invent
> $GIT_TRACE_EXEC.

IMHO the unconditional single-quotes make this longer and uglier than it
needs to be. I've often been tempted to have them kick in only when
necessary. Here are some patches to do that (on top of yours).

  [5/4]: sq_quote_argv: drop maxlen parameter
  [6/4]: trace: avoid unnecessary quoting

 builtin/am.c        |  2 +-
 builtin/rev-parse.c |  4 ++--
 quote.c             | 30 +++++++++++++++++++++++++++---
 quote.h             | 10 +++++++++-
 trace.c             | 10 +++++-----
 5 files changed, 44 insertions(+), 12 deletions(-)

-Peff
