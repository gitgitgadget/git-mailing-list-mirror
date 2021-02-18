Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52992C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1464EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBRWaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:30:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61344 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRWaP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:30:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5512510A2D6;
        Thu, 18 Feb 2021 17:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tBBgTbUYTjl7
        wLLsrr49Gm7w+n4=; b=a+FGgO3tNDgS3T53SNBldSzJSt80i4O3KIyI2X8NRg6t
        E+LR26K4P4+ZKQdpbObfUogg1Gq5+GY7aYpZKPw3RHKYlgUOV52XMNbnRHKDd/3y
        IfXgxfXY3Kq6g4U4IJsELVhjPeO0K6SCE1BLBiwmFokLcfIjBFtm1idYxWEIu10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i5zQut
        mvqDcnWBrvfHYPdYZeIM8PrzHL8lnXm02gCaNg7iju3y5531XLn0Oh0krgwyOUZP
        RoXNTfS9CzXv8iut9MYqCiTf+wAYkh3W3BDIoH0py+NxwaoRoTszWd4fNVe1mOTx
        gkVfVGzb7XVbk4UZxUVyju6y3DSbtjIBTsv9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DB6B10A2D4;
        Thu, 18 Feb 2021 17:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73D8010A2D2;
        Thu, 18 Feb 2021 17:29:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 07/10] fsck.c: call parse_msg_type() early in
 fsck_set_msg_type()
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-8-avarab@gmail.com>
Date:   Thu, 18 Feb 2021 14:29:28 -0800
In-Reply-To: <20210218105840.11989-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 11:58:37 +0100")
Message-ID: <xmqqtuq9c8mv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C4789EBE-7238-11EB-ACEE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There's no reason to defer the calling of parse_msg_type() until after
> we've checked if the "id < 0". This is not a hot codepath, and
> parse_msg_type() itself may die on invalid input.

That explains why this change can be done, but does not justify why
it is a good change.  Unlike all the previous steps, I would rather
say this is borderline needless churn.

Let's keep reading as the picture may change as we touch more code
around this area.

Thanks.


>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 00e0fef21ca..7c53080ad48 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -203,11 +203,10 @@ void fsck_set_msg_type(struct fsck_options *optio=
ns,
>  		const char *msg_id_str, const char *msg_type_str)
>  {
>  	int msg_id =3D parse_msg_id(msg_id_str);
> -	enum fsck_msg_type msg_type;
> +	enum fsck_msg_type msg_type =3D parse_msg_type(msg_type_str);
> =20
>  	if (msg_id < 0)
>  		die("Unhandled message id: %s", msg_id_str);
> -	msg_type =3D parse_msg_type(msg_type_str);
> =20
>  	if (msg_type !=3D FSCK_ERROR && msg_id_info[msg_id].msg_type =3D=3D F=
SCK_FATAL)
>  		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
