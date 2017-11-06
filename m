Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F247E202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdKFLFw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:05:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:47482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751457AbdKFLFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:05:52 -0500
Received: (qmail 20811 invoked by uid 109); 6 Nov 2017 11:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 11:05:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19809 invoked by uid 111); 6 Nov 2017 11:06:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 06:06:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Nov 2017 06:05:50 -0500
Date:   Mon, 6 Nov 2017 06:05:50 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] builtin/merge-base: UNLEAK commit lists
Message-ID: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
 <cover.1509908607.git.martin.agren@gmail.com>
 <b06f593d3f8b0ad53754eeb394f77e7c3ee916bd.1509908607.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b06f593d3f8b0ad53754eeb394f77e7c3ee916bd.1509908607.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 05, 2017 at 09:26:30PM +0100, Martin Ågren wrote:

> In several functions, we iterate through a commit list by assigning
> `result = result->next`. As a consequence, we lose the original pointer
> and eventually leak the list.
> 
> These are immediate helpers to `cmd_merge_base()` which is just about to
> return, so we can use UNLEAK. For example, we could `UNLEAK(result)`
> before we start iterating. That would be a one-liner change per
> function. Instead, leave the lists alone and iterate using a dedicated
> pointer. Then UNLEAK immediately before returning.
> 
> After this change, it is clearer that the leaks happen as we return, and
> not as we process the list. That is, we could just as well have used
> `free_commit_list()`. Also, leaving a "result" unchanged as we display
> it feels (marginally) better.

I think it would be OK to show that we are consuming the list as we go,
like:

  while ((commit = pop_commit(&result))
	...do the thing ...

but like you I think I prefer the read-only iteration followed by a
separate deallocation/leak phase.

Like Junio, though, I kind of wonder if just calling free_commit_list()
would be the most readable thing.

The "other" benefit of UNLEAK() is that it has zero runtime cost. I'm
not sure if that matters much here, so I'd tend to choose the thing that
is most readable / understandable. These aren't cmd_* functions, so it's
not _immediately_ obvious that it is OK for them to leak. But it's also
pretty easy to see that they are called as the final element of
cmd_merge_base(). So I'm on the fence as far as this being a good use of
UNLEAK() or not.

-Peff
