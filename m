Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DBD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbeKNAYt (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:24:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:37080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726846AbeKNAYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:24:49 -0500
Received: (qmail 17593 invoked by uid 109); 13 Nov 2018 14:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Nov 2018 14:26:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19666 invoked by uid 111); 13 Nov 2018 14:25:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 09:25:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 09:26:24 -0500
Date:   Tue, 13 Nov 2018 09:26:24 -0500
From:   Jeff King <peff@peff.net>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181113142624.GA17128@sigill.intra.peff.net>
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 02:44:56PM -0800, steadmon@google.com wrote:

> When a smart HTTP server sends an error message via pkt-line,
> remote-curl will fail to detect the error (which usually results in
> incorrectly falling back to dumb-HTTP mode).
> 
> This patch adds a check in discover_refs() for server-side error
> messages, as well as a test case for this issue.

Aside from the reformatting of the conditional that Junio mentioned,
this seems pretty good to me. But while looking at that, I found a few
things, some old and some new. :)

> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..bb3a86505e 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -436,7 +436,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	} else if (maybe_smart &&
>  		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
>  		last->proto_git = 1;
> -	}
> +	} else if (maybe_smart && last->len > 5 &&
> +		   starts_with(last->buf + 4, "ERR "))
> +		die(_("remote error: %s"), last->buf + 8);

The magic "4" here and in the existing "version 2" check is because we
are expecting pkt-lines. The original conditional always calls
packed_read_line_buf() and will complain if we didn't actually get a
pkt-line.

Should we confirm that we got a real packet-line? Or at least that those
first four are even plausible hex chars?

I admit that it's pretty unlikely that the server is going to fool us
here. It would need something like "foo ERRORS ARE FUN!". And even then
we'd report an error (whereas the correct behavior is falling back to
dumb http, but we know that won't work anyway because that's not a valid
ref advertisement). So I doubt this is really a bug per se, but it might
make it easier to understand what's going on if we actually parsed the
packet.

Similarly, we seem eager to accept "version 2" even if we are only
expecting v0. I know you have another series working in that direction,
but I don't think it touches this "proto_git". I guess accepting
"version 2" as "we're speaking git protocol" and then barfing later with
"wait, I didn't mean to speak v2" is probably OK.

-Peff
