Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D5C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DCB60F39
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhH1BaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:30:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55896 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhH1BaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:30:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46D5113821F;
        Fri, 27 Aug 2021 21:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DP53HVhUBFctaKbKns52papUt9ds3AM6glsd9s
        /bzWg=; b=fDuzmZB8Or/EMa/eaw2KfVgx9oQye0/EsBerLdovlXM2pdDGydm6kY
        i54LeQkxqroshoGxFKbhGo3/dr6y5EBvgdRXA5ePcyDeHgBj2zpOh8d+p8FM4qUw
        OmAud4RUqV1jFep83YfsO1zcBvTsrV5Q1htDR1xGwnvbOUxZ1l8Hg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40A5913821E;
        Fri, 27 Aug 2021 21:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E14413821C;
        Fri, 27 Aug 2021 21:29:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
        <xmqq8s0m9xbl.fsf@gitster.g>
Date:   Fri, 27 Aug 2021 18:29:30 -0700
In-Reply-To: <xmqq8s0m9xbl.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        27 Aug 2021 18:23:26 -0700")
Message-ID: <xmqq4kba9x1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64EAE1EE-079F-11EC-B79D-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +void strvec_pushvec(struct strvec *array, const struct strvec *items)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < items->nr; i++)
>> +		strvec_push(array, items->v[i]);
>> +}
>
> This implementation is not wrong per-se, but is somewhat
> disappointing.  When items->nr is large, especially relative to the
> original array->alloc, it would incur unnecessary reallocations that
> we can easily avoid by pre-sizing the array before pushing the
> elements of items from it.
>
> In the original code that became the first user of this helper, it
> may not have made much difference, but now it is becoming a more
> generally reusable API function, we should care.

And if we do not care, you can rewrite the code that became the
first user of this helper to instead call strvec_pushv() on the
items->v array that is guaranteed to be NULL terminated, without
inventing this new helper.

I think I am fine with either way.
