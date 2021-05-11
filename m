Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E9C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70966611CE
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEKNNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:13:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52254 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKNNT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:13:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2F68C2D36;
        Tue, 11 May 2021 09:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rBlOlQ17ANrqf6i7jEPJFwhC1W2RZMwVZFZCPq
        PyjLA=; b=iwHQ7yLUpbk75fT9kFJOkRojS+xsxURAgmAs0rv1r0VqZUwUDQ0z4V
        /+ksbIGCGDzycg3SDCKnwv/HWhW1/zh9vrm2eZAI05CIPHRAblzK4XKd5PenvpO6
        VhGn5rbIWvENgHGJP3i5Jzm1k6CI4ocKglCVyU+nhh1WqJietFSNk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA8CDC2D35;
        Tue, 11 May 2021 09:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38D78C2D34;
        Tue, 11 May 2021 09:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
        <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
        <xmqqcztyovf7.fsf@gitster.g>
        <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com>
        <xmqqlf8lmxca.fsf@gitster.g>
        <CAOLTT8SiEVR62LwuagnpbZ4XxiUMe2M2WPjaorzSJmfERD6BMw@mail.gmail.com>
Date:   Tue, 11 May 2021 22:12:11 +0900
In-Reply-To: <CAOLTT8SiEVR62LwuagnpbZ4XxiUMe2M2WPjaorzSJmfERD6BMw@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 11 May 2021 19:47:01 +0800")
Message-ID: <xmqq7dk5mn2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F99C982-B25A-11EB-83E2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> Well, the thing is,
>>
>>     $ git checkout 49f38e2d ;# (The fifteenth batch, 2021-05-10)
>>     $ git am -s mbox
>>     $ git show --stat --oneline
>>     39509d100a (HEAD) ref-filter: fix read invalid union member bug
>>      ref-filter.c                   |  2 +-
>>      t/t6302-for-each-ref-filter.sh | 18 ++++++++++++++++++
>>      2 files changed, 19 insertions(+), 1 deletion(-)
>>     $ git show ref-filter.c | git apply -R ;# revert only the fix
>>     $ make -j32 && make -C t T=t6302-*.sh
>>
>> does not seem to break anything.  Perhaps there is something more
>> than the "17th byte" thing (like structure padding that may vary
>> depending on the compiler and architecture)?
>
> Fine, I guess the reason for this mystery is I "push" this branch to github
> and you haven't done it. That may not be due to the platform. Because I
> can see no this bug happening when I use a new git repo without "git push",
> and I test in archlinux or deepin, this bug will happen in these environments.

Sorry, you lost me.  I was talking about what happens in the new
test you added to t6302 not failing as designed, and there shouldn't
be "I've pushed but you haven't pushed to GitHub" distinction.  The
test is running in a brand-new repository just created for the sole
purpose of running the test after all.

> #!/bin/sh
> mkdir test
> cd test
> git init
> echo 1>1
> git add .
> git branch -M main
> git commit -m "test"
> git remote add origin nowhere
> git config branch.main.remote origin
> git config branch.main.merge refs/heads/main
> git for-each-ref --format="%(color:#aa22ac)%(objectname)"
>
> These two "git config" is for simulating a push environment.

So in short, the test script added to t6302 in the v4 patch was not
testing what it was supposed to be testing, as it didn't have the
configuration items related to %(push) atom necessary to trigger the
error?  

That I can believe.  I was starting to worry if there was something
more subtle going on, but I am glad that it was only an uncooked
patch submitted without checking.

> I guess you also saw this bug:
>
> BUG: ref-filter.c:1544: unhandled RR_* enum

No, I didn't.  I just tried to make sure the new test was truly
checking the existing breakage by partially reverting the code fix,
and saw that the new test did not fail.

Thanks.
