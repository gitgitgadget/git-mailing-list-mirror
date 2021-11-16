Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C08C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB85613D0
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhKPIca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:32:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61084 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhKPIcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 03:32:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 769171606E0;
        Tue, 16 Nov 2021 03:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TLsxIhlfe+x00JGBAdT95xHnQ
        UgFT+2m7sFyU0AmpqI=; b=sG3giWv/BmgkBAAKmGWJ2Nyfc09RC2fh986w89W+E
        YuJuYYT68hB9hrv90153MO5Cy5Rh7zh+ee77pZgjVZ7scyYNglE9MF9U/CStYlBa
        fsSwM0Z9xPt931OQ0ZHy0igJMUIbcbifMYXf9/ce6p+jHDqP9WqINMxyHd1uysX+
        H0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F6AA1606DF;
        Tue, 16 Nov 2021 03:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D29C31606DE;
        Tue, 16 Nov 2021 03:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
        <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
        <CAN0heSpLy8c6WM1UpyEXJLfmnX=5B0eFhJwH3wqSZN15HAJGeg@mail.gmail.com>
Date:   Tue, 16 Nov 2021 00:29:08 -0800
Message-ID: <xmqqee7gbj1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4563B7CC-46B7-11EC-913E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Mon, 15 Nov 2021 at 07:30, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> There are certain C99 features that might be nice to use in our code
>> base, but we've hesitated to do so in order to avoid breaking
>> compatibility with older compilers. But we don't actually know if
>> people are even using pre-C99 compilers these days.
>
>> is a long-enough time, so let's try it agin.
>
> s/agin/again/
>
>>  void show_object_with_name(FILE *out, struct object *obj, const char =
*name)
>>  {
>> -       const char *p;
>> -
>>         fprintf(out, "%s ", oid_to_hex(&obj->oid));
>> -       for (p =3D name; *p && *p !=3D '\n'; p++)
>> +       for (const char *p =3D name; *p && *p !=3D '\n'; p++)
>>                 fputc(*p, out);
>>         fputc('\n', out);
>>  }
>
> This seems like a stable-enough function for this experiment.

Yup, the callers and the implementation are from several years ago,
if I am not mistaken.

> Similar to 765dc16888 ("git-compat-util: always enable variadic macros"=
,
> 2021-01-28), maybe we should add something like
>
>   /*
>    * This "for (const char *p =3D ..." is made as a first step towards
>    * making use of such declarations elsewhere in our codebase.  If
>    * it causes compilation problems on your platform, please report
>    * it to the Git mailing list at git@vger.kernel.org.
>    */
>
> to reduce the chance of someone patching it up locally thinking that
> it's just a one-off.

Probably.  It would help people to refrain from copying and pasting
this and making it harder to back out, too.
