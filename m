Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326CBC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1103B610C8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbhIHTOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:14:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52563 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIHTOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:14:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1C8FE7871;
        Wed,  8 Sep 2021 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=P8MbPih0LMXDMqCrI80EaksJ//V4zH/iYcW8Asy3NQo=; b=rzx/
        qioiiAK9Hg5epovXo4Rdjr5xVC3bR9CdiGoslJZMeM8qOfF0pJzg/kL9eQTYD5EK
        bvFoW/Tz4bGDjhT6iz49HR8Y7YgNb8DhdGu9nm2t24ahMzCZxCLelGDkPKQxipjB
        HYglzVIVNX9NtSV1dgs4IEAFSdvECV78dLKWNsw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6C80E7870;
        Wed,  8 Sep 2021 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07064E786F;
        Wed,  8 Sep 2021 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
        <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com>
        <xmqqmton7ehn.fsf@gitster.g>
        <CANQDOddQsf4Jj+634mdnJXaPG=2idCbCHd1iXO2qm1EMGcDmXg@mail.gmail.com>
Date:   Wed, 08 Sep 2021 12:12:50 -0700
Message-ID: <xmqqr1dy3mq5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E6328E-10D8-11EC-AB38-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Tue, Sep 7, 2021 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Neeraj Singh <nksingh85@gmail.com> writes:
>>
>> > BTW, I updated the github PR to enable batch mode everywhere, and all
>> > the tests passed, which is good news to me.
>>
>> I doubt that fsyncObjectFiles is something we can reliably test in
>> CI, either with the new batched thing or with the original "when we
>> close one, make sure the changes hit the disk platter" approach.  So
>> I am not sure what conclusion we should draw from such an experiment,
>> other than "ok, it compiles cleanly."  After all, unless we cause
>> system crashes, what we thought we have written and close(2) would
>> be seen by another process that we spawn after that, with or without
>> sync, no?
>
> The main failure mode I was worried about is that some test or other part
> of Git is relying on a loose object being immediately available after it is
> added to the ODB. With batch mode, the loose objects aren't actually
> available until the bulk checkin is unplugged.

Ah, I see.  If there are two processes that communicate over pipes
to decide whose turn it is (perhaps a producer of data that feeds
fast-import may wait for fast-import to say "I gave this label to
the object you requested" and goes ahead to use that object), and at
the point that the "other" process takes its turn, if the objects
are not "flushed" yet, things can break.  That's a valid concern.
