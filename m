Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81AC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiJSP4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiJSPzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:55:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE23E5BC20
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:53:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5451C13CA79;
        Wed, 19 Oct 2022 11:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KiOdHXmrLI/R
        bB15oSkiC+7Ch+alV2eFkwpFjlaJOv8=; b=yXwuOtd4JTRWD3FdQ6wbsQoLRpbu
        xCQEX05KZG6MDyp/bcnYTQ8FMUNLNimoCjLH6sJt9dFCPmyGNCsY1lMetep/WZw4
        9jkAEyVShMtCbYjHlARmPHpst+yPfG+ECvVz4YHA1BJeeVRPu1JLF3tI7pSMrhnq
        7UdRYHXxvWNJTp8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C1F213CA78;
        Wed, 19 Oct 2022 11:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A676213CA77;
        Wed, 19 Oct 2022 11:43:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
        <xmqq4jw1wl6z.fsf@gitster.g>
        <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
        <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
Date:   Wed, 19 Oct 2022 08:43:43 -0700
In-Reply-To: <Y08P0G1Be+5hCVML@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 18 Oct 2022 16:42:56 -0400")
Message-ID: <xmqq7d0vu8cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0680866-4FC4-11ED-BE9A-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think Junio saying "consensus" may have been premature. I expresse=
d
> my opinion and he agreed, but I think that is as far as it got. :)

Maybe.  This is a tangent, but as far as I am concerned, when R=C3=A9ne
writes something that looks to me very straight-forward and correct,
and it passes your taste buds, then that is enough consensus to move
ahead.  As Linus often said and I concur, some people got good
taste, that is hard to quantify and probably hard to teach, and
there are a handful folks here with good taste.  And when two who
have demonstrated they are with good taste agrees, that is good
enough to me.

>> I don't see how *_l_opt() is particularly error prone, I just had a
>> stupid think-o in v1 of this, but that if/else if bug is something tha=
t
>> could have snuck in with run_command() given the same stupidity :)
>
> I don't think it's error-prone. It just seems like it complicates an AP=
I
> for little gain, and causes us to have a lot of boilerplate mapping
> RUN_* flags into cmd.* fields.

True. run_command() needs the RUN_* flags twiddling, too, so it is
not a point against _l_opt() variant.  What I see as its biggest
problem is it is a bit too rigid for many of the current callers
that use _v_opt() to replace them, and can easily tempt developers
to write almost-duplicate _l_opt() calls, leading to an easily
avoidable bug like we saw in the if/else if/else cascade.

Thanks.
