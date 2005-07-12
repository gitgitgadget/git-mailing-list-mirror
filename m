From: Chris Wedgwood <cw@f00f.org>
Subject: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Tue, 12 Jul 2005 12:05:52 -0700
Message-ID: <20050712190552.GA7178@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:09:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsQ7Y-0007Jr-Ge
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 21:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVGLTIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVGLTHh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 15:07:37 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:3268 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262246AbVGLTF7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 15:05:59 -0400
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6CJ5Xgb008906
	for <git@vger.kernel.org>; Tue, 12 Jul 2005 15:05:34 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout3-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6CJ5qbg084110;
	Tue, 12 Jul 2005 15:05:57 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 30E79529BBC; Tue, 12 Jul 2005 12:05:52 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sometimes (often actually) I do:

          cp -Rl tree1 tree2    # new tree with implied CoW semantics
          cd tree2
          cg-update             # or similar

the latter well frob .git/HEAD or similar by doing echo foo > bar
which obviously breaks the intended CoW semantics.

How would people feel about something like the patch below be?  (RFC
purposes only, please eyeball this before blidnly applying anything.
I may have missed spots or goofed, you never know).



diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -21,6 +21,12 @@ usage() {
 	die "usage: $USAGE"
 }
 
+echo_to_file() {
+    TMPFILE=`mktemp "$2.tmp-XXXXXXX"`
+    echo "$1" > "$TMPFILE"
+    mv "$TMPFILE" "$2"
+}
+
 pager () {
 	local line
 	# Invoke pager only if there's any actual output
@@ -101,7 +107,7 @@ tree_timewarp () {
 	fi
 
 	git-read-tree -m "$branch" || die "$branch: bad commit"
-	[ "$no_head_update" ] || echo "$branch" > $_git/HEAD
+	[ "$no_head_update" ] || echo_to_file "$branch" $_git/HEAD
 
 	# Kill gone files
 	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -50,4 +50,4 @@ mkdir -p $_git/branches
 [ -s "$_git/branches/$name" ] && die "branch already exists"
 [ -s "$_git/refs/heads/$name" ] && echo "warning: I already have head of this branch" >&2
 
-echo "$location" >$_git/branches/$name
+echo_to_file "$location" $_git/branches/$name
diff --git a/cg-branch-chg b/cg-branch-chg
--- a/cg-branch-chg
+++ b/cg-branch-chg
@@ -14,4 +14,4 @@ location=$2
 ([ "$name" ] && [ "$location" ]) || usage
 
 [ -s "$_git/branches/$name" ] || die "branch does not exist"
-echo "$location" >$_git/branches/$name
+echo_to_file "$location" $_git/branches/$name
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -331,7 +331,7 @@ fi
 
 if [ "$newhead" ]; then
 	echo "Committed as $newhead."
-	echo $newhead >$_git/HEAD
+	echo_to_file $newhead $_git/HEAD
 	[ "$merging" ] && rm $_git/merging $_git/merging-sym $_git/merge-base
 
 	# Trigger the postcommit hook
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -44,7 +44,7 @@ mkdir $_git/branches
 touch $_git/refs/heads/master
 
 if [ "$uri" ]; then
-	echo "$uri" >$_git/branches/origin
+	echo_to_file "$uri" $_git/branches/origin
 	cg-pull origin || die "pull failed"
 
 	cp $_git/refs/heads/origin $_git/refs/heads/master
diff --git a/cg-seek b/cg-seek
--- a/cg-seek
+++ b/cg-seek
@@ -44,8 +44,8 @@ fi
 
 if [ "$seek_mode" = "away" ]; then
 	rm $_git/HEAD
-	echo "$dstcommit" >$_git/HEAD
-	[ -s $_git/blocked ] || echo "seeked from $_git_head" >$_git/blocked
+	echo_to_file "$dstcommit" $_git/HEAD
+	[ -s $_git/blocked ] || echo_to_file "seeked from $_git_head" $_git/blocked
 else
 	rm $_git/HEAD
 	ln -s "refs/heads/$_git_head" $_git/HEAD
diff --git a/cg-tag b/cg-tag
--- a/cg-tag
+++ b/cg-tag
@@ -79,5 +79,5 @@ SIGEND
 
 	rm -rf "$tagdir"
 else
-	echo "$id" >$_git/refs/tags/$name
+	echo_to_file "$id" $_git/refs/tags/$name
 fi
diff --git a/git-branch-script b/git-branch-script
--- a/git-branch-script
+++ b/git-branch-script
@@ -8,4 +8,4 @@ rev=$(git-rev-parse --verify --default H
 [ -z "$branchname" ] && die "git branch: I want a branch name"
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
 
-echo $rev > "$GIT_DIR/refs/heads/$branchname"
+echo_to_file $rev "$GIT_DIR/refs/heads/$branchname"
diff --git a/git-checkout-script b/git-checkout-script
--- a/git-checkout-script
+++ b/git-checkout-script
@@ -67,7 +67,7 @@ fi
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		echo $new > "$GIT_DIR/refs/heads/$newbranch"
+		echo_to_file $new "$GIT_DIR/refs/heads/$newbranch"
 		branch="$newbranch"
 	fi
 	[ "$branch" ] && ln -sf "refs/heads/$branch" "$GIT_DIR/HEAD"
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -97,7 +97,7 @@ grep -v '^#' < .editmsg | git-stripspace
 [ -s .cmitmsg ] && 
 	tree=$(git-write-tree) &&
 	commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&
-	echo $commit > "$GIT_DIR/HEAD" &&
+	echo_to_file $commit "$GIT_DIR/HEAD" &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD"
 ret="$?"
 rm -f .cmitmsg .editmsg
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -30,4 +30,4 @@ rsync://*)
 	;;
 esac || exit 1
 git-rev-parse --verify "$head" > /dev/null || exit 1
-echo "$head" > "$GIT_DIR/$destination"
+echo_to_file "$head" "$GIT_DIR/$destination"
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -21,7 +21,7 @@ case "$#" in
 esac
 
 git-read-tree -m -u $junio $linus &&
-echo "$linus" >"$GIT_DIR/HEAD" || exit
+echo_to_file "$linus" "$GIT_DIR/HEAD" || exit
 
 tmp=.rebase-tmp$$
 fail=$tmp-fail
diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -24,8 +24,8 @@ if [ -z "$head" -o -z "$merge" -o -z "$m
 fi
 
 dropheads
-echo $head > "$GIT_DIR"/ORIG_HEAD
-echo $merge > "$GIT_DIR"/LAST_MERGE
+echo_to_file $head "$GIT_DIR"/ORIG_HEAD
+echo_to_file $merge "$GIT_DIR"/LAST_MERGE
 
 common=$(git-merge-base $head $merge)
 if [ -z "$common" ]; then
@@ -40,7 +40,7 @@ fi
 if [ "$common" == "$head" ]; then
 	echo "Updating from $head to $merge."
 	git-read-tree -u -m $head $merge || exit 1
-	echo $merge > "$GIT_DIR"/HEAD
+	echo_to_file $merge "$GIT_DIR"/HEAD
 	git-diff-tree -p $head $merge | git-apply --stat
 	dropheads
 	exit 0
@@ -52,13 +52,13 @@ if [ $? -ne 0 ]; then
 	echo "Simple merge failed, trying Automatic merge"
 	git-merge-cache -o git-merge-one-file-script -a
 	if [ $? -ne 0 ]; then
-		echo $merge > "$GIT_DIR"/MERGE_HEAD
+		echo_to_file $merge "$GIT_DIR"/MERGE_HEAD
 		die "Automatic merge failed, fix up by hand"
 	fi
 	result_tree=$(git-write-tree) || exit 1
 fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
-echo $result_commit > "$GIT_DIR"/HEAD
+echo_to_file $result_commit "$GIT_DIR"/HEAD
 git-diff-tree -p $head $result_commit | git-apply --stat
 dropheads
