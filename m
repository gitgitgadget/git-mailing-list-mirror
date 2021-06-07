Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B002C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D4561059
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 23:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFGXnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:43:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59224 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFGXnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 19:43:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 750D7DB0DE;
        Mon,  7 Jun 2021 19:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+B9Omo0XHCiP
        abKvg/Oa1d+1IG8/I4xXzK2pmhMQzD4=; b=qgeqG0M9ieNaucZbqdiYt3RN+byP
        FJcdBsHP5x8xz923uOOfTueOGHzUwNnCXpo/ksaZXCMe7AdrgAj598UBHQEcz0K2
        PlQ8phxqcX22X9mskgcQy6/kCdsjKiDcp0Go0fj2gTUFcv2VJ6FcdKdt7j+Xley/
        WWu5dnkBucMRcIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 694B4DB0DD;
        Mon,  7 Jun 2021 19:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E40C1DB0DC;
        Mon,  7 Jun 2021 19:41:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
        <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
        <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
        <87k0n54qb6.fsf@evledraar.gmail.com>
        <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
        <8735tt4fhx.fsf@evledraar.gmail.com>
Date:   Tue, 08 Jun 2021 08:41:19 +0900
In-Reply-To: <8735tt4fhx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 07 Jun 2021 21:49:32 +0200")
Message-ID: <xmqqczsxtf8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC230EB2-C7E9-11EB-8E53-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So I think this pattern works:
>>
>> 	for (i =3D 0; i < nr; i++) {
>> 		display_progress(p, i);
>> 		/* work work work */
>> 	}
>> 	display_progress(p, nr);
>>
>> Alternatively, if the work part doesn't contain continue statements:
>>
>> 	for (i =3D 0; i < nr; i++) {
>> 		/* work work work */
>> 		display_progress(p, i + 1);
>> 	}
>
> But yes, I agree with the issue in theory, but I think in practice we
> don't need to worry about these 100% cases.

Hmph, but in practice we do need to worry, don't we?  Otherwise you
wouldn't have started this thread and Ren=C3=A9 wouldn't have responded.

I agree with the issue and I think we should count what we have
finished.

