Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924F120A17
	for <e@80x24.org>; Mon, 23 Jan 2017 19:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbdAWTHI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 14:07:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWTHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 14:07:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A49BA62026;
        Mon, 23 Jan 2017 14:07:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EL+/zNCOpN6m
        yBv+7s7DNXaOxqo=; b=Ay6IqMuxggWHRLJCegEEvNikEI8J9KcpwfKltZAqvsPN
        N7Jltwh4hPI46rWdUDdM9r1MieMQgtRL8A88+1l+ZyECMWT+odKFyXB9NHs4uwFB
        2Fh0GiDsJi2oPtlG3u5eZZvMKyL/C8a2SfvXHM6D9AQZfCPU4pC0zzguSH4JFj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MjseN0
        vNhKhP2zFMdEPSpal2aJZJ3vaJK6LXuLRoksCpw+DKYE5oNdbNqPOWIBA9to/mI4
        2Pt4B1NJ8HGyeDlWbWKKqJZsp+5780z4OfIuMN/ejFG961nGJJBIpOoFGAkppszW
        PUl0RZi/2IR0P4hC0spDeAj+FwWkbXmtgHwvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BCAE62025;
        Mon, 23 Jan 2017 14:07:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07E2462024;
        Mon, 23 Jan 2017 14:07:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation based on GNU's qsort_r(1)
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
        <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
Date:   Mon, 23 Jan 2017 11:07:04 -0800
In-Reply-To: <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 22 Jan 2017 19:02:25 +0100")
Message-ID: <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 218F7E9E-E19F-11E6-BAE8-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Implement qsort_s() as a wrapper to the GNU version of qsort_r(1) and
> use it on Linux.  Performance increases slightly:
>
> Test                         HEAD^             HEAD
> --------------------------------------------------------------------
> 0071.2: sort(1)              0.10(0.20+0.02)   0.10(0.21+0.01) +0.0%
> 0071.3: string_list_sort()   0.17(0.15+0.01)   0.16(0.15+0.01) -5.9%
>
> Additionally the unstripped size of compat/qsort_s.o falls from 24576
> to 16544 bytes in my build.
>
> IMHO these savings aren't worth the increased complexity of having to
> support two implementations.

I do worry about having to support more implementations in the
future that have different function signature for the comparison
callbacks, which will make things ugly, but this addition alone
doesn't look too bad to me.

Thanks.

> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
> index 52d1f0a73d..763ee1faae 100644
> --- a/compat/qsort_s.c
> +++ b/compat/qsort_s.c
> @@ -1,5 +1,21 @@
>  #include "../git-compat-util.h"
> =20
> +#if defined HAVE_GNU_QSORT_R
> +
> +int git_qsort_s(void *b, size_t n, size_t s,
> +		int (*cmp)(const void *, const void *, void *), void *ctx)
> +{
> +	if (!n)
> +		return 0;
> +	if (!b || !cmp)
> +		return -1;
> +
> +	qsort_r(b, n, s, cmp, ctx);
> +	return 0;
> +}
> +
> +#else
> +
>  /*
>   * A merge sort implementation, simplified from the qsort implementati=
on
>   * by Mike Haertel, which is a part of the GNU C Library.
> @@ -67,3 +83,5 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  	}
>  	return 0;
>  }
> +
> +#endif
> diff --git a/config.mak.uname b/config.mak.uname
> index 447f36ac2e..a1858f54ff 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
>  	NEEDS_LIBRT =3D YesPlease
>  	HAVE_GETDELIM =3D YesPlease
>  	SANE_TEXT_GREP=3D-a
> +	HAVE_GNU_QSORT_R =3D YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	HAVE_ALLOCA_H =3D YesPlease
