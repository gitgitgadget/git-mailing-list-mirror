From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add file checkout progress
Date: Mon, 23 Apr 2007 13:17:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704231311540.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2AF-0004oV-LV
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030672AbXDWRRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbXDWRRV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:17:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30875 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030672AbXDWRRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:17:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGY00KAJO0VNU20@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Apr 2007 13:17:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45339>

It is nice to see what is happening when checking out large amount of 
files, either with git-checkout or git-reset.  The new progress code 
already decides what is a "significant amount" and displays progress 
only in that case..

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/git-checkout.sh b/git-checkout.sh
index deb0a9a..ed7c2c5 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -17,6 +17,7 @@ newbranch=
 newbranch_log=
 merge=
 quiet=
+v=-v
 LF='
 '
 while [ "$#" != "0" ]; do
@@ -47,6 +48,7 @@ while [ "$#" != "0" ]; do
 		;;
 	"-q")
 		quiet=1
+		v=
 		;;
 	--)
 		break
@@ -197,7 +199,7 @@ fi
 
 if [ "$force" ]
 then
-    git-read-tree --reset -u $new
+    git-read-tree $v --reset -u $new
 else
     git-update-index --refresh >/dev/null
     merge_error=$(git-read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
@@ -210,7 +212,7 @@ else
 	# Match the index to the working tree, and do a three-way.
     	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
-	git read-tree --reset -u $new || exit
+	git read-tree $v --reset -u $new || exit
 
 	eval GITHEAD_$new='${new_name:-${branch:-$new}}' &&
 	eval GITHEAD_$work=local &&
@@ -221,7 +223,7 @@ else
 	# this is not a real merge before committing, but just carrying
 	# the working tree changes along.
 	unmerged=`git ls-files -u`
-	git read-tree --reset $new
+	git read-tree $v --reset $new
 	case "$unmerged" in
 	'')	;;
 	*)
diff --git a/git-reset.sh b/git-reset.sh
index fee6d98..a172d7c 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -71,7 +71,7 @@ then
 		die "Cannot do a soft reset in the middle of a merge."
 	fi
 else
-	git-read-tree --reset $update "$rev" || exit
+	git-read-tree -v --reset $update "$rev" || exit
 fi
 
 # Any resets update HEAD to the head being switched to.
