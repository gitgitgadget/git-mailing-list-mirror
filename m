Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AFEC433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCZBZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCZBZP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 21:25:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2F3D4B9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:23:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A08C11B74A;
        Fri, 25 Mar 2022 21:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MZTsvhWldsLq
        QHNz9JmF9jFgiGFE4oqrkiC8PQCpfRM=; b=G5Z//7NBtwxptOquOE+SII+RP6vl
        KivTVl17rvHrItZn+Ru4VUMGDYc0NlCcZHKlvEiq0In8pT75OzGv8DVxfM0Jomts
        1dGN1cifrTCyY6Oh2Ug/0gR2DafCaMAlgUgfebA63Uet+R1vkvSV9HYrcQLaei3H
        mMCBxCgfBKiwDqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FDAB11B749;
        Fri, 25 Mar 2022 21:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D831511B748;
        Fri, 25 Mar 2022 21:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: do we have too much fsync() configuration in 'next'?
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
        <20220315191245.17990-1-neerajsi@microsoft.com>
        <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
        <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
        <220326.86ils1lfho.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Mar 2022 18:23:37 -0700
In-Reply-To: <220326.86ils1lfho.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 26 Mar 2022 01:24:57 +0100")
Message-ID: <xmqqk0ch7bhi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D72252C-ACA3-11EC-BAFB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> We've gone over this a few times already, but just wanted to state it
>> again.  The really detailed settings are really there for Git hosters
>> like GitLab or GitHub. I'd be happy to remove the per-component
>> core.fsync values from the documentation and leave just the ones we
>> point the user to.
>
> I'm prettty sure (but Patrick knows more) that GitLab's plan for this i=
s
> to keep it at whatever the safest setting is, presumably GitHub's as
> well (but I don't know at all on that front).

I thought we've already settled it long ago, and it wasn't like you
were taking vacation from the list for a few weeks.  Why are we
talking about this again now?  Did we discover any new argument
against it?

Puzzled.
