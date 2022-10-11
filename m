Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60870C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJKVn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKVn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 17:43:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846E5B06D
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 14:43:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FE1D14D7D7;
        Tue, 11 Oct 2022 17:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h+oXH5a8kYsb
        bMY0mDfQXb2OpXXMDPIohGO8FL/5QbU=; b=kPnsu4d+/tiaFlAHtcMKkPggSCID
        jst5znuR6EcXQU06Uoe4o0LPQYLlNphAa2NrV5OBZD6cQfn8e5dYjkayoosDck9z
        dptexqqLtJvY+Hnyd3aOskkT93d1eZ0uBjDdkP1L8HPjPtxAgQG3QAG01K4n4G1H
        J6gp+9tNnJ9ir7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9756C14D7D6;
        Tue, 11 Oct 2022 17:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0161114D7D5;
        Tue, 11 Oct 2022 17:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
        <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
        <xmqqk05cipq8.fsf@gitster.g>
        <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
        <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
        <xmqq35buykz1.fsf@gitster.g>
        <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
        <xmqqpmeyuvxt.fsf@gitster.g>
        <221011.86czayns5x.gmgdl@evledraar.gmail.com>
Date:   Tue, 11 Oct 2022 14:43:24 -0700
In-Reply-To: <221011.86czayns5x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 11 Oct 2022 20:13:20 +0200")
Message-ID: <xmqq8rlmujcz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC922C3A-49AD-11ED-A876-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I was experimenting with implementing a run_command_opt_l() earlier
> which would give us the safety Jeff notes. The relevant end-state for
> these two files is (there's more conversions, and I manually edited the
> diff to remove an unrelated change):

There still are some changes that would not belong here, but for the
purpose of illustrating the usage of _l variant, this is good enough.
Of course, if we want to follow the existing naming scheme, the new
function must be called _l_opt(), not _opt_l().  _v_ in the _v_opt()
comes from execv() and you are adding execl() analogue here.

> -	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +	if (run_command_opt_l(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
> +			      "set", NULL)) {

And this does give us protection from the "Programmers can give
unterminated list to run_command_v_opt() by mistake", which is not
really solved mechanically even if the list is prepared with the
strvec API (because the compiler has to be smart enough to know that
argv.v was prepared with proper use of the API), which is nice.

Having to give the option flags as the first argument, of course it
is necessary because we are talking about the _l variant with
varargs, looks ugly, though.

Also, I am not sure how useful this new function actually is.  Many
hits from my quick "grep" in the message you are responding to did
use strvec because they wanted to dynamically build up the command
line, and _l variant does not really shine in these places.

We may probably be able to refactor some (but not all) of these
sites so that the command line is not built dynamically with unknown
number of elements in unknown order, but that feels like a solution
looking for a problem, changing code to use the new function, tail
wagging the dog.  So, I dunno...
