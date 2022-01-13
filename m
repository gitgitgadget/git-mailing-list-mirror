Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFEC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 19:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiAMTJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 14:09:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58564 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiAMTJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 14:09:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97F6A107F1C;
        Thu, 13 Jan 2022 14:09:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SHEzVcfjivll
        zqnVlC4Rlu9yLBNdGRBhz/Pv8gfQ8/Q=; b=Emdf+McoNehNSrtJDr0MAjTyr0+W
        X6ss+p7X1VxX5/lebRobqtS4bgQRJ8OYR0zaBBnvm0AYM/cwFA8ozZ3UNppPxQyM
        ekm4byvEkI9rIvKQ+pYHcG/ACEAFRMwOvRzeg2vmjKBm/LrxZiwI29tF9hurx7es
        J3UyEzS59A9SG9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9067D107F1B;
        Thu, 13 Jan 2022 14:09:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F38C7107F1A;
        Thu, 13 Jan 2022 14:09:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] reftable tests: use C syntax compatible with old xlc
References: <0b86f6c2327b88886ad8667d28e0fa8382791499.1633638316.git.gitgitgadget@gmail.com>
        <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>
        <CAFQ2z_M2ZH-8RNS_zxShkdaXdO4x4Vr8EwrFo6atd0qzyy36oA@mail.gmail.com>
Date:   Thu, 13 Jan 2022 11:09:13 -0800
In-Reply-To: <CAFQ2z_M2ZH-8RNS_zxShkdaXdO4x4Vr8EwrFo6atd0qzyy36oA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 13 Jan 2022 15:23:29 +0100")
Message-ID: <xmqq4k67ihba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C98ED9E-74A4-11EC-9504-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Jan 13, 2022 at 12:38 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Change code added in 1ae2b8cda84 (reftable: add merged table view,
>> 2021-10-07) to be compatible with older versions of AIX's IBM xlc
>> compiler. Version V12.1 of it (on gcc111.fsffrance.org) will hard
>> error with:
>>
>>     "reftable/merged_test.c", line 211.19: 1506-196 (S) Initialization=
 between types "char*" and "struct reftable_ref_record" is not allowed.
> ...
> Weird. What C standard does xlc implement?

Interesting.  It is complaining about this thing:

	struct reftable_ref_record r2[] =3D { {
		.refname =3D "a",
		.update_index =3D 2,
		.value_type =3D REFTABLE_REF_DELETION,
	} };
	...
	struct reftable_ref_record want[] =3D {
		r2[0],
		r1[1],
		r3[0],
		r3[1],
	};

and somehow assuming that r2[0] corresponds to the first member of a
"struct reftable_ref_record" structure, which is "char *refname".
Of course, you cannot initialize a character pointer with a whole
struct, which is *not* what the code wants to do.  I would
understand if it were written incorrectly like so

BAD:	struct reftable_ref_record want[] =3D {
BAD:		{ r2[0] },
BAD:		{ r1[1] },
BAD:		{ r3[0] },
BAD:		{ r3[1] },
BAD:	};

but that is not what we fed the compiler.  But apparently the
compiler is confused.

I wonder if it helps to use designated initializer on the latter, i.e.

	struct reftable_ref_record want[] =3D {
		[0] =3D r2[0],
		[1] =3D r1[1],
		[2] =3D r3[0],
		[3] =3D r3[1],
	};

