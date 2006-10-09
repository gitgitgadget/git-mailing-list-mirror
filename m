From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Sun, 08 Oct 2006 22:48:06 -0700
Message-ID: <7v8xjqdoq1.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
	<7v7izaf62c.fsf@assigned-by-dhcp.cox.net>
	<7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 07:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWnzr-0003bI-53
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 07:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWJIFsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWJIFsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 01:48:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62373 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932236AbWJIFsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 01:48:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009054807.DIJQ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 01:48:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y5o91V00L1kojtg0000000
	Mon, 09 Oct 2006 01:48:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vodsmdq0m.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Oct 2006 22:20:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28563>

The three-way merge complained unconditionally when a path that
does not exist in the index is involved in a merge when it
existed in the working tree.  If we are merging an old version
that had that path tracked, but the path is not tracked anymore,
and if we are merging that old version in, the result will be
that the path is not tracked.  In that case we should not
complain.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Consolidated patch to summarize a few crapoids I sent out
   tonight.

   The change to merge-one-file still does not do .gitignore
   check but that is easy to add once we know this is the right
   direction to go, which I am not sure yet.  If we can convince
   ourselves that this is the right direction we should update
   merge-recursive as well.

 git-merge-one-file.sh       |   16 ++++++++++++-
 t/t1004-read-tree-m-u-wf.sh |   53 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c              |    2 -
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index fba4b0c..74ad4f2 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -23,6 +23,12 @@ #
 "$1.." | "$1.$1" | "$1$1.")
 	if [ "$2" ]; then
 		echo "Removing $4"
+	else
+		# read-tree checked that index matches HEAD already,
+		# so we know we do not have this path tracked.
+		# there may be an unrelated working tree file here,
+		# which we should just leave unmolested.
+		exit 0
 	fi
 	if test -f "$4"; then
 		rm -f -- "$4" &&
@@ -34,8 +40,16 @@ #
 #
 # Added in one.
 #
-".$2." | "..$3" )
+".$2.")
+	# the other side did not add and we added so there is nothing
+	# to be done.
+	;;
+"..$3")
 	echo "Adding $4"
+	test -f "$4" || {
+		echo "ERROR: untracked $4 is overwritten by the merge."
+		exit 1
+	}
 	git-update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
 		exec git-checkout-index -u -f -- "$4"
 	;;
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
new file mode 100755
index 0000000..018fbea
--- /dev/null
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='read-tree -m -u checks working tree files'
+
+. ./test-lib.sh
+
+# two-tree test
+
+test_expect_success 'two-way setup' '
+
+	echo >file1 file one &&
+	echo >file2 file two &&
+	git update-index --add file1 file2 &&
+	git commit -m initial &&
+
+	git branch side &&
+	git tag -f branch-point &&
+
+	echo file2 is not tracked on the master anymore &&
+	rm -f file2 &&
+	git update-index --remove file2 &&
+	git commit -a -m "master removes file2"
+'
+
+test_expect_success 'two-way not clobbering' '
+
+	echo >file2 master creates untracked file2 &&
+	if err=`git read-tree -m -u master side 2>&1`
+	then
+		echo should have complained
+		false
+	else
+		echo "happy to see $err"
+	fi
+'
+
+# three-tree test
+
+test_expect_success 'three-way not complaining' '
+
+	rm -f file2 &&
+	git checkout side &&
+	echo >file3 file three &&
+	git update-index --add file3 &&
+	git commit -a -m "side adds file3" &&
+
+	git checkout master &&
+	echo >file2 file two is untracked on the master side &&
+
+	git-read-tree -m -u branch-point master side
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ac0289..b1d78b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -661,8 +661,6 @@ int threeway_merge(struct cache_entry **
 	if (index) {
 		verify_uptodate(index, o);
 	}
-	else if (path)
-		verify_absent(path, "overwritten", o);
 
 	o->nontrivial_merge = 1;
 
-- 
1.4.2.3.g2c59
