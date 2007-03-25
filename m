From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use diff* with --exit-code in git-am, git-rebase and git-merge-ours
Date: Sun, 25 Mar 2007 01:56:13 +0100
Message-ID: <20070325005613.GE11507@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 01:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVH1u-00062E-4l
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 01:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbXCYA4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbXCYA4P
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 20:56:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:17225 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbXCYA4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 20:56:14 -0400
Received: from tigra.home (Fc89f.f.strato-dslnet.de [195.4.200.159])
	by post.webmailer.de (mrclete mo23) (RZmta 5.4)
	with ESMTP id B031f9j2OMZBNQ ; Sun, 25 Mar 2007 01:56:13 +0100 (MET)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 31B82277B6;
	Sun, 25 Mar 2007 01:56:13 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 2EC3BBF79; Sun, 25 Mar 2007 01:56:13 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a4mM=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43026>

This simplifies the shell code, reduces its memory footprint, and
speeds things up. The performance improvements should be noticable
when git-rebase works on big commits.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-am.sh         |   18 +++++++-----------
 git-merge-ours.sh |    2 +-
 git-rebase.sh     |   10 ++++------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 88af8dd..e69ecbf 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -408,12 +408,10 @@ do
 		# trust what the user has in the index file and the
 		# working tree.
 		resolved=
-		changed="$(git-diff-index --cached --name-only HEAD)"
-		if test '' = "$changed"
-		then
+		git-diff-index --quiet --cached HEAD && {
 			echo "No changes - did you forget to use 'git add'?"
 			stop_here_user_resolve $this
-		fi
+		}
 		unmerged=$(git-ls-files -u)
 		if test -n "$unmerged"
 		then
@@ -435,13 +433,11 @@ do
 		then
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
-		    changed="$(git-diff-index --cached --name-only HEAD)"
-		    if test '' = "$changed"
-		    then
-			    echo No changes -- Patch already applied.
-			    go_next
-			    continue
-		    fi
+		    git-diff-index --quiet --cached HEAD && {
+			echo No changes -- Patch already applied.
+			go_next
+			continue
+		    }
 		    # clear apply_status -- we have successfully merged.
 		    apply_status=0
 		fi
diff --git a/git-merge-ours.sh b/git-merge-ours.sh
index 4f3d053..2b6a5c0 100755
--- a/git-merge-ours.sh
+++ b/git-merge-ours.sh
@@ -9,6 +9,6 @@
 # because the current index is what we will be committing as the
 # merge result.
 
-test "$(git-diff-index --cached --name-status HEAD)" = "" || exit 2
+git-diff-index --quiet --cached HEAD || exit 2
 
 exit 0
diff --git a/git-rebase.sh b/git-rebase.sh
index aadd580..1d96f32 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,7 +59,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	if test -n "`git-diff-index HEAD`"
+	if ! git-diff-index --quiet HEAD
 	then
 		if ! git-commit -C "`cat $dotest/current`"
 		then
@@ -124,13 +124,11 @@ while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	--continue)
-		diff=$(git-diff-files)
-		case "$diff" in
-		?*)	echo "You must edit all merge conflicts and then"
+		git-diff-files --quiet || {
+			echo "You must edit all merge conflicts and then"
 			echo "mark them as resolved using git update-index"
 			exit 1
-			;;
-		esac
+		}
 		if test -d "$dotest"
 		then
 			prev_head="`cat $dotest/prev_head`"
-- 
1.5.1.rc1.63.g59cc5
