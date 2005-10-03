From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Enable and fix support for base less merges.
Date: Mon, 3 Oct 2005 08:13:09 +0200
Message-ID: <20051003061309.GA1712@c165.ib.student.liu.se>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <4340A01F.7040901@gmail.com> <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 08:13:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMJZj-0003qp-6X
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 08:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVJCGNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVJCGNQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 02:13:16 -0400
Received: from [85.8.31.11] ([85.8.31.11]:43708 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932138AbVJCGNP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 02:13:15 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A04C84114; Mon,  3 Oct 2005 08:19:22 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EMJZV-0000yr-00; Mon, 03 Oct 2005 08:13:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9632>

Let the merge strategies handle the base less case if they are able to
do it. It also fixes git-resolve.sh to die if no common ancestors
exists, instead of doing the wrong thing. Furthermore, it contains a
small independent fix for git-merge.sh and a fix for a base less code
path in gitMergeCommon.py.

With this it's possible to use
    git merge -s recursive 'merge message' A B
to do a base less merge of A and B.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-resolve.sh |    6 ++++++
 git-merge.sh         |    4 ++--
 gitMergeCommon.py    |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

d298deec60a0fac7a16f43135f390c285251f613
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -31,6 +31,12 @@ case "$remotes" in
 	exit 2 ;;
 esac
 
+# Give up if this is a baseless merge.
+if test '' == "$bases"
+then
+	exit 2
+fi
+
 git-update-index --refresh 2>/dev/null
 git-read-tree -u -m $bases $head $remotes || exit 2
 echo "Trying simple merge."
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -26,7 +26,7 @@ dropsave() {
 savestate() {
 	# Stash away any local modifications.
 	git-diff-index -r -z --name-only $head |
-	cpio -0 -o >"$GIR_DIR/MERGE_SAVE"
+	cpio -0 -o >"$GIT_DIR/MERGE_SAVE"
 }
 
 restorestate() {
@@ -103,7 +103,7 @@ echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
 case "$#,$common" in
 *,'')
-	die "Unable to find common commit between $head_arg and $*"
+	# No common ancestors found. We need a real merge.
 	;;
 1,"$1")
 	# If head can reach all the merge then we are up to date.
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -213,7 +213,7 @@ def buildGraph(heads):
 
 # Write the empty tree to the object database and return its SHA1
 def writeEmptyTree():
-    tmpIndex = os.environ['GIT_DIR'] + '/merge-tmp-index'
+    tmpIndex = os.environ.get('GIT_DIR', '.git') + '/merge-tmp-index'
     def delTmpIndex():
         try:
             os.unlink(tmpIndex)
