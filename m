Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3BC4332F
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiDGSml (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346904AbiDGSmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:42:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F5DEB3
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:40:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63A2F135D63;
        Thu,  7 Apr 2022 14:40:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=6ef+/kfjuhFgv2wAtFAUtqn7Y
        X55FVq0jftpvUS8Xas=; b=RUQM7V9v0nHDsamyVp0yWS6t6cX5ztP8GbcrhoQNq
        1wN+L8UOPj46bO92VkmiVo/gszpIn4UZdAYgnl9zmYWld0/qFY+ot/BK8kf3jsUJ
        El9zhEM/6lZoThEQUIeiiZtlBDIOe+12wBe+ZInWz7hmvN9/pQ3krewwwIRPr+8X
        84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A695135D62;
        Thu,  7 Apr 2022 14:40:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BED66135D61;
        Thu,  7 Apr 2022 14:40:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, Fabian Stelzer <fs@gigacodes.de>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in
 9c4d58ff2c3
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
        <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
        <xmqqwng2xfi8.fsf@gitster.g>
        <220406.8635iqdjzl.gmgdl@evledraar.gmail.com>
        <xmqq4k35x4m6.fsf@gitster.g>
        <220407.86y20hcpy5.gmgdl@evledraar.gmail.com>
Date:   Thu, 07 Apr 2022 11:40:33 -0700
Message-ID: <xmqqee28spni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36901410-B6A2-11EC-BF56-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>> Let's not go too cute like this.  This forces the caller to remember
>>>> which among 6, 7, and 8 corresponds to which option.  It is too ugly
>>>> to live.
>>>
>>> I think it's rather elegant actually, but to be fair it would, per:
>>>
>>> 	git grep '<&[1-9]| [1-9]<<-'
>>>
>>> Be the user with the most FD's using this sort of pattern.
>>
>> Please give a clear explanation why "-d" has to be 6, "-r" 7 and
>> "-t" 8, that can be used by developers as a memory aid to help them
>> write new tests using the helper.
>
> It's documented when test-lib.sh does the redirection, since Fabian
> Stelzer's a6714088e0c (test-lib: make BAIL_OUT() work in tests and
> prereq, 2021-12-01).

Sorry, but that is not what I asked.  I know what we use lower file
descriptors for, and I didn't ask why we start from 6 (as opposed to
3).

The updated helper forces our developers to know that the expected
result for "-d" has to go to #6 (not #7 or #8), and "-r" to #7 (not
#6 or #8), etc., in order to write new tests using it, and in order
to spot a mistake while reviewing such new tests.

It is an invitation to unmaintainable mess.  Don't encourage it.
