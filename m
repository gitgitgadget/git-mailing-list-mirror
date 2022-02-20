Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55560C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 09:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiBTJD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 04:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiBTJD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 04:03:57 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC626568
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 01:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645347803;
        bh=xIJKpUva0apT4l/o7WFwKZOpZnXSaIVhEoTzoI42pdY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JyNE0iJuSwhfKF/mnvvz1Xq/mTFFRMzyHEUvXKFDQtHYV/hGSo2dnXOax+XDQRJ6n
         TH1RKMTENIP4X4wc9uv8rWNvWXt/cUqDsdb9fwUDeDWt0AZzSlUMOjuylnYQEKhcxQ
         uG357bp6wWcj8diG/sOk0F5neSZapq36oaO8Hgc0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.16.203]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cHX-1oIXgE1m57-015cGW; Sun, 20
 Feb 2022 10:03:23 +0100
Message-ID: <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
Date:   Sun, 20 Feb 2022 10:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 04/12] merge-tree: implement real merges
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
 <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
 <7994775a9341b256d1ea7dfc417bb577d9a3195f.1645340082.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7994775a9341b256d1ea7dfc417bb577d9a3195f.1645340082.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bf3/E8vEihfaHLSrA8oBdVUei5nBE6TQPzxuE7aa3YKQ8kzmWYz
 XI2ODlq42d0sg7bAZ0fV0FE9lBpCi1RWsDZMpRQSwI2J9u2XOig6wQLYDaCq/YitFej91rm
 upwr4L0JuxGoeLKlQgt6q7Vw13OAoW7KvGbog33IXt8UFo1UA1FtvO24QlDqFGFK90PyrZz
 yrAoJX+YVU66L8ME4gBGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vIB7PPqtIGw=:fzrnMxdm3SEV6OvE85nOwQ
 Pf3lfULWlb73rXtTDdjxstW/sMZHw6DcaENtHa5MJpS7vqxemMcnTFoMO2E+1tbTUXA4y5la6
 kfmgHF7kfr08FolRy6lfPivJldzztpWb2Oi676Blj5Jb7BwNZM2Up+UVD8IGudh5HQziXoEI6
 pBNSQCKhw1g/MZgPy18ky8WEwvk86eC+2d5o747Iysu3NVZjX+ynuUfnMAVWu6/20xaUjT03W
 CuF73tyR2wxQ49iDBfNQM8JM1UWNyUw4LEoyIaeebMLpTBsWNJvsybUR185NwvVBccPZF5yp7
 DhZkpxLrmpOU67g0hHsM8wA0YI73NDAqjY3UBFu6blDNDlLKpuXpCKOS8SXwn69BrP2SIIWNO
 v888WEHaUAQaW5abOoTcVj9T1JQoekKSd0TE9LTAjAvb4drwizVJoF6wkWzGwUfn9c1JFvz63
 v0DjdzS48+jXFJtYRvQQNDkGz3nJrTQPgztv8EoBzPZuY94D2W7oqbloT/+CncWYlaDfJeyAj
 bHbYYZ6s3q4ZrPjFyginzZBGb61ANNOEKBfkvR+3b+Ct4vunis/R8mmJbQIKkbq4VCwfJ3zEm
 Y/LYPkZw1XQ7vVBguIhfnjfwvAz3Rowb1P5b+at+PcVCh7H5pDCQumEgEJ1rn4GA5lYw5ZvFV
 Evr2GL3eqT/pApAUSehCyR8v3BEwAscwl1nN0J/ink6AsJnDjHgtNhRY0RPLD5NDgu+UvFovS
 MEj4BvPBAcOWlX3hOQRei+2d/4UrSXJJlBtN8bu+eTVdQTsY+NxX027QVeiADPUff8RqjEwVx
 wXB3T9DHFDJmJo2+CJjeticr742p1lLFqibfCeju1DIHG0r8PWoQ5932TZ/pyprnvxiKocpZn
 kQXWXAUxTuRvzhS+V3w2yf3wv/PNmSWpiRscWK2Y/b3hD1nYT0MfloXR0Y3LSIO87DxFKZtCW
 scdK+MZN+mnwigOjxyfI+59b8jL7Sj30As9ywAd4QXSIiwD++anw1tI909sHnACy5XpdGpek3
 t69n/Jh6EvjjQ+AROITPnwSbqQsdS95LOdJKZ7UwZ+9awT1YtN+wH3/6EHz39rxUJLQPRbvFj
 vEcW03mSsw5RRU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.02.22 um 07:54 schrieb Elijah Newren via GitGitGadget:
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
>    NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>    test $? -eq 0 || die "There were conflicts..."
>    NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
>    git update-ref $BRANCH1 $NEWCOMMIT
>
> Note that higher level scripts may also want to access the
> conflict/warning messages normally output during a merge, or have quick
> access to a list of files with conflicts.  That is not available in this
> preliminary implementation, but subsequent commits will add that
> ability (meaning that NEWTREE would be a lot more than a tree in the
> case of conflicts).
>
> This also marks the traditional trivial merge of merge-tree as
> deprecated.  The trivial merge not only had limited applicability, the
> output format was also difficult to work with (and its format
> undocumented), and will generally be less performant than real merges.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-merge-tree.txt |  79 +++++++++++++++++++----
>  builtin/merge-tree.c             |  44 ++++++++++++-
>  t/t4301-merge-tree-write-tree.sh | 106 +++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+), 13 deletions(-)
>  create mode 100755 t/t4301-merge-tree-write-tree.sh
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-=
tree.txt
> index 58731c19422..589a83738ce 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -3,26 +3,81 @@ git-merge-tree(1)
>
>  NAME
>  ----
> -git-merge-tree - Show three-way merge without touching index
> +git-merge-tree - Perform merge without touching index or working tree
>
>
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge-tree' <base-tree> <branch1> <branch2>
> +'git merge-tree' [--write-tree] <branch1> <branch2>
> +'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (dep=
recated)
>
>  DESCRIPTION
>  -----------
> -Reads three tree-ish, and output trivial merge results and
> -conflicting stages to the standard output.  This is similar to
> -what three-way 'git read-tree -m' does, but instead of storing the
> -results in the index, the command outputs the entries to the
> -standard output.
> -
> -This is meant to be used by higher level scripts to compute
> -merge results outside of the index, and stuff the results back into the
> -index.  For this reason, the output from the command omits
> -entries that match the <branch1> tree.
> +
> +Performs a merge, but does not make any new commits and does not read
> +from or write to either the working tree or index.
> +
> +The first form will merge the two branches, doing a real merge.  A real
> +merge is distinguished from a trivial merge in that it includes:
> +
> +  * three way content merges of individual files
> +  * rename detection
> +  * proper directory/file conflict handling
> +  * recursive ancestor consolidation (i.e. when there is more than one
> +    merge base, creating a virtual merge base by merging the merge base=
s)
> +  * etc.
> +
> +After the merge completes, the first form will create a new toplevel
> +tree object.  See `OUTPUT` below for details.
> +
> +The second form is deprecated; it is kept for backward compatibility
> +reasons but may be deleted in the future.  Other than the optional
> +`--trivial-merge`, it accepts no options.  It can only do a trivial
> +merge.  It reads three tree-ish, and outputs trivial merge results and
> +conflicting stages to the standard output in a semi-diff format.
> +Since this was designed for higher level scripts to consume and merge
> +the results back into the index, it omits entries that match
> +<branch1>.  The result of this second form is similar to what
> +three-way 'git read-tree -m' does, but instead of storing the results
> +in the index, the command outputs the entries to the standard output.
> +This form not only has limited applicability, the output format is
> +also difficult to work with, and it will generally be less performant
> +than the first form even on successful merges (especially if working
> +in large repositories).  The remainder of this manual will only
> +discuss the first form.
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
> +
> +EXIT STATUS
> +-----------
> +
> +For a successful, non-conflicted merge, the exit status is 0.  When the
> +merge has conflicts, the exit status is 1.  If the merge is not able to
> +complete (or start) due to some kind of error, the exit status is
> +something other than 0 or 1 (and the output is unspecified).
> +
> +USAGE NOTES
> +-----------
> +
> +git-merge-tree was written to be low-level plumbing, similar to
> +hash-object, mktree, commit-tree, write-tree, update-ref, and mktag.
> +Thus, it could be used as a part of a series of steps such as
> +
> +       NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> +       test $? -eq 0 || die "There were conflicts..."
> +       NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> +       git update-ref $BRANCH1 $NEWCOMMIT
>
>  GIT
>  ---
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0f9d928e862..af445cb1576 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -2,6 +2,9 @@
>  #include "builtin.h"
>  #include "tree-walk.h"
>  #include "xdiff-interface.h"
> +#include "help.h"
> +#include "commit-reach.h"
> +#include "merge-ort.h"
>  #include "object-store.h"
>  #include "parse-options.h"
>  #include "repository.h"
> @@ -398,7 +401,46 @@ struct merge_tree_options {
>  static int real_merge(struct merge_tree_options *o,
>  		      const char *branch1, const char *branch2)
>  {
> -	die(_("real merges are not yet implemented"));
> +	struct commit *parent1, *parent2;
> +	struct commit_list *common;
> +	struct commit_list *merge_bases =3D NULL;
> +	struct commit_list *j;
> +	struct merge_options opt;
> +	struct merge_result result =3D { 0 };
> +
> +	parent1 =3D get_merge_parent(branch1);
> +	if (!parent1)
> +		help_unknown_ref(branch1, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	parent2 =3D get_merge_parent(branch2);
> +	if (!parent2)
> +		help_unknown_ref(branch2, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	init_merge_options(&opt, the_repository);
> +
> +	opt.show_rename_progress =3D 0;
> +
> +	opt.branch1 =3D branch1;
> +	opt.branch2 =3D branch2;
> +
> +	/*
> +	 * Get the merge bases, in reverse order; see comment above
> +	 * merge_incore_recursive in merge-ort.h
> +	 */
> +	common =3D get_merge_bases(parent1, parent2);
> +	if (!common)
> +		die(_("refusing to merge unrelated histories"));
> +	for (j =3D common; j; j =3D j->next)
> +		commit_list_insert(j->item, &merge_bases);

This loop creates a reversed copy of "common".  You could use
reverse_commit_list() instead to do it in-place and avoid the
allocations.  Only the copy, "merge_bases", is used below.

> +
> +	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +	if (result.clean < 0)
> +		die(_("failure to merge"));
> +	puts(oid_to_hex(&result.tree->object.oid));
> +	merge_finalize(&opt, &result);
> +	return !result.clean; /* result.clean < 0 handled above */
>  }
>
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write=
-tree.sh
> new file mode 100755
> index 00000000000..6d321652e21
> --- /dev/null
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -0,0 +1,106 @@
> +#!/bin/sh
> +
> +test_description=3D'git merge-tree --write-tree'
> +
> +. ./test-lib.sh
> +
> +# This test is ort-specific
> +if test "$GIT_TEST_MERGE_ALGORITHM" !=3D "ort"
> +then
> +	skip_all=3D"GIT_TEST_MERGE_ALGORITHM !=3D ort"
> +	test_done
> +fi
> +
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
> +	git branch side3 &&
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
> +	git commit -m other-modifications &&
> +
> +	git checkout side3 &&
> +	git mv numbers sequence &&
> +	test_tick &&
> +	git commit -m rename-numbers
> +'
> +
> +test_expect_success 'Clean merge' '
> +	TREE_OID=3D$(git merge-tree --write-tree side1 side3) &&
> +	q_to_tab <<-EOF >expect &&
> +	100644 blob $(git rev-parse side1:greeting)Qgreeting
> +	100644 blob $(git rev-parse side1:numbers)Qsequence
> +	100644 blob $(git rev-parse side1:whatever)Qwhatever
> +	EOF
> +
> +	git ls-tree $TREE_OID >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'Content merge and a few conflicts' '
> +	git checkout side1^0 &&
> +	test_must_fail git merge side2 &&
> +	expected_tree=3D$(git rev-parse AUTO_MERGE) &&
> +
> +	# We will redo the merge, while we are still in a conflicted state!
> +	test_when_finished "git reset --hard" &&
> +
> +	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
> +	actual_tree=3D$(head -n 1 RESULT) &&
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
> +	git rev-parse ${expected_tree}:whatever ${expected_tree}:whatever~HEAD=
 >expect &&
> +	git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~side1 >a=
ctual &&
> +	test_cmp expect actual &&
> +
> +	# greeting should have a merge conflict
> +	git show ${expected_tree}:greeting >tmp &&
> +	sed -e s/HEAD/side1/ tmp >expect &&
> +	git show ${actual_tree}:greeting >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'Barf on misspelled option, with exit code other th=
an 0 or 1' '
> +	# Mis-spell with single "s" instead of double "s"
> +	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side=
1 side2 2>expect &&
> +
> +	grep "error: unknown option.*mesages" expect
> +'
> +
> +test_expect_success 'Barf on too many arguments' '
> +	test_expect_code 129 git merge-tree --write-tree side1 side2 invalid 2=
>expect &&
> +
> +	grep "^usage: git merge-tree" expect
> +'
> +
> +test_done
