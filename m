Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3443C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 16:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiEZQgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiEZQgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 12:36:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1A4D9F0
        for <git@vger.kernel.org>; Thu, 26 May 2022 09:36:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD711124C9E;
        Thu, 26 May 2022 12:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kLfOT+coTOkr
        +/p2R2NTH51Is8H9Twxh98xYs/LY/bE=; b=PD4E1NG6Fs0nrYvoNgv/AwAmNx9S
        eNW6+r5cIaB65s+4vUizTTsevK3gtBTtnErYXmIxLMuig2pTKQHMEMaePoDQUnU0
        GOQNs/65x3Na4Ws19OsF3aPzKIhxR+S4qKRZlT6CkDXvpKZnHHkLayCQx+r1bqpn
        K7idZF8nP4xoPng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A82E0124C99;
        Thu, 26 May 2022 12:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1A62124C98;
        Thu, 26 May 2022 12:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
        <xmqqbkvl8s88.fsf@gitster.g> <xmqqczg13xpy.fsf@gitster.g>
        <220526.86pmk060xa.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 09:36:20 -0700
In-Reply-To: <220526.86pmk060xa.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 12:16:23 +0200")
Message-ID: <xmqqpmk01caj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9FF3828-DD11-11EC-A0C2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The current proposal is large by line count, but it's relatively easy t=
o
> skim it and assure oneself that a new parameter is being passed in, and
> that all the proposed behavior change applies only to the one caller
> that passes in that new parameter.
>
> Whereas switching to a new non-callback based API will require carefull=
y
> going over the parallel API line-by-line, assuring oneself that the
> non-callback version is really doing the same thing etc.

I was worried about something like that when I wrote (admittedly
unfairly, in a somewhat frustrated state) that the series was
designed to be hard to revert.  The reverting itself was reasonably
easy if the "did we invoke the hook, really?" topic is discarded at
the same time, but if was done with too much rearchitecting, it is
understandable to become cumbersome to review X-<.

I wonder if rebuilding from scratch is easier to review, then?  The
first three patches of such a series would be

 - Revert cb3b3974 (Merge branch 'ab/racy-hooks', 2022-03-30)
 - Revert 7431379a (Merge branch 'ab/racy-hooks', 2022-03-16)
 - Revert c70bc338 (Merge branch 'ab/config-based-hooks-2', 2022-02-09)

and then the rest would rebuild what used to be in the original
series on top.  There will be a lot of duplicate patches between
that "the rest" and the patches in the original series (e.g. I would
imagine that the resulting hook.h would look more or less
identical), but "git range-diff" may be able to trim it down by
comparing between "the rest" and "c70bc338^..c70bc338^2" (aka
ab/config-based-hooks-2).  I dunno.

Thanks.
