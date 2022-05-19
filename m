Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F7C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiESRo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiESRo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:44:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39492674DC
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:44:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 373C6192984;
        Thu, 19 May 2022 13:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZohrAsF4/mPVU+OYv/kKl1kR/r9+m1jxompVKe
        c+dO4=; b=G3M5wFTsZ3GmZlDR8A32q1DCLbhSld7TLNFojnN9I06PSzfhlTijKG
        pxb9xjRlYU9bfQiuG6OjOEPLg45jFHfVda73jP/O6TZwe9VXcjBULDT/omoRTOHE
        J/M0bWbqA887UhGCvsdniFbKECET3Mu8ufObniFnsdAQY43Wwot20=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FD5D192983;
        Thu, 19 May 2022 13:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9658192982;
        Thu, 19 May 2022 13:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: make restore_state() do as its name says
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <88bdca72a780d70e156e22e1ab96dedd368c761b.1652977582.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 10:44:49 -0700
In-Reply-To: <88bdca72a780d70e156e22e1ab96dedd368c761b.1652977582.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 19 May 2022
        16:26:22 +0000")
Message-ID: <xmqq5ym1pgby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6228F91A-D79B-11EC-9D52-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 00de224a2da..ae3ee3a996b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -377,11 +377,11 @@ static void restore_state(const struct object_id *head,
>  {
>  	const char *args[] = { "stash", "apply", NULL, NULL };
>  
> -	if (is_null_oid(stash))
> -		return;
> -
>  	reset_hard(head, 1);

when there is only one strategy to be tried, save_state() will never
be called.  Removing the above safety means the hard-reset is
discarding a local change that is not saved anywhere.  The reason
why the merge stopped may be because such a local change has crashed
with the change the merge wanted to bring in, no?

> +	if (is_null_oid(stash))
> +		goto refresh_cache;
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
> +
> +	for b in branch1 branch2 branch3
> +	do
> +		git checkout -b $b main &&
> +		test_commit --no-tag "Change on $b" base $b
> +	done &&
> +
> +	git checkout branch1 &&

Here, perhaps we can make two additional test cases, that try with
local change that (1) overlaps with the changes branch2 and branch3
bring in and that (2) does not overlap.  I am worried about the case
(2) losing the local change due to the call to reset_hard().

> +	test_must_fail git merge branch2 branch3 &&
> +	git diff --exit-code --name-status &&
> +	test_path_is_missing .git/MERGE_HEAD
> +'
> +
> +test_done
