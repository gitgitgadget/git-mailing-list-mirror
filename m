Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7896C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379680AbiBEIE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 03:04:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58754 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbiBEIEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 03:04:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A9201792AA;
        Sat,  5 Feb 2022 03:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=skLUGmbyuwW/
        BqIRQaN1n1a2FMX+ETMxA34mN7+IVcY=; b=tc6nq4rHvtnC4wXwhvPcQvQh//N1
        TfeKvZi7cEdoqkXArXhm3CheWYXnz3exIBxasKWtYXp8Os6Z+9H6ZTW7aOvEYlbT
        lPfYENsreKUOc+p82fwnJbXWAseRoDgtmgkFWe4D46pVvSPS2ETMgJRF92dY+Opi
        5jLq4nwNYeD5fWg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 780301792A9;
        Sat,  5 Feb 2022 03:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BAB9D1792A8;
        Sat,  5 Feb 2022 03:04:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bojun Chen <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
        <20220129063538.24038-1-bojun.cbj@gmail.com>
        <xmqqczk6b3pt.fsf@gitster.g>
        <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com>
Date:   Sat, 05 Feb 2022 00:04:21 -0800
In-Reply-To: <CADuS7AoAbtbC3RKrXR=SGvfs7C-n57Y9zkaGne_XrfyJh46zXg@mail.gmail.com>
        (Bojun Chen's message of "Sat, 5 Feb 2022 15:17:32 +0800")
Message-ID: <xmqqwni9kad6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A78B12C-865A-11EC-99AF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bojun Chen <bojun.cbj@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 06:51=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Chen BoJun <bojun.cbj@gmail.com> writes:
>>
>> > From: Chen Bojun <bojun.cbj@alibaba-inc.com>
>> >
>> > When pushing a hidden ref, e.g.:
>> >
>> >     $ git push origin HEAD:refs/hidden/foo
>> >
>> > "receive-pack" will reject our request with an error message like th=
is:
>> >
>> >     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hid=
den ref)
>> >
>> > The remote side ("git-receive-pack") will not create the hidden ref =
as
>> > expected, but the pack file sent by "git-send-pack" is left inside t=
he
>> > remote repository. I.e. the quarantine directory is not purged as it
>> > should be.
>>
>> I was puzzled by the reference to "pushing a hidden ref" at the
>> beginning of the proposed log message, as it wasn't quite clear that
>> it was merely an easy-to-reproduce recipe to fall into such a
>> situation where all ref updates are rejected.
>>
>
> Thanks for the suggestion. Do I have to rewrite this commit message on =
the v3?

If you can make it more clear that "hidden refs" is merely one
sample scenario that may mark all elements on the commands list
as failed, that would be great.
