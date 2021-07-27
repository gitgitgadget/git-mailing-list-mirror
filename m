Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786EC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961F260F6D
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhG0VCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:02:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51381 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhG0VAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:00:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E41BBDB5CB;
        Tue, 27 Jul 2021 17:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YNtjMlYO7lSsZwNHI4ATyEJiN8iUuUuin4ev9h
        5CEHQ=; b=sIrE0MuQUqQj/bBhKfY2yQm3XA7bfuaMVv1VKlJaZuOR3xCnUTbNRX
        LZ9yxGjVhgwuw75rs9gWo+7XZZadrExIkwqi9GKBIZTWP6D0IOhNdEnFTl0ZOZAc
        8a08XI3FwuMIwx6+wLyM9EO15pDK8pUhMael/pbZp8ruue6+sgx9w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DADDDDB5CA;
        Tue, 27 Jul 2021 17:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B5B2DB5C9;
        Tue, 27 Jul 2021 17:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
        <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
        <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
        <xmqq1r7jebbf.fsf@gitster.g>
Date:   Tue, 27 Jul 2021 14:00:52 -0700
In-Reply-To: <xmqq1r7jebbf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jul 2021 13:44:36 -0700")
Message-ID: <xmqqtukfcvzv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAEABD2A-EF1D-11EB-BDB9-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> This will break git-rebase--preserve-merges.sh which uses
>> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is 
>> removed when picking commits.
>
> Ahh, I didn't realize we still had scripted rebase backends that
> called cherry-pick as an executable.  I was hoping that all rebase
> backends by now would be calling into the cherry-pick machinery
> directly, bypassing cmd_cherry_pick(), and that was why I suggested
> to catch stray one the end-users set manually in the environment
> and clear it there.
>
>> I'm a bit confused as to what the
>> problem is - how is 'git cherry-pick' being run with
>> GIT_CHERRY_PICK_HELP set in the environment outside of a rebase (your
>> explanation in [1] does not mention how GIT_CHERRY_PICK_HELP is set)?
>
> I didn't press for the information too hard, but I guessed that it
> was perhaps because somebody like stackoverflow suggested to set a
> message in their environment to get a "better message."

A good way forward may be to relieve sequencer.c::print_advice() of
the responsibility of optinally removing CHERRY_PICK_HEAD; make it a
separate function that bases its decision on a more direct cue, not
on the presense of a custom message in GIT_CHERRY_PICK_HELP, make
do_pick_commit(), which is the sole caller of print_advice(), call
it after calling print_advice().

I do not offhand know what that "direct cue" should be, but we may
already have an appropriate field in the replay_opts structure;
"replay.action is neither REVERT nor PICK" could be a good enough
approximation, I dunno.

Otherwise we can allocate a new bit in the structure, have relevant
callers set it, and teach cherry-pick an unadvertised command line
option that sets the bit, and use that option only from
git-rebase--preserve-merges when it makes a call to cherry-pick.
When "rebase -p" is either retired or rewritten in C, we can retire
the option from cherry-pick.

Workable?
