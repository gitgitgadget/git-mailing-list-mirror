Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3CC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 04:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGKEif (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 00:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKEie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 00:38:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03088BEB
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 21:38:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C71FD1259D3;
        Mon, 11 Jul 2022 00:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tRuXZwGvmuEHRCMEyggExIjahLYYUn+iYtBruu
        gOG+0=; b=wLLMS47TR8SYM1W+JyoowZmiYinQGHivZKZBdwpqEy3NOFWpqrmJbl
        3XRsqkP2fV3Gb+ZFZ/hGqfNXKofkAhbr+XoDngLiySAXl1SH7YOiTxxeKj0pc60L
        bIcN3ruceInUdPMBtFB21+SleCybI+N+CXjwLEhrGnJ7HKCE2mMcE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB6D11259D1;
        Mon, 11 Jul 2022 00:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 059951259D0;
        Mon, 11 Jul 2022 00:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
References: <20220710081135.74964-1-sunshine@sunshineco.com>
        <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
        <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
Date:   Sun, 10 Jul 2022 21:38:29 -0700
In-Reply-To: <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 10 Jul 2022 22:41:12 -0400")
Message-ID: <xmqq7d4kp8l6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50B443EA-00D3-11ED-845B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jul 10, 2022 at 10:00 PM Han Xin <chiyutianyi@gmail.com> wrote:
>> On Sun, Jul 10, 2022 at 4:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On macOS High Sierra (10.13), Apple's `clang`[1] complains about missing
>> > braces around initialization of a subobject, which is problematic when
>> > building with `DEVELOPER=YesPlease` which enables `-Werror`:
>> >
>> >     builtin/unpack-objects.c:388:26: error: suggest braces around
>> >         initialization of subobject [-Werror,-Wmissing-braces]
>> >             git_zstream zstream = { 0 };
>> >
>> > [1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"
>> > -       git_zstream zstream = { 0 };
>> > +       git_zstream zstream = {{ 0 }};
>>
>> Not a comment, just wondering, when should I use "{ { 0 } }" and when
>> should I use "{ 0 }"?
>>
>> I didn't get the error with "Apple clang version 13.0.0
>> (clang-1300.0.29.30)",  because it's
>> a higher version ?
>
> I don't have a good answer. More modern `clang` versions don't seem to
> complain about plain old `{0}` here, but the older `clang` with which
> I'm stuck does complain.

I think, from the language-lawyer perspective, "{ 0 }" is how we
should spell these initialization when we are not using designated
initializers, even when the first member of the struct happens to be
a struct.

The older clang that complains at you is simply buggy, and I think
we had the same issue with older sparse.

