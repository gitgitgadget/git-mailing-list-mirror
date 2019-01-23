Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEA91F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfAWF5H (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:57:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:45402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725950AbfAWF5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:57:07 -0500
Received: (qmail 7398 invoked by uid 109); 23 Jan 2019 05:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Jan 2019 05:57:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15494 invoked by uid 111); 23 Jan 2019 05:57:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 Jan 2019 00:57:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2019 00:57:05 -0500
Date:   Wed, 23 Jan 2019 00:57:05 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct
 repository_format`
Message-ID: <20190123055704.GA19601@sigill.intra.peff.net>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com>
 <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 10:45:48PM +0100, Martin Ågren wrote:

> Call `clear_...()` at the start of `read_...()` instead of just zeroing
> the struct, since we sometimes enter the function multiple times. This
> means that it is important to initialize the struct before calling
> `read_...()`, so document that.

This part is a little counter-intuitive to me. Is anybody ever going to
pass in anything except a struct initialized to REPOSITORY_FORMAT_INIT?

If so, might it be kinder for read_...() to not assume anything about
the incoming struct, and initialize it from scratch? I.e., not to use
clear() but just do the initialization step?

A caller which calls read_() multiple times would presumably have an
intervening clear (either their own, or the one done on an error return
from the read function).

Other than that minor nit, I like the overall shape of this.

One interesting tidbit:

> +/*
> + * Always use this to initialize a `struct repository_format`
> + * to a well-defined, default state before calling
> + * `read_repository()`.
> + */
> +#define REPOSITORY_FORMAT_INIT \
> +{ \
> +	.version = -1, \
> +	.is_bare = -1, \
> +	.hash_algo = GIT_HASH_SHA1, \
> +	.unknown_extensions = STRING_LIST_INIT_DUP, \
> +}
> [...]
> +	struct repository_format candidate = REPOSITORY_FORMAT_INIT;

This uses designated initializers, which is a C99-ism, but one we've
used previously and feel confident in. But...

> +void clear_repository_format(struct repository_format *format)
> +{
> +	string_list_clear(&format->unknown_extensions, 0);
> +	free(format->work_tree);
> +	free(format->partial_clone);
> +	*format = (struct repository_format)REPOSITORY_FORMAT_INIT;
> +}

...this uses that expression not as an initializer, but as a compound
literal. That's also C99, but AFAIK it's the first usage in our code
base. I don't know if it will cause problems or not.

The "old" way to do it is:

  struct repository_format foo = REPOSITORY_FORMAT_INIT;
  memcpy(format, &foo, sizeof(foo));

Given how simple it is to fix if it turns out to be a problem, I'm OK
including it as a weather balloon.

-Peff
