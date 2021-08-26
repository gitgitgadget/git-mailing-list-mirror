Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A96C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A0D60F6F
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhHZQuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:50:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52436 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhHZQuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:50:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCEB714A506;
        Thu, 26 Aug 2021 12:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hBqZAvYFIJfy
        ZbNcJYnJqH+e10h2fum0qmyIm4ZYNZI=; b=VlahiUkXCveF4vdh4GWZZNrAZSTf
        iC1nuQrq62VF0zZyhB+Xe7dJtePXrn4csSROxXJMvnJpSehflJGLuRHBBDFHblyd
        4dJ4BJeJ6RDJUWSVSLQwlyspRnYuMGzfNeqzoEpEM3SD+yVtQ6WWSiOlQ/m8LvGd
        rLGQcdyFl5KVIJw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1BA014A505;
        Thu, 26 Aug 2021 12:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DEBC414A504;
        Thu, 26 Aug 2021 12:49:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] xopen: explicitly report creation failures
References: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
        <CAPUEspjkcV1_R5DNXCkL5wQpZCW+K4As2nGuEGu6fyeFrr15KQ@mail.gmail.com>
        <f44bf316-efae-34ce-33e0-0161c3bb78a0@web.de>
Date:   Thu, 26 Aug 2021 09:49:27 -0700
In-Reply-To: <f44bf316-efae-34ce-33e0-0161c3bb78a0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 Aug 2021 17:23:27 +0200")
Message-ID: <xmqqa6l4f8x4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94440E56-068D-11EC-B806-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 26.08.21 um 01:46 schrieb Carlo Arenas:
>> On Wed, Aug 25, 2021 at 2:11 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
>>>
>>> diff --git a/wrapper.c b/wrapper.c
>>> index 563ad590df..7c6586af32 100644
>>> --- a/wrapper.c
>>> +++ b/wrapper.c
>>> @@ -193,7 +193,9 @@ int xopen(const char *path, int oflag, ...)
>>>                 if (errno =3D=3D EINTR)
>>>                         continue;
>>>
>>> -               if ((oflag & O_RDWR) =3D=3D O_RDWR)
>>> +               if ((oflag & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_=
EXCL))
>>> +                       die_errno(_("unable to create '%s'"), path);
>>
>> probably over conservative, but && errno =3D=3D EEXIST?
>
> No matter what error we got, if O_CREAT and O_EXCL were both given then
> we tried to create a file, so this message applies.

100% agreed.

>>> +               else if ((oflag & O_RDWR) =3D=3D O_RDWR)
>>>                         die_errno(_("could not open '%s' for reading =
and writing"), path);
>>>                 else if ((oflag & O_WRONLY) =3D=3D O_WRONLY)
>>>                         die_errno(_("could not open '%s' for writing"=
), path);
>>
>> Since you are already changing this code, why not take the opportunity
>> to refactor it
>> and remove the " =3D=3D FLAG" part of these conditionals which is
>> otherwise redundant?
>
> The repetition is unsightly, but it's a different issue that should be
> addressed separately.  Simply removing the comparison feels iffy,
> though.  POSIX doesn't seem to forbid e.g. O_RDONLY to be 1, O_WRONLY
> to be 2 and O_RDWR to be 3, and then you need to check all masked bits.
> I can't think of simpler alternative to the comparison.

I fully agree that such a change, if done, must be done in an
unrelated patch. =20

It is funny that the code is already prepared for such a case where
RDWR is defined as RDONLY|WRONLY.  I wonder if we wrote the series
of comparisons in this order on purpose, or we were just lucky, when
we did 3ff53df7 (wrapper: implement xopen(), 2015-08-04) ;-)


>
>> Either way "Reviewed-by", and indeed a nice cleanup.
>
> Thank you!

Yes, indeed, this is nicely done.
