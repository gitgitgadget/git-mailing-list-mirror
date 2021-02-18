Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D6EC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C74B64EB3
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBRX00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:26:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60176 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBRX0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 18:26:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F146912C656;
        Thu, 18 Feb 2021 18:25:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z9r8Wvwt/qmj
        Wq6gxE9bsZ4mVFM=; b=HJub/124SR9Zx4XR+o1lXMILqQ7dlwWh0fkhdWbJRRbh
        WIVd6aRCVtKcBwq4WTw8UYG4GWp67pNOPssnmnnru6ShxsgepXn/r1pjLVLP+Gkq
        A1UfrNqfEb4/2vZK/VzOyEYTGkBd1pVN71hq+/N/q8kZ/vw7DC7+v1g7fCdCHAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nH9QCk
        2IQ3u1RTQQE3MJ0IYxQ79stZ9EryWquPMd0Y+1liqMpddG1H31MjYEnvez+P4eIB
        JX8MbtPikKp9zFzNY2nqpikA1OegYVTBIY3BM9vznl2bWa+Tn0PIJKJAs8LZ/XXY
        eA7vH27XnmCQdDd21Ml/15fFPrJieuiKGelrk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E84E312C655;
        Thu, 18 Feb 2021 18:25:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3753112C654;
        Thu, 18 Feb 2021 18:25:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] Speed up remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <7a1a8990-59e7-d538-d382-446fdc270810@gmail.com>
Date:   Thu, 18 Feb 2021 15:25:28 -0800
In-Reply-To: <7a1a8990-59e7-d538-d382-446fdc270810@gmail.com> (Derrick
        Stolee's message of "Mon, 1 Feb 2021 10:48:02 -0500")
Message-ID: <xmqq8s7lc61j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 970A4542-7240-11EB-B6C5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/1/2021 7:47 AM, Derrick Stolee via GitGitGadget wrote:
>> My tests were on the Linux kernel repository, testing this command:
>>=20
>>   git merge-base --independent $(git for-each-ref refs/tags --format=3D=
"%(refname)")
>>=20
>>        Before: 16.4s
>> After Patch 1:  1.1s
>> After Patch 2:  0.1s
>
> During my testing of v2, I discovered how remove_redundant()
> is being used as part of 'git log --simplify-merges'. So, here
> are some performance numbers for the Linux kernel repository
> with a full commit-graph and changed-path Bloom filters running
>
>   git log --oneline -n10 --simplify-merges -- kernel/
>
> Benchmark #1: old
>   Time (mean =C2=B1 =CF=83):      5.770 s =C2=B1  0.030 s    [User: 5.5=
51 s, System: 0.219 s]
>   Range (min =E2=80=A6 max):    5.728 s =E2=80=A6  5.827 s    10 runs
> =20
> Benchmark #2: new
>   Time (mean =C2=B1 =CF=83):      5.030 s =C2=B1  0.017 s    [User: 4.8=
05 s, System: 0.224 s]
>   Range (min =E2=80=A6 max):    4.999 s =E2=80=A6  5.054 s    10 runs
> =20
> Summary
>   'new' ran
>     1.15 =C2=B1 0.01 times faster than 'old'


This topic seems to have been forgotten?  Is the only thing missing
is an updated 2/5 or is there anything more that is needed?
