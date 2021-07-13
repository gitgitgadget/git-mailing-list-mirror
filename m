Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34037C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2018F61375
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGMSJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:09:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57139 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:09:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2ABAE142133;
        Tue, 13 Jul 2021 14:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3pAHbjXZGYAJCxWaJouL/k3dcHg2mGmElSQvGd
        LhCoU=; b=D4AEp8JiBfsM6nEA539SOBfef4yqjJaOsW7AASWrjuhxCRd3sdzfJx
        JI90zg0AZQKLHISwxb9YrhSxlcp+/wrS/Cv4rJmVifjCfJDJ7UZQr/vMvBOkINQc
        UiDdcYGsj0DnKgzwFmLfr4pcPoaNSjdgnqZKC2LMP7mTCGdoJCfmM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22CEE142132;
        Tue, 13 Jul 2021 14:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F792142130;
        Tue, 13 Jul 2021 14:07:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
        <87h7hdbpgb.fsf@evledraar.gmail.com>
        <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
        <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com>
        <797f4e85-33cc-df7e-31d8-3a4f95a9109a@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 11:07:02 -0700
In-Reply-To: <797f4e85-33cc-df7e-31d8-3a4f95a9109a@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 13 Jul 2021 13:58:16 -0400")
Message-ID: <xmqqtuky141l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20D0F358-E405-11EB-8527-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> FWIW, the xargs is clustering the 10,000 files into ~4 command lines,
> so there is a little bit of Windows process overhead, but not that
> much.
>
> 	seq 1 10000 | xargs wc -l | grep total
>
>> I'd really like to modify test_seq to use seq when it's available and
>> fall back to the looping-in-shell when we need to for various
>> platforms.
>> Maybe it'd even make sense to write a 'test-tool seq' and make
>> test_seq use that just so we can rip out that super lame shell
>> looping.
>> 

So what lame in this picture is not shell, or process overhead, but
I/O performance.

I've seen some noises about Windows file creation performance raised
as an issue when doing initial checkout followed by "git clone", and
an idea floated to create a bunch of open file handles for writing
in threads when checkout (really the caller that repeatedly calls
entry.c:write_entry() by iterating the in-core index) starts, and
write out the contents in parallel, as a workaround.  When I heard
it, I somehow thought it was meant as a not-so-funny joke, but from
the sounds of it, the I/O performance may be so horrible to require
such a hack to be usable there.  Sigh...

