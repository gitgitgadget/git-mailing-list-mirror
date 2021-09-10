Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45545C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADC760C40
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhIJPQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:16:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:44004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:16:52 -0400
Received: (qmail 6048 invoked by uid 109); 10 Sep 2021 15:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:15:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26030 invoked by uid 111); 10 Sep 2021 15:15:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:15:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:15:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 7/8] http: centralize the accounting of libcurl
 dependencies
Message-ID: <YTt2nHMXAkyfol9v@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-7.8-8e57a8409c5-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-7.8-8e57a8409c5-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As discussed in 644de29e220 (http: drop support for curl < 7.19.4,
> 2021-07-30) checking against LIBCURL_VERSION_NUM isn't as reliable as
> checking specific symbols present in curl, as some distros have been
> known to backport features.
> 
> However, while some of the curl_easy_setopt() arguments we rely on are
> macros, others are enum, and we can't assume that those that are
> macros won't change into enums in the future.
> 
> So we're still going to have to check LIBCURL_VERSION_NUM, but by
> doing that in one central place and using a macro definition of our
> own, anyone who's backporting features can define it themselves, and
> thus have access to more modern curl features that they backported,
> even if they didn't bump the LIBCURL_VERSION_NUM.

I think this lays out a nicer argument for this centralized registry
than the previous round.

I looked over the changes themselves and didn't notice any problems. I
didn't cross-check every moved-version field, since that seemed like an
unlikely mistake to make. I did check for easy mistakes at the
use-sites, like making sure to use #ifndef for "version < X" and #ifdef
for "version >= X".

> -#if LIBCURL_VERSION_NUM >=0x072b00
> +#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2

Good, I was going to complain about the whitespace in this one when you
touched it earlier, but now it goes away. :)

-Peff
