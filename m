Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A782A1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdCIHtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 02:49:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:41098 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdCIHto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 02:49:44 -0500
Received: (qmail 30053 invoked by uid 109); 9 Mar 2017 07:48:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:48:51 +0000
Received: (qmail 6457 invoked by uid 111); 9 Mar 2017 07:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 02:49:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 02:48:49 -0500
Date:   Thu, 9 Mar 2017 02:48:49 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 04/10] upload-pack: add partial (sparse) fetch
Message-ID: <20170309074849.ktl5vqbzkiwwwbob@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-5-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488994685-37403-5-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 05:37:59PM +0000, Jeff Hostetler wrote:

> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index c59ac99..0032729 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -212,6 +212,7 @@ out of what the server said it could do with the first 'want' line.
>    upload-request    =  want-list
>  		       *shallow-line
>  		       *1depth-request
> +		       *partial
>  		       flush-pkt
>  
>    want-list         =  first-want
> @@ -223,10 +224,15 @@ out of what the server said it could do with the first 'want' line.
>  		       PKT-LINE("deepen-since" SP timestamp) /
>  		       PKT-LINE("deepen-not" SP ref)
>  
> +  partial           =  PKT-LINE("partial-by-size" SP magnitude) /
> +		       PKT-LINE("partial-special)  
> +

I probably would have added this as a capability coming back from the
client, since it only makes sense to send once (the same way we ask for
other features like include-tag or ofs-delta). I guess it's six of one,
half a dozen of the other, though.

I notice that you require the client to request the "partial" capability
_and_ to send these commands. I'm not sure what the client capability
response is helping. The server has said "I can do this" and the client
either asks for it or not.

> +		if (skip_prefix(line, "partial-by-size ", &arg)) {
> +			unsigned long s;
> +			if (!client_requested_partial_capability)
> +				die("git upload-pack: 'partial-by-size' option requires 'partial' capability");
> +			if (!git_parse_ulong(arg, &s))
> +				die("git upload-pack: invalid partial-by-size value: %s", line);
> +			strbuf_addstr(&partial_by_size, "--partial-by-size=");
> +			strbuf_addstr(&partial_by_size, arg);
> +			have_partial_by_size = 1;
> +			continue;

So we parse it here for validation, but then pass the original string on
to be parsed again by pack-objects. I think I'd rather see us use the
result of our parse here, just to avoid any bugs where the parsing isn't
identical (and there is such a bug currently due to the signed/unsigned
thing I mentioned).

I also wonder whether the magnitude suffixes are worth exposing across
the wire. Anybody touching the list of units in git_parse_ulong() would
probably be surprised that the protocol is dependent on them (not that I
expect us to really take any away, but it just seems like an unnecessary
protocol complication).

-Peff
