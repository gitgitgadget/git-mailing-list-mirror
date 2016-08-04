Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9303D1F855
	for <e@80x24.org>; Thu,  4 Aug 2016 22:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457AbcHDWd6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 18:33:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751142AbcHDWd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2016 18:33:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04BDF3198A;
	Thu,  4 Aug 2016 18:33:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=303ogdFfwo66
	dE02goxAysANs6c=; b=a1z1m6HOdnb9ytWzqw4UVrbHRHj4SUSMKxUsOkcs4ssP
	/2qXsRq1ez0z5dkOMdkZhnfK6FUSpFnGihXF9CUHOTKf9V+GahQDKrPqgIAJ4ows
	R5f9SGxkI2iariYcs2mvffx/jik266dzt/Y3e8u38uBm3sLcixlLPAe7v0z1H1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OHX2HL
	K6VqZ807G9JQBhZmT/hTqEfHmxV2tzbyuXNphHSulmIzat9mvsuYbANakE+5eyAe
	CSFLzj2MIshJcgcSEaT1Cxt86zC7hL/AqFapbTxR7CwvR53buQFRTe/AbR3j68b9
	53RNoUBLHDGG1ZP6aAerRE+t5FPYIws10SF2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1DC831989;
	Thu,  4 Aug 2016 18:33:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70E3731988;
	Thu,  4 Aug 2016 18:33:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
	<57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
	<57A3BA26.5080601@web.de>
Date:	Thu, 04 Aug 2016 15:33:52 -0700
In-Reply-To: <57A3BA26.5080601@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 4
	Aug 2016 23:56:54 +0200")
Message-ID: <xmqqoa58yxin.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8681ECE4-5A93-11E6-BEDE-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> This version of strdup() is only compiled if nedmalloc is used instead
> of the system allocator.  That means we can't rely on strdup() being
> able to take NULL -- some (most?) platforms won't like it.  Removing
> the NULL check would be a more general and overall easier way out, no?

The callers of this version must be prepared to call a version of
strdup() that does not accept NULL, so in a sense, passing NULL to
this function is already an error in the context of this project.

That sounds like a good rationale to take this more straight-forward
approach.

> But it should check the result of malloc() before copying.
> ---
>  compat/nedmalloc/nedmalloc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index a0a16eb..cc18f0c 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -955,12 +955,10 @@ void **nedpindependent_comalloc(nedpool *p,
> size_t elems, size_t *sizes, void **
>   */
>  char *strdup(const char *s1)
>  {
> -	char *s2 = 0;
> -	if (s1) {
> -		size_t len = strlen(s1) + 1;
> -		s2 = malloc(len);
> +	size_t len = strlen(s1) + 1;
> +	char *s2 = malloc(len);
> +	if (s2)
>  		memcpy(s2, s1, len);
> -	}
>  	return s2;
>  }
>  #endif
