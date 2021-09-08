Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B011C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AC761051
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbhIHTcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:32:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:42364 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhIHTcV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:32:21 -0400
Received: (qmail 26027 invoked by uid 109); 8 Sep 2021 19:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 19:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32637 invoked by uid 111); 8 Sep 2021 19:31:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 15:31:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 15:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 4/5] http: centralize the accounting of libcurl
 dependencies
Message-ID: <YTkPfyAYTU4ZgRgb@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-4.5-47b513a261b-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.5-47b513a261b-20210908T152807Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 05:31:55PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As discussed in 644de29e220 (http: drop support for curl < 7.19.4,
> 2021-07-30) checking against LIBCURL_VERSION_NUM isn't as reliable as
> checking specific defines in curl, as some distros have been known to
> backport features. Furthermore as shown in the preceding commit doing
> these version checks makes for hard to read and possibly buggy code,
> as shown by the bug fixed there where we were conflating base 10 for
> base 16 when comparing the version.

Just playing devil's advocate for a moment: we are making the assumption
here that curl will use preprocessor macros to implement these constants
(as opposed to, say, enums). I think that has been historically true,
but it is an extra dependency we're adding on curl's internal-ish
details.

> +/**
> + * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
> + */
> +#ifdef CURLOPT_TCP_KEEPALIVE
> +#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> +#endif
>
> [...]
>
> -#if LIBCURL_VERSION_NUM >= 0x071900
> +#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
>  static void set_curl_keepalive(CURL *c)
>  {
>  	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);

Part of me is a little sad at the duplication this creates. We could
just be checking

  #ifdef CURLOPT_TCP_KEEPALIVE

in the second hunk, without the first one at all. That does make it
harder to see which ones are in use (and we'd still want a comment to
take note of the versions). I dunno. I guess having a central-ish
registry of these is worth the duplication.

-Peff
