From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 2/2] merge-base: add --merge-child option
Date: Sat, 11 May 2013 13:23:44 +0100
Message-ID: <b0684a64dc07ef8969fdefdedbff62586e8ea967.1368274689.git.john@keeping.me.uk>
References: <cover.1368274689.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 14:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub8r1-0004l8-3w
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 14:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab3EKMYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 08:24:43 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51781 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3EKMYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 08:24:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id AA696198007;
	Sat, 11 May 2013 13:24:41 +0100 (BST)
X-Quarantine-ID: <MI8OLq9PaMiW>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MI8OLq9PaMiW; Sat, 11 May 2013 13:24:40 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id BCD35198003;
	Sat, 11 May 2013 13:24:40 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id AD9BB161E418;
	Sat, 11 May 2013 13:24:40 +0100 (BST)
X-Quarantine-ID: <jegFhjpryVko>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jegFhjpryVko; Sat, 11 May 2013 13:24:39 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0B968161E4AB;
	Sat, 11 May 2013 13:24:28 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc1.289.gcb3647f
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk>
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk>
References: <cover.1368274689.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223961>

This is helpful when examining branches with disjoint roots, for example
because one is periodically merged into a subtree of the other.

With the --merge-child option, "git merge-base" will print a
first-parent ancestor of the first revision given, where the commit
printed is either a merge-base of the supplied revisions or a merge for
which one of its parents (not the first) is a merge-base.

For example, given the history:

	A---C---G
	     \
	B-----D---F
	 \
	  E

we have:

	$ git merge-base F E
	B

	$ git merge-base --merge-child F E
	D

	$ git merge-base F G
	C

	$ git merge-base --merge-child F G
	C

	$ git log --left-right F...E
	< F
	< D
	< C
	< A
	> E

	$ git log --left-right F...E --not $(git merge-base --merge-child F E)
	< F
	> E

The git-log case is useful because it allows us to limit the range of
commits that we are examining for patch-identical changes when using
--cherry.  For example with git-gui in git.git I know that anything
before the last merge of git-gui is not interesting:

	$ time git log --cherry master...git-gui/master >/dev/null
	real    0m32.731s
	user    0m31.956s
	sys     0m0.664s

	$ time git log --cherry master...git-gui/master --not \
		$(git merge-base --merge-child master git-gui/master) \
		>/dev/null
	real    0m2.296s
	user    0m2.193s
	sys     0m0.092s

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-merge-base.txt |  6 ++++
 builtin/merge-base.c             | 61 ++++++++++++++++++++++++++++++++++++++--
 t/t6010-merge-base.sh            | 25 ++++++++++++++--
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 87842e3..a1404e1 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge-base' [-a|--all] <commit> <commit>...
+'git merge-base' [-a|--all] --merge-child <commit>...
 'git merge-base' [-a|--all] --octopus <commit>...
 'git merge-base' --is-ancestor <commit> <commit>
 'git merge-base' --independent <commit>...
@@ -39,6 +40,11 @@ As a consequence, the 'merge base' is not necessarily contained in each of the
 commit arguments if more than two commits are specified. This is different
 from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 
+--merge-child::
+	Find the first-parent ancestor of the first commit that is either
+	reachable from all of the supplied commits or which has a parent that
+	is.
+
 --octopus::
 	Compute the best common ancestors of all supplied commits,
 	in preparation for an n-way merge.  This mimics the behavior
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 1bc7991..0bf9f6d 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,7 +1,9 @@
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
+#include "diff.h"
 #include "parse-options.h"
+#include "revision.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
@@ -24,12 +26,61 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a|--all] <commit> <commit>..."),
+	N_("git merge-base [-a|--all] --merge-child <commit>..."),
 	N_("git merge-base [-a|--all] --octopus <commit>..."),
 	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
 	NULL
 };
 
