Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E25C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 20:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiEYUWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiEYUWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 16:22:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B78AFB1F
        for <git@vger.kernel.org>; Wed, 25 May 2022 13:22:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5E0135AA6;
        Wed, 25 May 2022 16:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mGEI6I0R9cPp+7D6JiWOOG0uTuQtwOd4SzwaR3
        JW5ZU=; b=A1FWUJMq8o3+y/sQAdt3dMhEDgWI9kvxQJgij6Ghppbb0rcs/67kbK
        tmYy3Rl4LGkGc5l1VvfE+xdmtNp6XOeOhQZNzzyotuh6JdEdFJ/NHqTwqyzKI0ai
        zOwd80W30W+aGheRUZKKxvZwSYaIWTFXZKkHOkLOwlTtn21e0GTW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B187F135AA4;
        Wed, 25 May 2022 16:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C499135A9B;
        Wed, 25 May 2022 16:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 2/7] archive --add-virtual-file: allow paths
 containing colons
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <7eebcf27b45eb13541d4abae70a374a0e35ab6b8.1653145696.git.gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 13:22:24 -0700
In-Reply-To: <7eebcf27b45eb13541d4abae70a374a0e35ab6b8.1653145696.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 21 May 2022
        15:08:11 +0000")
Message-ID: <xmqq5ylt7473.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 646F242A-DC68-11EC-9ACF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
> +	if test_have_prereq FUNNYNAMES
> +	then
> +		PATHNAME=quoted:colon
> +	else
> +		PATHNAME=quoted
> +	fi &&
>  	git archive --format=zip >with_file_with_content.zip \
> +		--add-virtual-file=\"$PATHNAME\": \

The name is better, but this still limits what can be in PATHNAME.

Write either one of these:

		--add-virtual-file="\"$PATHNAME\":" \
		--add-virtual-file=\""$PATHNAME"\": \

to signal the intention better to future readers.  We are showing an
explicit dq-pair we want to pass to the c-unquote machinery, and we
are showing that we are not being unnecessarily loose by protecting
the string from getting word split.

Either is fine, but leaving it unquoted is not.

> +		test_path_is_file $PATHNAME &&

Ditto.  There is no reason to forbid future developers from futzing
the test to include space in the PATHNAME variable.  

IOW, I want us to be better than saying

    I know there is no $IFS whitespace now because I just wrote it.
    Because I do not think there is any need to test with a string
    with whitespace in it, I will leave the variable unquoted.
    Anybody who changes the variable and breaks this assumption have
    only themselves to blame for breaking the tests.  It is not my
    fault and it is not my problem.

which is the signal our readers would get from this patch (I would,
if I were reading this commit as a third-party), especially once
they become aware of the fact that this exact issue was already
pointed out during the review discussion.

Using double-quote appropriately sends a strong signal to reviewers
and future developers that we care about details.

A valid alternative is to write the assumption out where we
currently assign to PATHNAME.

	# The PATHNAME variable is used without quote in the code
	# below for such and such reasons, so you cannot use a $IFS
	# whitespace in it.
	if test_have_prereq FUNNYNAMES
	then
		...

If the "defensive" measure that is necessary to avoid a limitation
is too onerous, such an approach may be very much more preferrable
than preparing for future changes.  "for such and such reasons" is
a good place to justify why we avoid unnecessarily complex defensive
measure and restrict future changes in the documented way.

But in _this_ particular case, the "defensive" measure necessary is
merely just to quote the shell variables properly, which nobody
sensible would say too onerous.  I couldn't come up with anything
remotely plausible to fill "for such and such reasons" myself when I
tried to justify leaving the variables unquoted.

Regardless of the quoting issue, we probably want to comment on what
value exactly is in PATHNAME before the assignment, by the way.

E.g.

	# The PATHNAME variable holds a filename encoded like a
	# string constant in C language (e.g. "\060" is digit "0")
	if test_have_prereq FUNNYNAMES
	then
		PATHNAME=quoted:colon:\\060zero
	else
		PATHNAME=quoted\\060zero
	fi

That would not just protect only one aspect (i.e. we can pass a
colon into the resulting filename) this change but the path goes
through the c-unquoting rules.

Thanks.
