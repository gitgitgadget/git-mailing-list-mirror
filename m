Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE3C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC6F207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLItsyIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439736AbgJQWZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:25:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62595 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439621AbgJQWZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 18:25:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5997C9AD84;
        Sat, 17 Oct 2020 18:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ap02LoU/9f1WUwO3YnzZqF95Xp4=; b=VLItsy
        IEfthKyEnZwudKc/HjSA7emlGfkrPB4Sq4wcOwLJw+9efvBYGDfiwc/NbN9TMltm
        dBTX/K7cy+Np4XVrU0dUi5s0QUeN9CnY7g8ae3LhXhVx6etKsHcmP5/o7j61pTwS
        ls4qs/uzoi6scHwrtzIKyWtOjOlaaON7FIBA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mESeBSkhnX0iIW4gR750ozFB8UvS7XY8
        aQbjcyE7UTwxU4/Q4uU2vReL/wr+/KNjLKzEPkLnmlIiPvzbMJlIQr1pdJMYd2PV
        MOhuqxthCEnc3jY9ZNrnr0wy9p4x/Kk2LLHUmw5tzdxb5L86EZcua8sjGttWWo9N
        324JzrAK4ow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EE3F9AD82;
        Sat, 17 Oct 2020 18:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04C229AD81;
        Sat, 17 Oct 2020 18:25:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 15:25:01 -0700
In-Reply-To: <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
        (Alex Vandiver via GitGitGadget's message of "Sat, 17 Oct 2020
        21:04:33 +0000")
Message-ID: <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99E2D872-10C7-11EB-A9D9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Vandiver <alexmv@dropbox.com>
>
> With fsmonitor enabled, the first call to match_stat_with_submodule
> calls refresh_fsmonitor, incurring the overhead of reading the list of
> updated files -- but run_diff_files does not respect the
> CE_FSMONITOR_VALID flag.

run_diff_files() is used not just by "git diff" but other things
like "git add", so if we get an overall speed-up without having to
pay undue cost, that would be a very good news.

> diff --git a/diff-lib.c b/diff-lib.c
> index f95c6de75f..b7ee1b89ef 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -97,6 +97,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>  
> +	refresh_fsmonitor(istate);
> +

"git diff" and friends are often run with pathspec, but the API into
the fsmonitor, refresh_fsmonitor() call, has no way to say "I only
am interested in the status of this directory and everything else
does not matter".  How expensive would this call to accept fsmonitor
data for the entire tree be, and would there eventually be a point
where the number of paths we are interested in checking (i.e. the
paths that would match the pathspec) is so small that we would be
better off not making this call?  E.g. if we are checking more than
20% of the working tree, running refresh_fsmonitor() for the entire
working tree is still a win, but if we are only checking less than
that, we are better off without fsmonitor, or does a tradeoff like
that exist?

> @@ -197,8 +199,19 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		if (ce_uptodate(ce) || ce_skip_worktree(ce))
>  			continue;
>  
> -		/* If CE_VALID is set, don't look at workdir for file removal */
> -		if (ce->ce_flags & CE_VALID) {
> +		/*
> +		 * If CE_VALID is set, the user has promised us that the workdir
> +		 * hasn't changed compared to index, so don't stat workdir
> +		 * for file removal

The above seems to be an attempt to elaborate on the existing
comment, but ...

> +		 *  eg - via git udpate-index --assume-unchanged
> +		 *  eg - via core.ignorestat=true

... what are these two lines doing here?  It makes no sense to say
"Don't stat workdir for file removal by doing 'git update-index' or
by seetting core.ignorestat", but the placement of these two lines
makes it look as if that is what you are saying.  Perhaps

	When CE_VALID is set (via "update-index --assume-unchanged"
	or via adding paths while core.ignorestat is set to true),
	the user has promised ..., so don't stat workdir for removed
	files.

would probably be what you meant bo say.

> +		 * When using FSMONITOR:
> +		 * If CE_FSMONITOR_VALID is set, then we know the metadata on disk
> +		 * has not changed since the last refresh, and we can skip the
> +		 * file-removal checks without doing the stat in check_removed.

An iffy description.  You skip all the file-removal check by not
calling check_removed() as a whole.

This is not the fault of this patch, but in any case, the
description places too much stress on "removal" when in reality,
removal is not all that special in this codepath.  The check_removed
call also contributes to noticiing modified (not removed) files.  If
we are updating the comment here, we should correct that too,
perhaps

	When CE_VALID is set (via "update-index --assume-unchanged"
	or via adding paths while core.ignorestat is set to true),
	the user has promised that the working tree file for that
	path will not be modified.  When CE_FSMONITOR_VALID is true,
	the fsmonitor knows that the path hasn't been modified since
	we refreshed the cached stat information.  In either case,
	we do not have to stat to see if the path has been removed
	or modified.

or something like that, perhaps.

> +		 */
> +		if (ce->ce_flags & CE_VALID || ce->ce_flags & CE_FSMONITOR_VALID) {

Would it become easier to read, if written like this instead?

		if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {

That reflects what the suggested comment says better.

>  			changed = 0;
>  			newmode = ce->ce_mode;
>  		} else {

Thanks.
