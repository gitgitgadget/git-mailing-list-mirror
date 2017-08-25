Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A1D208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 15:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbdHYPIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 11:08:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933333AbdHYPIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 11:08:23 -0400
Received: (qmail 25734 invoked by uid 109); 25 Aug 2017 15:08:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 15:08:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18978 invoked by uid 111); 25 Aug 2017 15:08:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 11:08:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 08:08:20 -0700
Date:   Fri, 25 Aug 2017 08:08:20 -0700
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cat-file timing window on Cygwin
Message-ID: <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
References: <20170825112529.GA10378@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825112529.GA10378@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 12:25:29PM +0100, Adam Dinwoodie wrote:

> As of v2.10.0-rc1-4-g321459439 ("cat-file: support --textconv/--filters
> in batch mode"), t8010-cat-file-filters.sh has been failing on Cygwin.
> Digging into this, the test looks to expose a timing window: it appears
> that if `git cat-file --textconv --batch` receives input on stdin too
> quickly, it fails to parse some of that input.

Hmm. That commit doesn't seem to actually touch the stdin loop. That
happens via strbuf_getline(), which should be pretty robust to timing.
But here are a few random thoughts:

  1. Do you build with HAVE_GETDELIM? Does toggling it have any effect?

  2. Does the problem happen only with --textconv?

     If so, I wonder if spawning the child process is somehow draining
     stdin. I don't see how the child would accidentally read from our
     stdin; we replace its stdin with a pipe so it shouldn't get a
     chance to see our descriptor at all.

     If we accidentally called fflush(stdin) that would discard buffered
     input and give the results you're seeing. We don't do that
     directly, of course, but we do call fflush(NULL) in run-command
     before spawning the child. That _should_ just flush output handles,
     but it's possible that there's a cygwin bug, I guess.

I can't reproduce here on Linux. But does the patch below have any
impact?

diff --git a/run-command.c b/run-command.c
index 98621faca8..064ebd1995 100644
--- a/run-command.c
+++ b/run-command.c
@@ -641,7 +641,6 @@ int start_command(struct child_process *cmd)
 	}
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
-	fflush(NULL);
 
 #ifndef GIT_WINDOWS_NATIVE
 {

-Peff
