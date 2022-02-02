Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415BC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiBBVaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:30:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50235 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiBBVaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:30:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BA1A1800DA;
        Wed,  2 Feb 2022 16:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hezclED/wEGppVIsIeWX24woJIa9JMXRNBUEvvYtoc4=; b=Gn6r
        xBrANePcuhPSQK4t0kjjRtuWgrbWKDyA54Xf9EpvW3IcVD9JTlrew2AbqY0OcdQ3
        r00FMbqSkH9RX9lR3plQh/A9dcWm7d3QbqK+cSo+j4qC3wu+pqZkL8vZziecHmDK
        w4SJg5/MvA11vy0MWxZ28P51aA4HbchTm+oZvew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 136621800D9;
        Wed,  2 Feb 2022 16:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76DB31800D8;
        Wed,  2 Feb 2022 16:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/13] merge-tree: implement real merges
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643479633.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:30:35 -0800
Message-ID: <xmqqmtj9x8g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C37D528-846F-11EC-BCEA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> This adds the ability to perform real merges rather than just trivial
> merges (meaning handling three way content merges, recursive ancestor
> consolidation, renames, proper directory/file conflict handling, and so
> forth).  However, unlike `git merge`, the working tree and index are
> left alone and no branch is updated.
>
> The only output is:
>   - the toplevel resulting tree printed on stdout
>   - exit status of 0 (clean), 1 (conflicts present), anything else
>     (merge could not be performed; unknown if clean or conflicted)
>
> This output is meant to be used by some higher level script, perhaps in
> a sequence of steps like this:
>
>    NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>    test $? -eq 0 || die "There were conflicts..."
>    NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
>    git update-ref $BRANCH1 $NEWCOMMIT

It is unclear what NEWTREE has, if anything meaningful, when the
command exited with non-zero status.  Let's read on.

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 58731c19422..569485815a0 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -3,26 +3,73 @@ git-merge-tree(1)
>  
>  NAME
>  ----
> -git-merge-tree - Show three-way merge without touching index
> +git-merge-tree - Perform merge without touching index or working tree

OK.  It is interesting that both apply equally to either command
mode ;-)

> +Performs a merge, but does not make any new commits and does not read
> +from or write to either the working tree or index.
> +
> +The second form is deprecated and supported only for backward
> +compatibility.  It will likely be removed in the future, and will not
> +be discussed further in this manual.

This, especially the deletion of the original description on what
trivial merge does, may be premature, especially if it is still
"supported for backward compatibility".

> +The first form will merge the two branches, doing a real merge.  A real
> +merge is distinguished from a trivial merge in that it includes:

I think this is worth keeping, simply because I do not think you
should entirely omit description on the trivial one.

But if we were to remove the description on the trivial one, then it
is totally meaningless to label the following as "... distinguished
from a trivial merge in that".  The list of things the real merge
command mode does (below) is of course worth having.

> +  * three way content merges of individual files
> +  * rename detection
> +  * proper directory/file conflict handling
> +  * recursive ancestor consolidation (i.e. when there is more than one
> +    merge base, creating a virtual merge base by merging the merge bases)
> +  * etc.
> +
> +After the merge completes, it will create a new toplevel tree object.
> +See `OUTPUT` below for details.
> +
> +OUTPUT
> +------
> +
> +For either a successful or conflicted merge, the output from
> +git-merge-tree is simply one line:
> +
> +	<OID of toplevel tree>
> +
> +The printed tree object corresponds to what would be checked out in
> +the working tree at the end of `git merge`, and thus may have files
> +with conflict markers in them.

So we would leave cruft in the object store, but that is very much
on purpose, and the expectation is that the user would commit-tree
the tree object and reference it with a ref soon enough before
garbage collection prunes them, just like how write-tree is meant to
be used.  OK.

> +EXIT STATUS
> +-----------
> +
> +For a successful, non-conflicted merge, the exit status is 0.  When the
> +merge has conflicts, the exit status is 1.  If the merge is not able to
> +complete (or start) due to some kind of error, the exit status is
> +something other than 0 or 1.

And the output given to the standard output stream, when the command
exits with status higher than 1, is...?  "unspecified" is of course
an acceptable answer, of course, but I am wondering if it is worth
spelling out in the doc.

> +USAGE NOTES
> +-----------
> +
> +git-merge-tree was written to be low-level plumbing, similar to
> +hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could

A notable omission in the above list is 'write-tree'.

> +be used as a part of a series of steps such as
> +
> +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> +       test $? -eq 0 || die "There were conflicts..."
> +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> +       git update-ref $BRANCH1 $NEWCOMMIT
> +
> +However, it does not quite fit into the same category of low-level
> +plumbing commands since the possibility of merge conflicts give it a
> +much higher chance of the command not succeeding.

