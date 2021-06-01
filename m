Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C5C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23ABE613B9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhFAVGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:06:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:06:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC9D512B823;
        Tue,  1 Jun 2021 17:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UQ0EcRpsW2DH
        8dt2FP2zW8h0jR6LgvrM9/AUuk2fH9k=; b=MwNg4f7FpkjvgW9HXTJwXenjQU65
        QieRlUnNeaF6YVlEzn/lz1K1GTO3OWLXwD3P4Jml41TIGhEBSOE0rp6dWg8hba3d
        sO0XYRw+rghu+g3GsJHIhTYKTmOLZpsGyFXytcQ7NiSZ2A6QG/8AUv2SAtu6oQuE
        K86gVX1g2IQ9Bi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A53FE12B822;
        Tue,  1 Jun 2021 17:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8720612B81D;
        Tue,  1 Jun 2021 17:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/fsck.c: don't conflate "int" and "enum" in
 callback
References: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
Date:   Wed, 02 Jun 2021 06:04:31 +0900
In-Reply-To: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Jun
 2021 02:05:59 +0200")
Message-ID: <xmqq8s3ts3ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F70449CA-C31C-11EB-9754-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a warning on AIX's xlc compiler that's been emitted since my
> a1aad71601a (fsck.h: use "enum object_type" instead of "int",
> 2021-03-28):
>
>     "builtin/fsck.c", line 805.32: 1506-068 (W) Operation between
>     types "int(*)(struct object*,enum object_type,void*,struct
>     fsck_options*)" and "int(*)(struct object*,int,void*,struct
>     fsck_options*)" is not allowed.
>
> I.e. it complains about us assigning a function with a prototype "int"
> where we're expecting "enum object_type". Enums are just ints in C,
> but it seems xlc is more picky than some about conflating them at the
> source level.

As others already have pointed out, xlc is correct and these
warnings are perhaps useful.  I'd just remove the last sentence
while queuing, as "Enums are just ints in C" is only half a truth.

The constants like OBJ_COMMIT can be used as "int", but the type of
an enum itself may not be the same as "int"---it can be narrower.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> This is new in v2.32.0, so sending this during the rc phase, just a
> warning though, so unless you're using fatal warnings on that
> OS/platform it won't impact anything, and even then it's just a minor
> annoyance...

Thanks.

>
>  builtin/fsck.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 87a99b0108..b42b6fe21f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -109,7 +109,8 @@ static int fsck_error_func(struct fsck_options *o,
> =20
>  static struct object_array pending;
> =20
> -static int mark_object(struct object *obj, int type, void *data, struc=
t fsck_options *options)
> +static int mark_object(struct object *obj, enum object_type type,
> +		       void *data, struct fsck_options *options)
>  {
>  	struct object *parent =3D data;
