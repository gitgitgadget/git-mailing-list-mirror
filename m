Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A44C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 01:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiAVBLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 20:11:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiAVBLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 20:11:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6F1415D17E;
        Fri, 21 Jan 2022 20:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=cJ7V2wmYY1s+pQZdgtVabAIlv
        RrqGHzTVcLxb5IBKc4=; b=WQEq+D+yHD3zjVnlEQEqh3EWwDRNKdypwPdDD4sxN
        aMRNZ02UT8f7Tbgnn/k80925zRDfMGYJsjEgioXlDn2gUJZJ9PUhCKjX6ZnFXlXZ
        dnJhqIew7fuZOG6ajjYSyWAoRWhWqs8qeBgRS7KyOJoorMTkR5mzP0H7BtcKqE3k
        Nk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFAE815D17D;
        Fri, 21 Jan 2022 20:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 559E115D17C;
        Fri, 21 Jan 2022 20:11:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 02/15] reftable: fix resource leak in block.c error path
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <315ce62e710e6e80dc8a4d959e5532b5f9142669.1642691534.git.gitgitgadget@gmail.com>
        <220121.865yqdl3ff.gmgdl@evledraar.gmail.com>
Date:   Fri, 21 Jan 2022 17:11:51 -0800
Message-ID: <xmqq5yqcd160.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 484A9670-7B20-11EC-8DB0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:
>
>> From: Han-Wen Nienhuys <hanwen@google.com>
>>
>> Add test coverage for corrupt zlib data. Fix memory leaks demonstrated=
 by
>> unittest.
>>
>> This problem was discovered by a Coverity scan.
>>
>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> ---
>>  reftable/block.c          | 26 +++++++++------
>>  reftable/reader.c         | 23 ++++++++------
>>  reftable/readwrite_test.c | 66 ++++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 97 insertions(+), 18 deletions(-)
>>
>> diff --git a/reftable/block.c b/reftable/block.c
>> index 855e3f5c947..6c8e8705205 100644
>> --- a/reftable/block.c
>> +++ b/reftable/block.c
>> @@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, s=
truct reftable_block *block,
>>  	uint32_t full_block_size =3D table_block_size;
>>  	uint8_t typ =3D block->data[header_off];
>>  	uint32_t sz =3D get_be24(block->data + header_off + 1);
>> -
>
> stray extra whitespace being added in the middle of variable
> declarations.

Hmph.  Isn't it removing a blank line?
