Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77657C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593DB613B3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhI1Xky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:40:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbhI1Xkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:40:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBB6EF40AA;
        Tue, 28 Sep 2021 19:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9HE1KdujLP1k
        xJyiiI8kzs9UgLwM4wbBdsgTPmSAEDw=; b=ATFjNx4Htfj7MijdovABcIs6/xTI
        QcXY9SHbIoHc6RXiHhCfyV1gAqgwt4tZUWIFp8sae7peGHpgTbqdQj0GNx77nv1T
        hQDx7G5epaySUqNU1pw7IwYw/V9GyoJWlw0ekfW1EZ7KuiPOrX7Ya5Hdrv9JwMiK
        5zzVPsPnHAJM1cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D38F0F40A9;
        Tue, 28 Sep 2021 19:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46FC7F40A8;
        Tue, 28 Sep 2021 19:39:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1/3] Makefile: restrict -Wpedantic and
 -Wno-pedantic-ms-format better
References: <20210928091054.78895-1-carenas@gmail.com>
        <20210928091054.78895-2-carenas@gmail.com>
        <87o88cx69w.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 16:39:10 -0700
In-Reply-To: <87o88cx69w.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 13:46:14 +0200")
Message-ID: <xmqq1r58i82p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48230E0E-20B5-11EC-8565-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In any case, I wonder if we should at least be better off with the
> diff-at-the-end on top (untested).
> ...
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -11,6 +11,10 @@ uname_R :=3D $(shell sh -c 'uname -r 2>/dev/null || =
echo not')
>  uname_P :=3D $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  uname_V :=3D $(shell sh -c 'uname -v 2>/dev/null || echo not')
> =20
> +ifneq (,$(findstring MINGW,$(uname_S)))
> +	uname_S :=3D MINGW
> +endif
> +

It does sound like a better organization to "normalize" different
spellings early so that later users of the macro can pretend that
there is no "MINGW64_BLA-foo" to worry about.

>  ifdef MSVC
>  	# avoid the MingW and Cygwin configuration sections
>  	uname_S :=3D Windows
> @@ -588,8 +592,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SANE_TOOL_PATH =3D /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH =3D /usr/coreutils/bin/bash
>  endif
> -ifneq (,$(findstring MINGW,$(uname_S)))
> -	uname_S :=3D MINGW
> +ifeq ($(uname_S),MINGW)
>  	pathsep =3D ;
>  	HAVE_ALLOCA_H =3D YesPlease
>  	NO_PREAD =3D YesPlease


Thanks.
