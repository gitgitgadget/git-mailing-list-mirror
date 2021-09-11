Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124AC433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D90C6109F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhIKOeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:34:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:44886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhIKOeK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:34:10 -0400
Received: (qmail 12393 invoked by uid 109); 11 Sep 2021 14:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:32:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20674 invoked by uid 111); 11 Sep 2021 14:32:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:32:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:32:56 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 2/5] http: drop support for curl < 7.16.0
Message-ID: <YTy+GH0I2KPnBCUY@coredump.intra.peff.net>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
 <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
 <1b18309a-93e8-60cc-1bd3-61857b1da819@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b18309a-93e8-60cc-1bd3-61857b1da819@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:28:25AM +0200, Andrei Rybak wrote:

> >   enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
> > -#if LIBCURL_VERSION_NUM >= 0x071700
> > -/* Use CURLOPT_KEYPASSWD as is */
> > -#elif LIBCURL_VERSION_NUM >= 0x070903
> > -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
> > -#else
> > -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
> > -#endif
> 
> In 0x071700, 0x17 == 23, so it seems that this chain of `#if`s
> distinguishes between three categories of curl versions:
> 
>   1. version < 7.9.3
>   2. 7.9.3 <= version < 7.23.0
>   3. 7.23.0 <= version
> 
> So it seems that this patch [1] drops support for curl < 7.23.0, while
> the subject line claims "drop support for curl < 7.16.0".
> 
> [1]: already in branch master as commit 013c7e2b07 (http: drop support
>      for curl < 7.16.0, 2021-07-30)

Yes, you're right, though there's a little more going on.

The same issue was raised in the original thread starting here:

  https://lore.kernel.org/git/xmqq1sok7i82.fsf@gitster.mtv.corp.google.com/

but unfortunately that seems to have been missed when the patches were
reposted more recently. :(

There's further discussion there, though. It turns out this was yet
another decimal/hex confusion, and the correct version is actually
7.17.0. So it breaks things from 7.9.3 <= version < 7.17.0. But later in
the series we bump the minimum to 7.19.4 anyway.

So the patch is indeed wrong, but the series overall ends up correct.

-Peff
