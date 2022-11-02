Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44240C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKBWtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKBWs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:56 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE497653
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXUojVpY; Wed, 02 Nov 2022 22:48:52 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=Ppx76nGJAAAA:20 a=4RBUngkUAAAA:8 a=NEAV23lmAAAA:8
 a=ZDxNuopYyby_AUrMg10A:9 a=_sbA2Q-Kp09kWB8D3iXc:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 5/5] docbundle: provide the git-log History Simplification example
Date:   Wed,  2 Nov 2022 22:48:43 +0000
Message-Id: <20221102224843.2104-6-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102224843.2104-1-philipoakley@iee.email>
References: <20221102224843.2104-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJAoomSHHEJArNnDNwgT61RA5NAOxdzeff1ytLl5cTL8EyLlOk/x5WfMU2WWGq2cxPJok4rzyCiVrKcb6AEPzNRAMYXYmgjM90/jsDG42u2V09z3AFFz
 O8aIJCypsTgB+JFx+D9DTcEUWHwXRYEVRxn5fDyTOY3nVQ2L51MAkZhJYallx+owDkpe5C2lYCvlfE7XrjLEsA/i+JRhURHgX1h5gfRMPK3I9XyuWyqvwtfn
 Yuequh3LziH08vc6bzxDO+0nLAi9bYQ9IX86cMAxAKY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create the History Simplification example and bundle it.

ToDo: add the tests that the man page attempts to demonstrate.

add the effects of `--graph` to the tests and man page.

/* NEEDSWORK */

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 t/t9990-history-simplification.sh | 261 ++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)
 create mode 100644 t/t9990-history-simplification.sh

