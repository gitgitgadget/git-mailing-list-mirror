Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A1C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74F660F57
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJXFyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 01:54:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54095 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXFya (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 01:54:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7512515F793;
        Sun, 24 Oct 2021 01:52:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s1dOQHO7C7PG
        vrUBJ9epvsIKutE0nPJQMyMm1CzIhek=; b=uK59zJGSAjDyoixy6XtgaX5YvfHH
        VzaC6roJKjpjVK+Y9ve6fr+Ylfex4wxHc9ua86szz71Gf+NtD2rOGppx6Og+iwy7
        MROp9IEdCmnGxL1Z+PdBBpwTIdnASuSqeAD8sntZcik+GyQZQ2fW5eEpy8mJmXnW
        xUYzKYeLpmxu2iQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DDF815F792;
        Sun, 24 Oct 2021 01:52:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAEAE15F791;
        Sun, 24 Oct 2021 01:52:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 3/6] usage.c + gc: add and use a die_message_errno()
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
        <patch-v3-3.6-6b33e394b2f-20211022T175227Z-avarab@gmail.com>
Date:   Sat, 23 Oct 2021 22:52:06 -0700
In-Reply-To: <patch-v3-3.6-6b33e394b2f-20211022T175227Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 20:19:36
        +0200")
Message-ID: <xmqqilxn55rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85EBF2F4-348E-11EC-AB8B-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code the "error: " output when we exit with 128 due to gc.log
> errors to use a "fatal: " prefix instead. This adds a sibling function
> to the die_errno() added in a preceding commit.
>
> Since it returns 128 instead of -1 we'll need to adjust
> report_last_gc_error(). Let's adjust it while we're at it to not
> conflate the "should skip" and "exit with this non-zero code"
> conditions, as the caller is no longer hardcoding "128", but relying
> on die_errno() to return a nen-zero exit() status.

OK, that sort of makes sense, and I am very glad that you didn't add
die_message_errno() to [1/6].  Adding this function to support the
caller that will benefit by using it in this same commit makes quite
a lot of sense.

> diff --git a/usage.c b/usage.c
> index 3d4b90bce1f..efc2064dde3 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -233,6 +233,18 @@ void NORETURN die_errno(const char *fmt, ...)
>  	va_end(params);
>  }
> =20
> +#undef die_message_errno
> +int die_message_errno(const char *fmt, ...)
> +{
> +	char buf[1024];
> +	va_list params;
> +
> +	va_start(params, fmt);
> +	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
> +	va_end(params);
> +	return -1;
> +}
> +
>  #undef error_errno
>  int error_errno(const char *fmt, ...)
>  {
