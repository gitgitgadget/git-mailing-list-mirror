Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C0C4167B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126D8207B6
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgLGVLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:11:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50848 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVLk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 16:11:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C298BA1B;
        Mon,  7 Dec 2020 16:10:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4rxxvE1iyK/ne+PRLLQy9jGgRoo=; b=WVkS7A
        emYLYV9uEzLEyqoHzxMzvS2bkZwCrTqv/+34bQknurvAJ5DmjwVYpnRgOpP7VHKu
        fHFiR5hmgQjM5Y6EvzG5BJ/Ypjux+KUQelMn37zda2CzIaC4El+7h5/rcfM/y9HB
        POzoB4N5yAtNWnNDzoy8FipXMue5Vgm2bGHhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SduKq4rgYBf3TcOYLsi9SSHtwzumgPqG
        wf6pPmDZUvwlzsoo75WqVGrHM/KAZJLbNz38O/H7wt7gG2F+FlWeutUZd32IjCp0
        wxG+XoSZ8jLIX/PNDJtB4DJ/yblpN8NxZZmlP79KqQq2inok22abIZ2dSUO1P26l
        /bSQ3rb1JD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47FB08BA1A;
        Mon,  7 Dec 2020 16:10:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE2CA8BA19;
        Mon,  7 Dec 2020 16:10:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
        <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
        <xmqq360hbev1.fsf@gitster.c.googlers.com>
        <BF6B37E9-5AF9-4A81-90D8-0270D1269332@gmail.com>
        <xmqqsg8h8h3d.fsf@gitster.c.googlers.com>
Date:   Mon, 07 Dec 2020 13:10:57 -0800
In-Reply-To: <xmqqsg8h8h3d.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Dec 2020 13:02:46 -0800")
Message-ID: <xmqqo8j58gpq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B354C582-38D0-11EB-B2E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>
>>>> +test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
>>>> +	# depends on previous test for setup
>>>> +
>>>> +	git -C B/ fetch &&
>>>> +	compare_refs_in_dir A origin/master B origin/master
>>> 
>>> Can we do this without relying on the name of the default branch?
>>> Perhaps when outer, middle and inner are prepared, they can be
>>> forced to be on the 'sample' (not 'master' nor 'main') branch, or
>>> something like that?
>>
>> Or, simpler, we could call "git remote set-head -a' 
>> in A and B in the setup script, which would make
>> origin/HEAD in A and B point to the default branch, 
>> such that the call here could be :
>
> The set-up prepares A and B by cloning from elsewhere, no?  Should
> we even need a set-head call?

Ah, they are created by cloning an empty repository.  That explains
why.  Thanks.

>> compare_refs_in_dir A origin/HEAD B origin/HEAD
>
> Yes, using HEAD would be another simple way to avoid having to rely
> on the default behaviour.
>
> THanks.
