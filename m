Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E96020A40
	for <e@80x24.org>; Thu, 30 Nov 2017 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbdK3DHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 22:07:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:44034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751961AbdK3DHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 22:07:30 -0500
Received: (qmail 7526 invoked by uid 109); 30 Nov 2017 03:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 03:07:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24581 invoked by uid 111); 30 Nov 2017 03:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 29 Nov 2017 22:07:48 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Nov 2017 22:07:28 -0500
Date:   Wed, 29 Nov 2017 22:07:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
Message-ID: <20171130030727.GA24732@sigill.intra.peff.net>
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 12:51:41AM +0100, Johannes Schindelin wrote:

> The hashmap API is just complicated enough that even at least one
> long-time Git contributor has to look up how to use it every time he
> finds a new use case. When that happens, it is really useful if the
> provided example code is correct...
> 
> While at it, "fix a memory leak", avoid statements before variable
> declarations, fix a const -> no-const cast, several %l specifiers (which
> want to be %ld), avoid using an undefined constant, call scanf()
> correctly, use FLEX_ALLOC_STR() where appropriate, and adjust the style
> here and there.

Heh, that's quite a list of faults for what's supposed to be simple
example code. ;)

Your improvements all look good to me, and I'd be happy to see this
applied as-is. But here are two possible suggestions:

> diff --git a/hashmap.h b/hashmap.h
> index 7cb29a6aede..7ce79f3f72c 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -18,75 +18,71 @@
>   *
>   * #define COMPARE_VALUE 1
>   *
> - * static int long2string_cmp(const struct long2string *e1,
> + * static int long2string_cmp(const void *hashmap_cmp_fn_data,
> + *                            const struct long2string *e1,
>   *                            const struct long2string *e2,
> - *                            const void *keydata, const void *userdata)
> + *                            const void *keydata)

If these struct pointers became "const void *", then we would not need
to cast the function pointer here:

>   *     hashmap_init(&map, (hashmap_cmp_fn) long2string_cmp, &flags, 0);

which would mean that the original problem you are fixing would have
been caught by the compiler, rather than probably segfaulting at
runtime.

My second suggestion (which I'm on the fence about) is: would it better
to just say "see t/helper/test-hashmap.c for a representative example?"

I'm all for code examples in documentation, but this one is quite
complex. The code in test-hashmap.c is not much more complex, and is at
least guaranteed to compile and run. It doesn't show off how to combine
a flex-array with a hashmap as well, but I'm not sure how important that
is. So I could go either way.

-Peff
