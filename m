Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864CCCA481
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 06:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiFHGzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiFHGDB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 02:03:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1545373E
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 21:52:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93B4A19CABD;
        Wed,  8 Jun 2022 00:52:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGcOHjDrv+V3K8Q72QCcKe5GEM6oGiZjinAT7j
        C7lzg=; b=JSRGJmUZMQS5Ed9TxcxvsnQyYw19GqN8Gkj3hUjrSkEoKnn3a7LNU0
        Qm5VXNthfJJMba7DSa+SOb0vCsWfR6U298rGikeLA0LUoZVvj4rMWTG5C1qJDUV8
        Di+yrfxh0SMXIsz6aTNpafJDI5BgxfSA7LJANxnnK/BZoeO0jCE3E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80FBE19CABC;
        Wed,  8 Jun 2022 00:52:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D8F219CABB;
        Wed,  8 Jun 2022 00:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/7] branch: add branch_checked_out() helper
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
        <xmqqr140t9am.fsf@gitster.g>
        <e84b8f19-4fb4-77cd-7e56-087e84e59817@github.com>
        <74d5f74b-c95f-6892-6a66-3e646b1f9e53@github.com>
Date:   Tue, 07 Jun 2022 21:52:22 -0700
In-Reply-To: <74d5f74b-c95f-6892-6a66-3e646b1f9e53@github.com> (Derrick
        Stolee's message of "Tue, 7 Jun 2022 22:43:00 -0400")
Message-ID: <xmqqleu7sqnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9A29E98-E6E6-11EC-9D00-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Yes, that's a good plan. I'll take a look.
>
> Here is a fixup for this patch that should work. I'll put it in v3.
>
> diff --git a/branch.c b/branch.c
> index 2e6419cdfa5..514212f5619 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -10,6 +10,7 @@
>  #include "worktree.h"
>  #include "submodule-config.h"
>  #include "run-command.h"
> +#include "strmap.h"
>  
>  struct tracking {
>  	struct refspec_item spec;
> @@ -369,17 +370,44 @@ int validate_branchname(const char *name, struct strbuf *ref)
>  	return ref_exists(ref->buf);
>  }
>  
> -int branch_checked_out(const char *refname, char **path)
> +static int initialized_checked_out_branches;
> +static struct strmap current_checked_out_branches = STRMAP_INIT;
> +
> +static void prepare_checked_out_branches(void)
>  {
> +	int i = 0;
> +	struct worktree **worktrees;
> +
> +	if (initialized_checked_out_branches)
> +		return;
> +	initialized_checked_out_branches = 1;
> +
> +	worktrees = get_worktrees();
> +
> +	while (worktrees[i]) {
> +		struct worktree *wt = worktrees[i];
>  
> +		if (!wt->is_bare && wt->head_ref)
> +			strmap_put(&current_checked_out_branches,
> +				   wt->head_ref,
> +				   wt->path);
> +
> +		i++;
> +	}
>  	free_worktrees(worktrees);
> -	return result;
> +}

Yeah, the above illustrates what I had in mind pretty closely.  The
above outline only checks where the HEAD symref points at, and it
does not protect a branch that is in the middle of getting bisected
or rebased, which find_shared_symref() tries to do, IIRC, though.

It should not be too hard to add that to the above to allow us to
achieve feature parity with the original.

> +
> +int branch_checked_out(const char *refname, char **path)
> +{
> +	const char *path_in_set;
> +	prepare_checked_out_branches();
> +
> +	path_in_set = strmap_get(&current_checked_out_branches, refname);
> +	if (path_in_set && path)
> +		*path = xstrdup(path_in_set);
> +
> +	return !!path_in_set;
>  }

This one looks quite straight-forward.

> And there is another use of find_shared_symref() in the same file, allowing
> us to do the following:
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ac29c2b1ae3..3933c482839 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -885,7 +885,7 @@ static int update_local_ref(struct ref *ref,
>  			    struct worktree **worktrees)
>  {
>  	struct commit *current = NULL, *updated;
> -	const struct worktree *wt;
> +	char *path = NULL;
>  	const char *pretty_ref = prettify_refname(ref->name);
>  	int fast_forward = 0;
>  
> @@ -900,17 +900,17 @@ static int update_local_ref(struct ref *ref,
>  	}
>  
>  	if (!update_head_ok &&
> -	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
> -	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
> +	    !is_null_oid(&ref->old_oid) &&
> +	    branch_checked_out(ref->name, &path)) {

Yes.  It looks like a good direction to go in.

Thanks.
