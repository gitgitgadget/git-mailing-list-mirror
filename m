Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8860D61BD3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhKQJWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:22:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59718 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhKQJWK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:22:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7374116C3EE;
        Wed, 17 Nov 2021 04:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=KmIdf7MEiepYRAAHrZJXo6xlf8UKVMhxRMfGoYs+bfA=; b=reAT
        JDxT91GpPZiwiDJNEN80eKg+o2CIattjPQYZRDrJej4Hmbu1Uh5uUX91cxBtDlpO
        Ed/mcx3sPpO04/YYa7PNX5TBYxdqxG2GgK9ZbZOLVICYOw0DDzh8qEaWZFPWOxUO
        0dsbcuy3kplCcYuuU2JxHa68hUULaksxJEpA4Vo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BFDC16C3ED;
        Wed, 17 Nov 2021 04:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF0FC16C3EA;
        Wed, 17 Nov 2021 04:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mergesort: avoid left shift overflow
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
        <nycvar.QRO.7.76.6.2111161505500.21127@tvgsbejvaqbjf.bet>
Date:   Wed, 17 Nov 2021 01:19:08 -0800
Message-ID: <xmqqr1bf2l83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BEF2112-4787-11EC-BE21-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/mergesort.c b/mergesort.c
>> index 6216835566..bd9c6ef8ee 100644
>> --- a/mergesort.c
>> +++ b/mergesort.c
>> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
>>  		void *next = get_next_fn(list);
>>  		if (next)
>>  			set_next_fn(list, NULL);
>> -		for (i = 0; n & (1 << i); i++)
>> +		for (i = 0; n & ((size_t)1 << i); i++)
>
> I was a bit concerned about the operator precedence (some of which I
> remember by heart, some not), but according to
> https://en.cppreference.com/w/c/language/operator_precedence the cast has
> a higher precedence than the shift operator.
>
> I would have preferred an extra pair of parentheses around `(size_t)1` so
> that I (and other readers) do not have to remember or look up the operator
> precedence, but it _is_ correct.

Interesting.

I do not quite see the need for it myself, but if we wanted to, we
can smoke them out with this, I think.

	$ cat >contrib/coccinelle/cast.cocci <<-\EOF
	@@
	type T;
	expression V, C;
	@@
	-(T) V << C
	+((T) V) << C
	EOF
	$ make contrib/coccinelle/cast.cocci.patch
	$ git apply --stat contrib/coccinelle/cast.cocci.patch
         compat/mingw.c     |    2 +-
         compat/mingw.c     |    2 +-
         ewah/bitmap.c      |    2 +-
         ewah/ewok_rlw.h    |    6 +++---
         ewah/ewah_bitmap.c |    8 ++++----
         ewah/ewok_rlw.h    |    6 +++---
         ppc/sha1.c         |    2 +-
         wrapper.c          |    2 +-
         8 files changed, 15 insertions(+), 15 deletions(-)


