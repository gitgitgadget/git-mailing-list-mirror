From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Alter git-rebase command line options.
Date: Wed, 26 Apr 2006 07:51:18 -0400
Message-ID: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 26 13:55:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYicc-0002QA-V4
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 13:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWDZLzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 07:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDZLzn
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 07:55:43 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:39433 "EHLO
	BAYC1-PASMTP06.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932404AbWDZLzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 07:55:43 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP06.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 26 Apr 2006 04:57:19 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id BE26D644C28
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 07:55:39 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060426075118.65876315.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 26 Apr 2006 11:57:20.0250 (UTC) FILETIME=[926775A0:01C66928]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  git rebase [--branch <branch>] <newbase>
  git rebase --continue
  git rebase --abort

Add "--continue" to restart the rebase process after
manually resolving conflicts.  The user is warned if
there are still differences between the index and the
working files.

Add "--abort" to restore the original branch, and
remove the .dotest working files.

Change the order that branch and newbase are specified
as per comments from Linus.  Also remove the need to
specify both an upstream branch _and_ a new merge base.

The documentation is updated to reflect this new command
line format but the script still quietly supports the
existing command line options completely.

This fixes a minor bug in the current version where:
"git rebase master^ master" doesn't notice that there
is no need to perform the rebase.

---

 Documentation/git-rebase.txt |   95 ++++++++++++++++++++++--------
 git-rebase.sh                |  133 ++++++++++++++++++++++--------------------
 2 files changed, 139 insertions(+), 89 deletions(-)

d8366d9de1aecf3143af646f49e7f7bc0f924ae6
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4a7e67a..f1e83ea 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -3,76 +3,121 @@ git-rebase(1)
 
 NAME
 ----
-git-rebase - Rebase local commits to new upstream head
+git-rebase - Rebase local commits to a new upstream head
 
 SYNOPSIS
 --------
-'git-rebase' [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [--branch <branch>] <newbase>
+
+'git-rebase' --continue
+
+'git-rebase' --abort
 
 DESCRIPTION
 -----------
-git-rebase applies to <upstream> (or optionally to <newbase>) commits
-from <branch> that do not appear in <upstream>. When <branch> is not
-specified it defaults to the current branch (HEAD).
+git-rebase replaces <branch> with a new branch of the same name having
+a HEAD of <newbase>.  It then attempts to make a new commit for each
+commit from the original <branch> that does not yet exist in this new
+<branch>.
+
+It is possible that a merge failure will prevent this process from being
+completely automatic.  You will have to resolve any such merge failure
+and run `git rebase --continue`.  If you can not resolve the merge
+failure, running `git rebase --abort` will restore the original <branch>
+and remove the working files found in the .dotest directory.
 
-When git-rebase is complete, <branch> will be updated to point to the
-newly created line of commit objects, so the previous line will not be
-accessible unless there are other references to it already.
+Note that if <branch> is not specified on the command line, the currently
+checked out branch is used.
 
 Assume the following history exists and the current branch is "topic":
 
+------------
           A---B---C topic
          /
     D---E---F---G master
+------------
+
+From this point, the result of running the following command:
+
 
-From this point, the result of either of the following commands:
+    git rebase --branch topic master
 
-    git-rebase master
-    git-rebase master topic
 
 would be:
 
+------------
                   A'--B'--C' topic
                  /
     D---E---F---G master
+------------
 
 While, starting from the same point, the result of either of the following
 commands:
 
-    git-rebase --onto master~1 master
-    git-rebase --onto master~1 master topic
+    git rebase master~1
+    git rebase --branch topic master~1
+
 
 would be:
 
+------------
               A'--B'--C' topic
              /
     D---E---F---G master
+------------
 
 In case of conflict, git-rebase will stop at the first problematic commit
-and leave conflict markers in the tree.  After resolving the conflict manually
-and updating the index with the desired resolution, you can continue the
-rebasing process with
+and leave conflict markers in the tree.  You can use git diff to locate
+the markers (<<<<<<) and make edits to resolve the conflict.  For each
+file you edit, you need to tell git that the conflict has been resolved,
+typically this would be done with
+
+
+    git update-index <filename>
+
+
+After resolving the conflict manually and updating the index with the
+desired resolution, you can continue the rebasing process with
+
+
+    git rebase --continue
 
-    git am --resolved --3way
 
 Alternatively, you can undo the git-rebase with
 
-    git reset --hard ORIG_HEAD
-    rm -r .dotest
+
+    git rebase --abort
 
 OPTIONS
 -------
 <newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.
-
-<upstream>::
-	Upstream branch to compare against.
+	Starting point at which to create the new commits.
 
 <branch>::
 	Working branch; defaults to HEAD.
 
+--continue::
+	Restart the rebasing process after having resolved a merge conflict.
+
+--abort::
+	Restore the original branch and abort the rebase operation.
+
+NOTES
+-----
+When you rebase a branch, you are changing its history in a way that
+will cause problems for anyone who already has a copy of the branch
+in their repository and tries to pull updates from you.  You should
+understand the implications of using 'git rebase' on a repository that
+you share.
+
+When the git rebase command is run, it will first execute a "pre-rebase"
+hook if one exists.  You can use this hook to do sanity checks and
+reject the rebase if it isn't appropriate.  Please see the template
+pre-rebase hook script for an example.
+
+You must be in the top directory of your project to start (or continue)
+a rebase.  Upon completion, <branch> will be the current branch.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
diff --git a/git-rebase.sh b/git-rebase.sh
index 86dfe9c..5a4e33b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,40 +3,61 @@ #
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--onto <newbase>] <upstream> [<branch>]'
-LONG_USAGE='git-rebase applies to <upstream> (or optionally to <newbase>) commits
-from <branch> that do not appear in <upstream>. When <branch> is not
-specified it defaults to the current branch (HEAD).
-
-When git-rebase is complete, <branch> will be updated to point to the
-newly created line of commit objects, so the previous line will not be
-accessible unless there are other references to it already.
-
-Assuming the following history:
-
-          A---B---C topic
-         /
-    D---E---F---G master
-
-The result of the following command:
-
-    git-rebase --onto master~1 master topic
-
-  would be:
-
-              A'\''--B'\''--C'\'' topic
-             /
-    D---E---F---G master
+USAGE='[--branch <branch>] <newbase>'
+LONG_USAGE='git-rebase replaces <branch> with a new one of the
+same name having a HEAD of <newbase>.  It then attempts to create
+a new commit for each commit from the original <branch> that does
+not yet exist on this new <branch>.
+
+It is possible that a merge failure will prevent this process
+from being completely automatic.  You will have to resolve any
+such merge failure and run git-rebase --continue.  If you can
+not resolve the merge failure, running git-rebase --abort will
+restore the original <branch> and remove the working files found
+in the .dotest directory.
+
+Note that if <branch> is not specified on the command line, the
+currently checked out branch is used.  You must be in the top
+directory of your project to start (or continue) a rebase.
+
+Example:       git-rebase --branch topic master~1
+
+        A---B---C topic                   A'\''--B'\''--C'\'' topic
+       /                   -->           /
+  D---E---F---G master          D---E---F---G master
 '
 
 . git-sh-setup
 
 unset newbase
