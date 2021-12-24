Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D5CC433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 04:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbhLXEQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 23:16:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbhLXEQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 23:16:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7087F16D7AF;
        Thu, 23 Dec 2021 23:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=agJbAXpByv6kWSxvlpbbURVh9Ok35XLcsawT7zB9TGQ=; b=hMBK
        wwyFgO70mtKFBkjx3GA5vmmeBsuv2GhNygoi9Mk8f8eXviptgFnC3UDaBTmThGNe
        OdJtBzTJVofQikrSUzLpM0x/cS38RT9EGfDkHpmgcrDL42tmgNifZuBl6r3R4Nqi
        WiUFTsK1HOxxXsX5wqbUOrO9QPYuOU15OHLxVQ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68D3116D7AE;
        Thu, 23 Dec 2021 23:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68B9516D7AA;
        Thu, 23 Dec 2021 23:16:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length
 memcpy calls
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
        <xmqq1r24gsph.fsf@gitster.g>
        <CAFQ2z_OXPw9-hLsaD+E1nGESS7eJH5o5sRrr_R_vW1Oa-vvZoA@mail.gmail.com>
Date:   Thu, 23 Dec 2021 20:16:29 -0800
Message-ID: <xmqqy24a4oyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F52492-6470-11EC-950C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Dec 22, 2021 at 11:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > -     memcpy(r->hash_prefix, key.buf, key.len);
>> > +     if (key.len)
>> > +             memcpy(r->hash_prefix, key.buf, key.len);
>> >       r->hash_prefix_len = key.len;
>> >
>> >       if (val_type == 0) {
>>
>> I am not sure why any of these are needed.
>
> I'm not sure they are needed, but IMO it's not worth spending brain
> cycles on deciding either way. Checking the length is always a safe
> alternative.
>
> I would support having a safe_memcpy() that does this check centrally
> (note how our array_copy() array function also does this check, even
> if it's not always needed.)

But your safe_memcpy() should not be

    safe_memcpy(dst, src, n)
    {
	if (n)
		memcpy(dst, src, n);
	return dst;
    }

Using memcpy() with size==0 is not a crime wrt the language.
Passing an invalid pointer while doing so is.

It should rather be

    safe_memcpy(dst, src, n)
    {
	if (dst)
		memcpy(dst, src, n);
	else if (n)
               	BUG(...);
	return dst;
    }

to support a common pattern of <ptr, len> that lazily allocates the
ptr only when len goes more than zero from triggering an error from
picky runtime, compiler and tools.  We want to allow "dst==NULL &&
n==0", while still catching "dst==NULL && n!=0" as an error.

And these places, I do not think use of safe_memcpy() is relevant.
