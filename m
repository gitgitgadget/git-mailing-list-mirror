Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D2C6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B5A221FB
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLBXHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:07:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56554 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLBXHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 18:07:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88FF08B20E;
        Wed,  2 Dec 2020 18:06:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+p1m2zeaMZzNOYNrO2q4ZZsxjYE=; b=H/oGv/
        WK7PaPeJIJvxj13gNMB1jIGy1JhmYByV4OVVjkH02Rv4IYpK5J96JVxC4oZI54RM
        5a18B+ptrfG7P96HMXGhSutlGaX0DhQa9l8OBvqsqbGss3rapf/6FJjODQiE+IiN
        COXiA/12MVojPDfrXN6IscZgEkpiXihAug7Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cp7FxYWewBLGr+Wfz30fmKNWA8nO/ilD
        IHdBaIqwYjFy286Lr35l3Ptr/Wo3cMKiHe/0Tei+Q6EtA123goMzHnknbAnYitRX
        Py1sG84nvl39JtNfNPOUBohJ3ctxvS7fIjpRqX4xBbES2tmXEJaYtoVrzN7hwo6B
        PhwgeH4GUaU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8120E8B20D;
        Wed,  2 Dec 2020 18:06:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 007788B20C;
        Wed,  2 Dec 2020 18:06:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        peter.kaestle@nokia.com
Subject: Re: BUG in fetching non-checked out submodule
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
        <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
Date:   Wed, 02 Dec 2020 15:06:23 -0800
In-Reply-To: <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com> (Philippe
        Blain's message of "Wed, 2 Dec 2020 12:19:59 -0500")
Message-ID: <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF9DD438-34F2-11EB-B3F4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Thanks for bisecting it. That commit wanted to fix a different bug
> related to nested submodules, and the route taken was simply
> reverting an earlier commit (a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28).
>
> As you discovered, it breaks other scenarios.
>
>> 
>> $ git version
>> git version 2.29.2.435.g72ffeb997e
>> 
>> $ git config --get submodule.recurse
>> true

I think the current situation is probably worse.  

As a short-term fix, we should revert 1b7ac4e6d4 until we can come
up with a real fix, probably.

> Yeah, I think the test suite could make more efforts
> to run more tests with that setting turned 'on', but
> it would require significants efforts since it changes 
> the behaviour of several commands.

I am not sure if the question is about amount of efforts.

A configuration variable is there to change the behaviour of
commands, so a test of a command that has been running happily and
producing a set of expected outcome with a configuration unset
should break the expectation when the configuration is set ---
otherwise there is no point in having a configuration variable.

> Meta question: is there an easy way to run the whole test
> suite with specific config options turned on ?

Hence, I do not think it even makes sense to have such an "easy
way".  If the "fetch" command, for example, is expected to change
behaviour depending on the value of submodule.recurse, a test
written for the case where the variable is not set should produce
different outcome when the variable is set.

What we need may be a better test coverage.  submodule.recurse is a
later addition, and all tests written earlier do test how the commands
behave without the configuration being set.  If one wants to change
the behaviour of these commands when the configuration is set, new
tests to specify what the expected behaviour need to be added.

> Thanks for the report,

Yup, thanks for helping out.
