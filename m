Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C8C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiATTP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:15:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377466AbiATTOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 14:14:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55D1317AB58;
        Thu, 20 Jan 2022 14:14:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V1ETw4iP3UdM
        fJiWuFq4fz1/GUirmFj9+1uxTUei8QE=; b=fJ2mFnSIvgRIjg7vad55Z1zqLJVG
        XwHYr37Nm4AaUuLJKjNQHZaIcMq4FylN3JTqA1ESn5vOqHGh1ZucarqYrGykChgz
        oQKT1RbnjbD7nJWY3vDukNLmYJ3HBffb5H9D6gsapWANCF9SI+rOVVv3fYtpuhYo
        iBupvmmGPZNYV20=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DDE517AB57;
        Thu, 20 Jan 2022 14:14:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9FE317AB54;
        Thu, 20 Jan 2022 14:13:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
        <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
        <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com>
        <xmqqv8yovlc2.fsf@gitster.g>
        <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
        <xmqqr193j8y4.fsf@gitster.g>
        <220120.86czkmn6gj.gmgdl@evledraar.gmail.com>
Date:   Thu, 20 Jan 2022 11:13:57 -0800
In-Reply-To: <220120.86czkmn6gj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jan 2022 09:42:27 +0100")
Message-ID: <xmqqfspii5je.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E95085C-7A25-11EC-B081-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jan 19 2022, Junio C Hamano wrote:
>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Even if the helper is finalizing the current hunk then I think that
>>> "nonsense" hunk would still wrong as it would be calling
>>> finalize_hunk() on _every_ context line in the hunk rather than just
>>> being called once to finalize the hunk.
>>
>> True; this triggers every time we finish reading the common context
>> lines and not at the end of hunk.  In any case, I think what we
>> queued looks good for 'next'.
>
> For what it's worth (and as the person who started this side-thread) I
> agree. This looks good as-is, thanks both!
>
>>>>   -		if ((marker =3D=3D '-' || marker =3D=3D '+') && *p =3D=3D ' ')
>>>> -			hunk->splittable_into++;
>>>> +		if (*p =3D=3D ' ')
>>>> +			complete_file(marker, &hunk->splittable_into);

Yup, thanks all.  The fix is now in 'next' and I expect we can
safely merge it down as part of the first batch next cycle.

