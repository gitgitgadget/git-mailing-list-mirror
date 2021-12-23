Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F34C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbhLWS7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:59:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63292 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLWS7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:59:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD521EE07F;
        Thu, 23 Dec 2021 13:59:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5Q+axDMP8dst
        TOdphH6O16QMg9EsCOqyLjKZARjCE/o=; b=sPbQy9/G2Xp2fyf0Ja07WjLP0qj9
        bOZexzvkPWnLKBFXDHo/V83Y3JXEDbChSzuHmgOYVKdlgtCZv3YuhmI0F7D0idO8
        Dijkd8VQjcC5LYmVQIE7qzgTpkvGkvLTcgCaWLTKp8q2ahhmhbx3SDHlKKqseuat
        zp1WSpJXOWzLU9M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4089EE07E;
        Thu, 23 Dec 2021 13:59:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15D21EE07D;
        Thu, 23 Dec 2021 13:59:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length
 memcpy calls
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
        <xmqq1r24gsph.fsf@gitster.g>
        <af378ac5-a24c-5110-04a7-3257a909815b@web.de>
Date:   Thu, 23 Dec 2021 10:59:06 -0800
In-Reply-To: <af378ac5-a24c-5110-04a7-3257a909815b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 23 Dec 2021 10:49:25 +0100")
Message-ID: <xmqqo857b11h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 682DBCDE-6422-11EC-A94A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> @@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, =
struct strbuf key,
>>>  	uint64_t last;
>>>  	int j;
>>>  	r->hash_prefix =3D reftable_malloc(key.len);
>>> -	memcpy(r->hash_prefix, key.buf, key.len);
>>> +	if (key.len)
>>> +		memcpy(r->hash_prefix, key.buf, key.len);
>>>  	r->hash_prefix_len =3D key.len;
>>>
>>>  	if (val_type =3D=3D 0) {
>>
>> I am not sure why any of these are needed.
>> ...
> I don't know about the first two, but in the third case dst (i.e.
> r->hash_prefix) might be NULL if key.len =3D=3D 0, reftable_malloc is m=
alloc
> (which it is, because reftable_set_alloc is never called) and malloc(0)
> returns NULL (which it might do according to
> https://www.man7.org/linux/man-pages/man3/malloc.3.html).
>
> malloc can return NULL on failure, too, of course, and none of the
> reftable_malloc callers check for that.  That seems a bit too
> optimistic.

Yeah, I agree that the real bug in this code is that the returned
value of malloc() is not checked.  But checking if key.len is zero
before using memcpy() would not help fix it, or hide it.  So I am
not sure if that is a counter-argument against "this check is
pointless".

Thanks.

