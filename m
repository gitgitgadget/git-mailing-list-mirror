Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B046C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiAMRit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 12:38:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiAMRis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 12:38:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EED3217531F;
        Thu, 13 Jan 2022 12:38:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f87515MkDEV/
        SZiJ/5Mgyl8xcsNW6yU2oRtHnUcdW/A=; b=MQEuYeNt8BoxBbQwPibGqKVdfztC
        vymYdKpe10yEO1VZS7IY2D4EfAdFR/DmMGpsdXcZbgJnw8BaKNZm+vD2WCOqgFAg
        x8oydHX9FK5pUGqY29T/1qmax3yncJGDhQMObV/9pvOyOPotjcSSpw5OUXAew3uC
        /fnwp31ZB3drEYI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E754117531E;
        Thu, 13 Jan 2022 12:38:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6454517531D;
        Thu, 13 Jan 2022 12:38:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
        <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet>
        <Yd8njHz2m099iDfL@nand.local>
        <220113.8635lsvsw6.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Jan 2022 09:38:44 -0800
In-Reply-To: <220113.8635lsvsw6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Jan 2022 11:08:44 +0100")
Message-ID: <xmqqee5bk02j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A84F0CB6-7497-11EC-8A76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jan 12 2022, Taylor Blau wrote:
>
>> On Wed, Jan 12, 2022 at 03:21:46PM +0100, Johannes Schindelin wrote:
>>> > diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
>>> > index 8ca988d6216..5dc89eda0cb 100644
>>> > --- a/t/helper/test-genzeros.c
>>> > +++ b/t/helper/test-genzeros.c
>>> > @@ -3,8 +3,7 @@
>>> >
>>> >  int cmd__genzeros(int argc, const char **argv)
>>> >  {
>>> > -	/* static, so that it is NUL-initialized */
>>> > -	static const char zeros[256 * 1024];
>>> > +	const char zeros[256 * 1024] =3D { 0 };
>>>
>>> This diff does two things: add an initializer, and turn the variable =
into
>>> a `static`. The former is the actual fix that is required. The latter=
 is
>>> not. During the -rc phase, we do not want to see any of the latter. I=
t is
>>> unnecessarily controversial and distracting, and can easily be postpo=
ned
>>> until January 25th, 2022.
>>
>> This assumes that making the declaration non-static isn't necessary to
>> fix the warning from SunCC.
>
> Just adding "=3D { 0 }" and retaining the "static" would FWIW make SunC=
C
> happy here.

It would make folks, who worry about having too large an item on the
stack to begin with, happy, too.  256kB on stack of a function that
does not make a call into a deep call chain would not matter all
that much, but it is a good principle to keep in mind.

We've worked around false "uninitialized" alarms from too picky
(versions of) compilers before by adding an otherwise unnecessary
initializers before, and I think this falls into the same category.

It is a separate matter if it is appropriate to worry about SunCC
this late in the cycle.  If this were "we were clean before, and
these small number of places add breakages", I would say yes.

But if this is "let's not add more of the same existing breakage
that we already have tons", we should not even be discussing about
such a change this late in the cycle (immediately after the new
offenders were added would have been more appropriate).

I offhand do not know which side of that line this one falls,
though.

Thanks.

