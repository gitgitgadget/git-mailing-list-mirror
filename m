From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] checkout --conflict=<style>: recreate merge in a
 non-default style
Date: Sun, 31 Aug 2008 23:22:29 -0700
Message-ID: <7v4p501j2y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 08:23:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka2pB-0005tX-Ur
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 08:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYIAGWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 02:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYIAGWg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 02:22:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYIAGWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 02:22:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 05C95696FC;
	Mon,  1 Sep 2008 02:22:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 60E6C696F9; Mon,  1 Sep 2008 02:22:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DBF4CE2-77EE-11DD-BCA4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94533>

This new option does essentially the same thing as -m option when checking
unmerged paths out of the index, but it uses the specified style instead
of configured merge.conflictstyle.

Setting "merge.conflictstyle" to "diff3" is usually less useful than using
the default "merge" style, because the latter allows a conflict that
results by both sides changing the same region in a very similar way to
get simplified substancially by reducing the common lines.  However, when
one side removed a group of lines (perhaps a function was moved to some
other file) while the other side modified it, the default "merge" style
does not give any clue as to why the hunk is left conflicting.  You would
need the original to understand what is going on.

The recommended use would be not to set merge.conflictstyle variable so
that you would usually use the default "merge" style conflict, and when
the result in a path in a particular merge is too hard to understand, use
"git checkout --conflict=diff3 $path" to check it out with the original to
review what is going on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This comes on top of the previous series (the series got reordered
   in my tree before it was merged to 'next', but it is essentially the
   same).

 Documentation/git-checkout.txt |   10 ++++-
 builtin-checkout.c             |   10 ++++-
 t/t7201-co.sh                  |  100 +++++++++++++++++++++------------------
 3 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c884862..13b106d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
-'git checkout' [-f|--ours|--theirs|-m] [<tree-ish>] [--] <paths>...
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 
 DESCRIPTION
 -----------
@@ -84,6 +84,7 @@ entries; instead, unmerged entries are ignored.
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -m::
+--merge::
 	When switching branches,
 	if you have local modifications to one or more files that
 	are different between the current branch and the branch to
@@ -101,6 +102,13 @@ should result in deletion of the path).
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
 
+--conflict=<style>::
+	The same as --merge option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	merge.conflictstyle configuration variable.  Possible values are
+	"merge" (default) and "diff3" (in addition to what is shown by
+	"merge" style, shows the original contents).
+
 <new_branch>::
 	Name for the new branch.
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b957193..7921432 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -580,6 +580,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	const char *arg;
 	struct branch_info new;
 	struct tree *source_tree = NULL;
+	char *conflict_style = NULL;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
@@ -591,7 +592,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
 			    3),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
-		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
+		OPT_STRING(0, "conflict", &conflict_style, "style",
+			   "conflict style (merge or diff3)"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -606,6 +609,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (conflict_style) {
+		opts.merge = 1; /* implied */
+		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+	}
+
 	if (!opts.new_branch && (opts.track != git_branch_track))
 		die("git checkout: --track and --no-track require -b");
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1d4ff6e..ac49311 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -337,7 +337,7 @@ test_expect_success \
     test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
     test_must_fail git checkout --track -b track'
 
-test_expect_success 'checkout an unmerged path should fail' '
+setup_conflicting_index () {
 	rm -f .git/index &&
 	O=$(echo original | git hash-object -w --stdin) &&
 	A=$(echo ourside | git hash-object -w --stdin) &&
@@ -348,7 +348,11 @@ test_expect_success 'checkout an unmerged path should fail' '
 		echo "100644 $A 2	file" &&
 		echo "100644 $B 3	file" &&
 		echo "100644 $A 0	filf"
-	) | git update-index --index-info &&
+	) | git update-index --index-info
+}
+
+test_expect_success 'checkout an unmerged path should fail' '
+	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	cat sample >fild &&
 	cat sample >file &&
@@ -360,17 +364,7 @@ test_expect_success 'checkout an unmerged path should fail' '
 '
 
 test_expect_success 'checkout with an unmerged path can be ignored' '
