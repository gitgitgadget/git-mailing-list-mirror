Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB97C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhKVRIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:08:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52723 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhKVRIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:08:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8CBC153296;
        Mon, 22 Nov 2021 12:05:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WWb/pMbYPpRj
        71nGFvuVdEl96ab+v7N4Pc69eq6zL/I=; b=e51wNf0xbs7TGjJudokh6CRXj7RH
        yXfvoP7sMm6DmBHq2Udakj/NtlKV587nCd7Lr26yndnmkCHHq+8ioHHcFOtcDd86
        mXuwFFQB2qq58C6+H6+AvtdEHfHy6MyRAvcPi8402s5Q+nDXOM169ZzvTWMiIji9
        E7eJ/zyvcaQS0g8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B14EA153295;
        Mon, 22 Nov 2021 12:05:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED90A15328F;
        Mon, 22 Nov 2021 12:05:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
References: <20211117090410.8013-3-fs@gigacodes.de>
        <20211120150401.254408-1-fs@gigacodes.de>
        <20211120150401.254408-4-fs@gigacodes.de>
        <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 09:05:06 -0800
In-Reply-To: <211122.86y25gz9q7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 22 Nov 2021 12:52:42 +0100")
Message-ID: <xmqqh7c4i0jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58577FD6-4BB6-11EC-8007-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> -exec 5>&1
>> -exec 6<&0
>> -exec 7>&2
>
> This doesn't break (I think) with your change here because you only
> manipulate >&5, but I think the post-image would be lot clearer if...
>
>>  if test "$verbose_log" =3D "t"
>>  then
>>  	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
>
> ...this bit of code were moved up along with the "exec". They're
> currently intentionally snuggled together as we conditionally set the
> 3rd and 4th fd depending on verbose/tee settings right after the setup
> of 5/6/7, keeping them grouped in the post-image makes more sense than
> splitting them up here.

I actually have to wonder if the handling of 3 and 4 should be moved
down, not up like you suggest, so that they are grouped together
with the maybe_teardown_verbose and the maybe_setup_verbose helper
functions.  The lines we see here are the file descriptors that are
always redirected, which is a bit different.  Raising all of them up
to group them together is also fine.

In any case, the comment in front of the block of exec wants to
become a bit more detailed than just "# Set up additional fds", with
an explanation about which FD is used for what.

And any change that involves handling of FD #4 probably wants to
further include the BASH_XTRACEFD setting.

Thanks.
