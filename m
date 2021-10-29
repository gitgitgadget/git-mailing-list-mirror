Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFFC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF823600CC
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ2UBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:01:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62361 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJ2UBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:01:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9F9216AD2E;
        Fri, 29 Oct 2021 15:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=weKdpKwQRfS5lhfnmpeIz6zRs0KnnpMZg1meVX
        hxkds=; b=CvlRR0O4m33Zt2bm+/tWX6tRRfYKMMBi1dD1cU73hwl59WUuTyqkce
        JOorCE5lR1+XXagEbxOUjJgq90ax1thNiRWG4EEczUvip8S8+G/9zp1B2YpqTT14
        cOhm7MJtu3uwb0JG6kHMVNbWsW/M+uvF/jvKd8JBE5ZcDusCYN57A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2DC716AD2D;
        Fri, 29 Oct 2021 15:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B9C416AD24;
        Fri, 29 Oct 2021 15:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Frade <ifrade@google.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] fetch-pack: redact packfile urls in traces
References: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
        <c95b3cafcd66ce64a140b767664a8fc98eb535bf.1635461500.git.gitgitgadget@gmail.com>
        <xmqqa6isohve.fsf@gitster.g>
        <CANQMx9VXRnLjMgvYM63tq8aecvWNd-0cxi+XMSkkwm-iUeX+1g@mail.gmail.com>
Date:   Fri, 29 Oct 2021 12:59:03 -0700
In-Reply-To: <CANQMx9VXRnLjMgvYM63tq8aecvWNd-0cxi+XMSkkwm-iUeX+1g@mail.gmail.com>
        (Ivan Frade's message of "Fri, 29 Oct 2021 11:42:36 -0700")
Message-ID: <xmqqbl37li0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB29EE32-38F2-11EC-8C3D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Frade <ifrade@google.com> writes:

> On Thu, Oct 28, 2021 at 4:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>
>> > +     len = strspn(buffer, "0123456789abcdefABCDEF");
>> > +     if (!(len == 40 || len == 64) || buffer[len] != ' ')
>> > +             return NULL; /* required "<hash>SP" not seen */
>>
>> People may have comments on hardcoded 40/64 here and offer a better
>> way to write it ;-)
>
> Latest version uses the_hash_algo->hexsz:
>
> +       if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
> +               return NULL; /* required "<hash>SP" not seen */
>
> Thanks!

OK.  If the <hash> is given by this side (as opposed to "you started
to talk to a remote, and it turns out that you are still talking
SHA-1 but the other side talks SHA-256 and their <hash> size that is
64 does not match your 40" case), then checking against
the_hash_algo->hexsz should be sufficient.  The original suggestion
was tried both because I didn't know where <hash> originates, and we
would want to redact even in such a hash type mismatch case.

Thanks.  Will take a look at the updated one.
