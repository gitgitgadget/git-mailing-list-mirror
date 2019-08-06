Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500151F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfHFQ5y (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:57:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57780 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfHFQ5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:57:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2019A8315F;
        Tue,  6 Aug 2019 12:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZLbtR9pHBm+0gRTAWx/1Xlr0Uls=; b=EKc/JV
        /yEoItgRdz11JCIozoNg2712EvsyvANF9h+fvMwsq46N4ly5AMjMtp7AvtPW3RIG
        7nuw/M70Ggb1Vdv8VujquEiwnRLdxx37J7ZPj6ivBSL8ZDNyYb1GhLjrb4eRLBBy
        o2VxU/S5py6xy1kIepqivqS+Lj3cThRXPdGMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Di3tPdT+qmsnvHBG5v4u1kfOWrZw7/jk
        LdFETLBB5Bnaw/wk+g6JEMYQNtYp0EhFdo6Wuf6xI668v9NqJFLWluTpYm/Ww4Gy
        F7v/Z+Uc/rD+ROYFPibbuu/mOVdCkFAwzbvXTaDTtTq9QA6nYgUZWJkW2Wlbht02
        GUWiniizi+Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18FF98315E;
        Tue,  6 Aug 2019 12:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE8958315C;
        Tue,  6 Aug 2019 12:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in recursive case
References: <20190726220928.GG113966@google.com>
        <20190805223350.27504-1-newren@gmail.com>
Date:   Tue, 06 Aug 2019 09:57:46 -0700
In-Reply-To: <20190805223350.27504-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 5 Aug 2019 15:33:50 -0700")
Message-ID: <xmqq1rxykz91.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5205E054-B86B-11E9-9A33-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ever since commit 8c8e5bd6eb33 ("merge-recursive: switch directory
> rename detection default", 2019-04-05), the default handling with
> directory rename detection was to report a conflict and leave unstaged
> entries in the index.  However, when creating a virtual merge base in
> the recursive case, we absolutely need a tree, and the only way a tree
> can be written is if we have no unstaged entries -- otherwise we hit a
> BUG().
>
> There are a few fixes possible here which at least fix the BUG(), but
> none of them seem optimal for other reasons; see the comments with the
> new testcase 13e in t6043 for details (which testcase triggered a BUG()
> prior to this patch).  As such, just opt for a very conservative and
> simple choice that is still relatively reasonable: have the recursive
> case treat 'conflict' as 'false' for opt->detect_directory_renames.
>
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>
> I really should introduce constants like
>   DETECT_DIRECTORY_RENAMES_NEVER    = 0
>   DETECT_DIRECTORY_RENAMES_CONFLICT = 1
>   DETECT_DIRECTORY_RENAMES_YES      = 2

How would they compare with MERGE_DIRECTORY_RENAMES_* macros
I see at the tip of 'pu'?  init_merge_options() seems to read
one of those values from the "repo settings" and copies it to
the detect_directory_renames field, so I am reading that they
must be identical.

> and then use them in the code to make it clearer, but I wanted to make
> the code change as simple and contained as possible given that this is
> built on maint, fixes a BUG() and we're already in -rc1.
>
> I know this bug doesn't satisfy the normal criteria for making it into
> 2.23 (it's a bug that was present in 2.22 rather than a regression in
> 2.23), but given that it's a BUG() condition, I was hoping it is
> important and safe enough to include anyway.

I do agree that it is sensible to avoid doing any funky thing during
the virtual base merges, whose result is much less observable (hence
harder to form the right mental model in end user's head) than the
outermost merge.  Do we want to allow this for inner merges when the
setting is 2?  Wouldn't that hit the same BUG()?

> (This fix does merge down cleanly to master, next, and pu.)
>
>  merge-recursive.c                   |   3 +-
>  t/t6043-merge-rename-directories.sh | 111 ++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d2e380b7ed..c7691d9b54 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2856,7 +2856,8 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	head_pairs = get_diffpairs(opt, common, head);
>  	merge_pairs = get_diffpairs(opt, common, merge);
>  
> -	if (opt->detect_directory_renames) {
> +	if ((opt->detect_directory_renames == 2) ||
> +	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {
>  		dir_re_head = get_directory_renames(head_pairs);
>  		dir_re_merge = get_directory_renames(merge_pairs);
>  
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index 50b7543483..c966147d5d 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -4403,4 +4403,115 @@ test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual
>  	)
>  '
>  
> +# Testcase 13e, directory rename in virtual merge base
> +#
> +# This testcase has a slightly different setup than all the above cases, in
> +# order to include a recursive case:
> +#
> +#      A   C
> +#      o - o
> +#     / \ / \
> +#  O o   X   ?
> +#     \ / \ /
> +#      o   o
> +#      B   D
> +#
> +#   Commit O: a/{z,y}
> +#   Commit A: b/{z,y}
> +#   Commit B: a/{z,y,x}
> +#   Commit C: b/{z,y,x}
> +#   Commit D: b/{z,y}, a/x
> +#   Expected: b/{z,y,x}  (sort of; see below for why this might not be expected)
> +#
> +#   NOTES: 'X' represents a virtual merge base.  With the default of
> +#          directory rename detection yielding conflicts, merging A and B
> +#          results in a conflict complaining about whether 'x' should be
> +#          under 'a/' or 'b/'.  However, when creating the virtual merge
> +#          base 'X', since virtual merge bases need to be written out as a
> +#          tree, we cannot have a conflict, so some resolution has to be
> +#          picked.
> +#
> +#          In choosing the right resolution, it's worth noting here that
> +#          commits C & D are merges of A & B that choose different
> +#          locations for 'x' (i.e. they resolve the conflict differently),
> +#          and so it would be nice when merging C & D if git could detect
> +#          this difference of opinion and report a conflict.  But the only
> +#          way to do so that I can think of would be to have the virtual
> +#          merge base place 'x' in some directory other than either 'a/' or
> +#          'b/', which seems a little weird -- especially since it'd result
> +#          in a rename/rename(1to2) conflict with a source path that never
> +#          existed in any version.
> +#
> +#          So, for now, when directory rename detection is set to
> +#          'conflict' just avoid doing directory rename detection at all in
> +#          the recursive case.  This will not allow us to detect a conflict
> +#          in the outer merge for this special kind of setup, but it at
> +#          least avoids hitting a BUG().
> +#
> +test_expect_success '13e-setup: directory rename detection in recursive case' '
> +	test_create_repo 13e &&
> +	(
> +		cd 13e &&
> +
> +		mkdir a &&
> +		echo z >a/z &&
> +		echo y >a/y &&
> +		git add a &&
> +		test_tick &&
> +		git commit -m "O" &&
> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		git mv a/ b/ &&
> +		test_tick &&
> +		git commit -m "A" &&
> +
> +		git checkout B &&
> +		echo x >a/x &&
> +		git add a &&
> +		test_tick &&
> +		git commit -m "B" &&
> +
> +		git branch C A &&
> +		git branch D B &&
> +
> +		git checkout C &&
> +		test_must_fail git -c merge.directoryRenames=conflict merge B &&
> +		git add b/x &&
> +		test_tick &&
> +		git commit -m "C" &&
> +
> +
> +		git checkout D &&
> +		test_must_fail git -c merge.directoryRenames=conflict merge A &&
> +		git add b/x &&
> +		mkdir a &&
> +		git mv b/x a/x &&
> +		test_tick &&
> +		git commit -m "D"
> +	)
> +'
> +
> +test_expect_success '13e-check: directory rename detection in recursive case' '
> +	(
> +		cd 13e &&
> +
> +		git checkout --quiet D^0 &&
> +
> +		git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&
> +
> +		test_i18ngrep ! CONFLICT out &&
> +		test_i18ngrep ! BUG: err &&
> +		test_i18ngrep ! core.dumped err &&
> +		test_must_be_empty err &&
> +
> +		git ls-files >paths &&
> +		! grep a/x paths &&
> +		grep b/x paths
> +	)
> +'
> +
>  test_done
