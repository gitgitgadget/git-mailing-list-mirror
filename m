From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use git-update-ref in scripts.
Date: Tue, 27 Sep 2005 19:45:24 -0700
Message-ID: <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 04:46:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKRws-0005Zu-Bc
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 04:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVI1Cp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 22:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbVI1Cp2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 22:45:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18899 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965256AbVI1Cp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 22:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928024525.REUT4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 22:45:25 -0400
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 25 Sep 2005 12:05:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9421>

This uses the git-update-ref command in scripts for safer updates.
Also places where we used to read HEAD ref by using "cat" were fixed
to use git-rev-parse.  This will matter when we start using symbolic
references.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Requesting extra sets of eyeballs from the list for stupid
   mistakes.

 git-applypatch.sh |    5 +++--
 git-commit.sh     |    4 +++-
 git-fetch.sh      |   34 ++++++++++++++++++----------------
 git-merge.sh      |    9 +++++----
 git-octopus.sh    |    2 +-
 git-pull.sh       |    6 +++---
 git-rebase.sh     |    5 +++--
 git-reset.sh      |    2 +-
 git-resolve.sh    |    4 ++--
 9 files changed, 39 insertions(+), 32 deletions(-)

7bae83d5754a1afb8e64f9de17f1dc34d0022f0a
diff --git a/git-applypatch.sh b/git-applypatch.sh
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -108,9 +108,10 @@ fi
 
 tree=$(git-write-tree) || exit 1
 echo Wrote tree $tree
-commit=$(git-commit-tree $tree -p $(cat "$GIT_DIR"/HEAD) < "$final") || exit 1
+parent=$(git-rev-parse --verify HEAD) &&
+commit=$(git-commit-tree $tree -p $parent <"$final") || exit 1
 echo Committed: $commit
-echo $commit > "$GIT_DIR"/HEAD
+git-update-ref HEAD $commit $parent || exit
 
 if test -x "$GIT_DIR"/hooks/post-applypatch
 then
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -159,7 +159,9 @@ if [ ! -r "$GIT_DIR/HEAD" ]; then
 		exit 1
 	fi
 	PARENTS=""
+	current=
 else
+	current=$(git-rev-parse --verify HEAD)
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	fi
@@ -220,7 +222,7 @@ if test -s .cmitchk
 then
 	tree=$(git-write-tree) &&
 	commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&
