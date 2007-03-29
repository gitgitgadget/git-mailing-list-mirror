From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Use BASE index extension in git-commit and git-merge.
Date: Thu, 29 Mar 2007 01:23:12 -0700
Message-ID: <7vbqic4fwv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpwh-00058W-O3
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbXC2IZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbXC2IZV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:25:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53612 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXC2IZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:25:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329082313.QHFH373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:23:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gYPC1W0051kojtg0000000; Thu, 29 Mar 2007 04:23:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43416>

This makes git-commit and git-merge check the HEAD commit the
index is based on, and make sure the HEAD still points at that
commit, so that the user will notice the situation where
somebody else runs "git push" into the repository to update the
head of the current branch.  Committing blindly on such a head
can cause lossage of what was pushed into.

When you are working on your changes, somebody (maybe yourself
from a different machine) could push into your current branch by
mistake.  When this happens, what is happening is that you start
from this graph:

 ---o---A branch tip

You are working on commit A to create the next commit X.

 ---o---A............X (you were working towards creating this commit)

However, somebody else mucked with your branch head in the meantime.

          x---x---B updated branch tip
         /
 ---o---A............X

At this point, your working tree and the index are still based
on A, so you would hopefully notice something very fishy is
happening behind your back if you run "git diff --cached" or
"git status", and you would see many paths that are touched by
'x' and 'B' commits as "updated" in the comments in "git commit"
log message template. But if you are not careful, you may not
notice and make a commit on top of whereever the HEAD is.

If we allowed a commit to be created in such a case, your next
commit will have B as the parent, with the tree state you wanted
to have in X.  The graph becomes like this:

          x---x---B
         /          \
 ---o---A            X (New HEAD)

The commit essentially reverts what happened in 'x' and 'B',
which is quite bad.

What you want to happen in this case is to make a graph like
this:

          x---x---B branch tip
         /
 ---o---A-------X (your work is still based on A)

and then perhaps merge B's work, after making sure B is a
fast-forward of A and doing other sanity checks:

          x---x---B
         /         \
 ---o---A-------X---M the final branch tip

An example transcript with this patch when you try to commit in
the above scenario looks like this:

    : start working based on A
    ... in the meantime, somebody does 'git push' into the
    ... repository to update the branch you are on.
    $ edit; git commit -a -m 'X'; echo $?
    * The index is based on '1d5c138... A', however, the HEAD
      points at different commit 'a093461... B'
    1

