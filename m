From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] scripts: do not get confused with HEAD in work tree
Date: Wed, 28 Nov 2007 16:15:04 -0800
Message-ID: <7vbq9d29h3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 01:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxX3z-00037F-1H
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbXK2APL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756938AbXK2APL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:15:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50300 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbXK2APJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:15:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1A58A2F0;
	Wed, 28 Nov 2007 19:15:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 69EA89AD84;
	Wed, 28 Nov 2007 19:15:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66474>

When you have a file called HEAD in your work tree, many commands that
our scripts feed "HEAD" to would complain about the rev vs path
ambiguity.  A solution is to form command line more carefully by
appending -- to them, which makes it clear that we mean HEAD rev not
HEAD file.

This patch would apply to maint.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                  |    8 ++++----
 git-filter-branch.sh       |    2 +-
 git-merge-ours.sh          |    2 +-
 git-rebase--interactive.sh |    4 ++--
 git-rebase.sh              |    4 ++--
 git-stash.sh               |    2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 32c46d7..5792631 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -214,7 +214,7 @@ fi
 
 case "$resolved" in
 '')
-	files=$(git diff-index --cached --name-only HEAD) || exit
+	files=$(git diff-index --cached --name-only HEAD --) || exit
 	if [ "$files" ]; then
 	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
 	   exit 1
@@ -348,7 +348,7 @@ do
 		case "$resolved$interactive" in
 		tt)
 			# This is used only for interactive view option.
-			git diff-index -p --cached HEAD >"$dotest/patch"
+			git diff-index -p --cached HEAD -- >"$dotest/patch"
 			;;
 		esac
 	esac
@@ -409,7 +409,7 @@ do
 		# trust what the user has in the index file and the
 		# working tree.
 		resolved=
-		git diff-index --quiet --cached HEAD && {
+		git diff-index --quiet --cached HEAD -- && {
 			echo "No changes - did you forget to use 'git add'?"
 			stop_here_user_resolve $this
 		}
@@ -431,7 +431,7 @@ do
 		then
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
-		    git diff-index --quiet --cached HEAD && {
+		    git diff-index --quiet --cached HEAD -- && {
 			echo No changes -- Patch already applied.
 			go_next
 			continue
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ffcc408..dbab1a9 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -95,7 +95,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 . git-sh-setup
 
 git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD ||
+	git diff-index --cached --quiet HEAD -- ||
 	die "Cannot rewrite branch(es) with a dirty working directory."
 
 tempdir=.git-rewrite
diff --git a/git-merge-ours.sh b/git-merge-ours.sh
index c81a790..29dba4b 100755
--- a/git-merge-ours.sh
+++ b/git-merge-ours.sh
@@ -9,6 +9,6 @@
 # because the current index is what we will be committing as the
 # merge result.
 
-git diff-index --quiet --cached HEAD || exit 2
+git diff-index --quiet --cached HEAD -- || exit 2
 
 exit 0
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65df2c..ff38a22 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -52,7 +52,7 @@ require_clean_work_tree () {
 	git rev-parse --verify HEAD > /dev/null &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD ||
+	git diff-index --cached --quiet HEAD -- ||
 	die "Working tree is dirty"
 }
 
@@ -331,7 +331,7 @@ do
 		git rev-parse --verify HEAD > /dev/null &&
 		git update-index --refresh &&
 		git diff-files --quiet &&
-		! git diff-index --cached --quiet HEAD &&
+		! git diff-index --cached --quiet HEAD -- &&
 		. "$DOTEST"/author-script &&
 		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
 		git commit -F "$DOTEST"/message -e
diff --git a/git-rebase.sh b/git-rebase.sh
index b0c8ac1..c9b284c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,7 +60,7 @@ continue_merge () {
 	fi
 
 	cmt=`cat "$dotest/current"`
-	if ! git diff-index --quiet HEAD
+	if ! git diff-index --quiet HEAD --
 	then
 		if ! git-commit -C "$cmt"
 		then
@@ -253,7 +253,7 @@ fi
 
 # The tree must be really really clean.
 git update-index --refresh || exit
-diff=$(git diff-index --cached --name-status -r HEAD)
+diff=$(git diff-index --cached --name-status -r HEAD --)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
 	echo "$diff"
diff --git a/git-stash.sh b/git-stash.sh
index 5bbda47..77c9421 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -14,7 +14,7 @@ trap 'rm -f "$TMP-*"' 0
 ref_stash=refs/stash
 
 no_changes () {
-	git diff-index --quiet --cached HEAD &&
+	git diff-index --quiet --cached HEAD -- &&
 	git diff-files --quiet
 }
 
