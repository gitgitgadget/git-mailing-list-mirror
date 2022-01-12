Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD66C433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 14:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbiALOD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 09:03:56 -0500
Received: from mout.web.de ([212.227.15.4]:48807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353924AbiALODw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 09:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641996201;
        bh=GGYNrfwmmNkWcHeD7V2fFbIeOoQ7fgJ0KQarSwTra4k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Scx2eZT+iD3HW12uIErMueRR7/pZqeQ+Of5f5csMXpTrzPIhHGyr7e3asdntGmoHi
         0XPQCxMq6bM6828kATNjbWAjdMwo9zJi2OvlhgvlHVU0O1aY2XaWyYxiM4Kvs4dJkL
         mBC3nv7ruegw+XT8E6bfEkNkDKDGyqLHWGAQmQZc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1mIZhC1o0x-016n0E; Wed, 12
 Jan 2022 15:03:21 +0100
Message-ID: <6993c156-4df1-198f-5ce0-781ba13d5dd2@web.de>
Date:   Wed, 12 Jan 2022 15:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error
 path
Content-Language: en-US
To:     Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
 <xmqqtuf0fe3r.fsf@gitster.g>
 <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
 <xmqq4k6y63j7.fsf@gitster.g>
 <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4PeLnQ744QMNl5+2aQpCvu0kE1PPzhDRX2T8D/xA8r0Ry7ehM6o
 fdb8nXTinFs3ipGZnBcFELD42TA7O8GER+kqw5Fd7zrJZsRpeyfZ8dhPBK/297pvFNKuqBp
 5zbxUKhXS9ZX4eFfN0No1qt276mwTXJIRAyENnGpWxaRyYm+Fgjw8E7xocuN8l9n2rJa/NS
 imfJEhFq1YpHl77Xqy9Dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jZ3CyMRQ8wY=:w/NmH530lY9KsKnvXDHNqH
 843JKcz0Iq4sACI9EImVtyPVwPt6I0SLi6ezDcaljuEq6QssR6FGqxMefgkmoFfeCaG4sbHb1
 kQVv65JlTqb+lW4Bns8Jts47NqpIPgDmPmM0CDm/mMv1YFDH1yjbnQHCUWLGxZ1+VrTPKOhrC
 L8QOS8HNoXhs4lHgJ7ORIijs6pDZlezfVHcbuNz0urHQMmAPHIbLgShKrP719oKaAr7u1LDjq
 l1tUTTJm+30Itj1IVTVo70r8qMXcJ23+LP7hka0bNZQGhSAvI0wHpGmJ+xaYP8xbQog4ZntrW
 6VyoEPidUfoXzxcl4OUFfSxY84dUfkwdOkchM3wtav8g99VkiloI93opxAIj6nOvdeu6O3Ues
 469iGAqGn8YUqnG0rsyoOrNHOTNQpR//1C6FFavBVwV1yuiuyllaw8xbDTK8coeh6UaDVD4Xg
 4IyZqszfWvsJwwuJpapUr/WW9Xc7vBT6+OE1q1ljoQzNTHpfbEGmqfu6iZtaZpn8e//me7ROK
 TsGL+ZWVopadprX3JAUFzT16lhg+CR3ZhxVZd0mSG1UlqyczOyihiiRiv+k99IDjH1J+FbvM7
 hZUH68HrEH01vYgQFLUrM2AJ8VZWq4g/I2+aocqHUISDttJMcwfLO5qq4s7mm+9ZR6hF7f8MD
 s4D0lryXSyoTAMygN8LrJ9pxLAoSeww9/M7wdOXhV0AOqCrUcCrcqnVbQYGg2N/CL+33HkBod
 UrT0Bifl+xM9L58VYK+ywtUYOpRY7xxg5MGboHj6dzdjyfe40opMaPc5kFy0aT4Oyj9TOZ0Wo
 0WgqQ5EbNzSZpZ65RwZKnT0c7oEDoTx9XDEyQd3DJE1MUDGhYW2h9HzIwyStckKANsbrmUId5
 eAYxotqmQZbsacWRhukHZXjGg0QEdfqLo5JSHu0LWpqIOP1YslW/FZ3pWFdZv29HnlgQFRxYj
 +0obT1jKnn3UtaYa7UBxCpV/Py2RBs9Awkdxip4CcnEb1R8tQ95CjKNH+p2B6kMNAQuyq4kUK
 tghUem01zyT5wbrGJ9jWWq3j3YEq2Yh4p8RGt0K/S6lOJZft5fccWNpQ6XMgCaIQF7AscUQLx
 K7lOr592Ujw/g4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.22 um 12:58 schrieb Han-Wen Nienhuys:
> On Fri, Dec 24, 2021 at 5:16 AM Junio C Hamano <gitster@pobox.com> wrote=
:
>> Once you
>> initialize at the declaration with "less meaningful" value (like
>> zero initialization), the tools won't be able to tell when the code
>> uses that variable "uninitialized" (because the assignment was
>> skipped by a bug), since it appears to always be initialied to them.
>
> Which tools are these? When I add
>
> static void test_memcpy(void)
> {
>  uint32_t dest;
>  char not_init[200];
>  int i;
>  memcpy(&dest, not_init, sizeof(dest));
>
>  for (i =3D 0 ; i < 10; i++)
>   not_init[i] =3D rand() % 255 + 1;
>  printf("%d", (int) strlen(not_init));
> }
>
> to the C code, it compiles cleanly if I do "make DEVELOPER=3D1".

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html says about
-Wuninitialized:

   "Note that there may be no warning about a variable that is used only
    to compute a value that itself is never used, because such
    computations may be deleted by data flow analysis before the
    warnings are printed."

And indeed, dest is not used above.  But even if we change the funtion
to use dest by returning it, GCC versions 9.1 and higher don't warn
about the use of the uninitialized buffer.  GCC 4.7.1 to 8.5 do warn,
though: https://godbolt.org/z/zYz9KvPdK

Ren=C3=A9
