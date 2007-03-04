From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: more detailed merge discussion
Date: Sun,  4 Mar 2007 16:59:15 -0500
Message-ID: <11730455601849-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu> <11730455592152-git-send-email-bfields@citi.umich.edu> <11730455602463-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysm-00081f-Tx
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbXCDWI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXCDWI1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:27 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752661AbXCDWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:24 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxLpj006639;
	Sun, 4 Mar 2007 16:59:21 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxKST006638;
	Sun, 4 Mar 2007 16:59:20 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11730455602463-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41379>

From: J. Bruce Fields <bfields@citi.umich.edu>

Add more details on conflict, including brief discussion of file stages.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |  102 +++++++++++++++++++++++++++++++----------
 1 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 907f122..ffd673e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1168,18 +1168,46 @@ the working tree in a special state that gives you all the
 information you need to help resolve the merge.
 
 Files with conflicts are marked specially in the index, so until you
-resolve the problem and update the index, git commit will fail:
+resolve the problem and update the index, gitlink:git-commit[1] will
+fail:
 
 -------------------------------------------------
 $ git commit
 file.txt: needs merge
 -------------------------------------------------
 
-Also, git status will list those files as "unmerged".
+Also, gitlink:git-status[1] will list those files as "unmerged", and the
+files with conflicts will have conflict markers added, like this:
+
+-------------------------------------------------
+<<<<<<< HEAD:file.txt
+Hello world
+=======
+Goodbye
+>>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
+-------------------------------------------------
+
+All you need to do is edit the files to resolve the conflicts, and then
+
+-------------------------------------------------
+$ git add file.txt
+$ git commit
+-------------------------------------------------
+
+Note that the commit message will already be filled in for you with
+some information about the merge.  Normally you can just use this
+default message unchanged, but you may add additional commentary of
+your own if desired.
+
+The above is all you need to know to resolve a simple merge.  But git
+also provides more information to help resolve conflicts:
+
+Getting conflict-resolution help during a merge
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 All of the changes that git was able to merge automatically are
 already added to the index file, so gitlink:git-diff[1] shows only
-the conflicts.  Also, it uses a somewhat unusual syntax:
+the conflicts.  It uses an unusual syntax:
 
 -------------------------------------------------
 $ git diff
@@ -1200,14 +1228,32 @@ conflict will have two parents instead of the usual one: one parent
 will be HEAD, the tip of the current branch; the other will be the
 tip of the other branch, which is stored temporarily in MERGE_HEAD.
 
-The diff above shows the differences between the working-tree version
-of file.txt and two previous versions: one version from HEAD, and one
-from MERGE_HEAD.  So instead of preceding each line by a single "+"
-or "-", it now uses two columns: the first column is used for
-differences between the first parent and the working directory copy,
-and the second for differences between the second parent and the
-working directory copy.  Thus after resolving the conflict in the
-obvious way, the diff will look like:
+During the merge, the index holds three versions of each file.  Each of
+these three "file stages" represents a different version of the file:
+
+-------------------------------------------------
+$ git show :1:file.txt	# the file in a common ancestor of both branches
+$ git show :2:file.txt	# the version from HEAD, but including any
+			# nonconflicting changes from MERGE_HEAD
+$ git show :3:file.txt	# the version from MERGE_HEAD, but including any
+			# nonconflicting changes from HEAD.
+-------------------------------------------------
+
+Since the stage 2 and stage 3 versions have already been updated with
+nonconflicting changes, the only remaining differences between them are
+the important ones; thus gitlink:git-diff[1] can use the information in
+the index to show only those conflicts.
+
+The diff above shows the differences between the working-tree version of
+file.txt and the stage 2 and stage 3 versions.  So instead of preceding
+each line by a single "+" or "-", it now uses two columns: the first
+column is used for differences between the first parent and the working
+directory copy, and the second for differences between the second parent
+and the working directory copy.  (See the "COMBINED DIFF FORMAT" section
+of gitlink:git-diff-files[1] for a details of the format.)
+
+After resolving the conflict in the obvious way (but before updating the
+index), the diff will look like:
 
 -------------------------------------------------
 $ git diff
@@ -1225,26 +1271,37 @@ This shows that our resolved version deleted "Hello world" from the
 first parent, deleted "Goodbye" from the second parent, and added
 "Goodbye world", which was previously absent from both.
 
-The gitlink:git-log[1] command also provides special help for merges:
+Some special diff options allow diffing the working directory against
+any of these stages:
+
+-------------------------------------------------
+$ git diff -1 file.txt		# diff against stage 1
+$ git diff --base file.txt	# same as the above
+$ git diff -2 file.txt		# diff against stage 2
+$ git diff --ours file.txt	# same as the above
+$ git diff -3 file.txt		# diff against stage 3
+$ git diff --theirs file.txt	# same as the above.
+-------------------------------------------------
+
+The gitlink:git-log[1] and gitk[1] commands also provide special help
+for merges:
 
 -------------------------------------------------
 $ git log --merge
+$ gitk --merge
 -------------------------------------------------
 
-This will list all commits which exist only on HEAD or on MERGE_HEAD,
-and which touch an unmerged file.
+These will display all commits which exist only on HEAD or on
+MERGE_HEAD, and which touch an unmerged file.
 
-We can now add the resolved version to the index and commit:
+Each time you resolve the conflicts in a file and update the index:
 
 -------------------------------------------------
 $ git add file.txt
-$ git commit
 -------------------------------------------------
 
-Note that the commit message will already be filled in for you with
-some information about the merge.  Normally you can just use this
-default message unchanged, but you may add additional commentary of
-your own if desired.
+the different stages of that file will be "collapsed", after which
+git-diff will (by default) no longer show diffs for that file.
 
 [[undoing-a-merge]]
 undoing a merge
@@ -2988,11 +3045,6 @@ provides.
 Simplify beginning by suggesting disconnected head instead of
 temporary branch creation?
 
-Explain how to refer to file stages in the "how to resolve a merge"
-section: diff -1, -2, -3, --ours, --theirs :1:/path notation.  The
-"git ls-files --unmerged --stage" thing is sorta useful too,
-actually.  And note gitk --merge.
-
 Add more good examples.  Entire sections of just cookbook examples
 might be a good idea; maybe make an "advanced examples" section a
 standard end-of-chapter section?
-- 
1.5.0.gb75812-dirty
