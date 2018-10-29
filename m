Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBF71F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJ2XCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:02:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:58926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725977AbeJ2XCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:02:54 -0400
Received: (qmail 19976 invoked by uid 109); 29 Oct 2018 14:14:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:14:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17747 invoked by uid 111); 29 Oct 2018 14:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:13:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:14:03 -0400
Date:   Mon, 29 Oct 2018 10:14:03 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
Message-ID: <20181029141402.GA17668@sigill.intra.peff.net>
References: <20181028125025.30952-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181028125025.30952-1-anders@0x63.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 01:50:25PM +0100, Anders Waldenborg wrote:

> This new format placeholder allows displaying only a single
> trailer. The formatting done is similar to what is done for
> --decorate/%d using parentheses and comma separation.

Displaying a single trailer makes sense as a goal. It was one of the
things I considered when working on %(trailers), actually, but I ended
up needing something a bit more flexible (hence the ability to dump the
trailers in a parse-able format, where I feed them to another script).
But your ticket example makes sense for just ordinary log displays.

Junio's review already covered my biggest question, which is why not
something like "%(trailers:key=ticket)". And likewise making things like
comma-separation options.

But my second question is whether we want to provide something more
flexible than the always-parentheses that "%d" provides. That has been a
problem in the past when people want to format the decoration in some
other way.

We have formatting magic for "if this thing is non-empty, then show this
prefix" in the for-each-ref formatter, but I'm not sure that we do in
the commit pretty-printer beyond "% ". I wonder if we could/should add a
a placeholder for "if this thing is non-empty, put in a space and
enclose it in parentheses".

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 6109ef09aa..a46d0c0717 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -211,6 +211,10 @@ endif::git-rev-list[]
>    If the `unfold` option is given, behave as if interpret-trailer's
>    `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
>    both.
> +- %(trailer:<t>): display the specified trailer in parentheses (like
> +  %d does for refnames). If there are multiple entries of that trailer
> +  they are shown comma separated. If there are no matching trailers
> +  nothing is displayed.

It might be worth specifying how this match is done. I'm thinking
specifically of whether it's case-sensitive, but I wonder if there
should be any allowance for other normalization (e.g., allowing a regex
to match "coauthored-by" and "co-authored-by" or something).

-Peff
