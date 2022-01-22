Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF52AC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiAVV4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiAVV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D6C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ba4so6470499wrb.4
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=odFeYR2KbNOxmrzqunzaO4VsyPNeQv/hAkK/HFQjnMY=;
        b=cQ34xDWUaY7FV4rLm3TksAvmUg0V4aGKDg6j51AAelG/SqqLXyFMOMQeU/2Ym2UcJ6
         T3CE3RMCRXNL4bipMb94KMobjto/mOEwe7Chady6U0/nE6fRThGOutSsEF3boTXTmgSE
         BsCp1jq/Afpwyzc5+/QX/8ghCUyydv6og6LfM8ECnjvmBI16sMn1TpUvkuP4wQMi9Gqw
         dKp9pPx2N1RqCzJYexPemVj+ycSTodbywi4lDevfbgWvgaJH5laggS8FvbfRu/rGnCI3
         lZstiC2l808TypywCZ5zDhet51OjjkeWLNZXtjjPA2JMUrxn2Eolqm+YQ8bXYRjjfUp0
         f/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=odFeYR2KbNOxmrzqunzaO4VsyPNeQv/hAkK/HFQjnMY=;
        b=mYyENLCG2HLWfr6rDRPSOhA1M93NOrvtzuv1Lu5tylw3d0LTnT2p4G/NKopp4WwbGH
         yIE7r97LfenqjvArpPYl4IYcxgzscQ5nAKvnx26g3dv0hm4e04t28sFIT9FM/HeCYUlW
         wlsMIhRjse2nemvDSP/m6DPegUWQWV8bsQGEiMPcR08N/EOI7p/44DtKgw9WqzQX//UE
         pc2wvPFpSsNvBZYP4lwL1pEWxhWQUSlGZYoPUkvZkW/cAXA1i+1608Dta9taUeYEWvsd
         Cpy2BoMESvoFRXd0JVM6q678rE19qmmewEmCe/BRViwn1apsQ5xDf1XfFL7FZX6uBWog
         M6Qg==
X-Gm-Message-State: AOAM533QHlgLMwZ890PKl2xCuvPUxeNkFFlYTLfUW3zqtPoqjC7R7UDk
        nv0W8w8Mss3DSt+b+3XnpXo4M9I/3H4=
X-Google-Smtp-Source: ABdhPJybLZ2mGfvBItmd6ageF7MnCkX6Purr4khAXASUrxHMWZ/7MvtQrfRJ2cvdlvSqlcyIYovvEg==
X-Received: by 2002:a5d:6344:: with SMTP id b4mr7243475wrw.607.1642888567848;
        Sat, 22 Jan 2022 13:56:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm13553967wma.20.2022.01.22.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:07 -0800 (PST)
Message-Id: <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:54 +0000
Subject: [PATCH 04/12] merge-tree: implement real merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds the ability to perform real merges rather than just trivial
merges (meaning handling three way content merges, recursive ancestor
consolidation, renames, proper directory/file conflict handling, and so
forth).  However, unlike `git merge`, the working tree and index are
left alone and no branch is updated.

The only output is:
  - the toplevel resulting tree printed on stdout
  - exit status of 0 (clean) or 1 (conflicts present)

This output is meant to be used by some higher level script, perhaps in
a sequence of steps like this:

   NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT

Note that higher level scripts may also want to access the
conflict/warning messages normally output during a merge, or have quick
access to a list of files with conflicts.  That is not available in this
preliminary implementation, but subsequent commits will add that
ability.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 74 ++++++++++++++++++++++-----
 builtin/merge-tree.c             | 55 +++++++++++++++++++-
 t/t4301-merge-tree-real.sh       | 87 ++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 13 deletions(-)
 create mode 100755 t/t4301-merge-tree-real.sh

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c19422..b900bc1362c 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -3,26 +3,76 @@ git-merge-tree(1)
 
 NAME
 ----
-git-merge-tree - Show three-way merge without touching index
+git-merge-tree - Perform merge without touching index or working tree
 
 
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' <base-tree> <branch1> <branch2>
+'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2>
 
 DESCRIPTION
 -----------
