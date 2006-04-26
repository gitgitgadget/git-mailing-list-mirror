From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Add --continue and --abort options to git-rebase.
Date: Wed, 26 Apr 2006 10:49:38 -0400
Message-ID: <BAYC1-PASMTP025110BEB495EC4F07CDE2AEBC0@CEZ.ICE>
References: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
	<e2np4p$b9a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 26 16:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYlP8-0004ia-6b
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 16:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWDZOyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 10:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWDZOyF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 10:54:05 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:21970 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932461AbWDZOyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 10:54:04 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 26 Apr 2006 07:54:03 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E6DC1644C28
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 10:53:59 -0400 (EDT)
To: git <git@vger.kernel.org>
Message-Id: <20060426104938.1ff14b2b.seanlkml@sympatico.ca>
In-Reply-To: <e2np4p$b9a$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 26 Apr 2006 14:54:03.0953 (UTC) FILETIME=[42B42210:01C66941]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  git rebase [--onto <newbase>] <upstream> [<branch>]
  git rebase --continue
  git rebase --abort

Add "--continue" to restart the rebase process after
manually resolving conflicts.  The user is warned if
there are still differences between the index and the
working files.

Add "--abort" to restore the original branch, and
remove the .dotest working files.

This fixes a minor bug in the current version where:
"git rebase master^ master" doesn't notice that there
is no need to perform the rebase.

Some minor additions to the git-rebase documentation.

---

Take 2.  Must simpler patch which doesn't trying to 
rejigger the command line too much.

 Documentation/git-rebase.txt |   76 +++++++++++++++++++++++++++++++++++-------
 git-rebase.sh                |   64 ++++++++++++++++++++++-------------
 2 files changed, 102 insertions(+), 38 deletions(-)

b009f7b17dce8f860f242f9cafc2aa510daf9f41
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4a7e67a..cf74005 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -3,38 +3,54 @@ git-rebase(1)
 
 NAME
 ----
-git-rebase - Rebase local commits to new upstream head
+git-rebase - Rebase local commits to a new head
 
 SYNOPSIS
 --------
 'git-rebase' [--onto <newbase>] <upstream> [<branch>]
 
+'git-rebase' --continue
+
+'git-rebase' --abort
+
 DESCRIPTION
 -----------
-git-rebase applies to <upstream> (or optionally to <newbase>) commits
-from <branch> that do not appear in <upstream>. When <branch> is not
-specified it defaults to the current branch (HEAD).
+git-rebase replaces <branch> with a new branch of the same name.  When
+the --onto option is provided the new branch starts out with a HEAD equal
+to <newbase>, otherwise it is equal to <upstream>.  It then attempts to
+create a new commit for each commit from the original <branch> that does
+not exist in the <upstream> branch.
 
-When git-rebase is complete, <branch> will be updated to point to the
-newly created line of commit objects, so the previous line will not be
-accessible unless there are other references to it already.
+It is possible that a merge failure will prevent this process from being
+completely automatic.  You will have to resolve any such merge failure
+and run `git rebase --continue`.  If you can not resolve the merge
+failure, running `git rebase --abort` will restore the original <branch>
+and remove the working files found in the .dotest directory.
+
+Note that if <branch> is not specified on the command line, the currently
+checked out branch is used.
 
 Assume the following history exists and the current branch is "topic":
 
+------------
           A---B---C topic
          /
     D---E---F---G master
+------------
 
 From this point, the result of either of the following commands:
 
+
     git-rebase master
     git-rebase master topic
 
 would be:
 
+------------
                   A'--B'--C' topic
                  /
     D---E---F---G master
+------------
 
 While, starting from the same point, the result of either of the following
 commands:
@@ -44,21 +60,33 @@ commands:
 
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
@@ -73,6 +101,28 @@ OPTIONS
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
index 86dfe9c..2085ebe 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -4,37 +4,51 @@ # Copyright (c) 2005 Junio C Hamano.
 #
 
 USAGE='[--onto <newbase>] <upstream> [<branch>]'
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
+LONG_USAGE='git-rebase replaces <branch> with a new branch of the
+same name.  When the --onto option is provided the new branch starts
+out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
+It then attempts to create a new commit for each commit from the original
+<branch> that does not exist in the <upstream> branch.
+
+It is possible that a merge failure will prevent this process from being
+completely automatic.  You will have to resolve any such merge failure
+and run git-rebase --continue.  If you can not resolve the merge failure,
+running git-rebase --abort will restore the original <branch> and remove
+the working files found in the .dotest directory.
+
+Note that if <branch> is not specified on the command line, the
+currently checked out branch is used.  You must be in the top
+directory of your project to start (or continue) a rebase.
+
+Example:       git-rebase master~1 topic
+
+        A---B---C topic                   A'\''--B'\''--C'\'' topic
+       /                   -->           /
+  D---E---F---G master          D---E---F---G master
 '
-
 . git-sh-setup
 
 unset newbase
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
 	--onto)
 		test 2 -le "$#" || usage
 		newbase="$2"
@@ -107,7 +121,7 @@ # Now we are rebasing commits $upstream.
 
 # Check if we are already based on $onto, but this should be
 # done only when upstream and onto are the same.
-if test "$upstream" = "onto"
+if test "$upstream" = "$onto"
 then
 	mb=$(git-merge-base "$onto" "$branch")
 	if test "$mb" = "$onto"
-- 
1.3.0.gb009
