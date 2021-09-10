Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5DC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF7F60FDC
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhIJPSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:18:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:44016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhIJPSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:18:52 -0400
Received: (qmail 6068 invoked by uid 109); 10 Sep 2021 15:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26043 invoked by uid 111); 10 Sep 2021 15:17:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:17:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:17:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 8/8] http: don't hardcode the value of CURL_SOCKOPT_OK
Message-ID: <YTt3E6/klkL55kY8@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-8.8-465ab33ebda-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-8.8-465ab33ebda-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Use the new git-curl-compat.h header to define CURL_SOCKOPT_OK to its
> known value if we're on an older curl version that doesn't have it. It
> was hardcoded in http.c in a15d069a198 (http: enable keepalive on TCP
> sockets, 2013-10-12).

Thanks for splitting this one out. I agree it's unlike the rest.

> +/**
> + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
> + *
> + * This should be safe as CURL_SOCKOPT_OK has always been a macro, not
> + * an enum field (checked on curl version 7.78.0, released on July 19,
> + * 2021). Even if that were to change the value of "0" for "OK" is
> + * unlikely to change.
> + */
> +#ifndef CURL_SOCKOPT_OK
> +#define CURL_SOCKOPT_OK 0
> +#endif

I agree this is probably fine if it later becomes an enum. But it would
be easy enough to just do the version-number check here, wouldn't it?
That would be even safer, and using the #ifndef doesn't really buy us
much. We still have to annotate the version and date in a comment as you
did, because we want to know when it is time to drop support.

-Peff