At this point, you would recover by detaching your HEAD to point
at A, make a commit on top of it (which would be X whose parent
is A and does not lose any of 'x' and 'B'), and then merge in
'B'.  There is no command to do these yet.  This commit
implements only the detection of the above problematic case, and
does not deal with the recovery.  The outline for the recovery
procedure would be:

    $ ref=`git symbolic-ref HEAD`  ;# find out the original branch
    $ branch=${ref#refs/heads/}
    $ rm -f .git/HEAD              ;# detach the HEAD by hand
    $ git update-index --get-base >.git/HEAD
    $ git commit -a -m 'X' ;# the commit you wanted to make
    $ git merge $ref               ;# create M
    $ newhead=`git rev-parse HEAD` ;# ... and remember where it is
    $ git checkout $branch
    $ git merge $newhead           ;# and fast forward the branch

The last merge would fast-forward the original branch to M,
resulting in the above picture that has the final branch tip at
commit M.

NOTE!

There are other index-altering commands that can change HEAD
(e.g. git-checkout <branch>) that need to be taught about
checking and updating BASE.

Currently they just invalidate the BASE commit object recorded
in the index (see the change to builtin-read-tree.c in this
commit), so later commit/merge safety check won't trigger.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-read-tree.c |    1 +
 git-commit.sh       |   32 +++++++++++++++++++++++++++++++-
 git-merge.sh        |   15 +++++++++++++++
 merge-recursive.c   |    3 +++
 4 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 793eae0..06c2912 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -31,6 +31,7 @@ static int read_cache_unmerged(void)
 	struct cache_entry *last = NULL;
 
 	read_cache();
+	active_cache_base_valid = 0;
 	dst = active_cache;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/git-commit.sh b/git-commit.sh
index 292cf96..42f1c93 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -25,6 +25,22 @@ refuse_partial () {
 	exit 1
 }
 
+check_base () {
+	quiet="$1"
+	if HEAD=`git rev-parse --verify HEAD 2>/dev/null` &&
+	   BASE=`git update-index --get-base` &&
+	   test -n "$BASE" &&
+	   test "$BASE" != "$HEAD"
+	then
+		test -z "$quiet" || exit 1
+		ours=`git show -s --pretty=oneline --abbrev-commit $BASE`
+		theirs=`git show -s --pretty=oneline --abbrev-commit $HEAD`
+		echo >&2 "* The index is based on '$ours', however, the HEAD"
+		echo >&2 "  points at different commit '$theirs'"
+		exit 1
+	fi
+}
+
 THIS_INDEX="$GIT_DIR/index"
 NEXT_INDEX="$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
@@ -39,6 +55,10 @@ run_status () {
 	# NEXT_INDEX exists, that is the index file used to
 	# make the commit.  Otherwise we are using as-is commit
 	# so the regular index file is what we use to compare.
+
+	# We want a subshell, as we do not want to affect others with
+	# GIT_INDEX_FILE environment.
+	(
 	if test '' != "$TMP_INDEX"
 	then
 		GIT_INDEX_FILE="$TMP_INDEX"
@@ -57,6 +77,7 @@ run_status () {
 		${verbose:+--verbose} \
 		${amend:+--amend} \
 		${untracked_files:+--untracked}
+	)
 }
 
 trap '
@@ -322,6 +343,10 @@ t,,[1-9]*)
 esac
 
 ################################################################
+# Check for a case where HEAD was updated underneath us.
+check_base || exit
+
+################################################################
 # Prepare index to have a tree to be committed
 
 case "$all,$also" in
@@ -610,6 +635,10 @@ if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
 	wc -l` &&
    test 0 -lt $cnt
 then
+	# Check for a case where HEAD was updated underneath us
+	# while we were editing the message.
+	check_base || exit
+
 	if test -z "$TMP_INDEX"
 	then
 		tree=$(GIT_INDEX_FILE="$USE_INDEX" git-write-tree)
@@ -626,7 +655,8 @@ then
 		mv "$NEXT_INDEX" "$THIS_INDEX"
 	else
 		: ;# happy
-	fi
+	fi &&
+	git update-index --set-base $commit
 else
 	echo >&2 "* no commit message?  aborting commit."
 	false
diff --git a/git-merge.sh b/git-merge.sh
index fa45891..df4d3c9 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -80,6 +80,7 @@ finish () {
 			;;
 		*)
 			git-update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
+			git-update-index --set-base "$1"
 			;;
 		esac
 		;;
@@ -167,6 +168,8 @@ do
 	shift
 done
 
+BASE=`git update-index --get-base`
+
 # This could be traditional "merge <msg> HEAD <commit>..."  and the
 # way we can tell it is to see if the second token is HEAD, but some
 # people might have misused the interface and used a committish that
@@ -196,8 +199,16 @@ then
 	rh=$(git rev-parse --verify "$1^0") ||
 		die "$1 - not something we can merge"
 
+	# If somebody pushed :refs/heads/$current_branch in the meantime
+	# then we are in trouble.
+	if test -n "$BASE"
+	then
+		die "Your index is based on '$BASE' commit, but the branch you were on disappeared."
+	fi
+
 	git-update-ref -m "initial pull" HEAD "$rh" "" &&
 	git-read-tree --reset -u HEAD
+	git update-index --set-base $rh
 	exit
 
 else
@@ -217,6 +228,10 @@ else
 	merge_msg="${merge_msg:+$merge_msg$LF$LF}$merge_name"
 fi
 head=$(git-rev-parse --verify "$head_arg"^0) || usage
+if test -n "$BASE" && test "$head" != "$BASE"
+then
+	die "Your index is based on '$BASE' commit, but the branch tip you are on is at '$head'"
+fi
 
 # All the rest are remote heads
 test "$#" = 0 && usage ;# we need at least one remote head.
diff --git a/merge-recursive.c b/merge-recursive.c
index c96e1a7..4b86351 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1361,6 +1361,9 @@ int main(int argc, char *argv[])
 	}
 	clean = merge(h1, h2, branch1, branch2, ca, &result);
 
+	hashcpy(active_cache_base, h1->object.sha1);
+	active_cache_base_valid = 1;
+
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     close(index_fd) || commit_lock_file(lock)))
-- 
1.5.1.rc3.1.ga429d