+unset branch_name
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
+	--continue)
+		diff=$(git-diff-files)
+		case "$diff" in
+		?*)	echo "You must edit all merge conflicts and then"
+			echo "mark them as resolved using git update-index"
+			exit 1
+			;;
+		esac
+		git am --resolved --3way
+		exit
+		;;
+	--abort)
+		[ -d .dotest ] || die "No rebase in progress?"
+		git reset --hard ORIG_HEAD
+		rm -r .dotest
+		exit
+		;;
+	--branch)
+		test $# -ne 3 -o -n "$newbase" && usage
+		branch_name="$2"
+		shift
+		;;
 	--onto)
-		test 2 -le "$#" || usage
+		test $# -lt 2 -o -n "$branch_name" && usage
 		newbase="$2"
 		shift
 		;;
@@ -49,6 +70,20 @@ do
 	esac
 	shift
 done
+# Quietly support the historic command line [--onto newbase] newbase' [branch]
+test $# -lt 1 && usage
+test -z "$newbase" && newbase="$1"
+shift
+if [ -z "$branch_name" ]; then
+	if [ $# -gt 0 ]; then
+		branch_name="$1"
+		shift
+	else	branch_name=`git symbolic-ref HEAD` || die "No current branch"
+		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+	fi
+fi
+test $# -gt 0 && usage
+git checkout "$branch_name" || usage
 
 # Make sure we do not have .dotest
 if mkdir .dotest
@@ -72,11 +107,6 @@ case "$diff" in
 	;;
 esac
 
-# The upstream head must be given.  Make sure it is valid.
-upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-    die "invalid upstream $upstream_name"
-
 # If a hook exists, give it a chance to interrupt
 if test -x "$GIT_DIR/hooks/pre-rebase"
 then
@@ -86,47 +116,22 @@ then
 	}
 fi
 
-# If the branch to rebase is given, first switch to it.
-case "$#" in
-2)
-	branch_name="$2"
-	git-checkout "$2" || usage
-	;;
-*)
-	branch_name=`git symbolic-ref HEAD` || die "No current branch"
-	branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
-	;;
-esac
-branch=$(git-rev-parse --verify "${branch_name}^0") || exit
-
 # Make sure the branch to rebase onto is valid.
-onto_name=${newbase-"$upstream_name"}
-onto=$(git-rev-parse --verify "${onto_name}^0") || exit
-
-# Now we are rebasing commits $upstream..$branch on top of $onto
+branch=$(git-rev-parse --verify "${branch_name}^0") || exit
+onto=$(git-rev-parse --verify "${newbase}^0") || exit
 
 # Check if we are already based on $onto, but this should be
 # done only when upstream and onto are the same.
-if test "$upstream" = "onto"
-then
-	mb=$(git-merge-base "$onto" "$branch")
-	if test "$mb" = "$onto"
-	then
-		echo >&2 "Current branch $branch_name is up to date."
-		exit 0
-	fi
-fi
-
-# Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
-git-reset --hard "$onto"
-
-# If the $onto is a proper descendant of the tip of the branch, then
-# we just fast forwarded.
+mb=$(git-merge-base "$onto" "$branch")
 if test "$mb" = "$onto"
 then
-	echo >&2 "Fast-forwarded $branch to $newbase."
+	echo >&2 "Current branch $branch_name already has $newbase as a base!"
 	exit 0
 fi
 
-git-format-patch -k --stdout --full-index "$upstream" ORIG_HEAD |
+# Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
+git-reset --hard "$newbase"
+
+# Now we are rebasing commits $newbase..$branch on top of $newbase
+git-format-patch -k --stdout --full-index "$newbase" ORIG_HEAD |
 git am --binary -3 -k
-- 
1.3.0.gd8366
