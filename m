Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC5DC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTXuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTXuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:50:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2FB19899D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:50:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA3F1519D7;
        Thu, 20 Oct 2022 19:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=afE0speKd0Nh
        8meMpgXIyF0cAgJZshKw34TDVdzGcy8=; b=r6a7YA1/yzbttCDolyBahfJQYBJ7
        30gQvbI8KGj86uIP/y0Zrx7aHiD8woulydn0Vupvt7PhhN9xyPB8c85Ipch9yD+n
        VQZBUxk1sCBTpOawNSLtaPyL1xejwfv+mShvE3K+gmZL5dIPk8EXrSM+VFFtQKzf
        qKRmQ6W28/baxjk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 077021519D5;
        Thu, 20 Oct 2022 19:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D42B1519D4;
        Thu, 20 Oct 2022 19:50:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
        <xmqq4jw1wl6z.fsf@gitster.g>
        <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
        <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
        <xmqq7d0vu8cw.fsf@gitster.g>
        <Y1AujKKPUJFepph5@coredump.intra.peff.net>
        <xmqq7d0vsngp.fsf@gitster.g>
        <Y1BIfEN5ds2kKjjk@coredump.intra.peff.net>
        <xmqq5ygfr48b.fsf@gitster.g>
        <84971a3a-4c5c-5b79-582e-88b3bd8c624f@web.de>
Date:   Thu, 20 Oct 2022 16:50:29 -0700
In-Reply-To: <84971a3a-4c5c-5b79-582e-88b3bd8c624f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 20 Oct 2022 20:34:10 +0200")
Message-ID: <xmqqilkeoy0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAC59D7C-50D1-11ED-9209-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I wrote that patch out of curiosity and was pleased by the total line
> count reduction, getting rid of the on-stack array construction sites
> with their magic numbers, not having to manage strvecs explicitly
> anymore and the callers staying readable.
> ...
> But still: Is all of that code churn worth it?  Not sure.

Compared to doing nothing?  The result did look easier to grok,
especially as we no longer need to worry about another way to do the
same thing (i.e. run_command() vs run_command_v_*() variants) and
can get rid of the flags constants that need to be kept in sync with
the members of the child_process struct.

Compared to adding the _l_opt() variant?  Surely, as that goes the
other direction to add more callers that use the flags constants,
without much practical gain (which was a bit sad, but we only found
that out after seeing the result).