-	rm -f .git/index &&
-	O=$(echo original | git hash-object -w --stdin) &&
-	A=$(echo ourside | git hash-object -w --stdin) &&
-	B=$(echo theirside | git hash-object -w --stdin) &&
-	(
-		echo "100644 $A 0	fild" &&
-		echo "100644 $O 1	file" &&
-		echo "100644 $A 2	file" &&
-		echo "100644 $B 3	file" &&
-		echo "100644 $A 0	filf"
-	) | git update-index --index-info &&
+	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	echo ourside >expect &&
 	cat sample >fild &&
@@ -383,17 +377,7 @@ test_expect_success 'checkout with an unmerged path can be ignored' '
 '
 
 test_expect_success 'checkout unmerged stage' '
-	rm -f .git/index &&
-	O=$(echo original | git hash-object -w --stdin) &&
-	A=$(echo ourside | git hash-object -w --stdin) &&
-	B=$(echo theirside | git hash-object -w --stdin) &&
-	(
-		echo "100644 $A 0	fild" &&
-		echo "100644 $O 1	file" &&
-		echo "100644 $A 2	file" &&
-		echo "100644 $B 3	file" &&
-		echo "100644 $A 0	filf"
-	) | git update-index --index-info &&
+	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	echo ourside >expect &&
 	cat sample >fild &&
@@ -408,17 +392,7 @@ test_expect_success 'checkout unmerged stage' '
 '
 
 test_expect_success 'checkout with --merge' '
-	rm -f .git/index &&
-	O=$(echo original | git hash-object -w --stdin) &&
-	A=$(echo ourside | git hash-object -w --stdin) &&
-	B=$(echo theirside | git hash-object -w --stdin) &&
-	(
-		echo "100644 $A 0	fild" &&
-		echo "100644 $O 1	file" &&
-		echo "100644 $A 2	file" &&
-		echo "100644 $B 3	file" &&
-		echo "100644 $A 0	filf"
-	) | git update-index --index-info &&
+	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	echo ourside >expect &&
 	cat sample >fild &&
@@ -439,17 +413,7 @@ test_expect_success 'checkout with --merge' '
 
 test_expect_success 'checkout with --merge, in diff3 -m style' '
 	git config merge.conflictstyle diff3 &&
-	rm -f .git/index &&
-	O=$(echo original | git hash-object -w --stdin) &&
-	A=$(echo ourside | git hash-object -w --stdin) &&
-	B=$(echo theirside | git hash-object -w --stdin) &&
-	(
-		echo "100644 $A 0	fild" &&
-		echo "100644 $O 1	file" &&
-		echo "100644 $A 2	file" &&
-		echo "100644 $B 3	file" &&
-		echo "100644 $A 0	filf"
-	) | git update-index --index-info &&
+	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	echo ourside >expect &&
 	cat sample >fild &&
@@ -470,4 +434,48 @@ test_expect_success 'checkout with --merge, in diff3 -m style' '
 	test_cmp merged file
 '
 
+test_expect_success 'checkout --conflict=merge, overriding config' '
+	git config merge.conflictstyle diff3 &&
+	setup_conflicting_index &&
+	echo "none of the above" >sample &&
+	echo ourside >expect &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	git checkout --conflict=merge -- fild file filf &&
+	(
+		echo "<<<<<<< ours"
+		echo ourside
+		echo "======="
+		echo theirside
+		echo ">>>>>>> theirs"
+	) >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
+test_expect_success 'checkout --conflict=diff3' '
+	git config --unset merge.conflictstyle
+	setup_conflicting_index &&
+	echo "none of the above" >sample &&
+	echo ourside >expect &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	git checkout --conflict=diff3 -- fild file filf &&
+	(
+		echo "<<<<<<< ours"
+		echo ourside
+		echo "|||||||"
+		echo original
+		echo "======="
+		echo theirside
+		echo ">>>>>>> theirs"
+	) >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
 test_done
-- 
1.6.0.1.260.g7aa8
