Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0D420285
	for <e@80x24.org>; Sun, 27 Aug 2017 23:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdH0XXl (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 19:23:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:50560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751405AbdH0XXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 19:23:41 -0400
Received: (qmail 7262 invoked by uid 109); 27 Aug 2017 23:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 23:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29807 invoked by uid 111); 27 Aug 2017 23:24:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 19:24:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Aug 2017 19:23:39 -0400
Date:   Sun, 27 Aug 2017 19:23:39 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 10:04:55PM +0200, Lars Schneider wrote:

> I did run all tests under valgrind using "make valgrind" and I found
> the following files with potential issues:
> 
> cat valgrind.out | perl -nE 'say /^==.+\((.+)\:.+\)$/' | sort | uniq -c
> 7102
>    2 clone.c
>   33 common-main.c
>    6 connect.c
>   64 git.c
>    4 ls-remote.c
>  126 run-command.c
>   12 transport.c
>    7 worktree.c

I'm not sure where valgrind.out comes from. The individual
test-results/*.out files may have valgrind output, but I don't think
they usually contain leak output.

Doing "valgrind ./git-upload-pack . </dev/null >/dev/null" mentions
leaked memory but not the locations. Adding --leak-check=full shows that
most of it comes from format_packet().

And applying Martin's patch drops the "definitely lost" category down to
0 bytes (there's still 550k in "still reachable", but those are in the
"exit will free them for us" category).

> No mention of "pkt-line.c". Did you run Git with valgrind on one of 
> your repositories to find it?

I'm curious, too. I don't think the valgrind setup in our test suite is
great for finding leaks right now.

-Peff
