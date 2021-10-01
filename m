Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F7C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B88B61ABF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJAVUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:20:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52632 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJAVUq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:20:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA04616455A;
        Fri,  1 Oct 2021 17:19:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGVHc5nMhS92i1D5PyZu+lQPtx2UzHy38UTQFZ
        SVwcw=; b=GOBkJ/lmDhJIf45mD1HY9SFRpZLVUPdwihYtZKWxwtn9jOiL1Scv/c
        mVSx+LJLajiNoYUh52hvqYpeUebkhGIA9jvrmK9sRv6F9Sf0movvJpYFTn4xtP32
        ERrINNZ1j6r4sl+PX+XSXBuUM9WwEbBSjbBQvLKNdQYGtZyrhkuD0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A39C1164559;
        Fri,  1 Oct 2021 17:19:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39472164557;
        Fri,  1 Oct 2021 17:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 10/11] rebase --apply: set ORIG_HEAD correctly
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <e8884efcc83960fc0ea5d5aee72bb9839b4be397.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 14:18:57 -0700
In-Reply-To: <e8884efcc83960fc0ea5d5aee72bb9839b4be397.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:05:01
        +0000")
Message-ID: <xmqqwnmw4f5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3166EDBC-22FD-11EC-AF6F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> At the start of a rebase ORIG_HEAD is updated to tip of the branch
> being rebased. Unfortunately reset_head() always uses the current
> value of HEAD for this which is incorrect if the rebase is started
> with 'git rebase <upstream> <branch>' as in that case ORIG_HEAD should
> be updated to <branch>. This only affects the "apply" backend as the
> "merge" backend does not yet use reset_head() for the initial
> checkout. Fix this by passing in orig_head when calling reset_head()
> and add some regression tests.

All correct.  It is somewhat surprising that this wasn't caught and
reported as an issue for this long X-<.

> +	const struct object_id *orig_head;
>  	 /* Optional branch to switch to */
>  	const char *branch;
>  	/* Flags defined above */
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 738fbae9b29..be63456c5b9 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -323,4 +323,30 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
>  	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
>  '
>  
> +test_orig_head_helper() {

Need SP before "()" in addition to after it.  Ditto for the other one.

> +	test_when_finished 'git rebase --abort &&
> +		git checkout topic &&
> +		git reset --hard commit-new-file-F2-on-topic-branch' &&
> +	git update-ref -d ORIG_HEAD &&
> +	test_must_fail git rebase "$@" &&
> +	test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
> +}
> +
> +test_orig_head() {
> +	type=$1
> +	test_expect_success "rebase $type sets ORIG_HEAD correctly" '
> +		git checkout topic &&
> +		git reset --hard commit-new-file-F2-on-topic-branch &&
> +		test_orig_head_helper $type main
> +	'
> +
> +	test_expect_success "rebase $type <upstream> <branch> sets ORIG_HEAD correctly" '
> +		git checkout main &&
> +		test_orig_head_helper $type main topic
> +	'
> +}
> +
> +test_orig_head --apply
> +test_orig_head --merge
> +
>  test_done
