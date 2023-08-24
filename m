Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728ECC27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbjHXP5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjHXP5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 11:57:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D23198D
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 08:57:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE0AA221D6;
        Thu, 24 Aug 2023 11:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K3rx+d/PAIkqcKOockhxwu4zOSh5IPDMsgZELl
        ltMdA=; b=B1xSH821mkUpKyvzb5P6wO6Hd/9DsnPveGLOEuF8DCSFGJifR7SGAM
        MRJfvGDatWmcyEieglc/zUoWLV65S7n2oKif2OKxnZNc0QItpHpnqFwKlTpR2y3F
        xZt7tLUn0wpTJQ5ZYZGvNI1F6CYphQbvxB1+beoWxrtysrUJnI1BQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6FC2221D5;
        Thu, 24 Aug 2023 11:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59315221D2;
        Thu, 24 Aug 2023 11:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin Backhouse <kevinbackhouse@github.com>
Subject: Re: [PATCH v2 2/2] Fix minor memory leak found by LeakSanitizer.
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
        <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
        <353e1960b4466912c508733e5a7eb80884cd9bdd.1692886365.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Aug 2023 08:56:59 -0700
In-Reply-To: <353e1960b4466912c508733e5a7eb80884cd9bdd.1692886365.git.gitgitgadget@gmail.com>
        (Kevin Backhouse via GitGitGadget's message of "Thu, 24 Aug 2023
        14:12:45 +0000")
Message-ID: <xmqqv8d4bfhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC4F7F54-4296-11EE-ACF9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 2/2] Fix minor memory leak found by LeakSanitizer.

Continuing the review for the previous step, perhaps 

	Subject: [PATCH] merge: free list of merge bases upon failure

or something?

> From: Kevin Backhouse <kevinbackhouse@github.com>
>
> The callers of merge_recursive() and merge_ort_recursive() expects the

"expects" -> "expect"

> commit list passed in as the merge_bases parameter to be fully
> consumed by the function and does not free it when the function

"does not" -> "do not".

> returns.  In normal cases, the commit list does get consumed, but when
> the function returns early upon encountering an error, it forgets to
> clean it up.
>
> Fix this by freeing the list in the code paths for error returns.
>
> Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
> ---

Well written to be understandable.  Nicely done.

>  merge-ort-wrappers.c |  4 +++-
>  merge-ort.c          |  4 +++-
>  merge-recursive.c    | 32 ++++++++++++++++++++++----------
>  3 files changed, 28 insertions(+), 12 deletions(-)
>
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

OK.

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

OK.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6a4081bb0f5..49e54d3722f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3652,14 +3652,18 @@ static int merge_recursive_internal(struct merge_options *opt,
>  		opt->branch1 = "Temporary merge branch 1";
>  		opt->branch2 = "Temporary merge branch 2";
>  		if (merge_recursive_internal(opt, merged_merge_bases, iter->item,
> -					     NULL, &merged_merge_bases) < 0)
> -			return -1;
> +					     NULL, &merged_merge_bases) < 0) {
> +			clean = -1;
> +			goto out;
> +		}
>  		opt->branch1 = saved_b1;
>  		opt->branch2 = saved_b2;
>  		opt->priv->call_depth--;
>  
> -		if (!merged_merge_bases)
> -			return err(opt, _("merge returned no commit"));
> +		if (!merged_merge_bases) {
> +			clean = err(opt, _("merge returned no commit"));
> +			goto out;
> +		}
>  	}
>  
>  	/*
> @@ -3682,8 +3686,11 @@ static int merge_recursive_internal(struct merge_options *opt,
>  				     repo_get_commit_tree(opt->repo,
>  							  merged_merge_bases),
>  				     &result_tree);
> +
> +out:
>  	strbuf_release(&merge_base_abbrev);
>  	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
> +	free_commit_list(merge_bases);
>  	if (clean < 0) {
>  		flush_output(opt);
>  		return clean;

Hmph, so the proposed log message made it sound like the merge_bases
list is consumed fully in the normal non-error case, but even the
normal case was leaky on the "-s recursive" side?  Or was the
recursive side was OK and the caller had different expectations, in
which case we may be breaking them, but you poked at these codepaths
long enough to produce this patch, so I doubt it.  The proposed log
message needs to be updated to explain the findings on this side,
too, if the situation is different from the "ort" side.

> @@ -3729,6 +3736,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
>  	assert(!opt->record_conflict_msgs_as_headers);
>  	assert(!opt->msg_header_prefix);
>  
> +	CALLOC_ARRAY(opt->priv, 1);
> +	string_list_init_dup(&opt->priv->df_conflict_file_set);

This move, what it does, why it is needed, and what breaks without
it, is not explained in the proposed log message.

>  	/* Sanity check on repo state; index must match head */
>  	if (repo_index_has_changes(opt->repo, head, &sb)) {
>  		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> @@ -3737,16 +3747,13 @@ static int merge_start(struct merge_options *opt, struct tree *head)
>  		return -1;
>  	}
>  
> -	CALLOC_ARRAY(opt->priv, 1);
> -	string_list_init_dup(&opt->priv->df_conflict_file_set);
>  	return 0;
>  }

>  static void merge_finalize(struct merge_options *opt)
>  {
>  	flush_output(opt);
> -	if (!opt->priv->call_depth && opt->buffer_output < 2)
> -		strbuf_release(&opt->obuf);
> +	strbuf_release(&opt->obuf);

Ditto.  Unconditional release here may help the new caller in
merge_trees() that failed merge_start(), but is the change safe for
other existing callers and if so why/how?

In any case, this needs a review by somebody more familiar with the
recursive backend machinery than myself.  Any takers?

>  	if (show(opt, 2))
>  		diff_warn_rename_limit("merge.renamelimit",
>  				       opt->priv->needed_rename_limit, 0);
> @@ -3763,8 +3770,10 @@ int merge_trees(struct merge_options *opt,
>  
>  	assert(opt->ancestor != NULL);
>  
> -	if (merge_start(opt, head))
> +	if (merge_start(opt, head)) {
> +		merge_finalize(opt);
>  		return -1;
> +	}
>  	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
>  	merge_finalize(opt);
>  
> @@ -3785,8 +3794,11 @@ int merge_recursive(struct merge_options *opt,
>  	prepare_repo_settings(opt->repo);
>  	opt->repo->settings.command_requires_full_index = 1;
>  
> -	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
> +	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1))) {
> +		free_commit_list(merge_bases);
> +		merge_finalize(opt);
>  		return -1;
> +	}

I suspect that the way leaks happen is different between "ort" and
"recursive", and what is in the proposed log message may have been
the right description of the problem back when the patch was only
about fixing "ort" but no longer is sufficient now that we also fix
the "recursive" side.

>  	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
>  	merge_finalize(opt);

Hmph, but this does expect merge_bases is consumed in normal
codepath.  Now I am confused, sorry.

Thanks for working on this.
