Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC2C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315A6238D7
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLGTX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:23:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57869 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLGTX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:23:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CBA511CE7F;
        Mon,  7 Dec 2020 14:22:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGuNNHj2R0s3HwSCrh0j74aJTzI=; b=CEN50f
        8s7SLRbk9vQ/Fo8Norr8IQvlPAClF3cGDSOBV8d1nRdRtjhxDhmER7Xtp8GYFCdH
        hXDIv+Pq6gIx4pGYYAPbsC4ufwbL40LlE28qMl+p8f1dfeJcHjP8adaVx3ir4hH3
        iOjjiLV/14IfWL8WQgkyDAl2j9ijLvepVgOCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AliIEd+pDJCPogjyz+UIxnIWDVHSBTv/
        /dHAqzIZt/YgesAMCO76kJA8xVxPfqPf9/lFX433dOve9Q7niMFkNB8FHhTvx1Fp
        O4WbR1si0GySM9HuJnpdq4mpdcPmqRwQFQVDejxklS5b25qZ2tDXmSdChQaeR6vD
        XLiJkLT17sw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0621411CE7E;
        Mon,  7 Dec 2020 14:22:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BEB511CE7D;
        Mon,  7 Dec 2020 14:22:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
        <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
Date:   Mon, 07 Dec 2020 11:22:42 -0800
In-Reply-To: <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Mon, 7 Dec 2020 14:46:59 +0100")
Message-ID: <xmqq360hbev1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94D830EE-38C1-11EB-9890-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> +add_commit_push () {
> +	dir="$1" &&
> +	msg="$2" &&
> +	shift 2 &&
> +	git -C "$dir" add "$@" &&
> +	git -C "$dir" commit -a -m "$msg" &&
> +	git -C "$dir" push
> +}
> +
> +compare_refs_in_dir () {
> +	fail= &&
> +	if test "x$1" = 'x!'
> +	then
> +		fail='!' &&
> +		shift
> +	fi &&
> +	git -C "$1" rev-parse --verify "$2" >expect &&
> +	git -C "$3" rev-parse --verify "$4" >actual &&
> +	eval $fail test_cmp expect actual
> +}



> +test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
> +	# depends on previous test for setup
> +
> +	git -C B/ fetch &&
> +	compare_refs_in_dir A origin/master B origin/master

Can we do this without relying on the name of the default branch?
Perhaps when outer, middle and inner are prepared, they can be
forced to be on the 'sample' (not 'master' nor 'main') branch, or
something like that?

> +test_expect_success 'setup recursive fetch with uninit submodule' '
> +	# does not depend on any previous test setups
> +
> +	git init main &&
> +	git init sub &&

"super vs sub" would give us a better contrast than "main vs sub",
and it would help reduce mistakes in the mechanical conversion of
"master" to "main" happening in another topic.

> +	# In a regression the following git call will run into infinite recursion.
> +	# To handle that, we connect the grep command to the git call by a pipe
> +	# so that grep can kill the infinite recusion when detected.
> +	# The recursion creates git output like:
> +	# Fetching submodule sub
> +	# Fetching submodule sub/sub              <-- [1]
> +	# Fetching submodule sub/sub/sub
> +	# ...
> +	# [1] grep will trigger here and kill git by exiting and closing its stdin

"trigger here and kill..." -> "stop reading and cause git to
eventually stop and die"

But we probably cannot use 'grep -m1' so it is a moot point.

> +
> +	! git -C main fetch --recurse-submodules 2>&1 |
> +		grep -v -m1 "Fetching submodule sub$" &&

Unfortunately, "grep -m<count>" is not even in POSIX, I would think.

What do we expect to happen in the correct case?

 - A line "Fetching submodule sub" and nothing else is given?  That
   feels a bit brittle (how are we making sure, in the presence of
   "2>&1", that we will not get any other output, like progress?)

 - "sub" is the only thing that appears on lines that begin with
   "Fetching submodule" (i.e. "Fetching submodule $something" where
   $something is not 'sub' is an error), and we allow other garbage
   in the output?  That would be a bit more robust than the above.

As you seem to be comfortable using "sed" below, perhaps use it to
extract the first few lines that say "^Fetching submodule " from the
output and stop, and check that the output has only one such line
about 'sub' and nothing else?

> +	git -C main submodule status >out &&
> +	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
> +	test_cmp expect actual
