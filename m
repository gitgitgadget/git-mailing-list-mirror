Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195BC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiCNT2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiCNT2V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 15:28:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9B3B3DE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:27:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D043187F44;
        Mon, 14 Mar 2022 15:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6yvD0yxz+Jx2Pvn6iWkQDHS2tpfeTwEKK03Tv8
        VCTrE=; b=nYPyxPkYlcJYEhB1qm9ui74IYCiICe1u85g/Nx+twMuRsF8eoaHH2A
        LEvVgcmemOXb6grihoBItcPzc3QP4QA9G+n/Hz/nUAE/P5nr88wUyIv5rT1Z77d3
        ZJTAT01AOF8U1p3eJZZPGL6ZBkZsO7iqfxDE2NBsTMLppQE7OPrUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95611187F43;
        Mon, 14 Mar 2022 15:27:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E003187F42;
        Mon, 14 Mar 2022 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/5] reset: introduce --[no-]refresh option to --mixed
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <7f0226bc3e646167808fbd2413dc54e87417230c.1647274230.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 19:27:07 +0000
In-Reply-To: <7f0226bc3e646167808fbd2413dc54e87417230c.1647274230.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 14 Mar 2022 16:10:27
        +0000")
Message-ID: <xmqq7d8ws5bo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD02F1D6-A3CC-11EC-97BB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add a new --[no-]refresh option that is intended to explicitly determine
> whether a mixed reset should end in an index refresh.
>
> Starting at 9ac8125d1a (reset: don't compute unstaged changes after reset
> when --quiet, 2018-10-23), using the '--quiet' option results in skipping
> the call to 'refresh_index(...)' at the end of a mixed reset with the goal
> of improving performance. However, by coupling behavior that modifies the
> index with the option that silences logs, there is no way for users to have
> one without the other (i.e., silenced logs with a refreshed index) without
> incurring the overhead of a separate call to 'git update-index --refresh'.
> Furthermore, there is minimal user-facing documentation indicating that
> --quiet skips the index refresh, potentially leading to unexpected issues
> executing commands after 'git reset --quiet' that do not themselves refresh
> the index (e.g., internals of 'git stash', 'git read-tree').
>
> To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
> introduced to provide a dedicated mechanism for refreshing the index. When
> either is set, '--quiet' and 'reset.quiet' revert to controlling only
> whether logs are silenced and do not affect index refresh.
>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  Documentation/git-reset.txt |  9 +++++
>  builtin/reset.c             | 13 ++++++-
>  t/t7102-reset.sh            | 77 +++++++++++++++++++++++++++++++++----
>  3 files changed, 91 insertions(+), 8 deletions(-)

No complaints, but it is somewhat unsatisfying that we need these
two steps that keep --quiet tied to the decision to or not to
refresh.  In the longer term, it may be cleaner to completely
dissociate them, but it probably is not a huge deal.

> +	/*
> +	 * If refresh is completely unspecified (either by config or by command
> +	 * line option), decide based on 'quiet'.
> +	 */
> +	if (refresh < 0)
> +		refresh = !quiet;

OK.

> @@ -517,7 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			if (read_from_tree(&pathspec, &oid, intent_to_add))
>  				return 1;
>  			the_index.updated_skipworktree = 1;
> -			if (!quiet && get_git_work_tree()) {
> +			if (refresh && get_git_work_tree()) {
>  				uint64_t t_begin, t_delta_in_ms;
>  
>  				t_begin = getnanotime();

Quite sensible.

> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index d05426062ec..005940778b7 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -462,14 +462,77 @@ test_expect_success 'resetting an unmodified path is a no-op' '
>  	git diff-index --cached --exit-code HEAD
>  '
>  
> +test_index_refreshed () {
> +
> +	# To test whether the index is refresh, create a scenario where a

Doesn't the verb "refresh" refer to the act of making it "fresh"
(again)?  i.e. update the cached stat info to up-to-date?

"To test whether the index has been refreshed" or "To test whether
the cached stat info is up-to-date", perhaps?

> +	# command will fail if the index is *not* refreshed:
> +	#   1. update the worktree to match HEAD & remove file2 in the index

In other words, file2 tentatively becomes untracked.

> +	#   2. reset --mixed to unstage the change from step 1

But then, file2 is "added" to the index again, but added from the
HEAD.  If this did not refresh, then we do not know if the contents
of the file in the working tree is the same, and "diff-files" may
say "file2 may be modified".  If "reset" refreshes, this will take
us back to the same state as "reset --hard HEAD", and "diff-files"
will not report that "file2" is different.

> +	#   3. read-tree HEAD~1 (which differs from HEAD in file2)

With "-m" option, I presume?  Do we want "-u" here, too?

> +	# If the index is refreshed in step 2, then file2 in the index will be
> +	# up-to-date with HEAD and read-tree will succeed (thus failing the
> +	# test). If the index is *not* refreshed, however, the staged deletion
> +	# of file2 from step 1 will conflict with the changes from the tree read
> +	# in step 3, resulting in a failure.

This feels a bit brittle.  The implementation of "read-tree -m" may
choose to refresh beforehand to avoid such a failure.

In any case, the name of the helper alone wasn't of any help to
realize that this is about checking if "reset" refreshes the index
or not.  Perhaps call it more like

	reset_refreshes_index

or something?

In any case, instead of the big comment block, comments interspersed
in the steps may be easier to follow.  

> +	# Step 0: start with a clean index
> +	git reset --hard HEAD &&
> +
> +	# Step 1
	# remove file2 from the index
> +	git rm --cached file2 &&
> +
> +	# Step 2
	# resurrect file2 to the index from HEAD; if the cached stat
	# info gets refreshed, this brings us back to the state
        # after Step 0.  If not, "diff-files" would report file2 is
	# different.
> +	git $1 reset $2 --mixed HEAD &&
> +
> +	# Step 3
> +	git read-tree -m HEAD~1

And use "diff-files file2" here?  Then you do not even have to rely
on HEAD and HEAD~1 being different at file2.

