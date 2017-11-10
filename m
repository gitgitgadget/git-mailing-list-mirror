Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0B71F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 10:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbdKJKUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 05:20:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:52228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751063AbdKJKUP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 05:20:15 -0500
Received: (qmail 18715 invoked by uid 109); 10 Nov 2017 10:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Nov 2017 10:20:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 709 invoked by uid 111); 10 Nov 2017 10:20:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Nov 2017 05:20:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Nov 2017 10:20:12 +0000
Date:   Fri, 10 Nov 2017 10:20:12 +0000
From:   Jeff King <peff@peff.net>
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: cherry-pick very slow on big repository
Message-ID: <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 10:39:39AM +0100, Peter Krefting wrote:

> Running strace, it seems like it is doing lstat(), open(), mmap(), close()
> and munmap() on every single file in the repository, which takes a lot of
> time.
> 
> I thought it was just updating the status, but "git status" returns
> immediately, while cherry-picking takes several minutes for every
> cherry-pick I do.

It kind of sounds like a temporary index is being refreshed that doesn't
have the proper stat information.

Can you get a backtrace? I'd do something like:

  - gdb --args git cherry-pick ...
  - 'r' to run
  - give it a few seconds to hit the CPU heavy part, then ^C
  - 'bt' to generate the backtrace

which should give a sense of which code path is leading to the slowdown
(or of course use real profiling tools, but if the slow path is taking 6
minutes, you'll be likely to stop in the middle of it ;) ).

-Peff
