Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E6C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiGLOqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiGLOqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:46:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EF599D0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:46:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43197131FF1;
        Tue, 12 Jul 2022 10:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QiVQ5dDzb7Z8wsASzRdbOgMhPdTAA7GqUDpO2q
        6pEG8=; b=u6NsSVFecW0xyNW78vYdHYYkow/2qNWaIdfdelZ1tEK+REU58rm+9R
        9mR1PrU64H1ybxO5YaXNPaW4HsSwhzPn4hQL/Tigj2pUb2bXn/QOhghGuVFz9NHJ
        BxI4ghv6Fbkx70o547NdgdxC+X3cEVv/hbiHAsQIxqHNWcoV4b9BM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AD87131FF0;
        Tue, 12 Jul 2022 10:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0367131FEF;
        Tue, 12 Jul 2022 10:46:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
References: <20220710081135.74964-1-sunshine@sunshineco.com>
        <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
        <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
        <xmqq7d4kp8l6.fsf@gitster.g>
        <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
        <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
        <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
Date:   Tue, 12 Jul 2022 07:46:27 -0700
In-Reply-To: <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 12 Jul 2022 03:13:50 -0400")
Message-ID: <xmqqczeaie2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 697ABC82-01F1-11ED-AFCB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> >     % git grep -n '{ *{ *0 *} *}'
>> >     builtin/merge-file.c:31: xmparam_t xmp = {{0}};
>>
>> Not so fast :) If you check out "next", does compiling
>> builtin/merge-file.o there complain on that clang version now? I changed
>> this to the "{ 0 }" form.
>
> No, builtin/merge-file.c doesn't compile, and I discovered that just
> after sending the email to which you responded. I haven't yet prepared
> a patch for that new instance since I don't know if Junio feels
> inclined to pick up such a change.

Wait, what do you mean by "doesn't compile"?  The compiler totally
chokes on "{ 0 } recursively zero initializes" idiom and does not
know what binary to produce, or it merely warns even though it knows
what to do with the code, but because we choose to give -Werror, it
is stopped from producing a binary?

>> It is nice though to be able to use standard C99 consistently, where a
>> "{ 0 }" recursively initializes the members, I think that's what your
>> clang version is doing, it's just complaining about it.
>
> Agreed, it would be nice to use plain `{0}`.
>
>> Since this is only a warning, and only a practical issue with -Werror I
>> wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
>> -Wno-missing-braces for this older clang version.
>
> I'm in favor of this. It would, of course, require extra
> special-casing for Apple's clang for which the version number bears no
> resemblance to reality since Apple invents their own version numbers.

I guess from this that you meant "we get an erroneous warning".  If
so, I am in favor of squelching the warning.
