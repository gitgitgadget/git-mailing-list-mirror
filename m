Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A75C433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9C864DF0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBLTgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:36:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62907 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBLTgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 14:36:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D43771186A9;
        Fri, 12 Feb 2021 14:36:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wIpjNM5o8Ek6R3JUTv6z7KzVveo=; b=gtCzei
        sgbBVPUyWzFzhRFfaRRaiGplbsisU8DvDdlqZfU0xWk/6z7gG5dmYDBsHGf8a/AW
        pyPBuAZMfxS3v0Zp3m9EancR20ZRhXQUCeKi8aav6CD81PdyrK169+feW9Vg+7hu
        vE9MCOh2S0M/xkhBkNRxTtNiaH40VMlcErxm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xFLN8Pq5zaKaxS78Lsr/RreoFW0LvdyY
        BMQz60TDD7xm2Q+vgkaJ7UGhUWJ2vS269j10Yf24g7IVPeL9sWVvjMMV0lrG4ghC
        dO408pV+gHqL0KMpsDYUn+Eo3vBbtEvB7vCa8AWgh6otznO1UmiYD4In+dIGBKhZ
        zWZ/t+8iAgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCBC31186A8;
        Fri, 12 Feb 2021 14:36:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E4EE1186A4;
        Fri, 12 Feb 2021 14:35:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] reflog expire --stale-fix: be generous about missing
 objects
References: <pull.873.git.1612973499110.gitgitgadget@gmail.com>
        <xmqqy2fv1x98.fsf@gitster.c.googlers.com>
        <YCUQkqXNXFzBs7aA@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2102121702120.29765@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Feb 2021 11:35:58 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102121702120.29765@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 12 Feb 2021 17:04:08 +0100
        (CET)")
Message-ID: <xmqqy2ftuli9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88E68768-6D69-11EB-96C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Possibly the correct answer here is "turn off reflogs in new.git", but
>> they are sometimes useful, and things _mostly_ work (for history that
>> doesn't rewind, or where the rewound bits are specific to new.git). So
>> it's useful to be able to run something like "reflog expire --stale-fix"
>> to clear out the occasional problem.
>>
>> (A careful reader will note that objects mentioned only in the index
>> have a similar problem; but again, those tend to be local to new.git,
>> and don't exist at all in a server context).
>
> I want to add the experience with that half year during which `git gc`
> with worktrees was broken, as it would happily ignore the reflogs of the
> worktree-specific `HEAD`s, all except the one from the worktree from which
> `git gc` was run. That was some fun time, and `--stale-fix` was a life
> saver.

The option was invented for a specific case, but if its "fix"
applies for breakages caused by more recent bugs and user induced
actions, I would agree that that it gives us a good reason to keep
it around.

I have to wonder if the explanation in the documentation for the
option needs to be made less specific to the originally motivating
case, though.

Thanks.
