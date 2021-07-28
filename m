Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF290C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9E060F9E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhG1AxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:53:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59982 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhG1AxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 20:53:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 651F5DD0DD;
        Tue, 27 Jul 2021 20:53:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U96JSxzpQ+3Sly7IIfzWvTW/giZJiPI54kFx9y
        l5jhk=; b=Obe8Gl3TLTSih5cmsO48Cq+M3zNQTN4ZMRuLjEx1/CPDVstyOeODLc
        btwpJK6C558znX9CS7CsDiTnACLkQCW+XtaJSwTD3APMPIreq3fhwbL/IPt67POR
        Ios8qnx7j8U2xdRJd6NdrWouNHAXeRmvmbuGQtBSXcnWF+zvIMtZk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BAC7DD0DB;
        Tue, 27 Jul 2021 20:53:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17D67DD0D9;
        Tue, 27 Jul 2021 20:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szme?= =?utf-8?Q?k?= 
        <zbyszek@in.waw.pl>
Subject: Re: [PATCH] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
References: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
        <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
        <YQBEhj/Y6m0pqOth@coredump.intra.peff.net>
Date:   Tue, 27 Jul 2021 17:53:04 -0700
In-Reply-To: <YQBEhj/Y6m0pqOth@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 27 Jul 2021 13:38:14 -0400")
Message-ID: <xmqqzgu7b6of.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B90BD02-EF3E-11EB-8662-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Let's instead solve this more thoroughly. We'll now take
>> GIT_TEST_COLUMNS over COLUMNS, and furthermore intentionally spoil the
>> COLUMNS variable to break any tests that rely on it being set to a
>> sane value.
>> 
>> If something breaks because we have a codepath that's not
>> term_columns() checking COLUMNS we'd like to know about it, the narrow
>> "shopt -u checkwinsize" fix won't give us that.
>
> I guess people running with bash won't see the test breakage (because
> bash will quietly "fix" the COLUMNS setting). But enough people run with
> /bin/sh that we'll eventually notice.
>
>> This approach does mean that any tests of ours that expected to test
>> term_columns() behavior by setting COLUMNS will need to explicitly
>> unset GIT_TEST_COLUMNS, or set it to the empty string. I'm doing the
>> latter in all the tests changed here.
>
> This is rather ugly, and I'm not in general a fan of adding more
> test-only code into the bowels of Git itself. But it may be the least
> bad solution.

Yeah, this really look unsatisfactory, especially with this repeated
pattern that is hard to read:

+	GIT_TEST_COLUMNS= COLUMNS=81 git branch --column=column >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch --column=column >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch >actual &&
+	GIT_TEST_COLUMNS= COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&

Perhaps with something like

	test_with_columns () {
        	local columns=$1
		shift
		GIT_TEST_COLUMNS= COLUMNS=$columns "$@"
	}

we may be able to hide the ugly implementation detail like this:

	test_with_columns 81 git branch --column=column >actual

and may become a bit more palatable?  A good thing is that this can
be done as two-step process, with its first step being 

    s/^(\s*)COLUMNS=(\d+)/$1test_with_columns $2/;

plus addition of the helper to test-lib, perhaps like so:

	test_with_columns () {
        	local columns=$1
		shift
		COLUMNS=$columns "$@"
	}

and the whole GIT_TEST_COLUMNS stuff being the second step.
