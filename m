From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout: merge local modifications while switching branches.
Date: Thu, 12 Jan 2006 17:55:07 -0800
Message-ID: <7vpsmwhoxw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 13 02:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExE9q-0004Uj-Of
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 02:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161636AbWAMBzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 20:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161637AbWAMBzL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 20:55:11 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21459 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161636AbWAMBzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 20:55:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113015316.MBZK17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 20:53:16 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14597>

 * Instead of going interactive, introduce a command line switch
   '-m' to allow merging changes when normal two-way merge by
   read-tree prevents branch switching.

 * Leave the unmerged stages intact if automerge fails, but
   reset index entries of cleanly merged paths to that of the
   new branch, so that "git diff" (not "git diff HEAD") would
   show the local modifications.

 * Swap the order of trees in read-tree three-way merge used in
   the fallback, so that `git diff` to show the conflicts become
   more natural.

 * Describe the new option and give more examples in the documentation.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This comes on top of my yesterday's patch.  I am trying this
   out today in my day-job by deliberately developing on the
   "test" branch (which is a merge of all the topic branches),
   and then doing "checkout -m" to switch back to the relevant
   topic branch.  Things seem to work nicely.

 Documentation/git-checkout.txt |   76 ++++++++++++++++++++++++++++++++++++----
 git-checkout.sh                |   60 ++++++++++++++++++++------------
 2 files changed, 107 insertions(+), 29 deletions(-)

19394e9d4e99a1e49a5b958db66228df07dc8afb
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9442c66..df9a618 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -7,7 +7,7 @@ git-checkout - Checkout and switch to a 
 
 SYNOPSIS
 --------
-'git-checkout' [-f] [-b <new_branch>] [<branch>] [<paths>...]
+'git-checkout' [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,19 @@ OPTIONS
 -b::
 	Create a new branch and start it at <branch>.
 
+-m::
+	If you have local modifications to a file that is
+	different between the current branch and the branch you
+	are switching to, the command refuses to switch
+	branches, to preserve your modifications in context.
+	With this option, a three-way merge between the current
+	branch, your working tree contents, and the new branch
+	is done, and you will be on the new branch.
++
+When a merge conflict happens, the index entries for conflicting
+paths are left unmerged, and you need to resolve the conflicts
+and mark the resolved paths with `git update-index`.
+
 <new_branch>::
 	Name for the new branch.
 
@@ -42,13 +55,13 @@ OPTIONS
 	commit. Defaults to HEAD.
 
 
-EXAMPLE
--------
+EXAMPLES
+--------
 
-The following sequence checks out the `master` branch, reverts
+. The following sequence checks out the `master` branch, reverts
 the `Makefile` to two revisions back, deletes hello.c by
 mistake, and gets it back from the index.
-
++
 ------------
 $ git checkout master <1>
 $ git checkout master~2 Makefile <2>
@@ -59,15 +72,64 @@ $ git checkout hello.c <3>
 <2> take out a file out of other commit
 <3> or "git checkout -- hello.c", as in the next example.
 ------------
-
++
 If you have an unfortunate branch that is named `hello.c`, the
 last step above would be confused as an instruction to switch to
 that branch.  You should instead write:
-
++
 ------------
 $ git checkout -- hello.c
 ------------
 
+. After working in a wrong branch, switching to the correct
+branch you would want to is done with:
++
+------------
+$ git checkout mytopic
+------------
++
+However, your "wrong" branch and correct "mytopic" branch may
+differ in files that you have locally modified, in which case,
+the above checkout would fail like this:
++
+------------
+$ git checkout mytopic
+fatal: Entry 'frotz' not uptodate. Cannot merge.
+------------
++
+You can give the `-m` flag to the command, which would try a
+three-way merge:
++
+------------
+$ git checkout -m mytopic
+Auto-merging frotz
+------------
++
+After this three-way merge, the local modifications are _not_
+registered in your index file, so `git diff` would show you what
+changes you made since the tip of the new branch.
+
+. When a merge conflict happens during switching branches with
+the `-m` option, you would see something like this:
++
+------------
+$ git checkout -m mytopic
+Auto-merging frotz
+merge: warning: conflicts during merge
+ERROR: Merge conflict in frotz
+fatal: merge program failed
+------------
++
+At this point, `git diff` shows the changes cleanly merged as in
+the previous example, as well as the changes in the conflicted
+files.  Edit and resolve the conflict and mark it resolved with
+`git update-index` as usual:
++
+------------
+$ edit frotz
+$ git update-index frotz
+------------
+
 
 Author
 ------
diff --git a/git-checkout.sh b/git-checkout.sh
index 76e6a41..bd7f007 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-f] [-b <new_branch>] [<branch>] [<paths>...]'
+USAGE='[-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
@@ -9,6 +9,7 @@ new=
 force=
 branch=
 newbranch=
+merge=
 while [ "$#" != "0" ]; do
     arg="$1"
     shift
@@ -26,6 +27,9 @@ while [ "$#" != "0" ]; do
 	"-f")
 		force=1
 		;;
+	-m)
+		merge=1
+		;;
 	--)
 		break
 		;;
@@ -71,7 +75,7 @@ done
 
 if test "$#" -ge 1
 then
-	if test '' != "$newbranch$force"
+	if test '' != "$newbranch$force$merge"
 	then
 		die "updating paths and switching branches or forcing are incompatible."
 	fi
@@ -121,32 +125,44 @@ then
 	git-checkout-index -q -f -u -a
 else
     git-update-index --refresh >/dev/null
-    git-read-tree -m -u $old $new || (
-	echo >&2 -n "Try automerge [y/N]? "
-	read yesno
-	case "$yesno" in [yY]*) ;; *) exit 1 ;; esac
-
-	# NEEDSWORK: We may want to reset the index from the $new for
-	# these paths after the automerge happens, but it is not done
-	# yet.  Probably we need to leave unmerged ones alone, and
-	# yank the object name & mode from $new for cleanly merged
-	# paths and stuff them in the index.
-
-	names=`git diff-files --name-only`
-	case "$names" in
-	'')	;;
-	*)
-		echo "$names" | git update-index --remove --stdin ;;
+    merge_error=$(git-read-tree -m -u $old $new 2>&1) || (
+	case "$merge" in
+	'')
+		echo >&2 "$merge_error"
+		exit 1 ;;
 	esac
 
+	# Match the index to the working tree, and do a three-way.
+    	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
-	git read-tree -m -u $old $work $new || exit
+	git read-tree --reset $new &&
+	git checkout-index -f -u -q -a &&
+	git read-tree -m -u $old $new $work || exit
+
 	if result=`git write-tree 2>/dev/null`
 	then
-	    echo >&2 "Trivially automerged." ;# can this even happen?
-	    exit 0
+	    echo >&2 "Trivially automerged."
+	else
+	    git merge-index -o git-merge-one-file -a
 	fi
-	git merge-index -o git-merge-one-file -a
+
+	# Do not register the cleanly merged paths in the index yet.
+	# this is not a real merge before committing, but just carrying
+	# the working tree changes along.
+	unmerged=`git ls-files -u`
+	git read-tree --reset $new
+	case "$unmerged" in
+	'')	;;
+	*)
+		(
+			z40=0000000000000000000000000000000000000000
+			echo "$unmerged" |
+			sed -e 's/^[0-7]* [0-9a-f]* /'"0 $z40 /"
+			echo "$unmerged"
+		) | git update-index --index-info
+		;;
+	esac
+	exit 0
     )
 fi
 
-- 
1.1.1-gae96
