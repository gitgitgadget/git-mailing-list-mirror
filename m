Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC4DC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534C023158
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbhAFWhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:37:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53767 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbhAFWhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:37:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD016B42D5;
        Wed,  6 Jan 2021 17:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kU/qAxGI1Ebm
        w8MGyqkzqe8s0O4=; b=LMj5puYlGY0PrQdeHRd4lwubaUKbNom7o1xk9oWlpuQm
        QmH8LQFulzvwcsSblk/Wpj3LfeO9tshBM1VguzL3KpqRZa1gTxXxeeRMU2fJ6ENN
        CzSW0LxRgxqNTIYzcKUCgeuhX0vgHRNmtDsKhnWFmjGws+QUM0uLMYOavQj13xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NpMl7O
        JwEFHdQ4cS7bHw+0G9PdTb22k06KgOEpHEerLN8nw/yReAKSJHD40MINHpzf6yxB
        eiRMUpJcle/QcjNmnQd9dGiUWKF7+lcnUv8b2kjpuZU1uai4MM5jre/KGedv4Fdo
        nsd5oREDLXXWONyCvlrvHnuqWdDl2zI/Dbpa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3A9CB42D4;
        Wed,  6 Jan 2021 17:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23799B42D3;
        Wed,  6 Jan 2021 17:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
References: <cover.1609874026.git.martin.agren@gmail.com>
        <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
        <xmqq5z4as2j9.fsf@gitster.c.googlers.com>
Date:   Wed, 06 Jan 2021 14:36:55 -0800
In-Reply-To: <xmqq5z4as2j9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 Jan 2021 03:55:22 -0800")
Message-ID: <xmqqim89pu9k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE5981A6-506F-11EB-8CCA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 1/5/2021 2:23 PM, Martin =C3=85gren wrote:
>>> I made a comment in [1] about how we could avoid peeking into a `stru=
ct
>>> lock_file` and instead use a helper function that we happen to have a=
t
>>> our disposal. I then grepped around a bit and found that we're pretty
>>> good at avoiding such peeking at the moment, but that we could do
>>> a bit better.
>>>=20
>>> Here's a series to avoid such `lk.tempfile.foo` in favor of
>>> `get_lock_file_foo(&lk)`.
>>>=20
>>> [1] https://lore.kernel.org/git/CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+=
wz6NXCXTsfcvGg@mail.gmail.com/
>>
>> Thanks for being diligent and keeping the code clean.
>>
>> This series is good-to-go.
>>
>> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
>
> Thanks, both.

I liked what I saw.  The code after these patches got certainly
clearer.

But it was not quite clear what I was *NOT* seeing in these patches.

IOW, how extensive is the coverage of these patches?  If we renamed
the .tempfile field to, say, .tmpfile in "struct lock_file" in
"lockfile.h", for example, would "lockfile.[ch]" be the *only* files
that need to be adjusted to make the code compile again?  The same
question for various fields in "struct tempfile".

