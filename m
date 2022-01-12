Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F4BC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356366AbiALTCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:02:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65224 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbiALTCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:02:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B43A616B953;
        Wed, 12 Jan 2022 14:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bSFA+ppkkcuSF3eosV/5ygIWX09Z7wxJhsCHis
        f1mzM=; b=DHVmCEKemxaaV1jPs+luNyZ9+g7s+C+EtyNippeKuKPc6vDgbBLjA1
        raYfuw4axzExZl7sDiO3ZMq5ap0RrMf98sS7lWJwCZQYa/vysXdtRbD8AGinIsiy
        7LhKqvrk8W4JxPEiCSLF+0gBHkSt5FnX7ckbTEFZ3Y+WVjNcRJ1/I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAE5F16B951;
        Wed, 12 Jan 2022 14:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 247B616B94F;
        Wed, 12 Jan 2022 14:02:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
        <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
        <Yd3aZ5Q9Ph0H+Ijn@nand.local>
        <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
        <Yd3dao5Qh5yl/cBs@nand.local>
        <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
        <Yd3mCVLyxkVTNcS9@nand.local>
        <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
Date:   Wed, 12 Jan 2022 11:02:05 -0800
In-Reply-To: <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org> (Johannes Sixt's
        message of "Tue, 11 Jan 2022 21:21:11 +0100")
Message-ID: <xmqqh7a8vkuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23298A56-73DA-11EC-A3BC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.01.22 um 21:18 schrieb Taylor Blau:
>> On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
>>> Am 11.01.22 um 20:41 schrieb Taylor Blau:
>>>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
>>>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
>>>>>> In any case, you're only setting the lower half of `min` high. Maybe:
>>>>>>
>>>>>>     uint64_t min = ~0ul;
>>>>>
>>>>> yeah, that works.
>>>>
>>>> I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
>>>> somebody more confident than I in this area would be welcome :).
>>>
>>> It does not work on Windows: unsigned long is 32 bits wide. You have to
>>> make it
>>>
>>>    uint64_t min = ~(uint64_t)0;
>> 
>> Perfect; this is exactly what I was looking for. Thanks!

That sounds perfect.

> Actually, on second thought, UINT64_MAX would be even better.

I wouldn't introduce use of UINT64_MAX, which "git grep" does not
produce any hits for.

Unless it is very early in a development cycle, that is, in which
case we have enough time to help platforms that are not quite POSIX.

