Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE14FC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903996128D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhDDGJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 02:09:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59020 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhDDGJw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 02:09:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F198DC40AE;
        Sun,  4 Apr 2021 02:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToxIKzs/SpKWu0EVRZrePJdBG3M=; b=j0IRWh
        6FbTgTiK5WuJRszt6/JszJ7JAxWfYjWjSr3IEemMUYSOaeiM5p0mCNeqWHsIJb8T
        XBL2UYyasvBbJdHZcKhdg7dfQY/JcGPbBSNW0TpuYk5+aujplUjIMAemdxaAP9bB
        qbcRytebV6Utx2Rzhvg+9VObrW+jV0S1lFchk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EGjfiWrYcWZJphbjOqJXiwlBG5TB63fh
        nTDOc1a09iWvwdyPFttSRwP/zE3CtGievfq3XaSIWrxOsql6dDfzwcqApeXlaqfB
        e6kHtMziNrycqO219KcI5ga4fxZUF1inbRNyuTl+QX95yjvlaaGhhmpMvajtJKRv
        ywty01pNV+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E98A9C40AD;
        Sun,  4 Apr 2021 02:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70845C40AC;
        Sun,  4 Apr 2021 02:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chinmoy <chinmoy12c@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
        <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
Date:   Sat, 03 Apr 2021 23:09:46 -0700
In-Reply-To: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com> (Chinmoy
        via GitGitGadget's message of "Sat, 03 Apr 2021 15:57:00 +0000")
Message-ID: <xmqqy2dyy40l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BA736A6-950C-11EB-AA63-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/sparse-index.c b/sparse-index.c
> index 95ea17174da3..e4323ffd81db 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -128,12 +128,14 @@ int set_sparse_index_config(struct repository *repo, int enable)
>  int convert_to_sparse(struct index_state *istate)
>  {
>  	int test_env;
> +	struct repository *r = the_repository;
> +
>  	if (istate->split_index || istate->sparse_index ||
>  	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>  		return 0;
>  
>  	if (!istate->repo)
> -		istate->repo = the_repository;
> +		istate->repo = r;
>  

I am not quite sure if this is a reasonable conversion.  Surely it
would not make the compiler barf, but are we sure that the caller of
convert_to_sparse() wants us to work on the_repository instance and
no other repository?  As an istate has a .repo member, it seems to
me that using istate->repo would be a lot saner approach than
assigning the_repository upfront to r.  It might be even needed, if
cache_tree_update() wants to take a repository instance, to ensure
that all callers to this helper sets istate->repo before they call
it so that the above "if not set yet, use the_repository" code does
not have to kick in.

>  	/*
>  	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> @@ -161,7 +163,7 @@ int convert_to_sparse(struct index_state *istate)
>  		return -1;
>  	}
>  
> -	if (cache_tree_update(istate, 0)) {
> +	if (cache_tree_update(r, istate, 0)) {

And this looks like a bad conversion.  It may happen to do the same
thing, but the flow of the logic up to this point in the function
was to make sure istate->repo is not empty by filling it if it is
not yet set, and update the cache tree of that istate.  So, it seems
more logical if this call were like so, no?

	if (cache_tree_update(istate->repo, istate, 0)) {

In fact, in the world after 1fd9ae51 (repository: add repo reference
to index_state, 2021-01-23), it is dubious that this topic to teach
cache_tree_update() to take a repository pointer is sensible.  While
working on a single repository, we may create multiple in-core index
instances that represent temporary indices, but each of these in-core
index instances (i.e. istate) belong to a single repository.

And in a call to cache_tree_update(R, I, F), if I->repo is *NOT* R,
that must mean a bug.  Here is what 1fd9ae51 says on this point.

    repository: add repo reference to index_state

    It will be helpful to add behavior to index operations that might
    trigger an object lookup. Since each index belongs to a specific
    repository, add a 'repo' pointer to struct index_state that allows
    access to this repository.

    Add a BUG() statement if the repo already has an index, and the index
    already has a repo, but somehow the index points to a different repo.

    This will prevent future changes from needing to pass an additional
    'struct repository *repo' parameter and instead rely only on the 'struct
    index_state *istate' parameter.

Derrick, what's you thought on this?  The patch under discussion
looks to me a prime example of "future change(s)" needing "to pass
an additional 'struct repository *repo' parameter".

Thanks.

