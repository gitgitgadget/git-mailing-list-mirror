Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E69C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A86F64DD1
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhA1GOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:14:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64450 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhA1GOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:14:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A49B2120016;
        Thu, 28 Jan 2021 01:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/tjJw/gvnaEcgRL3q+jqwdBD5r4=; b=cVkemC
        fCJ2To5TZTh0oU2L5AKn0GhkTshxKHo+TsqLqEQ+8odpMUWNboSfXFFlcADIWObI
        IoYzVSc+ql1OFKgAE2AvFKTI3LLqGmQ3RiGVsPLTqZMSMCayUlsQjGdnWc1MiT0/
        tSCPyCaQfGLlfOTE6GEGTJ90+bRIsKTmHbqk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNWWJsmawq9j0NhQ7K0bUL7wZBalGdBR
        zu939su9bim0i9AmpqlgJkarwbWlLu/rHyDw5FcYCY1RURsEP9YznCG9T4fbB/yz
        /t1KYi0Vqm7VA8J3h5m9XL1P2NQdFxsjj+VEvhv6Rtw5xbxZ6jIFHnE4DUaJdZka
        jef2Wn0CDnY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EF8E120015;
        Thu, 28 Jan 2021 01:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9408120014;
        Thu, 28 Jan 2021 01:13:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util: always enable variadic macros
References: <YBJLgY+CWtS9TeVb@coredump.intra.peff.net>
Date:   Wed, 27 Jan 2021 22:13:29 -0800
In-Reply-To: <YBJLgY+CWtS9TeVb@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Jan 2021 00:28:33 -0500")
Message-ID: <xmqq5z3hy4fq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F19A451A-612F-11EB-946C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We allow variadic macros in the code base, but only if there is fallback
> code for platforms that lack it. This leads to some annoyances:
>
>   - the code is more complicated because of the fallbacks (e.g.,
>     trace_printf(), etc, is implemented twice with a set of parallel
>     wrappers).
>
>   - some constructs are just impossible and we've had to live without
>     them (e.g., a cross between FLEX_ALLOC and xstrfmt)
>
> Since this feature is present in C99, we may be able to start counting
> on it being available everywhere. Let's start with a weather balloon
> patch to find out.
>
> This patch makes the absolute minimal change by always setting
> HAVE_VARIADIC_MACROS. If somebody runs into a platform where it's a
> problem, they can undo it by commenting out the define. Likewise, if we
> have to revert this, it would be quite unlikely to cause conflicts.
>
> Once we feel comfortable that this is the right direction, then we can
> start ripping out all the spots that actually look at the flag, and
> removing the dead code.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We've talked about this off and on for a few years. I don't have any
> immediate plans for any features that need it, but let's get the ball
> rolling.

OK, so this is just callmine canary that can easily be undone when
somebody finds it problematic.  Let's give it enough time before we
actually start removing the fallback code that are protected by
"#ifndef HAVE_VARIADIC_MACROS" (they are quite well isolated---only
in the usage and trace, which is pretty much expected as we'd be
using the feature for printf-like macros).

Thanks.

>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 104993b975..5d5e47fbe2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1176,9 +1176,12 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  #endif
>  #endif
>  
> -#if defined(__GNUC__) || (_MSC_VER >= 1400) || defined(__C99_MACRO_WITH_VA_ARGS)
> +/*
> + * This is always defined as a first step towards making the use of variadic
> + * macros unconditional. If it causes compilation problems on your platform,
> + * please report it to the Git mailing list at git@vger.kernel.org.
> + */
>  #define HAVE_VARIADIC_MACROS 1
> -#endif
>  
>  /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
>  extern int BUG_exit_code;
