Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C48F1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936101AbcKNSYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:24:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:42926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933511AbcKNSYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 13:24:33 -0500
Received: (qmail 13070 invoked by uid 109); 14 Nov 2016 18:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 18:24:33 +0000
Received: (qmail 3403 invoked by uid 111); 14 Nov 2016 18:25:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 13:25:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 13:24:31 -0500
Date:   Mon, 14 Nov 2016 13:24:31 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 05:18:30PM -0500, David Turner wrote:

> In the event that a HTTP server closes the connection after giving a
> 200 but before giving any packets, we don't want to hang forever
> waiting for a response that will never come.  Instead, we should die
> immediately.

I agree we don't want to hang forever, but this leaves open the
question: what is hanging?

My guess is that fetch-pack is waiting for more data from the server,
and remote-curl is waiting for fetch-pack to tell us what to send for
the next request. Neither will make forward progress because they are
effectively waiting on each other.

Which means this is likely a special case of malformed input from the
server. A server which likewise sends a partial response could end up in
the same deadlock, I would think (e.g., a half-finished pktline, or a
pktline but no trailing flush).

That doesn't make it wrong to fix this specific case (especially if it's
a common one), but I wonder if we could do better.

The root of the issue is that only fetch-pack understands the protocol,
and remote-curl is blindly proxying the data. But only remote-curl knows
that the HTTP request has ended, and it doesn't relay that information
to fetch-pack. So I can think of two solutions:

  1. Some way of remote-curl communicating the EOF to fetch-pack. It
     can't just close the descriptor, since we need to pass more data
     over it for the followup requests. You'd need something
     out-of-band, or to frame the HTTP data inside another layer of
     pktlines, both of which are kind of gross.

  2. Have remote-curl understand enough of the protocol that it can
     abort rather than hang.

     I think that's effectively the approach of your patch, but for one
     specific case. But could we, for example, make sure that everything
     we proxy is a complete set of pktlines and ends with a flush? And
     if not, then we hang up on fetch-pack.

     I _think_ that would work, because even the pack is always encased
     in pktlines for smart-http.

> @@ -659,6 +662,8 @@ static int post_rpc(struct rpc_state *rpc)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
>  
> +
> +	rpc->any_written = 0;

Extra blank line here?

> @@ -667,6 +672,9 @@ static int post_rpc(struct rpc_state *rpc)
>  	if (err != HTTP_OK)
>  		err = -1;
>  
> +	if (!rpc->any_written)
> +		err = -1;
> +

I wondered if there were any cases where it was normal for the server to
return zero bytes. Possibly the ref advertisement is one, but this is
_just_ handling post_rpc(), so that's OK. And I think by definition
every response has to at least return a flush packet, or we would make
no forward progress (i.e., the exact case you are dealing with here).

-Peff
