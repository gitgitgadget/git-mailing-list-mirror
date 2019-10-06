Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6731F4BE
	for <e@80x24.org>; Sun,  6 Oct 2019 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfJFAlk (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:41:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64381 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfJFAlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:41:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EF6D79448;
        Sat,  5 Oct 2019 20:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Dd5fcMr5b4gR
        Hpe9DamDmdS2Iqo=; b=VRABFCsKySkUnVarM/JREwya6e7kb3OMD8PxQ6xMd7Ux
        e1rBj0vDfs88xwDg3WKsFyfKXvTO6bvHUj4KtMfzQs0pqGWwLDBgtAnaSnv6tjEU
        Nfq95X9BejqXO3RbDUbisj7G/gYSNTTyLikEQvBsMRLBGhhaTSoayUNjCXBa7g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LiVhvd
        2G3ENAmiLT9xQ+Bl/9mzga0J4XMG4XfPOJYBGEeF/ebFDhuZZUOG2zOboHhMCv7d
        x0iwDCI3+WWAAQArp1JzmT5pErm4/7aTcfF4p3F8/NsDHgblWjodZCqD2fPem3b3
        w2nS4dsG03FmdIeV62x8CP6qmL99cjr0HNQbA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5742A79446;
        Sat,  5 Oct 2019 20:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8398D79445;
        Sat,  5 Oct 2019 20:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] convert: fix handling of dashless UTF prefix in validate_encoding()
References: <c886671c-7753-6ac8-fefc-277e76019cd4@web.de>
Date:   Sun, 06 Oct 2019 09:41:30 +0900
In-Reply-To: <c886671c-7753-6ac8-fefc-277e76019cd4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 4 Oct 2019 21:25:50 +0200")
Message-ID: <xmqqeezq66yt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B04FB86-E7D2-11E9-90A3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Strip "UTF" and an optional dash from the start of 'upper' without
> passing a NULL pointer to skip_prefix() in the second call, as it canno=
t
> handle that.

Did the original meant to say "skip UTF- from the beginning of upper
and store it to stripped, or if that cannot be done, skip UTF from
the beginning of upper and store it to stripped", but made the
second one scan the stripped instead of upper by mistake?

Changing it to "skip UTF from upper and store it to stripped, and if
the resulting stripped begins with dash, advance stripped to skip
that too" is certainly a right fix.  Fixing the second one to scan
upper would also make the result correct, but there is no point
scanning the same thing twice to skip the same leading "UTF"
substring.

Thanks.

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  convert.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index deb6f71b2d..25ac525d5f 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -290,8 +290,8 @@ static int validate_encoding(const char *path, cons=
t char *enc,
>  			const char *stripped =3D NULL;
>  			char *upper =3D xstrdup_toupper(enc);
>  			upper[strlen(upper)-2] =3D '\0';
> -			if (!skip_prefix(upper, "UTF-", &stripped))
> -				skip_prefix(stripped, "UTF", &stripped);
> +			if (skip_prefix(upper, "UTF", &stripped))
> +				skip_prefix(stripped, "-", &stripped);
>  			advise(advise_msg, path, stripped);
>  			free(upper);
>  			if (die_on_error)
> @@ -310,8 +310,8 @@ static int validate_encoding(const char *path, cons=
t char *enc,
>  				"working-tree-encoding.");
>  			const char *stripped =3D NULL;
>  			char *upper =3D xstrdup_toupper(enc);
> -			if (!skip_prefix(upper, "UTF-", &stripped))
> -				skip_prefix(stripped, "UTF", &stripped);
> +			if (skip_prefix(upper, "UTF", &stripped))
> +				skip_prefix(stripped, "-", &stripped);
>  			advise(advise_msg, path, stripped, stripped);
>  			free(upper);
>  			if (die_on_error)
> --
> 2.23.0
