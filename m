Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E5E1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 17:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbcGLRYo (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 13:24:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbcGLRYn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 13:24:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9926729405;
	Tue, 12 Jul 2016 13:24:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qbNEjlAkglxq
	2D53A3J02J7zWSw=; b=HyvfGhSu1qKuiG81QxRb988QRlaYzpze5GP0FrR4TLa8
	zxtS0k/2QyoutN9PC+Vollu2JbHcnXKNjBdUhlUTEF15VNCLzHuCrHiScVPrj1SV
	Z0BRRKT2qbVQYy2Ko8m/9G0EGtrBW5fiAreMC2/71HiBXuzymZ5Utj/pPNRxJLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bNSW8D
	H7hpzJBhyjqKjTeNNU5nxEIThDs8Me+DpL1z5cgMRQBbgU7BYk7RpMdURyCIPgj4
	gUR+QReT2BAoruHaBpBxPPWmnAzHw1gYqCaoskFgo0OeBPtwb8Pu88OAtujuNRzv
	1fTsuOq9Nf7vIjtG/DX9wM+/xJxiD+G+EY5Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920A929404;
	Tue, 12 Jul 2016 13:24:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B3C229403;
	Tue, 12 Jul 2016 13:24:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 4/5] index-pack: report correct bad object offsets even if they are large
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-5-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 10:24:40 -0700
In-Reply-To: <20160705170558.10906-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:57 +0200")
Message-ID: <xmqqfure6a7b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84F1C188-4855-11E6-AC81-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Use the right type for offsets in this case, off_t, which makes a
> difference on 32-bit systems with large file support, and change
> formatting code accordingly.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/index-pack.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index cafaab7..73f7cd2 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -338,10 +338,10 @@ static void parse_pack_header(void)
>  	use(sizeof(struct pack_header));
>  }
>  
> -static NORETURN void bad_object(unsigned long offset, const char *format,
> +static NORETURN void bad_object(off_t offset, const char *format,
>  		       ...) __attribute__((format (printf, 2, 3)));
>  
> -static NORETURN void bad_object(unsigned long offset, const char *format, ...)
> +static NORETURN void bad_object(off_t offset, const char *format, ...)
>  {
>  	va_list params;
>  	char buf[1024];
> @@ -349,7 +349,8 @@ static NORETURN void bad_object(unsigned long offset, const char *format, ...)
>  	va_start(params, format);
>  	vsnprintf(buf, sizeof(buf), format, params);
>  	va_end(params);
> -	die(_("pack has bad object at offset %lu: %s"), offset, buf);
> +	die(_("pack has bad object at offset %"PRIiMAX": %s"),
> +	    (intmax_t)offset, buf);
>  }

We seem to have a fallback definition only for PRIuMAX.

off_t is supposed to be a signed integer type [*1*], but we know
this is a positive offset when we issue this warning, so PRIuMAX
would probably be fine.


[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