diff --git a/t/t9990-history-simplification.sh b/t/t9990-history-simplification.sh
new file mode 100644
index 0000000000..ada06698d5
--- /dev/null
+++ b/t/t9990-history-simplification.sh
@@ -0,0 +1,261 @@
+#!/bin/sh
+
+test_description='History simplification man page'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+note () {
+	git tag "$1"
+}
+
+unnote () {
+	test_when_finished "rm -f tmp" &&
+	git name-rev --tags --annotate-stdin >tmp &&
+	sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g" <tmp
+}
+
+#
+# Create a test repo with the man(3) History Simplification commit graph:
+#
+# We assume, for the TREESAME check,
+# that you are filtering for a file `foo` in this commit graph:
+#-----------------------------------------------------------------------
+#	  .-A---M---N---O---P---Q
+#	 /     /   /   /   /   /
+#	I     B   C   D   E   Y
+#	 \   /   /   /   /   /
+#	  `-------------'   X
+#-----------------------------------------------------------------------
+#The horizontal line of history A---Q is taken to be the first parent of
+#each merge.
+#
+# See Documentation/rev-list-options.txt
+# see https://groups.google.com/d/msgid/git-users/11286f4a-c961-4d12-91a0-f49e34d8691bn%40googlegroups.com. for git-user discussion.
+# https://github.com/ChuckTest/git-history-test
+# C:\git-sdk-64\usr\src\git-history-test
+
+test_expect_success setup '
+	# get the structure set out, then the file contents
+	echo "asdf" >foo &&
+	echo "quux" >quux &&
+	git add foo quux &&
+	test_tick && git commit -m "I: Initial commit" &&
+	note I &&
+
+	git branch B &&
+	git branch C &&
+	git branch D &&
+	git branch E &&
+
+	echo "foo" >foo &&
+	git add foo &&
+	test_tick && git commit -m "A" &&
+	note A &&
+
+	git checkout B &&
+	echo "foo" >foo &&
+	git add foo &&
+	test_tick && git commit -m "B" &&
+	note B &&
+
+	git checkout main &&
+	test_tick && git merge B -m "M: trivial merge" &&
+	note M &&
+
+	git checkout C &&
+	# is this needed?
+	#echo "other" >other &&
+	#git add other &&
+	test_tick && git commit --allow-empty -m "C: identical to I" &&
+	note C &&
+
+	git checkout main &&
+	test_tick && git merge C --no-commit -m "N: !TREESAME any parent" &&
+	echo "foobar" >foo &&
+	git add foo &&
+	git commit -m "N: !TREESAME any parent" &&
+	note N &&
+
+	git checkout D &&
+	echo "baz" >foo &&
+	git add foo &&
+	test_tick && git commit -m "D" &&
+	note D &&
+
+	git checkout main &&
+	test_tick &&
+	test_must_fail git merge D --no-commit &&
+	echo "foobarbaz" >foo &&
+	git add foo &&
+	git commit -m "O: !TREESAME any parent" &&
+	note O &&
+
+	git checkout E &&
+	echo "xyzzy" >quux &&
+	git add quux &&
+	test_tick && git commit -m "E" &&
+	note E &&
+
+	git checkout main &&
+	test_tick &&
+	git merge E --no-commit &&
+	echo "quux xyzzy" >quux &&
+	git add quux &&
+	git commit -m "P: TREESAME O; !E" &&
+	note S &&
+
+	git checkout --orphan Side &&
+	git rm -f foo quux &&
+	echo "initial" >side &&
+	git add side &&
+	git commit -m "X" &&
+	note X &&
+
+	echo "side" >side &&
+	git add side &&
+	git commit -m "Y" &&
+	note Y &&
+
+	git checkout main &&
+	test_tick && 
+	git merge Side --allow-unrelated-histories -m "Q: TREESAME P; !Y" &&
+	note Q
+'
+
+test_expect_success 'bundle history-simplification repo' '
+	git bundle create ${GIT_BUNDLE_DIR}/t9990-history-simplification.bndl --all
+'
+
+# Test it!
+# `rev-list` walks backwards through history, including or excluding
+# commits based on whether `--full-history` and/or parent rewriting
+# (via `--parents` or `--children`) are used. The following settings
+# are available.
+# 
+# Default mode::
+# 	Commits are included if they are not TREESAME to any parent
+# 	(though this can be changed, see `--sparse` below).  If the
+# 	commit was a merge, and it was TREESAME to one parent, follow
+# 	only that parent.  (Even if there are several TREESAME
+# 	parents, follow only one of them.)  Otherwise, follow all
+# 	parents.
+# +
+# This results in:
+# +
+# -----------------------------------------------------------------------
+# 	  .-A---N---O
+# 	 /     /   /
+# 	I---------D
+# -----------------------------------------------------------------------
+# +
+# Note how the rule to only follow the TREESAME parent, if one is
+# available, removed `B` from consideration entirely.  `C` was
+# considered via `N`, but is TREESAME.  Root commits are compared to an
+# empty tree, so `I` is !TREESAME.
+# +
+# Parent/child relations are only visible with `--parents`, but that does
+# not affect the commits selected in default mode, so we have shown the
+# parent lines.
+# 
+# --full-history without parent rewriting::
+# 	This mode differs from the default in one point: always follow
+# 	all parents of a merge, even if it is TREESAME to one of them.
+# 	Even if more than one side of the merge has commits that are
+# 	included, this does not imply that the merge itself is!  In
+# 	the example, we get
+# +
+# -----------------------------------------------------------------------
+# 	I  A  B  N  D  O  P  Q
+# -----------------------------------------------------------------------
+# +
+# `M` was excluded because it is TREESAME to both parents.  `E`,
+# `C` and `B` were all walked, but only `B` was !TREESAME, so the others
+# do not appear.
+# +
+# Note that without parent rewriting, it is not really possible to talk
+# about the parent/child relationships between the commits, so we show
+# them disconnected.
+# 
+# --full-history with parent rewriting::
+# 	Ordinary commits are only included if they are !TREESAME
+# 	(though this can be changed, see `--sparse` below).
+# +
+# Merges are always included.  However, their parent list is rewritten:
+# Along each parent, prune away commits that are not included
+# themselves.  This results in
+# +
+# -----------------------------------------------------------------------
+# 	  .-A---M---N---O---P---Q
+# 	 /     /   /   /   /
+# 	I     B   /   D   /
+# 	 \   /   /   /   /
+# 	  `-------------'
+# -----------------------------------------------------------------------
+# +
+# Compare to `--full-history` without rewriting above.  Note that `E`
+# was pruned away because it is TREESAME, but the parent list of P was
+# rewritten to contain `E`'s parent `I`.  The same happened for `C` and
+# `N`, and `X`, `Y` and `Q`.
+# 
+# In addition to the above settings, you can change whether TREESAME
+# affects inclusion:
+# 
+# --dense::
+# 	Commits that are walked are included if they are not TREESAME
+# 	to any parent.
+# 
+# --sparse::
+# 	All commits that are walked are included.
+# +
+# Note that without `--full-history`, this still simplifies merges: if
+# one of the parents is TREESAME, we follow only that one, so the other
+# sides of the merge are never walked.
+# 
+# --simplify-merges::
+# 	First, build a history graph in the same way that
+# 	`--full-history` with parent rewriting does (see above).
+# +
+# Then simplify each commit `C` to its replacement `C'` in the final
+# history according to the following rules:
+# +
+# --
+# * Set `C'` to `C`.
+# +
+# * Replace each parent `P` of `C'` with its simplification `P'`.  In
+#   the process, drop parents that are ancestors of other parents or that are
+#   root commits TREESAME to an empty tree, and remove duplicates, but take care
+#   to never drop all parents that we are TREESAME to.
+# +
+# * If after this parent rewriting, `C'` is a root or merge commit (has
+#   zero or >1 parents), a boundary commit, or !TREESAME, it remains.
+#   Otherwise, it is replaced with its only parent.
+# --
+# +
+# The effect of this is best shown by way of comparing to
+# `--full-history` with parent rewriting.  The example turns into:
+# +
+# -----------------------------------------------------------------------
+# 	  .-A---M---N---O
+# 	 /     /       /
+# 	I     B       D
+# 	 \   /       /
+# 	  `---------'
+# -----------------------------------------------------------------------
+# +
+# Note the major differences in `N`, `P`, and `Q` over `--full-history`:
+# +
+# --
+# * `N`'s parent list had `I` removed, because it is an ancestor of the
+#   other parent `M`.  Still, `N` remained because it is !TREESAME.
+# +
+# * `P`'s parent list similarly had `I` removed.  `P` was then
+#   removed completely, because it had one parent and is TREESAME.
+# +
+# * `Q`'s parent list had `Y` simplified to `X`. `X` was then removed, because it
+#   was a TREESAME root. `Q` was then removed completely, because it had one
+#   parent and is TREESAME.
+
+test_done
-- 
2.38.1.281.g83ef3ded8d