+static int handle_merge_child(struct commit **rev, int rev_nr, const char *prefix, int show_all)
+{
+	struct commit_list *merge_bases;
+	struct rev_info revs;
+	struct commit *commit;
+
+	merge_bases = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 0);
+
+	if (!merge_bases)
+		return 1;
+
+	init_revisions(&revs, prefix);
+	revs.first_parent_only = 1;
+
+	clear_commit_marks(rev[0], SEEN | UNINTERESTING | SHOWN | ADDED);
+	add_pending_object(&revs, &rev[0]->object, "rev0");
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	while ((commit = get_revision(&revs)) != NULL) {
+		/*
+		 * If a merge base is a first-parent ancestor of rev[0] then
+		 * we print the commit itself instead of a merge which is its
+		 * child.
+		 */
+		if (commit_list_contains(merge_bases, commit)) {
+			printf("%s\n", sha1_to_hex(commit->object.sha1));
+			if (!show_all)
+				return 0;
+		}
+
+		struct commit_list *parent;
+		for (parent = commit->parents; parent; parent = parent->next) {
+			/* Skip the first parent */
+			if (parent == commit->parents)
+				continue;
+
+			if (commit_list_contains(merge_bases, parent->item)) {
+				printf("%s\n", sha1_to_hex(commit->object.sha1));
+				if (!show_all)
+					return 0;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static struct commit *get_commit_reference(const char *arg)
 {
 	unsigned char revkey[20];
@@ -93,9 +144,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int octopus = 0;
 	int reduce = 0;
 	int is_ancestor = 0;
+	int merge_child = 0;
 
 	struct option options[] = {
 		OPT_BOOLEAN('a', "all", &show_all, N_("output all common ancestors")),
+		OPT_BOOLEAN(0, "merge-child", &merge_child,
+			    N_("find a merge with a parent reachable from others")),
 		OPT_BOOLEAN(0, "octopus", &octopus, N_("find ancestors for a single n-way merge")),
 		OPT_BOOLEAN(0, "independent", &reduce, N_("list revs not reachable from others")),
 		OPT_BOOLEAN(0, "is-ancestor", &is_ancestor,
@@ -107,11 +161,11 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
 	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
-	if (is_ancestor && (show_all | octopus | reduce))
+	if (is_ancestor && (show_all | octopus | reduce | merge_child))
 		die("--is-ancestor cannot be used with other options");
 	if (is_ancestor)
 		return handle_is_ancestor(argc, argv);
-	if (reduce && (show_all || octopus))
+	if (reduce && (show_all || octopus || merge_child))
 		die("--independent cannot be used with other options");
 
 	if (octopus || reduce)
@@ -120,5 +174,8 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
+
+	if (merge_child)
+		return handle_merge_child(rev, rev_nr, prefix, show_all);
 	return show_merge_base(rev, rev_nr, show_all);
 }
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f80bba8..454577e 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -42,12 +42,16 @@ test_expect_success 'setup' '
 	T=$(git mktree </dev/null)
 '
 
-test_expect_success 'set up G and H' '
+test_expect_success 'set up G, H and L' '
 	# E---D---C---B---A
 	# \"-_         \   \
 	#  \  `---------G   \
 	#   \                \
 	#    F----------------H
+	#                      \
+	# I---------------------J---K
+	#  \
+	#   L
 	E=$(doit 5 E) &&
 	D=$(doit 4 D $E) &&
 	F=$(doit 6 F $E) &&
@@ -55,7 +59,11 @@ test_expect_success 'set up G and H' '
 	B=$(doit 2 B $C) &&
 	A=$(doit 1 A $B) &&
 	G=$(doit 7 G $B $E) &&
-	H=$(doit 8 H $A $F)
+	H=$(doit 8 H $A $F) &&
+	I=$(doit 9 I) &&
+	J=$(doit 10 J $H $I) &&
+	K=$(doit 11 K $J) &&
+	L=$(doit 12 L $I)
 '
 
 test_expect_success 'merge-base G H' '
@@ -64,6 +72,9 @@ test_expect_success 'merge-base G H' '
 	MB=$(git merge-base G H) &&
 	git name-rev "$MB" >actual.single &&
 
+	MB=$(git merge-base --merge-child G H) &&
+	git name-rev "$MB" >actual.merge_child &&
+
 	MB=$(git merge-base --all G H) &&
 	git name-rev "$MB" >actual.all &&
 
@@ -71,6 +82,7 @@ test_expect_success 'merge-base G H' '
 	git name-rev "$MB" >actual.sb &&
 
 	test_cmp expected actual.single &&
+	test_cmp expected actual.merge_child &&
 	test_cmp expected actual.all &&
 	test_cmp expected actual.sb
 '
@@ -95,6 +107,15 @@ test_expect_success 'merge-base/show-branch --independent' '
 	test_cmp expected2 actual2.sb
 '
 
+test_expect_success 'merge-base --merge-child K L' '
+	git name-rev "$J" >expected &&
+
+	MB=$(git merge-base --merge-child K L) &&
+	git name-rev "$MB" >actual &&
+
+	test_cmp expected actual
+'
+
 test_expect_success 'unsynchronized clocks' '
 	# This test is to demonstrate that relying on timestamps in a distributed
 	# SCM to provide a _consistent_ partial ordering of commits leads to
-- 
1.8.3.rc1.289.gcb3647f
