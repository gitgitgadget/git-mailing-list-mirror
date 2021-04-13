Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02707C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C4D613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhDMH6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:58:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:50888 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhDMH6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:58:12 -0400
Received: (qmail 28800 invoked by uid 109); 13 Apr 2021 07:57:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:57:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23591 invoked by uid 111); 13 Apr 2021 07:57:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:57:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:57:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific
 code
Message-ID: <YHVPAGVDjS1EH6L3@coredump.intra.peff.net>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 01:02:17PM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9ddf9d7044b..540aba22a4d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -480,10 +480,15 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  
>  /*
>   * Let callers be aware of the constant return value; this can help
> - * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
> - * because some compilers may not support variadic macros. Since we're only
> - * trying to help gcc, anyway, it's OK; other compilers will fall back to
> - * using the function as usual.
> + * gcc with -Wuninitialized analysis.
> + *
> + * We restrict this trick to gcc, though, because while we rely on the
> + * presence of C99 variadic macros, this code also relies on the
> + * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
> + * work even if no format specifiers are passed to error().
> + *
> + * Since we're only trying to help gcc, anyway, it's OK; other
> + * compilers will fall back to using the function as usual.
>   */
>  #if defined(__GNUC__)

I don't mind leaving this gcc-only, since as you note that's the point
of what the code is trying to do. But wouldn't this always work because
we know there is at least one arg (the format itself)?

I.e., if we had written:

  #define error(fmt, ...) (error(fmt, __VA_ARGS__), const_error())

that would be a problem for:

  error("foo");

But because we wrote:

  #define error(...) (error(__VA_ARGS__), const_error())

then it's OK.

-Peff
