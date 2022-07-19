Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C5CC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 06:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGSGjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiGSGjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 02:39:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FDE275D9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 23:39:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2F2C192CB3;
        Tue, 19 Jul 2022 02:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AkBDtBjkY2GA/B2xIfNqMm7mXt3qb3WMHQ0QG4
        MyVmM=; b=NntgRP3F0VEMxy5pt3jIpi6gyxyfNC/ZJ8D+r2wGVjIb678uzhLHOs
        V1aneet6JwFWVVxsZcmmPBAMjWnqBI4LQ8b1w8yE/76ZY8RChb+NpXvQvy3FC/0e
        BQk3xYIS3ly8VVhPSg1uO2hUS70cegdXmEcZNXIQoYmHr1MTQOVPY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EA80192CB2;
        Tue, 19 Jul 2022 02:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A73A192CB0;
        Tue, 19 Jul 2022 02:39:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
References: <20220712231935.2979727-1-calvinwan@google.com>
        <20220718214349.3379328-1-calvinwan@google.com>
Date:   Mon, 18 Jul 2022 23:39:38 -0700
In-Reply-To: <20220718214349.3379328-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 18 Jul 2022 21:43:49 +0000")
Message-ID: <xmqqzgh5d2s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9032C982-072D-11ED-AF45-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Changes since v4:
>  - Rebased onto gitster/master
>  - Fixed test cases to work with only merge-ort (and not merge-recursive)

That's not a log-message material.  You could have probably written
scissors ...

> == Description ==

--- >8 ---

... here, perhaps?

> When attempting to merge in a superproject with conflicting submodule
> pointers that cannot be fast-forwarded or trivially resolved, the merge
> fails and git prints the following error:
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Automatic merge failed; fix conflicts and then commit the result.
>
> Git is left in a conflicted state, which requires the user to:
>  1. merge submodules or update submodules to an already existing
> 	commit that reflects the merge
>  2. add submodules changes to the superproject
>  3. finish merging superproject
> These steps are non-obvious for newer submodule users to figure out
> based on the error message and neither `git submodule status` nor `git
> status` provide any useful pointers. 
>
> Update error message to match the steps above. If git does not detect a 
> merge resolution, the following is printed:
>
> ====
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules currently only supports trivial cases.
> Please manually handle the merging of each conflicted submodule.
> This can be accomplished with the following steps:
>  - go to submodule (<submodule>), and either merge commit <commit>
> or update to an existing commit which has merged those changes
>  - come back to superproject, and `git add <submodule>` to record the above merge or update
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> ====
>
> If git detects a possible merge resolution, the following is printed:
>
> ====
>
> Failed to merge submodule sub, but a possible merge resolution exists:
>     <commit> Merge branch '<branch1>' into <branch2>
>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules currently only supports trivial cases.
> Please manually handle the merging of each conflicted submodule.
> This can be accomplished with the following steps:
> To manually complete the merge:
>  - go to submodule (<submodule>), and either merge commit <commit>
> or update to an existing commit which has merged those changes
> such as one listed above
>  - come back to superproject, and `git add <submodule>` to record the above merge or update
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> ====
>
> If git detects multiple possible merge resolutions, the following is printed:
>
> ====
>
> Failed to merge submodule sub, but multiple possible merges exist:
>     <commit> Merge branch '<branch1>' into <branch2>
>     <commit> Merge branch '<branch1>' into <branch3>
>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules currently only supports trivial cases.
> Please manually handle the merging of each conflicted submodule.
> This can be accomplished with the following steps:
> To manually complete the merge:
>  - go to submodule (<submodule>), and either merge commit <commit>
> or update to an existing commit which has merged those changes
> such as one listed above
>  - come back to superproject, and `git add <submodule>` to record the above merge or update
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.

But cutting the cruft at the top is still not enough, because the
below are not log-message material, either.

These extraneous stuff may help reviewers while the patch is being
polished, but once committed to our history, readers of "git log"
should not have to care what other attempts were made that did not
become part of the final hstory.  The log message proper should be
understandable standalone.

The stuff to help reviewers who may have seen earlier round are
usually written in the cover letter, or after the three-dash line.

> == Previous Changes ==
>
> Changes since v3:
> ...
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  merge-ort.c                 | 56 +++++++++++++++++++++++++++++++++++++
>  t/t6437-submodule-merge.sh  | 38 +++++++++++++++++++++----
>  t/t7402-submodule-rebase.sh |  9 ++++--
>  3 files changed, 95 insertions(+), 8 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b..125ee3c0d1 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> ...
> +	if (csub && csub->nr > 0) {
> +		int i;
> +		printf(_("Recursive merging with submodules currently only supports trivial cases.\n"
> +			"Please manually handle the merging of each conflicted submodule.\n"
> +			"This can be accomplished with the following steps:\n"));

This makes me wonder if these "helpful but verbose" messages should
use the advise mechanism.  Also, those reviewers who care about l10n
may suggest use of printf_ln() to lose the LF at the end of these
messages (i.e. not just the above one, but others we see below as
well).

> +		for (i = 0; i < csub->nr; i++) {
> +			printf(_(" - go to submodule (%s), and either merge commit %s\n"
> +				    "or update to an existing commit which has merged those changes\n"),
> +					csub->items[i].path,
> +					csub->items[i].oid);
> +			if (csub->items[i].resolution_exists)
> +				printf(_("such as one listed above\n"));
> +		}
> +		printf(_(" - come back to superproject, and `git add"));
> +		for (i = 0; i < csub->nr; i++)
> +			printf(_(" %s"), csub->items[i].path);
> +		printf(_("` to record the above merge or update \n"
> +			" - resolve any other conflicts in the superproject\n"
> +			" - commit the resulting index in the superproject\n"));
> +	}
> +}
> +
>  void merge_display_update_messages(struct merge_options *opt,
>  				   int detailed,
>  				   struct merge_result *result)
> @@ -4461,6 +4515,8 @@ void merge_display_update_messages(struct merge_options *opt,
>  	}
>  	string_list_clear(&olist, 0);
>  
> +	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
> +
>  	/* Also include needed rename limit adjustment now */
>  	diff_warn_rename_limit("merge.renamelimit",
>  			       opti->renames.needed_limit, 0);

Thanks.
