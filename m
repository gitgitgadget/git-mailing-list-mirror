From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 05 Feb 2008 17:14:28 +0200
Organization: Private
Message-ID: <ve53xwob.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 16:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPWj-0003zj-Ky
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYBEPPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYBEPPT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:15:19 -0500
Received: from main.gmane.org ([80.91.229.2]:49102 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYBEPPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:15:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMPVy-0003AW-Kl
	for git@vger.kernel.org; Tue, 05 Feb 2008 15:15:14 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 15:15:14 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 15:15:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:bkcep6Z1SzcQWyPe107BpTqtODw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72667>

Change git specific doings into namespace .git*. Define new variable
WORKDIR, which points to working directory .git-dotest.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 git-rebase.sh |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ec052c4..259096f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -14,7 +14,7 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run git rebase --continue.  Another option is to bypass the commit
 that caused the merge failure with git rebase --skip.  To restore the
-original <branch> and remove the .dotest working files, use the command
+original <branch> and remove the .git-dotest working files, use the command
 git rebase --abort instead.
 
 Note that if <branch> is not specified on the command line, the
@@ -43,7 +43,8 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
 unset newbase
 strategy=recursive
 do_merge=
-dotest=$GIT_DIR/.dotest-merge
+WORKDIR=$GIT_DIR/.git-dotest
+dotest=$WORKDIR-merge
 prec=4
 verbose=
 git_am_opt=
@@ -171,9 +172,9 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat .dotest/head-name) &&
-		onto=$(cat .dotest/onto) &&
-		orig_head=$(cat .dotest/orig-head) &&
+		head_name=$(cat $WORKDIR/head-name) &&
+		onto=$(cat $WORKDIR/onto) &&
+		orig_head=$(cat $WORKDIR/orig-head) &&
 		git am $git_am_opt --resolved --3way \
 		    --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
@@ -197,9 +198,9 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat .dotest/head-name) &&
-		onto=$(cat .dotest/onto) &&
-		orig_head=$(cat .dotest/orig-head) &&
+		head_name=$(cat $WORKDIR/head-name) &&
+		onto=$(cat $WORKDIR/onto) &&
+		orig_head=$(cat $WORKDIR/orig-head) &&
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -210,11 +211,11 @@ do
 		then
 			move_to_original_branch
 			rm -r "$dotest"
-		elif test -d .dotest
+		elif test -d $WORKDIR
 		then
-			dotest=.dotest
+			dotest=$WORKDIR
 			move_to_original_branch
-			rm -r .dotest
+			rm -r $WORKDIR
 		else
 			die "No rebase in progress?"
 		fi
@@ -262,17 +263,17 @@ do
 	shift
 done
 
-# Make sure we do not have .dotest
+# Make sure we do not have $WORKDIR
 if test -z "$do_merge"
 then
-	if mkdir .dotest
+	if mkdir $WORKDIR
 	then
-		rmdir .dotest
+		rmdir $WORKDIR
 	else
 		echo >&2 '
-It seems that I cannot create a .dotest directory, and I wonder if you
+It seems that I cannot create a $WORKDIR directory, and I wonder if you
 are in the middle of patch application or another rebase.  If that is not
-the case, please rm -fr .dotest and run me again.  I am stopping in case
+the case, please rm -fr $WORKDIR and run me again.  I am stopping in case
 you still have something valuable there.'
 		exit 1
 	fi
@@ -381,10 +382,10 @@ then
 	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
-	test 0 != $ret -a -d .dotest &&
-		echo $head_name > .dotest/head-name &&
-		echo $onto > .dotest/onto &&
-		echo $orig_head > .dotest/orig-head
+	test 0 != $ret -a -d $WORKDIR &&
+		echo $head_name > $WORKDIR/head-name &&
+		echo $onto > $WORKDIR/onto &&
+		echo $orig_head > $WORKDIR/orig-head
 	exit $ret
 fi
 
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
