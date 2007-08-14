From: Junio C Hamano <gitster@pobox.com>
Subject: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 15:33:07 -0700
Message-ID: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 00:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL4x6-00075E-5C
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 00:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbXHNWdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 18:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbXHNWdS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 18:33:18 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38891 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbXHNWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 18:33:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814223314.FDUW21830.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 18:33:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id byZC1X00X1kojtg0000000; Tue, 14 Aug 2007 18:33:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55860>

When you try to merge a path that involves binary file-level
merge, merge-recursive died rudely without cleaning up its own
mess.  A files added by the merge were left in the working tree,
but the index was not written out (because it just punted and
died), so it was cumbersome for the user to retry it by first
running "git reset --hard".

This changes merge-recursive to still warn but do the "binary"
merge for such a path; leave the "our" version in the working
tree, but still keep the path unmerged so that the user can sort
it out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c       |   51 +++++++++++++++++++----------------
 t/t6027-merge-binary.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f7d1b84..5326d7c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -677,6 +677,26 @@ struct ll_merge_driver {
 /*
  * Built-in low-levels
  */
+static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
+			   const char *path_unused,
+			   mmfile_t *orig,
+			   mmfile_t *src1, const char *name1,
+			   mmfile_t *src2, const char *name2,
+			   mmbuffer_t *result)
+{
+	/*
+	 * The tentative merge result is "ours" for the final round,
+	 * or common ancestor for an internal merge.  Still return
+	 * "conflicted merge" status.
+	 */
+	mmfile_t *stolen = index_only ? orig : src1;
+
+	result->ptr = stolen->ptr;
+	result->size = stolen->size;
+	stolen->ptr = NULL;
+	return 1;
+}
+
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			const char *path_unused,
 			mmfile_t *orig,
@@ -687,10 +707,15 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	xpparam_t xpp;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
-			buffer_is_binary(src1->ptr, src1->size) ||
-			buffer_is_binary(src2->ptr, src2->size))
-		return error("Cannot merge binary files: %s vs. %s\n",
+	    buffer_is_binary(src1->ptr, src1->size) ||
+	    buffer_is_binary(src2->ptr, src2->size)) {
+		warning("Cannot merge binary files: %s vs. %s\n",
 			name1, name2);
+		return ll_binary_merge(drv_unused, path_unused,
+				       orig, src1, name1,
+				       src2, name2,
+				       result);
+	}
 
 	memset(&xpp, 0, sizeof(xpp));
 	return xdl_merge(orig,
@@ -743,26 +768,6 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	return 0;
 }
 
-static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
-			   const char *path_unused,
-			   mmfile_t *orig,
-			   mmfile_t *src1, const char *name1,
-			   mmfile_t *src2, const char *name2,
-			   mmbuffer_t *result)
-{
-	/*
-	 * The tentative merge result is "ours" for the final round,
-	 * or common ancestor for an internal merge.  Still return
-	 * "conflicted merge" status.
-	 */
-	mmfile_t *stolen = index_only ? orig : src1;
-
-	result->ptr = stolen->ptr;
-	result->size = stolen->size;
-	stolen->ptr = NULL;
-	return 1;
-}
-
 #define LL_BINARY_MERGE 0
 #define LL_TEXT_MERGE 1
 #define LL_UNION_MERGE 2
diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
new file mode 100755
index 0000000..a7358f7
--- /dev/null
+++ b/t/t6027-merge-binary.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='ask merge-recursive to merge binary files'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	cat ../test4012.png >m &&
+	git add m &&
+	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
+	test_tick &&
+	git commit -m "initial" &&
+
+	git branch side &&
+	echo frotz >a &&
+	git add a &&
+	echo nitfol >>m &&
+	git add a m &&
+	git ls-files -s a >E0 &&
+	git ls-files -s m | sed -e "s/ 0	/ 3	/" >E3 &&
+	test_tick &&
+	git commit -m "master adds some" &&
+
+	git checkout side &&
+	echo rezrov >>m &&
+	git add m &&
+	git ls-files -s m | sed -e "s/ 0	/ 2	/" >E2 &&
+	test_tick &&
+	git commit -m "side modifies" &&
+
+	git tag anchor &&
+
+	cat E0 E1 E2 E3 >expect
+'
+
+test_expect_success resolve '
+
+	rm -f a* m* &&
+	git reset --hard anchor &&
+
+	if git merge -s resolve master
+	then
+		echo Oops, should not have succeeded
+		false
+	else
+		git ls-files -s >current
+		diff -u current expect
+	fi
+'
+
+test_expect_success recursive '
+
+	rm -f a* m* &&
+	git reset --hard anchor &&
+
+	if git merge -s recursive master
+	then
+		echo Oops, should not have succeeded
+		false
+	else
+		git ls-files -s >current
+		diff -u current expect
+	fi
+'
+
+test_done
