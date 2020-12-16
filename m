Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07624C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E26230FC
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPCIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:08:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50893 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgLPCIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 21:08:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12A5C1177AD;
        Tue, 15 Dec 2020 21:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVA7t9gwBRV1JVP9Pl+bRYbzl9E=; b=MGoAX6
        Tw/H7HiNGw9yzYF7d0k36GBEHwf/zMYJr5uJaukUMrV9G46LVLL4DGvPO61BjDe4
        u8Drh2wEfn26LOHy/niG5nrDo2Wb4zRKrsMcKvHrfAe4laCDWImfn8nG7AvTQevI
        L6/rVpzUvLLNqbeUIDIG/VA2lnet0+hO4l7jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NrenhuTEdKoyTi5c3Z7jmzYz1ndMera+
        Kz52u9cGYwoqB9q9tgwM7DWZ6nMHQw/Wyg++b873pxuh9YxtgchIsTTHE7OfMAx5
        DqnKCg/42ubZnfpIspmUXofjLqeXCMQ5xDGmbZwIFU3YKXnz6VBUwUogVo8K2r6+
        j2c/1d8Pp/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09B401177AC;
        Tue, 15 Dec 2020 21:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2D4A1177AB;
        Tue, 15 Dec 2020 21:07:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: implement merge_incore_recursive()
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <82a773d8972b6641a25b3c84121dd38703a9286c.1608054807.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:07:19 -0800
In-Reply-To: <82a773d8972b6641a25b3c84121dd38703a9286c.1608054807.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Dec 2020
        17:53:27 +0000")
Message-ID: <xmqqbleu5wrs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EA8303A-3F43-11EB-A105-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Originally from merge_recursive_internal(); somewhat adapted, though.
> + */
> +static void merge_ort_internal(struct merge_options *opt,
> +			       struct commit_list *merge_bases,
> +			       struct commit *h1,
> +			       struct commit *h2,
> +			       struct merge_result *result)
> +{
> +	struct commit_list *iter;
> +	struct commit *merged_merge_bases;
> +	const char *ancestor_name;
> +	struct strbuf merge_base_abbrev = STRBUF_INIT;
> +
> +	if (!merge_bases) {
> +		merge_bases = get_merge_bases(h1, h2);
> +		merge_bases = reverse_commit_list(merge_bases);

Do we want to say why we reverse here, or is the reason so well
known why in the original merge-recursive case?

> +	}
> +
> +	merged_merge_bases = pop_commit(&merge_bases);
> +	if (merged_merge_bases == NULL) {
> +		/* if there is no common ancestor, use an empty tree */
> +		struct tree *tree;
> +
> +		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
> +		merged_merge_bases = make_virtual_commit(opt->repo, tree,
> +							 "ancestor");
> +		ancestor_name = "empty tree";
> +	} else if (opt->ancestor && !opt->priv->call_depth) {
> +		ancestor_name = opt->ancestor;
> +	} else if (merge_bases) {
> +		ancestor_name = "merged common ancestors";
> +	} else {
> +		strbuf_add_unique_abbrev(&merge_base_abbrev,
> +					 &merged_merge_bases->object.oid,
> +					 DEFAULT_ABBREV);
> +		ancestor_name = merge_base_abbrev.buf;
> +	}

So, up to this point we learned:

 - merge bases either given by the caller, or computed from h1 and
   h2 when the caller just told us to figure it out ourselves.

 - if we have

   - 0 merge base between h1 and h2, in which case we would use an
     empty tree as an imaginary common

   - 1 merge base between h1 and h2, in which case the common
     ancestor of the resuting merge between h1 and h2 is that single
     merge base

   - 2 or more bases, in which case we'd use that would eventually
     come back when we merged recursively all bases.

and the primary products of the above procedure are

 - ancestor_name (the string used when presenting conflicts while
   merging h1 and h2)

 - merged_merge_bases (one starting commit among the merge bases)

And then the loop will iterate over the remaining merge bases,
merging one popped from it in the current merged_merge_bases,
until we run out.  At that point when we leave the loop, we'd
have merged_merge_bases that is a virtual commit to be used as
a single merge base to use while merging trees of h1 and h2.

> +	for (iter = merge_bases; iter; iter = iter->next) {
> +		const char *saved_b1, *saved_b2;
> +		struct commit *prev = merged_merge_bases;
> +
> +		opt->priv->call_depth++;
> +		/*
> +		 * When the merge fails, the result contains files
> +		 * with conflict markers. The cleanness flag is
> +		 * ignored (unless indicating an error), it was never
> +		 * actually used, as result of merge_trees has always
> +		 * overwritten it: the committed "conflicts" were
> +		 * already resolved.
> +		 */
> +		saved_b1 = opt->branch1;
> +		saved_b2 = opt->branch2;
> +		opt->branch1 = "Temporary merge branch 1";
> +		opt->branch2 = "Temporary merge branch 2";
> +		merge_ort_internal(opt, NULL, prev, iter->item, result);
> +		if (result->clean < 0)
> +			return;
> +		opt->branch1 = saved_b1;
> +		opt->branch2 = saved_b2;
> +		opt->priv->call_depth--;
> +
> +		merged_merge_bases = make_virtual_commit(opt->repo,
> +							 result->tree,
> +							 "merged tree");
> +		commit_list_insert(prev, &merged_merge_bases->parents);
> +		commit_list_insert(iter->item,
> +				   &merged_merge_bases->parents->next);

We need to record these parents because...?  When merged_merge_bases
we just created is used as one side of a merge in the next iteration,
we'd need to compute the merge base between it and the one we'd pop
out of merge_bases, and that is why.

> +		clear_or_reinit_internal_opts(opt->priv, 1);
> +	}

OK.  I think I understood this loop.  It looks mostly straight-forward.

> +	opt->ancestor = ancestor_name;

And the label to be used, that was computed before the above loop,
is used here...

> +	merge_ort_nonrecursive_internal(opt,
> +					repo_get_commit_tree(opt->repo,
> +							     merged_merge_bases),
> +					repo_get_commit_tree(opt->repo, h1),
> +					repo_get_commit_tree(opt->repo, h2),
> +					result);

... to finally compute the 3-way merge between h1 and h2.

> +	strbuf_release(&merge_base_abbrev);

And the storage that may have been holding the .ancestor name is
cleared, as we no longer need it.

> +	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
> +}
> +
>  void merge_incore_nonrecursive(struct merge_options *opt,
>  			       struct tree *merge_base,
>  			       struct tree *side1,
> @@ -1493,7 +1577,9 @@ void merge_incore_recursive(struct merge_options *opt,
>  			    struct commit *side2,
>  			    struct merge_result *result)
>  {
> -	(void)reverse_commit_list;
> -	(void)make_virtual_commit;
> -	die("Not yet implemented");
> +	assert(opt->ancestor == NULL ||
> +	       !strcmp(opt->ancestor, "constructed merge base"));

Where does this string come from?  The recursive backend does
asssign a fixed string with that value to opt->ancestor, but we
don't expect that string to come here, no?

> +	merge_start(opt, result);
> +	merge_ort_internal(opt, merge_bases, side1, side2, result);
>  }
