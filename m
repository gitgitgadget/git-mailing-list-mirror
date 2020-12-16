Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B195C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4242A259CD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgLPSKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:10:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53408 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgLPSKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:10:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4521CA519F;
        Wed, 16 Dec 2020 13:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9LYAhtl4oprdOvyzJPQv+N3g7eA=; b=mJDCoh
        TZG6UCnPbilUrBiix+/V7IE4KNkHyJPpgK3alTquvwS6e9y7f3vtYAsbeK35lH8Q
        sBDa1bbXkTAE9IPEc5LIR4j9PkB2AyD+wQA79VFiJKT4+D4c5XPo/GSPKfAKvfSC
        GciX/3sG9shRlETSdWvzC4UbrzY7GRRtc1C8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pyxX6kCqZrJHn9Ax/+I4IlFFl9S0ZGLi
        gFiPH9kDNuYHK5Pz+B6shhaV17nQExKtJS1rRF4xIZRMeRNE7O6tFJJPBxpIPMWT
        VQxxLwZJzsNN3tPpqE/4GrNDjYSOL+oCqT3YtErfZMrz3XK7U9pWNwRA1T9k7tPP
        ATh7cOuyGRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D641A519E;
        Wed, 16 Dec 2020 13:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4370A519D;
        Wed, 16 Dec 2020 13:09:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/3] merge-ort: implement merge_incore_recursive()
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
        <d8f79450a40e5a91b401ccbbedc7326cfe8a33d6.1608097965.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 10:09:22 -0800
In-Reply-To: <d8f79450a40e5a91b401ccbbedc7326cfe8a33d6.1608097965.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 16 Dec 2020
        05:52:44 +0000")
Message-ID: <xmqqeejp4o8d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D44A7034-3FC9-11EB-84F8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * merge_incore_nonrecursive() exists for cases where we always
> +	 * know there is a well-defined single merge base.  However,
> +	 * despite a similar structure, merge-recursive.c noted that some
> +	 * callers preferred to call the recursive logic anyway and still
> +	 * set a special name for opt->ancestor that would appear in
> +	 * merge.conflictStyle=diff3 output.

Sorry, I do not understand the comment, especially the "anyway"
part.  There is no such thing as nonrecursive variant of
merge-recursive, is it?  If somebody wanted to perform a merge of
two trees with a designated single common ancestor ("am -3" would
want to do so using a fabricated tree, "cherry-pick" would want to
do so using the parent commit of what gets picked), it would be
natural to call "git merge-recursive O -- A B" if it is a scripted
Porcelain, or would call merge_recursive() with the single merge
base on the merge_bases commit_list parameter if it is written in C,
I would think.

> +	 * git-am was one such example (it wanted to set opt->ancestor to
> +	 * "constructed merge base", since it created a fake merge base);
> +	 * it called the recursive merge logic through a special
> +	 * merge_recursive_generic() wrapper.
> +	 *
> +	 * Allow the same kind of special case here.
> +	 */

In any case, the mention of "constructed merge base" may explain
very well why the assert in the previous iteration checked for the
string, but it does not seem relevant after the condition changed.

> +	int num_merge_bases_is_1 = (merge_bases && !merge_bases->next);
> +	assert(opt->ancestor == NULL || num_merge_bases_is_1);

The above comment may have explained why some callers that call the
machinery with a single merge base want to use its own diff3 label,
but the assert the comment applies to is stricter than that.

In other words, it is unclear why the caller is forbidden from
giving the diff3 label, when the recursive merge needs to synthesize
the virtual ancestor using all the given merge bases?

The answer could be a simple "opt->ancestor field is managed by the
recursive machinery itself when it needs to create virtual ancestor,
and must start as NULL, but when we do not create virtual ancestor,
it is allowed to start with any value, as the machinery itself does
not assign any new value to the field", but I cannot read if that is
the case from the comments in the patch.

> +
> +	merge_start(opt, result);
> +	merge_ort_internal(opt, merge_bases, side1, side2, result);
>  }
> diff --git a/merge-ort.h b/merge-ort.h
> index 55ae7ee865d..d53a0a339f3 100644
> --- a/merge-ort.h
> +++ b/merge-ort.h
> @@ -34,6 +34,16 @@ struct merge_result {
>  /*
>   * rename-detecting three-way merge with recursive ancestor consolidation.
>   * working tree and index are untouched.
> + *
> + * merge_bases will be consumed (emptied) so make a copy if you need it.
> + *
> + * NOTE: empirically, the recursive algorithm will perform better if you
> + *       pass the merge_bases in the order of oldest commit to the
> + *       newest[1][2].
> + *
> + *       [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/
> + *       [2] commit 8918b0c9c2 ("merge-recur: try to merge older merge bases
> + *           first", 2006-08-09)
>   */

I initially thought that this was a bit out-of-place for the comment
that explains why the merge bases list gets reversed in the code, but
it is actually the right place---it guides the callers that hand a
list of merge_bases to the function.

>  void merge_incore_recursive(struct merge_options *opt,
>  			    struct commit_list *merge_bases,

Thanks.
