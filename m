Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9007EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E9A610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349726AbhIHTXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:23:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:42342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240049AbhIHTXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:23:38 -0400
Received: (qmail 25955 invoked by uid 109); 8 Sep 2021 19:22:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 19:22:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32521 invoked by uid 111); 8 Sep 2021 19:22:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 15:22:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 15:22:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Message-ID: <YTkNdGk28UJnSDVt@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 05:31:53PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
> dependency and warning() was added if curl older than 7.44.0 was used,
> but the relevant code depended on CURLOPT_PINNEDPUBLICKEY, introduced
> in 7.39.0.

According to the manpage for CURLOPT_PINNEDPUBLICKEY, it looks like
support for various formats and implementations was phased in. In
particular, 7.44.0 picked up sha256 support (I guess for a fingerprint?
I've never used this feature) for most major implementations.

But in terms of compiling, all we care about is that the constant is
there. So I think the cutoff point you found is what we want. Presumably
when the file format isn't supported we'd get some error, though it's
not clear if that would come during the actual curl_*_perform(), or if
we should be checking the curl_easy_setopt() result.

> Let's also remove the macro check before we declare the ssl_pinnedkey
> variable, the pattern for other such variables is to declare the
> static variable unconditionally, we just may not use it on older
> versions. This reduces macro verbosity.
> 
> The reduction in verbosity comes at the small cost of issuing a
> warning about the unused variable if this code is compiled with curl
> versions older than 7.39.0. I think that's an acceptable trade-off,
> anyone compiling a new git with a 2014-era toolchain likely has at
> least other warning that'll have prompted them not to use -Werror, and
> if not maybe this'll prompt them to compile their new git with a more
> modern libcurl.

OK. That's a bit of a departure from how we've handled variables before,
but it does make the code a bit cleaner. And I am fine with the attitude
of "if you are using ancient tools, you may see some extra warnings". We
already know this is true for older compilers, and it's not worth caring
too much about.

-Peff
