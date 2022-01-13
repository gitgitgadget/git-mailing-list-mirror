Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002BC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiAMSwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:52:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51583 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiAMSwI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 13:52:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECFBE175BBF;
        Thu, 13 Jan 2022 13:52:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EpVLYqMDA+tx
        Twp132PmvcANgHdDB2u11ObPFvch/+M=; b=erLs9VilxV5NrwHrHNUGUBOQ/jZD
        HPLaXUidUZEbzctaCyu/SMfpfTn5crnL/jqmBCPgkp7k0a6iS5xY5OESjAPC/dia
        drVFO4gKLKuPWA6CbmVXQ42pow4fGrjoVKf8Z1hK/RrNMLBZUMDl5zQr9XjsbdLJ
        qeiz3YLaHRfIAPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E57A7175BBE;
        Thu, 13 Jan 2022 13:52:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63253175BBD;
        Thu, 13 Jan 2022 13:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
        <xmqqtuf0fe3r.fsf@gitster.g>
        <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
        <xmqq4k6y63j7.fsf@gitster.g>
        <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
        <6993c156-4df1-198f-5ce0-781ba13d5dd2@web.de>
Date:   Thu, 13 Jan 2022 10:52:04 -0800
In-Reply-To: <6993c156-4df1-198f-5ce0-781ba13d5dd2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 12 Jan 2022 15:03:20 +0100")
Message-ID: <xmqqczkvii3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6E8F914-74A1-11EC-98C2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 12.01.22 um 12:58 schrieb Han-Wen Nienhuys:
>> On Fri, Dec 24, 2021 at 5:16 AM Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Once you
>>> initialize at the declaration with "less meaningful" value (like
>>> zero initialization), the tools won't be able to tell when the code
>>> uses that variable "uninitialized" (because the assignment was
>>> skipped by a bug), since it appears to always be initialied to them.
>>
>> Which tools are these? When I add
>>
>> static void test_memcpy(void)
>> {
>>  uint32_t dest;
>>  char not_init[200];
>>  int i;
>>  memcpy(&dest, not_init, sizeof(dest));
>>
>>  for (i =3D 0 ; i < 10; i++)
>>   not_init[i] =3D rand() % 255 + 1;
>>  printf("%d", (int) strlen(not_init));
>> }
>>
>> to the C code, it compiles cleanly if I do "make DEVELOPER=3D1".
>
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html says about
> -Wuninitialized:
>
>    "Note that there may be no warning about a variable that is used onl=
y
>     to compute a value that itself is never used, because such
>     computations may be deleted by data flow analysis before the
>     warnings are printed."
>
> And indeed, dest is not used above.  But even if we change the funtion
> to use dest by returning it, GCC versions 9.1 and higher don't warn
> about the use of the uninitialized buffer.  GCC 4.7.1 to 8.5 do warn,
> though: https://godbolt.org/z/zYz9KvPdK

What I meant in the original discussion was a runtime checker that
notices a read from an uninitialized location (I've also written one
myself way before my Git time, which was how I noticed strcpy() on
old SunOS, in an attempt to optimize by loading a word at a time,
sometimes read one word too much beyond the end of a page).

But if a static analysis may catch itas a potential error, that is
another reason to worry about it, too.

The original code wanted to do

	char message[100] =3D { 0 };

	for (i =3D 0; i < sizeof(message) - 1; i++)
        	message[i] =3D something();

	use_NUL_terminated_string(message);

and it allowed to omit an assigmnent

	message[sizeof(message) - 1] =3D '\0';

after the loop.

As I already said, I do not care too deeply in a test-only helper
like this.

Thanks.
