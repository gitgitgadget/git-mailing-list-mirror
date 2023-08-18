Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFCEE4998
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbjHRVly (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbjHRVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 17:41:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6A30FE
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 14:41:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BB451A2E25;
        Fri, 18 Aug 2023 17:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jfsVSmg4/IsBPlIoJmMGcJJDZ1LRrHn01Q72Ee
        fgaVQ=; b=tHmGsUkbs6Rwu52LIeh6bL7K3D1JNRn+JJrH6q7+O2ZJJF7u3YvYtt
        BLXBVjOToTlNb6H+7di2YIQk8UWufIrxE79cDG7zzioPYdZlrpZGdHjxVd0a60Ok
        VyblGVH4Z1dN3tuZJvo9Nd2aWpxLfEKmS49+pviSAkXy6BXD3YWAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B3F1A2E24;
        Fri, 18 Aug 2023 17:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 886F01A2E21;
        Fri, 18 Aug 2023 17:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin Backhouse <kevinbackhouse@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] This fixes a minor memory leak (detected by
 LeakSanitizer) in git merge.
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
Date:   Fri, 18 Aug 2023 14:41:41 -0700
In-Reply-To: <pull.1577.git.1692389061490.gitgitgadget@gmail.com> (Kevin
        Backhouse via GitGitGadget's message of "Fri, 18 Aug 2023 20:04:21
        +0000")
Message-ID: <xmqqo7j4t4dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05625316-3E10-11EE-8F10-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kevin Backhouse <kevinbackhouse@github.com>
>
> To reproduce (with an ASAN build):
>
> ```
> mkdir test
> cd test
> git init
> echo x > x.txt
> git add .
> git commit -m "WIP"
> git checkout -b dev
> echo y > x.txt
> git add .
> git commit -m "WIP"
> git checkout main
> echo z > x.txt
> git add .
> git commit -m "WIP"
> echo a > x.txt
> git add .
> git merge dev
> ```

We'd rather not to see the above in the proposed log message; can't
we add (a variation of) it to our test suite?

> The fix is to call free_commit_list(merge_bases) when an error occurs.

We usually have the description of what the problem is and give an
analysis on why/how it happens, before presenting a solution.  Write
it more like:

    The caller of merge_ort_recursive() expects the commit list
    passed in as the merge_bases parameter to be fully consumed by
    the function and does not free it when the function returns.  In
    normal cases, the commit list does get consumed, but when the
    function returns early upon encountering an error, it forgets to
    clean it up.

    Fix this by freeing the list in the code paths for error returns.

>  merge-ort-wrappers.c | 4 +++-
>  merge-ort.c          | 4 +++-

These two places and their fixes seem OK, but I have to wonder if
these are complete fixes.

> diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
> index 4acedf3c338..aeb56c9970c 100644
> --- a/merge-ort-wrappers.c
> +++ b/merge-ort-wrappers.c
> @@ -54,8 +54,10 @@ int merge_ort_recursive(struct merge_options *opt,
>  	struct tree *head = repo_get_commit_tree(opt->repo, side1);
>  	struct merge_result tmp;
>  
> -	if (unclean(opt, head))
> +	if (unclean(opt, head)) {
> +		free_commit_list(merge_bases);
>  		return -1;
> +	}
>  
>  	memset(&tmp, 0, sizeof(tmp));
>  	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);

The function before this hunk appears to have very similar code
structure.  Does it need the same fix, or if not why not?

> diff --git a/merge-ort.c b/merge-ort.c
> index 8631c997002..a0eb91fb011 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -5070,8 +5070,10 @@ static void merge_ort_internal(struct merge_options *opt,
>  		opt->branch1 = "Temporary merge branch 1";
>  		opt->branch2 = "Temporary merge branch 2";
>  		merge_ort_internal(opt, NULL, prev, next, result);
> -		if (result->clean < 0)
> +		if (result->clean < 0) {
> +			free_commit_list(merge_bases);
>  			return;
> +		}

Before this function, there is a comment that this came from another
function and it seems to still have a very similar code structure.
Does the other function need the same fix, or if not why not?

Thanks.
