Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D10FC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 23:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGSXN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSXNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 19:13:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19E43E44
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:13:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A41B7199D3E;
        Tue, 19 Jul 2022 19:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brOZ5muk2n045D4OZsmLxxR+zn82OL79+tvVY6
        NeOG4=; b=eiVeJERVsfe4AURJeG6jNu0HkirAN9E9ZWMA3H/BLMgjUZ57BJ+jbz
        JcGg9KeIH7xl6sChku5JjprSR5vAKQbQ7np8x1ha3nxbZZoVyQaX3gYv9Gvu/9bO
        vyASUeH8CDxxZ0SqorCmbVOGfJ4Su1q9+uYFJU1cTEA3PfE6cSG3w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CAC7199D3D;
        Tue, 19 Jul 2022 19:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34169199D3C;
        Tue, 19 Jul 2022 19:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 16:13:17 -0700
In-Reply-To: <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 19 Jun 2022
        06:50:24 +0000")
Message-ID: <xmqqzgh466ia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6111859A-07B8-11ED-B64E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix the main problem by making sure that restore_state() only skips the
> stash application if the stash is null rather than skipping the whole
> function.

OK.


> However, there is a secondary problem -- since merge.c forks
> subprocesses to do the cleanup, the in-memory index is left out-of-sync.
> While there was a refresh_cache(REFRESH_QUIET) call that attempted to
> correct that, that function would not handle cases where the previous
> merge strategy added conflicted entries.  We need to drop the index and
> re-read it to handle such cases.

Absolutely right.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index aaee8f6a553..a21dece1b55 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -385,11 +385,11 @@ static void restore_state(const struct object_id *head,
>  {
>  	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
>  
> -	if (is_null_oid(stash))
> -		return;
> -
>  	reset_hard(head, 1);
>  
> +	if (is_null_oid(stash))
> +		goto refresh_cache;
> +
>  	args[3] = oid_to_hex(stash);
>  
>  	/*
> @@ -398,7 +398,9 @@ static void restore_state(const struct object_id *head,
>  	 */
>  	run_command_v_opt(args, RUN_GIT_CMD);
>  
> -	refresh_cache(REFRESH_QUIET);
> +refresh_cache:
> +	if (discard_cache() < 0 || read_cache() < 0)
> +		die(_("could not read index"));

Don't we need refresh_cache() after re-reading the on-disk index, or
do we have nothing to do further after restore_state() returns and
the stat-info being stale does not matter?  Given that [3/6] exists,
I suspect that we do want to make sure the in-core index is refreshed
before we go ahead and run the next merge, no?

>  }
>  
>  /* This is called when no merge was necessary. */

> diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
> new file mode 100755

As long we are adding a brand-new script for new tests, probably we
should add tests for other steps (like [4/6]) here, perhaps?

> index 00000000000..655478cd0b3
> --- /dev/null
> +++ b/t/t7607-merge-state.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description="Test that merge state is as expected after failed merge"
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +. ./test-lib.sh
> +
> +test_expect_success 'set up custom strategy' '
> +	test_commit --no-tag "Initial" base base &&
> +git show-ref &&

Is this part of the test, or a leftover debugging aid?

> +
> +	for b in branch1 branch2 branch3
> +	do
> +		git checkout -b $b main &&
> +		test_commit --no-tag "Change on $b" base $b
> +	done &&
> +
> +	git checkout branch1 &&
> +	test_must_fail git merge branch2 branch3 &&
> +	git diff --exit-code --name-status &&
> +	test_path_is_missing .git/MERGE_HEAD
> +'

Hmph, I am not sure if the new behaviour is not too pessimistic.
When octopus fails after successfully merging branch2 and then
failing the merge of branch3 (i.e. the last one) due to conflict,
I think octpus users are used to be able to resolve it manually
and make a commit.  Are we making it impossible by doing the
reset-restore dance here?

I do not use, and more importantly, I do not recommend others to
use, Octopus anymore, and from that point of view, it is a good move
to make Octopus harder to use on any non-trivial merge, but those
who still like Octopus may disagree.

Thanks.

> +test_done
