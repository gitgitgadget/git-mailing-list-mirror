Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D730C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiBXWPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiBXWPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:15:38 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEE29DD78
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:15:08 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 816FB175E4D;
        Thu, 24 Feb 2022 17:15:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mHOzpuV3Jgm7z3axrwoT6ngywJn+8cp7K+Lu7A
        aCAoQ=; b=XRP4kcjiYD2KBhV7847zkpgg7xPpCH4aX6hhQtlm31K/T0S/otAUwY
        NvFPyO9Tg3hyHMqn+rkRLtpeVpbR/xx4phHl5Xk0si0oMr7sZ0Rr/kEnK08y23oJ
        icu0dcjbnexeSyFL1GfaNbkiGRxghUIRk2srxN+hBP/aivxI0Sook=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78877175E4C;
        Thu, 24 Feb 2022 17:15:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BB22175E4B;
        Thu, 24 Feb 2022 17:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/7] commit-graph: fix ordering bug in generation numbers
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <6e47ffed25795260c2b8614d4589fb58d892c8df.1645735117.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 14:15:02 -0800
In-Reply-To: <6e47ffed25795260c2b8614d4589fb58d892c8df.1645735117.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Feb 2022
        20:38:31 +0000")
Message-ID: <xmqqh78nkj2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36C71C98-95BF-11EC-9B3C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When computing the generation numbers for a commit-graph, we compute
> the corrected commit dates and then check if their offsets from the
> actual dates is too large to fit in the 32-bit Generation Data chunk.
> However, there is a problem with this approach: if we have parsed the
> generation data from the previous commit-graph, then we continue the
> loop because the corrected commit date is already computed.
>
> It is incorrect to add an increment to num_generation_data_overflows
> here, because we might start double-counting commits that are computed
> because of the depth-first search walk from a commit with an earlier
> OID.
>
> Instead, iterate over the full commit list at the end, checking the
> offsets to see how many grow beyond the maximum value.

Hmph, I can see how the new code correctly counts the commits that
require offsets that are too large, but I am not sure why the fix is
needed.  The overall loop structure is

    for each commit ctx->commits.list[i]:
        continue if generation number has been computed for it already

	set up a commit-list for depth first search
	while (we are still digging) {
		for each parent {
			if generation for the parent is not known yet:
				push it down and redo
			else
				compute max of parents' generation number
		}
                if (all parents' generation number is known) {
			set the generation number for ourselves
			count if we needed an offset that is too big
		}
	}
    }

The only case where we may double-count near the end of inner loop I
can think of is when we end up computing generation for the same
commit in the while () loop.  But isn't that "we dig the same thing
twice" by itself something we want to fix, regardless of the
double-counting issue?

IOW,

>  				if (current->date && current->date > max_corrected_commit_date)
>  					max_corrected_commit_date = current->date - 1;
>  				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
> -
> -				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
> -					ctx->num_generation_data_overflows++;
>  			}
>  		}
>  	}

here, before doing the assignment for the "current" commit's
generation number, if we added

		if (commit_graph_data_at(current)->generation !=
		    GENERATION_NUMBER_ZERO)
			BUG("why are we digging it twice?");

would it trigger?  If so, isn't that already a bug worth fixing?

Perhaps avoiding the second round, perhaps like this, may be a
better fix?

	while (list) {
		struct commit *current = list->item;
		struct commit_list *parent;
		int all_parents_computed = 1;
		timestamp_t max_corrected_commit_date = 0;

+		if (commit_graph_data_at(current)->generation !=
+		    GENERATION_NUMBER_ZERO) {
+			pop_commit(&list);
+			continue;
+		}
+
		for (parent = current->parents; parent; parent = parent->next) {

Or am I grossly misunderstanding why the original code is incorrect
to have the counting at this place?

> +
> +	for (i = 0; i < ctx->commits.nr; i++) {
> +		struct commit *c = ctx->commits.list[i];
> +		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
> +			ctx->num_generation_data_overflows++;
> +	}
>  	stop_progress(&ctx->progress);
>  }
>  
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2b05026cf6d..f9bffe38013 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -467,10 +467,10 @@ test_expect_success 'warn on improper hash version' '
>  	)
>  '
>  
> -test_expect_success 'lower layers have overflow chunk' '
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	UNIX_EPOCH_ZERO="@0 +0000" &&
> -	FUTURE_DATE="@2147483646 +0000" &&
> +	FUTURE_DATE="@4147483646 +0000" &&
>  	rm -f .git/objects/info/commit-graph &&
>  	test_commit --date "$FUTURE_DATE" future-1 &&
>  	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
