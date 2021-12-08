Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FCBC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhLHLgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:36:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhLHLgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 06:36:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3745CE7997;
        Wed,  8 Dec 2021 06:32:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Dc99TGXC9g/kSbrTl01Grbi84
        DFL3VOvWBncY96F24M=; b=A7PWRnzZwt3c8bi+fmOmaEHGB0TERgLKQv5pnv9O4
        Be6B419NPawDaf72Bm1l+/oFJ/oWQrAWK/65sIOnCnMpyW11l/OVoDRIBO/oj8u7
        ib9w1r9stJI5hyMRiRs4UClDl7TefukcUrWweWGMSbLSd3N1+ZY7QbWYEmYxXhYX
        9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F4F0E7996;
        Wed,  8 Dec 2021 06:32:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78839E7994;
        Wed,  8 Dec 2021 06:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     "" =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= via GitGitGadget "" 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Elijah Newren" <newren@gmail.com>, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v18 3/3] am: support --allow-empty to record specific
 empty patches
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <4c3077f938435508850727e05ad514035f09bebb.1638939946.git.gitgitgadget@gmail.com>
        <xmqqmtlb4nvm.fsf@gitster.g>
        <220a9954.252.17d98caf6ad.Coremail.pwxu@coremail.cn>
Date:   Wed, 08 Dec 2021 03:32:37 -0800
Message-ID: <xmqq7dcf49ii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C232B24-581A-11EC-990D-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:

>> This series has been trying to add code to punish users who give
>> "--allow-empty" when the command would have worked the same way
>> without it at least since the last round, and I am not sure where
>> that wish to stop users comes from.  Please explain.  I am starting
>> to think I may be missing something and this extra rigidity may be
>> helping a user (but again, I do not see how).
>
> If there is no such code to check, the user can use
> "--allow-empty" to do the same thing as "--continue" or
> "--resolved" after resolving conflicts because they all go into
> `am_resolve()`. =20

Yes, exactly.  That is the point of "allow"; we continue normally,
and even in a narrow situation (i.e. input is empty, and no change
is made to the index) where we normally stop, we allow it to
continue by creating an empty commit.

> In my opinion, "--allow-empty" only makes sense
> to allow the user to create empty commits when:
>
>     1. the result is an empty change (`!index_changed`)
>     2. the input is an empty change (`is_empty_or_missing_file(am_path(=
state, "patch"))`)

Then you are forcing the user to use it ONLY whe nhe input is empty
and no other time.  Whatever that is, that is not "allow" empty.

>> Here is where we can use is-empty-or-missing on "patch" and give a
>> different message (i.e. "even though the patch file is not empty,
>> the result of your patch application did not change anything"), if
>> we wanted to.  Or you could choose to reject such an attempt, which
>> might be simpler.  I.e.
>>=20
>> 		if (allow_empty &&
>> 		    is_empty_or_missing_file(am_path(state, "patch"))
>> 			"No changes - recorded an empty commit."
>> 		else
>> 			... the original error for no changes ...
>>=20
>>=20
>> Hmm?
>
> Based on the previous checking, there is no need to check
> `is_empty_or_missing_file(am_path(state, "patch"))` here because it is =
permanently true.

I think you misunderstood.

If we correct the overly strict check that makes "--allow-empty" to
mean "only create empty, anything else is an error", the "is patch
an empty file?" must be checked here.

