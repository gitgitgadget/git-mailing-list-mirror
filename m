Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D36C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 15:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378755AbiDDP4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbiDDP4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 11:56:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4215A17
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 08:54:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5554D18FA0A;
        Mon,  4 Apr 2022 11:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Q70RROAD0tDbsu7ZIYHrI7yHp+Vp7vfzzV5pM
        CvULM=; b=TqsJ6YXQ2D7/xHonSNf5S7Bh5A6p5pdHgzSbYJpo11jWIN1j1IY/bu
        E7nDKqgDLE97Rs5mARqvdwyt2ur2wydmwT8+AHWaQvb0yA7U36jgn9AngQZ7s0wR
        PvR60l4pk6xfr7lFLU5pcHkSSbmej5cQj1xJiXPIi6RzfMt+C3K7I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DE6218FA09;
        Mon,  4 Apr 2022 11:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6364D18FA03;
        Mon,  4 Apr 2022 11:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Labnann <khalid.masum.92@gmail.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH v3 1/1] t3501: remove redundant file check and stop
 ignoring git <cmd> exit code
References: <20220331191525.17927-1-khalid.masum.92@gmail.com>
        <20220402192415.19023-1-khalid.masum.92@gmail.com>
        <20220402192415.19023-2-khalid.masum.92@gmail.com>
Date:   Mon, 04 Apr 2022 08:54:48 -0700
In-Reply-To: <20220402192415.19023-2-khalid.masum.92@gmail.com> (Labnann's
        message of "Sat, 2 Apr 2022 19:24:15 +0000")
Message-ID: <xmqqfsmssv1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ED1AEEC-B42F-11EC-8F4A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labnann <khalid.masum.92@gmail.com> writes:

> In the test 'cherry-pick after renaming branch', stop checking for
> the presence of a file (opos) because we are going to "grep" in it in
> the same test and the lack of it will be noticed as a failure anyway.

OK.

> In the test 'revert after renaming branch', instead of allowing any
> random contents as long as a known phrase is not there in it, we can
> expect the exact outcome---after the successful revert of
> "added", the contents of file "spoo" should become identical to
> what was in file "oops" in the "initial" commit.

Makes sense.  The code removes "test -f spoo", which is not
explained in the above, and I do not think we want to.  We'd
notice a breakage where revert leaves the right result in HEAD
but fails to match the working tree files if we leave it there.

> In both tests, we would not notice when "git rev-parse" starts
> segfaulting without emitting any output.  The 'test' command would
> end up being just "test =", which yields success. Therefore we could
> use test_cmp_rev

The two sentences are right.  The conclusion is a bit iffy; it is
not "we could", which implies that the current one is OK but it is
OK to also rewrite it to use test_cmp_rev.

    Use the 'test_cmp_rev' helper to make sure we will notice such a
    breakage.

or something like that, perhaps?

> Signed-off-by: Labnann <khalid.masum.92@gmail.com>

Is Labnann your name?  I do not know where you are from so forgive
me if it is.  We prefer people to sign with their real names (cf.
Documentation/SubmittingPatches[[real-name]]) on this line (and
because the name/e-mail on this line must match the author's ident,
the same preference applies there, too).

> ---
>  t/t3501-revert-cherry-pick.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 8617efaaf1..ad8f0cae5a 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -66,8 +66,7 @@ test_expect_success 'cherry-pick after renaming branch' '
>  
>  	git checkout rename2 &&
>  	git cherry-pick added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
> -	test -f opos &&
> +	test_cmp_rev rename2 HEAD^ &&
>  	grep "Add extra line at the end" opos &&
>  	git reflog -1 | grep cherry-pick
>  
> @@ -77,9 +76,8 @@ test_expect_success 'revert after renaming branch' '
>  
>  	git checkout rename1 &&
>  	git revert added &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
> -	test -f spoo &&
> -	! grep "Add extra line at the end" spoo &&
> +	test_cmp_rev rename1 HEAD^ &&
> +	test_cmp_rev initial:oops HEAD:spoo &&
>  	git reflog -1 | grep revert
>  
>  '

The diff looks almost perfect here (modulo that "test -f spoo" is
better kept, I would think).

Thanks.
