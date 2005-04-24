From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [RFC] updates for git-pull-script
Date: Sun, 24 Apr 2005 09:14:29 -0500
Message-ID: <1114352069.4997.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 16:10:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPho0-0005e8-Hm
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 16:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVDXOOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 10:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVDXOOn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 10:14:43 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:4326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261604AbVDXOOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 10:14:39 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3OEEVA31073;
	Sun, 24 Apr 2005 10:14:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current git-pull-script has several behaviours that always trip me
up

1) when pulling from a local tree, you have to remember to append
the .git/ directory to the base
2) It always tries to checkout the files ... this drives me nuts since I
don't have a lot of space on my laptop so I keep most trees empty.
3) It doesn't attempt a more sophisticated merge.  The SCSI tree seems
to be the one that always has added or removed files.  Since I think
git-merge-one-file-script is reasonably trustworthy, I made automatic
merges using it one of the pull features.
4) It doesn't remember the old head.  This is useful for unpulling
(pruning back to if the merge misfires) or simply seeing the changes
between the old and new heads.

The attached addresses all these points.  It's what I use, but since
others may prefer the original behaviour, I'm sending it as a straw
horse.

James

--- a/git-pull-script
+++ b/git-pull-script
@@ -3,9 +3,17 @@
 # use "$1" or something in a real script, this 
 # just hard-codes it.
 #
-merge_repo=$1
+merge_repo="$1"
+
+[  -d .git ] || die
+
+if [ -d "$merge_repo" -a -d "$merge_repo/.git" ]; then
+	merge_repo="$merge_repo/.git"
+fi
 
 rm -f .git/MERGE_HEAD
+rm -f .git/OLD_HEAD
+cp .git/HEAD .git/OLD_HEAD
 
 echo "Getting object database"
 rsync -avz --ignore-existing $merge_repo/objects/. .git/objects/.
@@ -32,17 +40,22 @@ if [ "$common" == "$merge_head" ]; then
 fi
 if [ "$common" == "$head" ]; then
 	echo "Updating from $head to $merge_head."
-	echo "Destroying all noncommitted data!"
-	echo "Kill me within 3 seconds.."
-	sleep 3
-	read-tree -m $merge_tree && checkout-cache -f -a && update-cache --refresh
+	echo "Reading the current tree"
+	read-tree -m $merge_tree || exit 1
 	echo $merge_head > .git/HEAD
 	exit 0
 fi
 echo "Trying to merge $merge_head into $head"
 read-tree -m $common_tree $head_tree $merge_tree
-result_tree=$(write-tree) || exit 1
-result_commit=$(echo "Merge $merge_repo" | commit-tree $result_tree -p $head -p $merge_head)
+merge_msg="Merge $merge_repo"
+result_tree=$(write-tree 2>/dev/null)
+if [ $? -ne 0 ]; then
+	echo "Simple merge failed, trying Automatic merge"
+	merge-cache git-merge-one-file-script -a
+	merge_msg="Automatic merge of $merge_repo"
+	result_tree=$(write-tree) || exit 1
+fi
+result_commit=$(echo $merge_msg | commit-tree $result_tree -p $head -p $merge_head)
 echo "Committed merge $result_commit"
 echo $result_commit > .git/HEAD
-checkout-cache -f -a && update-cache --refresh
+#checkout-cache -f -a && update-cache --refresh


