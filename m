Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C25C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824A161208
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHGkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:40:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHGkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:40:46 -0400
Received: (qmail 28141 invoked by uid 109); 8 Jun 2021 06:38:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:38:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7016 invoked by uid 111); 8 Jun 2021 06:38:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:38:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:38:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] t: use user-specified utf-8 locale for testing svn
Message-ID: <YL8Qe31z1Q5/DkmF@coredump.intra.peff.net>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210607010844.24587-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210607010844.24587-1-congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 08:08:44AM +0700, Đoàn Trần Công Danh wrote:

> In some test-cases, UTF-8 locale is required. To find such locale,
> we're using the first available UTF-8 locale that returned by
> "locale -a".
> 
> However, the locale(1) utility is unavailable on some systems,
> e.g. Linux with musl libc.
> 
> However, without "locale -a", we can't guess provided UTF-8 locale.
> 
> Add a Makefile knob GIT_TEST_UTF8_LOCALE and activate it for
> linux-musl in our CI system.
> 
> Rename t/lib-git-svn.sh:prepare_a_utf8_locale to prepare_utf8_locale,
> since we no longer prepare the variable named "a_utf8_locale",
> but set up a fallback value for GIT_TEST_UTF8_LOCALE instead.
> The fallback will be LC_ALL, LANG environment variable,
> or the first UTF-8 locale from output of "locale -a", in that order.

This patch looks good to me. I have one tiny nit below, but I'm OK if
it's left as-is:

> +prepare_utf8_locale () {
> +	if test -n "$GIT_TEST_UTF8_LOCALE"
> +	then
> +		: test_set_prereq UTF8

This ":" is really just a comment, but since it contains code we would
like to run (but which actually gets run later), it confused me.
Something like:

  : already set by the caller, nothing to do

would have made it easier to understand.

And then the rest of the function is pretty self-explanatory.

-Peff
