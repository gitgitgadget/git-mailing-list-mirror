From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 6/7] add support for creating equal tree markers after
	rebase
Date: Mon, 30 Nov 2009 15:45:32 +0100
Message-ID: <07307f70f21343d69765c783dc82215ce52a3432.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7VS-0007W4-5m
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZK3Op0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbZK3Op0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:45:26 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33534
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbZK3Op0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:45:26 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7VM-00017H-7l
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:32 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7VM-0000rl-5p
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:32 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134109>

With the new --eqt option, git rebase adds an equal tree marker,
so that the old branch can be fast-forwarded to the new one.
If the trees are not equal, a fake merge of the new base and the
old branch is created first.

TODO:
 - manpage update,
 - should --eqt have a better (longer more descriptive) name?
 - the commit message of the merge should have a better default
   and presented to the user for editing
---
 git-rebase.sh |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 391f6d6..681c97b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -50,6 +50,7 @@ diffstat=$(git config --bool rebase.stat)
 git_am_opt=
 rebase_root=
 force_rebase=
+equal_tree_marker=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -132,11 +133,30 @@ call_merge () {
 	esac
 }
 
+# is there really no already existing function for this?
+tree_of_commit() {
+        git cat-file commit "$1" | grep '^tree ' | head -n 1 | sed -e 's/^tree //'
+}
+
 move_to_original_branch () {
 	test -z "$head_name" &&
 		head_name="$(cat "$dotest"/head-name)" &&
 		onto="$(cat "$dotest"/onto)" &&
-		orig_head="$(cat "$dotest"/orig-head)"
+		orig_head="$(cat "$dotest"/orig-head)" &&
+		equal_tree_marker="$(cat "$dotest"/eqt)"
+	if test t = "$equal_tree_marker" ; then
+		# first apply all the changes to the old branch
+		old_tree=$(tree_of_commit "$orig_head")
+		new_tree=$(tree_of_commit HEAD)
+		if test "$old_tree" = "$new_tree" ; then
+			old_branch="$orig_head"
+		else
+			# TODO: better commit message
+			old_branch=$(echo "rebase $head_name onto $onto" | git-commit-tree $new_tree -p "$orig_head" -p "$onto" )
+		fi
+		# then say the old branch can be upgraded to the new one:
+		git equal-tree-marker "$old_branch"
+	fi
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -220,6 +240,7 @@ do
 			end=$(cat "$dotest/end")
 			msgnum=$(cat "$dotest/msgnum")
 			onto=$(cat "$dotest/onto")
+			equal_tree_marker=$(cat "$dotest/eqt")
 			GIT_QUIET=$(cat "$dotest/quiet")
 			continue_merge
 			while test "$msgnum" -le "$end"
@@ -234,6 +255,7 @@ do
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
 		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		equal_tree_marker=$(cat "$GIT_DIR"/rebase-apply/eqt)
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -251,6 +273,7 @@ do
 			msgnum=$(cat "$dotest/msgnum")
 			msgnum=$(($msgnum + 1))
 			onto=$(cat "$dotest/onto")
+			equal_tree_marker=$(cat "$dotest/eqt")
 			GIT_QUIET=$(cat "$dotest/quiet")
 			while test "$msgnum" -le "$end"
 			do
@@ -264,6 +287,7 @@ do
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
 		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		equal_tree_marker=$(cat "$GIT_DIR"/rebase-apply/eqt)
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -340,6 +364,9 @@ do
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
+	--eqt)
+		equal_tree_marker=t
+		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
@@ -522,7 +549,8 @@ then
 		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
 		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
 		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head &&
-		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
+		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet &&
+		echo "$equal_tree_marker" > "$GIT_DIR"/rebase-apply/eqt
 	exit $ret
 fi
 
@@ -537,6 +565,7 @@ echo "$prev_head" > "$dotest/prev_head"
 echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 echo "$GIT_QUIET" > "$dotest/quiet"
+echo "$equal_tree_marker" > "$dotest/eqt"
 
 msgnum=0
 for cmt in `git rev-list --reverse --first-equal-tree-only --no-merges "$revisions"`
