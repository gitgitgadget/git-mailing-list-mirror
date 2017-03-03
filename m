Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02EF82013E
	for <e@80x24.org>; Fri,  3 Mar 2017 05:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdCCFO4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 00:14:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:37664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdCCFOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 00:14:54 -0500
Received: (qmail 3241 invoked by uid 109); 3 Mar 2017 05:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:14:54 +0000
Received: (qmail 24809 invoked by uid 111); 3 Mar 2017 05:15:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 00:15:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 00:14:52 -0500
Date:   Fri, 3 Mar 2017 00:14:52 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/9] Fix the early config
Message-ID: <20170303051451.elzz2kzumft2iugg@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:03:56AM +0100, Johannes Schindelin wrote:

> These patches are an attempt to make Git's startup sequence a bit less
> surprising.
> 
> The idea here is to discover the .git/ directory gently (i.e. without
> changing the current working directory, or global variables), and to use
> it to read the .git/config file early, before we actually called
> setup_git_directory() (if we ever do that).

Thanks for working on this. I think it's a huge improvement over the
status quo, and over the earlier attempt. I don't see anything hugely
wrong with this series, though I did note one bug, along with some minor
refinements.

> My dirty little secret is that I actually need this for something else
> entirely. I need to patch an internal version of Git to gather
> statistics, and to that end I need to read the config before and after
> running every Git command. Hence the need for a gentle, and correct
> early config.

We do something similar at GitHub, but it falls into two categories:

  - stat-gathering that's on all the time, so doesn't need to look at
    config (I'm not sure in your case if you want to trigger the
    gathering with config, or if config is just one of the things you
    are gathering).

  - logging that is turned on selectively for some repos, but which
    doesn't have to be looked up until we know we are in a repo

I looked into making something upstream-able, and my approach was to
allow GIT_TRACE_* variables to be specified in the config. But of course
that ran into the early-config problem (and I really wanted repo-level
config there, because I'd like to be able to turn on tracing for just a
single problematic repo).

So not really something you need to work on, but maybe food for thought
as you work on your internal project.

-Peff
