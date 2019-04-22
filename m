Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E73A1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfDVTw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 15:52:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731317AbfDVTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 15:52:28 -0400
Received: (qmail 4217 invoked by uid 109); 22 Apr 2019 19:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 19:52:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2293 invoked by uid 111); 22 Apr 2019 19:53:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 15:53:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 15:52:26 -0400
Date:   Mon, 22 Apr 2019 15:52:26 -0400
From:   Jeff King <peff@peff.net>
To:     "REIX, Tony" <tony.reix@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git on AIX: daemon.c & t5570-git-daemon.sh
Message-ID: <20190422195226.GB22798@sigill.intra.peff.net>
References: <DB7PR02MB466360C2CBC44AE5FEC22CC586470@DB7PR02MB4663.eurprd02.prod.outlook.com>
 <DB7PR02MB46634F68900E0F81B0110AF586400@DB7PR02MB4663.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB7PR02MB46634F68900E0F81B0110AF586400@DB7PR02MB4663.eurprd02.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 09:05:49AM +0000, REIX, Tony wrote:

> When testing version 2.21.0 of git on AIX (6.1 & 7.2), I have found an
> issue with daemon.c and test t5570-git-daemon.sh : within test 4, the
> child_handler() code gets crazy and calls itself recursively till the
> process crashes. We do not have a clear idea why this issue occurs.
> Maybe that this issue also appears on other operating  systems.

Interesting. I think re-arming a signal() has been a well-understood
technique for a while, but I am not too surprised that there would be a
platform that doesn't like it. :)

So I understand this hunk:

> --- ./daemon.c.ORIGIN	2019-03-18 17:53:51 +0100
> +++ ./daemon.c	2019-03-18 18:00:16 +0100
> @@ -943,8 +943,11 @@
>  	 * Otherwise empty handler because systemcalls will get interrupted
>  	 * upon signal receipt
>  	 * SysV needs the handler to be rearmed
> +	 * AIX does NOT like sometimes (t5570-git-daemon test 4) to rearm it.
>  	 */
> +#ifndef _AIX
>  	signal(SIGCHLD, child_handler);
> +#endif
>  }

Although usually we would split this out to a Makefile knob. E.g., call
it something like AVOID_REARMING_SIGNAL_HANDLERS or something, and then
put it into config.mak.uname for AIX, so that it's turned on by default
there. And then if other platforms need the same, they just need to add
a similar Makefile line (and people can experiment by building with or
without it). See how NO_INITGROUPS is used in daemon.c for prior art.

Did you test on a daemon with this patch that when serving multiple
clients it continues to handle SIGCHLD properly after the first
instance? Specifically, we'd want to make sure that our accept()
continues to be interrupted and we run check_dead_children() promptly.

>  static int set_reuse_addr(int sockfd)
> @@ -1155,7 +1158,19 @@
>  		pfd[i].events = POLLIN;
>  	}
>  
> +#ifdef _AIX
> +	/* AIX does NOT like sometimes (t5570-git-daemon test 4) to rearm the SIGCHLD handler */
> +	struct sigaction sa;
> +
> +	bzero(&sa, sizeof(sa));
> +	sa.sa_handler = child_handler;
> +	sa.sa_flags   = 0;
> +	sigemptyset(&sa.sa_mask);
> +
> +	sigaction(SIGCHLD, &sa, NULL);
> +#else
>  	signal(SIGCHLD, child_handler);
> +#endif

This hunk I don't quite understand. This signal() should be run only
once, so does it matter if it's done via sigaction() or signal()? Does
AIX require using sigaction() without SA_RESETHAND in order to not need
the re-arming behavior?

-Peff
