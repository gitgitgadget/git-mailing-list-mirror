Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6ABC433FE
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 19:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiAQTdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 14:33:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62854 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiAQTdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 14:33:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5365411015E;
        Mon, 17 Jan 2022 14:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbqORQekOjUKENLNv2HoikX/hvZ46gWkQtZ2x1
        2OBL4=; b=s/WmX3yHuMAjGlGRXVDrcZcAJ67lPcL4gQf0cRaw1mclPICXXEOTOW
        3tsZ61sFbS8YyN+5rMdDYpsYy9RITD0vn+D6EK3OUeU8vsr1ZKaEnaVPU8kMTrTE
        iH1rYCjuTZRO/jQNSVOGkQZTImaNLld+VvyPXMaM4epBbkhtHsbyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4881A11015D;
        Mon, 17 Jan 2022 14:33:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6D1611015C;
        Mon, 17 Jan 2022 14:33:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>,
        "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
        <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
Date:   Mon, 17 Jan 2022 11:33:11 -0800
In-Reply-To: <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Mon, 17 Jan 2022
        18:25:55 +0000")
Message-ID: <xmqqh7a2uphk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F2C7866-77CC-11EC-A455-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In commit 8b09a900a1 ("merge-ort: restart merge with cached renames to
> reduce process entry cost", 2021-07-16), we noted that in the merge-ort
> steps of
>     collect_merge_info()
>     detect_and_process_renames()
>     process_entries()
> that process_entries() was expensive, and we could often make it cheaper
> by changing this to
>     collect_merge_info()
>     detect_and_process_renames()
>     <cache all the renames, and restart>
>     collect_merge_info()
>     detect_and_process_renames()
>     process_entries()
> because the second collect_merge_info() would be cheaper (we could avoid
> traversing into some directories), the second
> detect_and_process_renames() would be free since we had already detected
> all renames, and then process_entries() has far fewer entries to handle.
>
> However, this was built on the assumption that the first
> detect_and_process_renames() actually detected all potential renames.
> If someone has merge.renameLimit set to some small value, that
> assumption is violated which manifests later with the following message:
>
>     $ git -c merge.renameLimit=1 rebase upstream
>     ...
>     git: merge-ort.c:546: clear_or_reinit_internal_opts: Assertion
>     `renames->cached_pairs_valid_side == 0' failed.
>
> Turn off this cache-renames-and-restart whenever we cannot detect all
> renames, and add a testcase that would have caught this problem.
>
> Reported-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Thanks.  An Ack?

>     merge-ort: avoid assuming all renames detected
>     
>     Fixes https://lore.kernel.org/git/YeHTIfEutLYM4TIU@nand.local/
>     
>     Changes since v1:
>     
>      * Fixed a small style issue
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1194%2Fnewren%2Favoid-assertion-assuming-renames-found-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1194/newren/avoid-assertion-assuming-renames-found-v2
> Pull-Request: https://github.com/git/git/pull/1194
>
> Range-diff vs v1:
>
>  1:  f1e9901ae67 ! 1:  239d3ba08c1 merge-ort: avoid assuming all renames detected
>      @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
>        	trace2_region_enter("merge", "regular renames", opt->repo);
>        	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
>        	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
>      -+	if (renames->needed_limit != 0) {
>      ++	if (renames->needed_limit) {
>       +		renames->cached_pairs_valid_side = 0;
>       +		renames->redo_after_renames = 0;
>       +	}
>
>
>  merge-ort.c                              |  4 ++
>  t/t6429-merge-sequence-rename-caching.sh | 67 ++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index c3197970219..b0ff9a72879 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3060,6 +3060,10 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	trace2_region_enter("merge", "regular renames", opt->repo);
>  	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
>  	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
> +	if (renames->needed_limit) {
> +		renames->cached_pairs_valid_side = 0;
> +		renames->redo_after_renames = 0;
> +	}
>  	if (renames->redo_after_renames && detection_run) {
>  		int i, side;
>  		struct diff_filepair *p;
> diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> index 035edc40b1e..f2bc8a7d2a2 100755
> --- a/t/t6429-merge-sequence-rename-caching.sh
> +++ b/t/t6429-merge-sequence-rename-caching.sh
> @@ -697,4 +697,71 @@ test_expect_success 'caching renames only on upstream side, part 2' '
>  	)
>  '
>  
> +#
> +# The following testcase just creates two simple renames (slightly modified
> +# on both sides but without conflicting changes), and a directory full of
> +# files that are otherwise uninteresting.  The setup is as follows:
> +#
> +#   base:     unrelated/<BUNCH OF FILES>
> +#             numbers
> +#             values
> +#   upstream: modify: numbers
> +#             modify: values
> +#   topic:    add: unrelated/foo
> +#             modify: numbers
> +#             modify: values
> +#             rename: numbers -> sequence
> +#             rename: values -> progression
> +#
> +# This is a trivial rename case, but we're curious what happens with a very
> +# low renameLimit interacting with the restart optimization trying to notice
> +# that unrelated/ looks like a trivial merge candidate.
> +#
> +test_expect_success 'avoid assuming we detected renames' '
> +	git init redo-weirdness &&
> +	(
> +		cd redo-weirdness &&
> +
> +		mkdir unrelated &&
> +		for i in $(test_seq 1 10)
> +		do
> +			>unrelated/$i
> +		done &&
> +		test_seq  2 10 >numbers &&
> +		test_seq 12 20 >values &&
> +		git add numbers values unrelated/ &&
> +		git commit -m orig &&
> +
> +		git branch upstream &&
> +		git branch topic &&
> +
> +		git switch upstream &&
> +		test_seq  1 10 >numbers &&
> +		test_seq 11 20 >values &&
> +		git add numbers &&
> +		git commit -m "Some tweaks" &&
> +
> +		git switch topic &&
> +
> +		>unrelated/foo &&
> +		test_seq  2 12 >numbers &&
> +		test_seq 12 22 >values &&
> +		git add numbers values unrelated/ &&
> +		git mv numbers sequence &&
> +		git mv values progression &&
> +		git commit -m A &&
> +
> +		#
> +		# Actual testing
> +		#
> +
> +		git switch --detach topic^0 &&
> +
> +		test_must_fail git -c merge.renameLimit=1 rebase upstream &&
> +
> +		git ls-files -u >actual &&
> +		! test_file_is_empty actual
> +	)
> +'
> +
>  test_done
>
> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
