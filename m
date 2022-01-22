Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E25C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiAVBmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 20:42:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51809 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiAVBmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 20:42:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3C41102EEC;
        Fri, 21 Jan 2022 20:42:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+EVtGknHrIcSm7x5jLe9LD7aR1tAse0jB6a5nDYUncs=; b=GKbt
        MYYPFk1QlIypIDCVBtIJGlc+OkXHxZan65jD8J/DwuPXiZ4YSgfA80d7yl5nae2w
        csKsGUzj7aGS9xCZsHac8EMTNLVrAPjEBjV1WYgF+CMmgi5o3tAxrJP93cefuZkO
        LcHqUvZCSxDQxamDZe1Bf7h7Ues/VMlbKTlQsZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A1DA102EEB;
        Fri, 21 Jan 2022 20:42:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0000F102EE9;
        Fri, 21 Jan 2022 20:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] sparse-index: sparse index is disallowed when split
 index is active
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
        <d5c1440d9a9c943bf195a9d158c4badbd9a022a3.1642613380.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 17:42:43 -0800
Message-ID: <xmqqtudwbl64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 988F0342-7B24-11EC-AE1B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 6e773527b6b (sparse-index: convert from full to sparse, 2021-03-30),
> we introduced initial support for a sparse index, and were careful to
> avoid converting to a sparse index in the presence of a split index.
>
> However, when we _just_ read a freshly-initialized index, it might not
> contain a split index even if _writing_ it will add one by virtue of
> being asked for via the `GIT_TEST_SPLIT_INDEX` variable.
>
> We did not notice any problems with checking _only_ for `split_index`
> (and not `GIT_TEST_SPLIT_INDEX`) right until both
> `vd/sparse-sparsity-fix-on-read` _and_ `vd/sparse-reset` were merged.
>
> Those two topics' interplay triggers a bug in conjunction with running
> t1091.15 when `GIT_TEST_SPLIT_INDEX=true` in the following way:
> `vd/sparse-sparsity-fix-on-read` ensures that the index is made sparse
> right after reading, and `vd/sparse-reset` ensures that the index is
> made non-sparse again unless running in the `--soft` mode. Since the
> split index feature is incompatible with the sparse index feature, we
> see a symptom like this:
>
> 	fatal: position for replacement 4 exceeds base index size 4
>
> Let's fix this by avoiding the conversion to a sparse index when
> `GIT_TEST_SPLIT_INDEX=true`.

Does [2/3] allow you to sidestep that issue entirely by skipping
1091 altogether?

There are 4 hits of "if (istate->split_index" in the codebase, and
this patch makes me wonder why it is suffice to patch only one of
them.

I also wondered why we test both split_index and environment
separately, instead of splitting the index very early when the
environment variable is set, so that the rest of the runtime does
not have to worry about the environment, but is the reason why such
an approach was not taken was because GIT_TEST_SPLIT_INDEX can later
allow the index to be splitted, even if istate->split_index is still
NULL right now when this function is called?

If that is the reason, it leads to another question.  Even if we
ignore GIT_TEST_SPLIT_INDEX and concentrate only on real workload,
if the in-core index can be NULL when this function is called and
then later can become split, there still must be somebody who
notices that sparse index is unallowed when (or after) such a split
happens, no?  If there is no such code, then this patch would not be
the whole fix and there needs more change to do so, no?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sparse-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index a1d505d50e9..08f54747bb4 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -136,7 +136,7 @@ static int is_sparse_index_allowed(struct index_state *istate, int flags)
>  		/*
>  		 * The sparse index is not (yet) integrated with a split index.
>  		 */
> -		if (istate->split_index)
> +		if (istate->split_index || git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
>  			return 0;
>  		/*
>  		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
