Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36431C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036A861D51
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhF2EFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:05:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59301 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2EFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 00:05:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92371C61B7;
        Tue, 29 Jun 2021 00:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ih/+SiEANMcW6nz+PH1NqHI8m7FSE6t3itIGisfp6pM=; b=r2WP
        HHyjy2crJaieUNRLPks7eeeg/RFxhteQVl6in+3BNQYO64DJt6nPoJTB3YJ5RHxD
        OVTXu+A134smc/RqlsYu/4sM2Ffbl86EXApD1SBqTG9QtbEEhlyi1sxK30PMHWD7
        4BiXyATKycjJBZ4DUXUaZAfdLov6U7rP8NpEoq8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89649C61B5;
        Tue, 29 Jun 2021 00:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15762C61B4;
        Tue, 29 Jun 2021 00:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] merge-recursive: handle rename-to-self case
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
        <dea97c25e52c0c5dcba7698cdc2af742344fe36d.1624727122.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Jun 2021 21:02:37 -0700
Message-ID: <xmqqeecl1foi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7B79CE8-D88E-11EB-B07E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Directory rename detection can cause transitive renames, e.g. if the two
> different sides of history each do one half of:
>     A/file -> B/file
>     B/     -> C/
> then directory rename detection transitively renames to give us
>     A/file -> C/file
>
> However, when C/ == A/, note that this gives us
>     A/file -> A/file.

Heh, of course this is recent because the "guess that directory B
has been moved to C in its entirety" heuristic is quite new.

Nicely fixed and described.  Will queue.  Thanks.


>
> merge-recursive assumed that any rename D -> E would have D != E.  While
> that is almost always true, the above is a special case where it is not.
> So we cannot do things like delete the rename source, we cannot assume
> that a file existing at path E implies a rename/add conflict and we have
> to be careful about what stages end up in the output.
>
> This change feels a bit hackish.  It took me surprisingly many hours to
> find, and given merge-recursive's design causing it to attempt to
> enumerate all combinations of edge and corner cases with special code
> for each combination, I'm worried there are other similar fixes needed
> elsewhere if we can just come up with the right special testcase.
> Perhaps an audit would rule it out, but I have not the energy.
> merge-recursive deserves to die, and since it is on its way out anyway,
> fixing this particular bug narrowly will have to be good enough.
>
> Reported-by: Anders Kaseorg <andersk@mit.edu>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                   | 19 +++++++++++++------
>  t/t6423-merge-rename-directories.sh |  4 ++--
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d146bb116f7..c895145a8f5 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2804,12 +2804,19 @@ static int process_renames(struct merge_options *opt,
>  			int renamed_stage = a_renames == renames1 ? 2 : 3;
>  			int other_stage =   a_renames == renames1 ? 3 : 2;
>  
> +			/*
> +			 * Directory renames have a funny corner case...
> +			 */
> +			int renamed_to_self = !strcmp(ren1_src, ren1_dst);
> +
>  			/* BUG: We should only remove ren1_src in the base
>  			 * stage and in other_stage (think of rename +
>  			 * add-source case).
>  			 */
> -			remove_file(opt, 1, ren1_src,
> -				    renamed_stage == 2 || !was_tracked(opt, ren1_src));
> +			if (!renamed_to_self)
> +				remove_file(opt, 1, ren1_src,
> +					    renamed_stage == 2 ||
> +					    !was_tracked(opt, ren1_src));
>  
>  			oidcpy(&src_other.oid,
>  			       &ren1->src_entry->stages[other_stage].oid);
> @@ -2823,6 +2830,9 @@ static int process_renames(struct merge_options *opt,
>  			    ren1->dir_rename_original_type == 'A') {
>  				setup_rename_conflict_info(RENAME_VIA_DIR,
>  							   opt, ren1, NULL);
> +			} else if (renamed_to_self) {
> +				setup_rename_conflict_info(RENAME_NORMAL,
> +							   opt, ren1, NULL);
>  			} else if (oideq(&src_other.oid, null_oid())) {
>  				setup_rename_conflict_info(RENAME_DELETE,
>  							   opt, ren1, NULL);
> @@ -3180,7 +3190,6 @@ static int handle_rename_normal(struct merge_options *opt,
>  	struct rename *ren = ci->ren1;
>  	struct merge_file_info mfi;
>  	int clean;
> -	int side = (ren->branch == opt->branch1 ? 2 : 3);
>  
>  	/* Merge the content and write it out */
>  	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
> @@ -3190,9 +3199,7 @@ static int handle_rename_normal(struct merge_options *opt,
>  	    opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
>  	    ren->dir_rename_original_dest) {
>  		if (update_stages(opt, path,
> -				  NULL,
> -				  side == 2 ? &mfi.blob : NULL,
> -				  side == 2 ? NULL : &mfi.blob))
> +				  &mfi.blob, &mfi.blob, &mfi.blob))
>  			return -1;
>  		clean = 0; /* not clean, but conflicted */
>  	}
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index 7480daab46a..d67b5c28944 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5058,7 +5058,7 @@ test_setup_12i () {
>  	)
>  }
>  
> -test_expect_merge_algorithm failure success '12i: Directory rename causes rename-to-self' '
> +test_expect_success '12i: Directory rename causes rename-to-self' '
>  	test_setup_12i &&
>  	(
>  		cd 12i &&
> @@ -5116,7 +5116,7 @@ test_setup_12j () {
>  	)
>  }
>  
> -test_expect_merge_algorithm failure success '12j: Directory rename to root causes rename-to-self' '
> +test_expect_success '12j: Directory rename to root causes rename-to-self' '
>  	test_setup_12j &&
>  	(
>  		cd 12j &&
