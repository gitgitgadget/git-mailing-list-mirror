Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59DC433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 19:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiAWTSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 14:18:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52255 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAWTSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 14:18:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35951FE011;
        Sun, 23 Jan 2022 14:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=15hCEQflv2fY
        qywxNOdcGeOi7HERf4vArLo/mujhWkA=; b=sRGn1FlNQ5KFhUoMjGD64gXc9I72
        LkELQroNnbongj4pk4vx+RZ5V6vcFZDlVaasmmFHFHPHgmg0nhtQO1c0HYQgHOkt
        eL8jxzCIX8xBB+XOZYFeapJ1FGIm91YI/BVgmB/+Yt3D+M54aV3HSkdMP9romshs
        zpOktitrdwBtn2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AE67FE010;
        Sun, 23 Jan 2022 14:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74B22FE00F;
        Sun, 23 Jan 2022 14:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
Date:   Sun, 23 Jan 2022 11:18:07 -0800
In-Reply-To: <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li> (Beat Bolli's
        message of "Sun, 23 Jan 2022 01:19:08 +0100")
Message-ID: <xmqqtudu9s7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32B514EA-7C81-11EC-8DA2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 22.01.22 00:23, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>>> As noted in the updated commit message this approach of having an
>>> object just for this fallback function comes at the cost of some
>>> complexity, but now the compat object lives neatly in its own object.
>> I do not see any change in this patch adding costly complexity, but
>> I notice lack of one possible trick that might become problem with
>> some compilers and linkers when their zlib has uncompress2()
>> function.  Let's have this graduate very early in the next cycle, to
>> see if anybody on a rarer system sees a complaint due to having to
>> deal with a totally empty object file.
>
> OpenSSL has a macro in include/openssl/macros.h to counteract exactly t=
his:
>
>     /*
>      * Sometimes OPENSSL_NO_xxx ends up with an empty file and some
>        compilers
>      * don't like that.  This will hopefully silence them.
>      */
>     #define NON_EMPTY_TRANSLATION_UNIT static void *dummy =3D &dummy;
>
> They insert it in the otherwise empty "#else" branch of conditionally
> complied code.

Between my "I recall some compilers and linkers had trouble with an
totally empty object files, and we'd better be prepared for them"
and "I didn't see any system that had such a problem during my
tests", I still lean toward "it merely shows that the problem is
rarer than the set of systems you tried", even without further
input.

But "It is a problem for which a real workaround is used in a system
that is used more widely than we are" is a clear enough evidence
that we should have one, especially the solution is so trivial.

https://github.com/openssl/openssl/pull/10425 seems to indicate that
they are moving in a direction that removes the necessity to use
this macro, by switching to tell the build system to not compile and
build a file that would become empty due to conditionals, but nobody
in the discussion seems to question the need for the macro for
portability if an otherwise empty file need to be dealt with.

Thanks.