-Reads three tree-ish, and output trivial merge results and
-conflicting stages to the standard output.  This is similar to
-what three-way 'git read-tree -m' does, but instead of storing the
-results in the index, the command outputs the entries to the
-standard output.
-
-This is meant to be used by higher level scripts to compute
-merge results outside of the index, and stuff the results back into the
-index.  For this reason, the output from the command omits
-entries that match the <branch1> tree.
+
+Performs a merge, but does not make any new commits and does not read
+from or write to either the working tree or index.
+
+The first form will merge the two branches, doing a full recursive
+merge with rename detection.  The rest of this manual (other than the
+next paragraph) describes the first form in more detail -- including
+options, output format, exit status, and usage notes.
+
+The second form is deprecated; it is kept for backward compatibility
+reasons but may be deleted in the future.  It will only do a trivial
+merge.  It reads three tree-ish, and outputs trivial merge results and
+conflicting stages to the standard output in a semi-diff format.
+Since this was designed for higher level scripts to consume and merge
+the results back into the index, it omits entries that match
+<branch1>.  The result of this second form is is similar to what
+three-way 'git read-tree -m' does, but instead of storing the results
+in the index, the command outputs the entries to the standard output.
+This form not only has limited applicability, the output format is
+also difficult to work with, and it will generally be less performant
+than the first form even on successful merges (especially if working
+in large repositories).  The remainder of this manual will only
+discuss the first form.
+
+OUTPUT
+------
+
+For either a successful or conflicted merge, the output from
+git-merge-tree is simply one line:
+
+	<OID of toplevel tree>
+
+The printed tree object corresponds to what would be checked out in
+the working tree at the end of `git merge`, and thus may have files
+with conflict markers in them.
+
+EXIT STATUS
+-----------
+
+For a successful, non-conflicted merge, the exit status is 0.  When the
+merge has conflicts, the exit status is 1.  If the merge is not able to
+complete (or start) due to some kind of error, the exit status is
+something other than 0 or 1.
+
+USAGE NOTES
+-----------
+
+git-merge-tree was written to be low-level plumbing, similar to
+hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could
+be used as a part of a series of steps such as
+
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
+       test $? -eq 0 || die "There were conflicts..."
+       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       git update-ref $BRANCH1 $NEWCOMMIT
+
+However, it does not quite fit into the same category of low-level
+plumbing commands since the possibility of merge conflicts give it a
+much higher chance of the command not succeeding.
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 33e47cc1534..0c19639594d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,6 +2,9 @@
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
+#include "help.h"
+#include "commit-reach.h"
+#include "merge-ort.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "repository.h"
@@ -393,7 +396,57 @@ struct merge_tree_options {
 static int real_merge(struct merge_tree_options *o,
 		      const char *branch1, const char *branch2)
 {
-	die(_("real merges are not yet implemented"));
+	struct commit *parent1, *parent2;
+	struct commit_list *common;
+	struct commit_list *merge_bases = NULL;
+	struct commit_list *j;
+	struct merge_options opt;
+	struct merge_result result = { 0 };
+
+	parent1 = get_merge_parent(branch1);
+	if (!parent1)
+		help_unknown_ref(branch1, "merge",
+				 _("not something we can merge"));
+
+	parent2 = get_merge_parent(branch2);
+	if (!parent2)
+		help_unknown_ref(branch2, "merge",
+				 _("not something we can merge"));
+
+	init_merge_options(&opt, the_repository);
+	/*
+	 * TODO: Support subtree and other -X options?
+	if (use_strategies_nr == 1 &&
+	    !strcmp(use_strategies[0]->name, "subtree"))
+		opt.subtree_shift = "";
+	for (x = 0; x < xopts_nr; x++)
+		if (parse_merge_opt(&opt, xopts[x]))
+			die(_("Unknown strategy option: -X%s"), xopts[x]);
+	*/
+
+	opt.show_rename_progress = 0;
+
+	opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
+	opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
+
+	/*
+	 * Get the merge bases, in reverse order; see comment above
+	 * merge_incore_recursive in merge-ort.h
+	 */
+	common = get_merge_bases(parent1, parent2);
+	if (!common)
+		die(_("refusing to merge unrelated histories"));
+	for (j = common; j; j = j->next)
+		commit_list_insert(j->item, &merge_bases);
+
+	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
+	if (result.clean < 0)
+		die(_("failure to merge"));
+	else if (!result.clean)
+		printf(_("Conflicts!\n"));
+	merge_finalize(&opt, &result);
+	return !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
new file mode 100755
index 00000000000..e03688515c5
--- /dev/null
+++ b/t/t4301-merge-tree-real.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='git merge-tree --write-tree'
+
+. ./test-lib.sh
+
+# This test is ort-specific
+test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {
+	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
+	test_done
+}
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >numbers &&
+	echo hello >greeting &&
+	echo foo >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m initial &&
+
+	git branch side1 &&
+	git branch side2 &&
+
+	git checkout side1 &&
+	test_write_lines 1 2 3 4 5 6 >numbers &&
+	echo hi >greeting &&
+	echo bar >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m modify-stuff &&
+
+	git checkout side2 &&
+	test_write_lines 0 1 2 3 4 5 >numbers &&
+	echo yo >greeting &&
+	git rm whatever &&
+	mkdir whatever &&
+	>whatever/empty &&
+	git add numbers greeting whatever/empty &&
+	test_tick &&
+	git commit -m other-modifications
+'
+
+test_expect_success 'Content merge and a few conflicts' '
+	git checkout side1^0 &&
+	test_must_fail git merge side2 &&
+	expected_tree=$(cat .git/AUTO_MERGE) &&
+
+	# We will redo the merge, while we are still in a conflicted state!
+	test_when_finished "git reset --hard" &&
+
+	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
+	actual_tree=$(head -n 1 RESULT) &&
+
+	# Due to differences of e.g. "HEAD" vs "side1", the results will not
+	# exactly match.  Dig into individual files.
+
+	# Numbers should have three-way merged cleanly
+	test_write_lines 0 1 2 3 4 5 6 >expect &&
+	git show ${actual_tree}:numbers >actual &&
+	test_cmp expect actual &&
+
+	# whatever and whatever~<branch> should have same HASHES
+	git rev-parse ${expected_tree}:whatever ${expected_tree}:whatever~HEAD >expect &&
+	git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~side1 >actual &&
+	test_cmp expect actual &&
+
+	# greeting should have a merge conflict
+	git show ${expected_tree}:greeting >tmp &&
+	cat tmp | sed -e s/HEAD/side1/ >expect &&
+	git show ${actual_tree}:greeting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
+	# Mis-spell with single "s" instead of double "s"
+	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
+
+	grep "error: unknown option.*mesages" expect
+'
+
+test_expect_success 'Barf on too many arguments' '
+	test_expect_code 129 git merge-tree --write-tree side1 side2 side3 2>expect &&
+
+	grep "^usage: git merge-tree" expect
+'
+
+test_done
-- 
gitgitgadget

