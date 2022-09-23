Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54BBC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 20:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiIWUnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiIWUmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 16:42:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB2137E55
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 13:37:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 198521B90C0;
        Fri, 23 Sep 2022 16:36:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UzjC6nORUBioFxemAZQO/WDEmpS1R6igyUrzJZ
        rPb+Y=; b=UBHDbawvcNlrK2Yysk+KGh/hScSFmCruS5VpqT2rST1OWzJHl/0S9W
        e352h9nMtXYNgUq8tIK63/Wk5zQalY1VtXh9A6+7MsdcANdOwZBBDLLInNjUiOY9
        X81XsMier0wqjfw4YDIp+v7aVb7NbePrifIzRlSgZKHDfQ2bAAcdU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE2CB1B90BF;
        Fri, 23 Sep 2022 16:36:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AEEC1B90BE;
        Fri, 23 Sep 2022 16:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 3/4] diff-lib: refactor functions
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-4-calvinwan@google.com>
Date:   Fri, 23 Sep 2022 13:36:20 -0700
In-Reply-To: <20220922232947.631309-4-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 22 Sep 2022 23:29:46 +0000")
Message-ID: <xmqqleq9u8u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62C911DC-3B7F-11ED-A44A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Flatten out the if statements in match_stat_with_submodule so the
> logic is more readable and easier for future patches to add to.
>
> Move code that updates relevant variables from the end of
> run_diff_files to finish_run_diff_files. A future patch will utilize
> said function.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  diff-lib.c | 71 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 7eb66a417a..2e148b79e6 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -73,21 +73,50 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>  				     unsigned *dirty_submodule)
>  {
>  	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> -	if (S_ISGITLINK(ce->ce_mode)) {
> -		struct diff_flags orig_flags = diffopt->flags;
> -		if (!diffopt->flags.override_submodule_config)
> -			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> -		if (diffopt->flags.ignore_submodules)
> -			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&
> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);
> -		diffopt->flags = orig_flags;
> +	struct diff_flags orig_flags = diffopt->flags;
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		goto cleanup;
> +	if (!diffopt->flags.override_submodule_config)
> +		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> +	if (diffopt->flags.ignore_submodules) {
> +		changed = 0;
> +		goto cleanup;
>  	}
> +	if (!diffopt->flags.ignore_dirty_submodules &&
> +		(!changed || diffopt->flags.dirty_submodules))
> +			*dirty_submodule = is_submodule_modified(ce->name,
> +							diffopt->flags.ignore_untracked_in_submodules);
> +cleanup:
> +	diffopt->flags = orig_flags;
>  	return changed;
>  }

Unlike the original, this always makes two needless structure
assignments for anything that is not a submodule.  

Can we fix that regression before moving forward?

Even when ce_mode is a gitlink, if .ignore_submodules bit is set,
the two structure assignments between diffopt->flags and orig_flags
become necessary, so the original was already doing extra copies but
we do not have to make it worse.

> +static void finish_run_diff_files(struct rev_info *revs,
> +						  struct cache_entry *ce,
> +						  struct index_state *istate,
> +						  int changed, int dirty_submodule,
> +						  unsigned int newmode)
> +{
> +	unsigned int oldmode;
> +	const struct object_id *old_oid, *new_oid;
> +
> +	if (!changed && !dirty_submodule) {
> +			ce_mark_uptodate(ce);
> +			if (!S_ISGITLINK(ce->ce_mode))
> +				mark_fsmonitor_valid(istate, ce);
> +			if (!revs->diffopt.flags.find_copies_harder)
> +				return;
> +		}
> +		oldmode = ce->ce_mode;
> +		old_oid = &ce->oid;
> +		new_oid = changed ? null_oid() : &ce->oid;
> +		diff_change(&revs->diffopt, oldmode, newmode,
> +			    old_oid, new_oid,
> +			    !is_null_oid(old_oid),
> +			    !is_null_oid(new_oid),
> +			    ce->name, 0, dirty_submodule);
> +}

Strange indentation.  It is unclear why this bottom 1/3 of the loop
body of run_diff_files() need to be a separate helper function,
while the top 2/3 does not.  The resulting loop (below) becomes very
hard to follow because the reader cannot tell when diff_change() is
called and when it is not.

Overall, I see this change detrimental to diff-lib API at this step
in the series.  Later steps may show something more rewarding than
the downsides we see here, hopefully.
