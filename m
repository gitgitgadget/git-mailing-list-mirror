Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C0C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66D261430
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEJF3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:29:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJF3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:29:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75B49C67AB;
        Mon, 10 May 2021 01:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2oQiCMJb1aN1/Rf+syUMdPvOcPHPl5lRCfoKJM
        K6yOI=; b=dNUdB8arpFrTvJvtCrfNbL4yCDU5EdV1SNcgH7gGaISBoIJdqu55LX
        kIOm1+pDghvO1JkRhyC1fHqJPrehx0UEv8RzExqu84NwawhWYeC6GLCCSIpQK9JE
        e3ooSrdTh59SCZj2HpENuoLMUt6WUdYDYyMxG8qs7AEzCx/UBzoM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 595ACC67AA;
        Mon, 10 May 2021 01:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC922C67A8;
        Mon, 10 May 2021 01:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 4/8] t7300: add testcase showing unnecessary
 traversal into ignored directory
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 14:28:35 +0900
In-Reply-To: <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        19:59:00 +0000")
Message-ID: <xmqq7dk7rwcc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9148FE38-B150-11EB-BE07-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_failure 'avoid traversing into ignored directories' '
> +	test_when_finished rm -f output error trace.* &&
> +	test_create_repo avoid-traversing-deep-hierarchy &&
> +	(
> +		cd avoid-traversing-deep-hierarchy &&
> +
> +		mkdir -p untracked/subdir/with/a &&
> +		>untracked/subdir/with/a/random-file.txt &&
> +
> +		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> +		git clean -ffdxn -e untracked
> +	) &&
> +
> +	grep data.*read_directo.*visited trace.output \
> +		| cut -d "|" -f 9 >trace.relevant &&
> +	cat >trace.expect <<-EOF &&
> +	 directories-visited:1
> +	 paths-visited:4

Are the origins of '1' and '4' trivially obvious to those who are
reading the test, or do these deserve comments?

We create an empty test repository, go there and create a untracked/
hierarchy with a junk file, and tell "clean" that 'untracked' is
"also" in the exclude pattern (but since there is no other exclude
pattern, that is the only one), so everything underneath untracked/
we have no reason to inspect.

So, we do not visit 'untracked' directory.  Which ones do we visit?
Is '1' coming from the top-level of the working tree '.'?  What
about the number of visited paths '4' (the trace is stored outside
this new test repository, so that's not it).

Thanks.

> +	EOF
> +	test_cmp trace.expect trace.relevant
> +'
> +
>  test_done
