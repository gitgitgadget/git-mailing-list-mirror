Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D246F20899
	for <e@80x24.org>; Thu, 27 Jul 2017 14:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdG0OR0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 10:17:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751444AbdG0ORZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 10:17:25 -0400
Received: (qmail 2990 invoked by uid 109); 27 Jul 2017 14:17:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 14:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1547 invoked by uid 111); 27 Jul 2017 14:17:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 10:17:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jul 2017 10:17:23 -0400
Date:   Thu, 27 Jul 2017 10:17:23 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Devin Lehmacher <lehmacdj@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] credential-cache: interpret an ECONNRESET as on EOF
Message-ID: <20170727141723.q7eeeajrdkwext5z@sigill.intra.peff.net>
References: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 02:08:40AM +0100, Ramsay Jones wrote:

> In order to suppress the fatal exit in this case, check the read error
> for an ECONNRESET and return as if no data was read from the daemon.
> This effectively converts an ECONNRESET into an EOF.

Yeah, I think this is a perfectly reasonable thing to do.

I'm not sure if we'd _ever_ see ECONNRESET on Linux. The only time I've
seen it on Linux (and I coincidentally fixed a bug just like this a week
or two ago, so it's fresh in my mind): if read() would return EOF but
there's outstanding data from a previous write, you get ECONNRESET.
Which is obviously going to be totally racy, since "outstanding" across
a TCP connection involves more than just the local kernel.

That shouldn't happen in this 'exit' case. But even if it does, there's
really nothing the client should do differently anyway. We're waiting
for the other side to exit, and they did. Hooray.

Though your change:

> diff --git a/credential-cache.c b/credential-cache.c
> index 91550bfb0..1cccc3a0b 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -25,7 +25,7 @@ static int send_request(const char *socket, const struct strbuf *out)
>  		int r;
>  
>  		r = read_in_full(fd, in, sizeof(in));
> -		if (r == 0)
> +		if (r == 0 || (r < 0 && errno == ECONNRESET))
>  			break;
>  		if (r < 0)
>  			die_errno("read error from cache daemon");

...is in the generic send_request(). Which means that it hits all of the
commands. So if we were to send a credential and the server
crashed midway through reading it, we'd get ECONNRESET. And instead of
reporting an error, we'd quietly assume the server had no response. But
again, I don't think that's really different than the EOF behavior. The
server could read our whole request and then crash, and we'd mistakenly
think it had nothing to say.

So I don't think this really changes the robustness much. If we did want
to address those cases, we'd require actual end-of-record framing in the
protocol. But I don't think it's worth caring too much about (this is,
after all, a local and internal socket between two relatively simple
programs).

Which is all a verbose way of saying that your patch looks good to me.
Thanks for digging up the root cause of the test failures.

-Peff