-	echo $commit > "$GIT_DIR/HEAD" &&
+	git-update-ref HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD"
 else
 	echo >&2 "* no commit message?  aborting commit."
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -105,14 +105,16 @@ fast_forward_local () {
 	else
 		echo >&2 "* $1: storing $3"
 	fi
-	echo "$2" >"$GIT_DIR/$1" ;;
+	git-update-ref "$1" "$2" 
+	;;
 
     refs/heads/*)
-	# NEEDSWORK: use the same cmpxchg protocol here.
-	echo "$2" >"$GIT_DIR/$1.lock"
-	if test -f "$GIT_DIR/$1"
+	# $1 is the ref being updated.
+	# $2 is the new value for the ref.
+	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
+	if test "$local"
 	then
-	    local=$(git-rev-parse --verify "$1^0") &&
+	    # Require fast-forward.
 	    mb=$(git-merge-base "$local" "$2") &&
 	    case "$2,$mb" in
 	    $local,*)
@@ -120,34 +122,34 @@ fast_forward_local () {
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
+		git-update-ref "$1" "$2" "$local"
 		;;
 	    *)
 		false
 		;;
 	    esac || {
 		echo >&2 "* $1: does not fast forward to $3;"
-		case "$force,$single_force" in
-		t,* | *,t)
+		case ",$force,$single_force," in
+		*,t,*)
 			echo >&2 "  forcing update."
+			git-update-ref "$1" "$2" "$local"
 			;;
 		*)
-			mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1.remote"
-			echo >&2 "  leaving it in '$1.remote'"
+			echo >&2 "  not updating."
 			;;
 		esac
 	    }
 	else
-		echo >&2 "* $1: storing $3"
+	    echo >&2 "* $1: storing $3"
+	    git-update-ref "$1" "$2"
 	fi
-	test -f "$GIT_DIR/$1.lock" &&
-	    mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1"
 	;;
     esac
 }
 
 case "$update_head_ok" in
 '')
-	orig_head=$(cat "$GIT_DIR/HEAD" 2>/dev/null)
+	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 	;;
 esac
 
@@ -184,7 +186,7 @@ do
     rsync://*)
 	TMP_HEAD="$GIT_DIR/TMP_HEAD"
 	rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
-	head=$(git-rev-parse TMP_HEAD)
+	head=$(git-rev-parse --verify TMP_HEAD)
 	rm -f "$TMP_HEAD"
 	test "$rsync_slurped_objects" || {
 	    rsync -av --ignore-existing --exclude info \
@@ -261,10 +263,10 @@ case ",$update_head_ok,$orig_head," in
 *,, | t,* )
 	;;
 *)
-	curr_head=$(cat "$GIT_DIR/HEAD" 2>/dev/null)
+	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 	if test "$curr_head" != "$orig_head"
 	then
-		echo "$orig_head" >$GIT_DIR/HEAD
+	    	git-update-ref HEAD "$orig_head"
 		die "Cannot fetch into the current branch."
 	fi
 	;;
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -114,8 +114,9 @@ case "$#,$common" in
 	# Again the most common case of merging one remote.
 	echo "Updating from $head to $1."
 	git-update-index --refresh 2>/dev/null
-	git-read-tree -u -m $head "$1" || exit 1
-	git-rev-parse --verify "$1^0" > "$GIT_DIR/HEAD"
+	git-read-tree -u -m $head "$1" &&
+	new_head=$(git-rev-parse --verify "$1^0") &&
+	git-update-ref HEAD "$new_head" "$head" || exit 1
 	summary "$1"
 	dropsave
 	exit 0
@@ -218,9 +219,9 @@ then
     do
         parents="$parents -p $remote"
     done
-    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents)
+    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
     echo "Committed merge $result_commit, made by $wt_strategy."
-    echo $result_commit >"$GIT_DIR/HEAD"
+    git-update-ref HEAD $result_commit $head
     summary $result_commit
     dropsave
     exit 0
diff --git a/git-octopus.sh b/git-octopus.sh
--- a/git-octopus.sh
+++ b/git-octopus.sh
@@ -86,5 +86,5 @@ esac
 result_commit=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD" |
 		git-commit-tree $MRT $PARENT)
 echo "Committed merge $result_commit"
-echo $result_commit >"$GIT_DIR"/HEAD
+git-update-ref HEAD $result_commit $head
 git-diff-tree -p $head $result_commit | git-apply --stat
diff --git a/git-pull.sh b/git-pull.sh
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -6,10 +6,10 @@
 
 . git-sh-setup || die "Not a git archive"
 
-orig_head=$(cat "$GIT_DIR/HEAD") || die "Pulling into a black hole?"
+orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
 git-fetch --update-head-ok "$@" || exit 1
 
-curr_head=$(cat "$GIT_DIR/HEAD")
+curr_head=$(git-rev-parse --verify HEAD)
 if test "$curr_head" != "$orig_head"
 then
 	# The fetch involved updating the current branch.
@@ -38,4 +38,4 @@ case "$merge_head" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
-git-resolve "$(cat "$GIT_DIR"/HEAD)" $merge_head "$merge_name"
+git-resolve "$curr_head" $merge_head "$merge_name"
diff --git a/git-rebase.sh b/git-rebase.sh
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -33,7 +33,8 @@ test "$different1$different2" = "" ||
 die "Your working tree does not match $ours_symbolic."
 
 git-read-tree -m -u $ours $upstream &&
-git-rev-parse --verify "$upstream^0" >"$GIT_DIR/HEAD" || exit
+new_head=$(git-rev-parse --verify "$upstream^0") &&
+git-update-ref HEAD "$new_head" || exit
 
 tmp=.rebase-tmp$$
 fail=$tmp-fail
@@ -50,7 +51,7 @@ do
 		continue ;;
 	esac
 	echo >&2 "* Applying: $msg"
-	S=`cat "$GIT_DIR/HEAD"` &&
+	S=$(git-rev-parse --verify HEAD) &&
 	git-cherry-pick --replay $commit || {
 		echo >&2 "* Not applying the patch and continuing."
 		echo $commit >>$fail
diff --git a/git-reset.sh b/git-reset.sh
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -60,7 +60,7 @@ then
 else
 	rm -f "$GIT_DIR/ORIG_HEAD"
 fi
-echo "$rev" >"$GIT_DIR/HEAD"
+git-update-ref HEAD "$rev"
 
 case "$reset_type" in
 --hard )
diff --git a/git-resolve.sh b/git-resolve.sh
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -45,7 +45,7 @@ case "$common" in
 "$head")
 	echo "Updating from $head to $merge."
 	git-read-tree -u -m $head $merge || exit 1
-	echo $merge > "$GIT_DIR"/HEAD
+	git-update-ref HEAD "$merge"
 	git-diff-tree -p $head $merge | git-apply --stat
 	dropheads
 	exit 0
@@ -99,6 +99,6 @@ if [ $? -ne 0 ]; then
 fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
-echo $result_commit > "$GIT_DIR"/HEAD
+git-update-ref HEAD "$result_commit"
 git-diff-tree -p $head $result_commit | git-apply --stat
 dropheads
