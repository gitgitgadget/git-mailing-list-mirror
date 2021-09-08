Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F340C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B2B600CC
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhIHGqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:46:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63481 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbhIHGqE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 02:46:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28453E9DC1;
        Wed,  8 Sep 2021 02:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UIlgOpNKN+HTtdHoJYvoCk0k16Mn2r5yl1jPvF
        J4Gro=; b=qEGf25GkcsxQ/NOGYM/O91UWR7wGJtl2ucs5O0e86csAl0wxcmuP30
        wYJVU9Z7w2gjgilG/kyZJF7sxNA/kGy8dB5nftEWIv8Y0VK05yiN7K55dAOyj7Q3
        DTfTJ4FAMTkNtMw69QFH6mQ2iPQhNpy8MdIBIy+YIBgug45xm+qTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F583E9DC0;
        Wed,  8 Sep 2021 02:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3E81E9DBF;
        Wed,  8 Sep 2021 02:44:54 -0400 (EDT)
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
Date:   Tue, 07 Sep 2021 23:44:52 -0700
In-Reply-To: <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com>
        (Neeraj Singh's message of "Tue, 7 Sep 2021 17:55:29 -0700")
Message-ID: <xmqqmton7ehn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4680FCDC-1070-11EC-AF08-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> BTW, I updated the github PR to enable batch mode everywhere, and all
> the tests passed, which is good news to me.

I doubt that fsyncObjectFiles is something we can reliably test in
CI, either with the new batched thing or with the original "when we
close one, make sure the changes hit the disk platter" approach.  So
I am not sure what conclusion we should draw from such an experiment,
other than "ok, it compiles cleanly."  After all, unless we cause
system crashes, what we thought we have written and close(2) would
be seen by another process that we spawn after that, with or without
sync, no?



