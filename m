Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD82C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 07:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiCMIAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiCMIAL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 04:00:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8C2DD59
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 23:59:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC9EF177C0A;
        Sun, 13 Mar 2022 03:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6XvKkH5+i9jv+CIiEpg5EglkSATXB3zU9xa20R
        kloZU=; b=rkSY+qy72e5D7AQlg5h22XY19/VGotn3HhDDm8TlizdsqqC4BrMeHQ
        LEnwn1wF0xr3IFUWpqLfb5cgz5wm/cpBIf8G41QFLaswdaEB+vyvyqRmVTQVnyRK
        yDHL+P41+xcIa249YFbpN7MY5BE9erONC730CzMPyCrvFYevqvDAs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D567F177C09;
        Sun, 13 Mar 2022 03:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E3AF177C06;
        Sun, 13 Mar 2022 03:59:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
        <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
        <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
Date:   Sun, 13 Mar 2022 07:58:59 +0000
In-Reply-To: <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 11 Mar 2022 17:24:52
        +0000")
Message-ID: <xmqq7d8ywaf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7130A44E-A2A3-11EC-8A4B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reset.c b/reset.c
> index e3383a93343..f8e32fcc240 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	if (opts->branch_msg && !opts->branch)
>  		BUG("branch reflog message given without a branch");
>  
> +	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)

It's just style thing but it probably is easier to read to have
an extra () around the bitwise-&.

> +		BUG("attempting to detach HEAD when branch is given");

I wonder if there is a valid use case NOT to use RESET_HEAD_DETACH
when switch_to_branch == NULL.  If there isn't, it could be that
we can get rid of RESET_HEAD_DETACH bit and base this decision
solely on switch_to_branch'es NULLness.

But that is totally outside the scope of this fix.  I'd prefer to
see a narrowly and sharply focused fix, and to be quite honest, I
would be happier if this assertion weren't in this topic.

>  	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
>  		ret = -1;
>  		goto leave_reset_head;
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 0643d015255..d5a8ee39fc4 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked out' '
>  	git rebase main other
>  '
>  
> +test_expect_success 'switch to non-branch detaches HEAD' '
> +	git checkout main &&
> +	old_main=$(git rev-parse HEAD) &&
> +	git rebase First Second^0 &&

Good.  For reproduction, the fork-point "First" does not have to be
a raw object name.  "Second^0" not being a branch name does matter.

> +	test_cmp_rev HEAD Second &&
> +	test_cmp_rev main $old_main &&
> +	test_must_fail git symbolic-ref HEAD

All correct and to the point.  Good.

Will queue.  Thanks.

> +'
> +
>  test_expect_success 'refuse to switch to branch checked out elsewhere' '
>  	git checkout main &&
>  	git worktree add wt &&
