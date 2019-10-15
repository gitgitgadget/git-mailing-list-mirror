Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED931F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 16:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfJOQka (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 12:40:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727994AbfJOQka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 12:40:30 -0400
Received: (qmail 19708 invoked by uid 109); 15 Oct 2019 16:40:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Oct 2019 16:40:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3554 invoked by uid 111); 15 Oct 2019 16:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Oct 2019 12:43:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Oct 2019 12:40:29 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] remote-curl: pass on atomic capability to remote side
Message-ID: <20191015164028.GA4710@sigill.intra.peff.net>
References: <20191015010759.2259-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191015010759.2259-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 01:07:59AM +0000, brian m. carlson wrote:

> Fix this by passing the option from the transport code through to remote
> helpers, and from the HTTP remote helper down to send-pack.  With this
> change, we can detect if the server side rejects the push and report
> back appropriately.  Note the difference in the messages: the remote
> side reports "atomic transaction failed", while our own checking rejects
> pushes with the message "atomic push failed".

Good find. The patch looks good to me, except for one minor style nit in
the documentation (see below).

> Document the atomic option in the remote helper documentation, so other
> implementers can implement it if they like.

I wondered what would happen for existing helpers that do not implement
the option, but the behavior here:

> +	if (flags & TRANSPORT_PUSH_ATOMIC)
> +		if (set_helper_option(transport, TRANS_OPT_ATOMIC, "true") != 0)
> +			die(_("helper %s does not support --atomic"), name);
> +

looks like the right thing.

> As I mentioned in the commit message, to my knowledge, this
> functionality has been broken since the atomic capability was introduced
> circa 2.4.0.

Yeah, I tried this with v2.4.0 and it had the same problem (plus it's
very clear from your patch that it's not a regression, but just that
nobody bothered to implement it in the first place).

> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index a5c3c04371..670d72c174 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -509,6 +509,11 @@ set by Git if the remote helper has the 'option' capability.
>  	Indicate that only the objects wanted need to be fetched, not
>  	their dependents.
>  
> +'option atomic' {'true'|'false'}::
> +  When pushing, request the remote server to update refs in a single atomic
> +  transaction.  If successful, all refs will be updated, or none will.  If the
> +  remote side does not support this capability, the push will fail.
> +

This is implemented with a single space, but the rest of the option
bodies are indented with a tab. Asciidoc seems to format it identically
either way, though.

-Peff
