Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CEFC43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3535215A4
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgINTty (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 15:49:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56496 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgINTtx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 15:49:53 -0400
Received: (qmail 7867 invoked by uid 109); 14 Sep 2020 19:49:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2020 19:49:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10013 invoked by uid 111); 14 Sep 2020 19:49:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Sep 2020 15:49:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Sep 2020 15:49:51 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200914194951.GA2819729@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914121906.GD4705@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 14, 2020 at 02:19:06PM +0200, Alex Riesen wrote:

> Unfortunately, it only worked for the fetches which didn't use --all or
> --multiple. After a light searching, I failed to find an explanation as to
> why --all|--multiple are handled so inconsistently with single remote fetches
> and added the options (similar to --force or --keep) to the argument list for
> sub-fetches:
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 82ac4be8a5..5e06c07106 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1531,6 +1531,10 @@ static void add_options_to_argv(struct argv_array *argv)
>  		argv_array_push(argv, "-v");
>  	else if (verbosity < 0)
>  		argv_array_push(argv, "-q");
> +	if (family == TRANSPORT_FAMILY_IPV4)
> +		argv_array_push(argv, "--ipv4");
> +	else if (family == TRANSPORT_FAMILY_IPV6)
> +		argv_array_push(argv, "--ipv6");
>  
>  }
>  
> Am I missing something obvious?

I don't think so. When we're starting fetch sub-processes, some options
will make sense to pass along and some won't. The parent has to either
pass all options and omit some, or explicitly pass ones it knows are
useful. It looks like the code chooses the latter, but these particular
options never got added (and it seems like they should be, as they are
only useful to the child fetch processes that actually touch the
network).

So your patch above looks quite sensible (modulo useful bits like a
signoff and maybe a test, though I guess the impact of those options
is probably hard to cover in our tests).

It is rather unfortunate that anybody adding new fetch options needs to
remember to (maybe) add them to add_options_to_argv() themselves.

Also, regarding these two specific options, it sounds like you'd want
them set for all fetches during the time your IPv6 setup is broken. In
which case I think a config option might have served you better. So that
might be something worth implementing (though either way I think the fix
above is worth doing independently).

-Peff