I am not sure if that is a fair categorization.  It is a fine
building block at the lowest level of the tool hierarchy.  The
primary thing that differentiates plumbing from Porcelain is that
the former is a better fit for scripting: doing one thing and one
thing well with minimum and stable UI.  The complexity of that one
thing it does has much less to do with the categorization, and the
rate at which users may use the command in a failure-inducing
situation has nothing to do with it.  The write-tree plumbing
command will reliably fail with 100% chance when the index used as
its input is unmerged.

> @@ -392,7 +395,46 @@ struct merge_tree_options {
>  static int real_merge(struct merge_tree_options *o,
>  		      const char *branch1, const char *branch2)
>  {
> -	die(_("real merges are not yet implemented"));
> +	struct commit *parent1, *parent2;
> +	struct commit_list *common;
> +	struct commit_list *merge_bases = NULL;
> +	struct commit_list *j;
> +	struct merge_options opt;
> +	struct merge_result result = { 0 };
> +
> +	parent1 = get_merge_parent(branch1);
> +	if (!parent1)
> +		help_unknown_ref(branch1, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	parent2 = get_merge_parent(branch2);
> +	if (!parent2)
> +		help_unknown_ref(branch2, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	init_merge_options(&opt, the_repository);
> +
> +	opt.show_rename_progress = 0;
> +
> +	opt.branch1 = branch1;
> +	opt.branch2 = branch2;
> +
> +	/*
> +	 * Get the merge bases, in reverse order; see comment above
> +	 * merge_incore_recursive in merge-ort.h
> +	 */
> +	common = get_merge_bases(parent1, parent2);
> +	if (!common)
> +		die(_("refusing to merge unrelated histories"));
> +	for (j = common; j; j = j->next)
> +		commit_list_insert(j->item, &merge_bases);
> +
> +	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +	if (result.clean < 0)
> +		die(_("failure to merge"));
> +	puts(oid_to_hex(&result.tree->object.oid));
> +	merge_finalize(&opt, &result);
> +	return !result.clean; /* result.clean < 0 handled above */
>  }

The implementation is rather straight-forward, if you know how to
drive the merge_incore_recursive() helper ;-)

> +test_expect_success setup '
> +	test_write_lines 1 2 3 4 5 >numbers &&
> +	echo hello >greeting &&
> +	echo foo >whatever &&
> +	git add numbers greeting whatever &&
> +	test_tick &&
> +	git commit -m initial &&
> +
> +	git branch side1 &&
> +	git branch side2 &&
> +
> +	git checkout side1 &&
> +	test_write_lines 1 2 3 4 5 6 >numbers &&
> +	echo hi >greeting &&
> +	echo bar >whatever &&
> +	git add numbers greeting whatever &&
> +	test_tick &&
> +	git commit -m modify-stuff &&
> +
> +	git checkout side2 &&
> +	test_write_lines 0 1 2 3 4 5 >numbers &&
> +	echo yo >greeting &&
> +	git rm whatever &&
> +	mkdir whatever &&
> +	>whatever/empty &&
> +	git add numbers greeting whatever/empty &&
> +	test_tick &&
> +	git commit -m other-modifications
> +'
> +
> +test_expect_success 'Content merge and a few conflicts' '
> +	git checkout side1^0 &&
> +	test_must_fail git merge side2 &&
> +	expected_tree=$(cat .git/AUTO_MERGE) &&
> +
> +	# We will redo the merge, while we are still in a conflicted state!
> +	test_when_finished "git reset --hard" &&
> +
> +	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
> +	actual_tree=$(head -n 1 RESULT) &&
> +
> +	# Due to differences of e.g. "HEAD" vs "side1", the results will not
> +	# exactly match.  Dig into individual files.
> +
> +	# Numbers should have three-way merged cleanly
> +	test_write_lines 0 1 2 3 4 5 6 >expect &&
> +	git show ${actual_tree}:numbers >actual &&
> +	test_cmp expect actual &&
> +
> +	# whatever and whatever~<branch> should have same HASHES
> +	git rev-parse ${expected_tree}:whatever ${expected_tree}:whatever~HEAD >expect &&
> +	git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~side1 >actual &&
> +	test_cmp expect actual &&
> +
> +	# greeting should have a merge conflict
> +	git show ${expected_tree}:greeting >tmp &&
> +	cat tmp | sed -e s/HEAD/side1/ >expect &&
> +	git show ${actual_tree}:greeting >actual &&
> +	test_cmp expect actual
> +'

It is somewhat sad that we need to reivent merge test cases over and
over, instead of easily reuse an existing one by replacing

	git checkout one &&
	git merge two

with

	git checkout one &&
	T=$(git merge-tree HEAD two) &&
	C=$(git commit-tree $T -p HEAD -p two) &&
	git reset --hard $C

;-)

> +> +test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
> +	# Mis-spell with single "s" instead of double "s"
> +	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
> +
> +	grep "error: unknown option.*mesages" expect
> +'
> +
> +test_expect_success 'Barf on too many arguments' '
> +	test_expect_code 129 git merge-tree --write-tree side1 side2 side3 2>expect &&
> +
> +	grep "^usage: git merge-tree" expect
> +'

