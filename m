From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Be careful with symlinks when detecting renames and copies.
Date: Sun, 22 May 2005 21:24:49 -0700
Message-ID: <7vhdgubmcu.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vbr73ha2c.fsf@assigned-by-dhcp.cox.net>
	<7vekbzfaze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 06:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da4Tz-000419-6Z
	for gcvg-git@gmane.org; Mon, 23 May 2005 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEWEZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 00:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEWEZF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 00:25:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28154 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261837AbVEWEYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 00:24:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523042451.COBQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 00:24:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbzfaze.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 22 May 2005 10:04:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, this is *not* based on the fixed rename/copy fix I am
going to send out shortly, but comes before that due to patch
dependency (the order I happened to have done things, that is).

Please apply this one before the rename/copy fix.

------------
Earlier round was not treating symbolic links carefully enough,
and would have produced diff output that renamed/copied then
edited the contents of a symbolic link, which made no practical
sense.  Change it to detect only pure renames.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-rename.c              |   24 ++++++++------
t/t4004-diff-rename-symlink.sh |   66 +++++++++++++++++++++++++++++++++++++++++
2 files changed, 80 insertions(+), 10 deletions(-)
new file (100755): t/t4004-diff-rename-symlink.sh

diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -20,7 +20,7 @@ static void diff_rename_pool_add(struct 
 				 struct diff_filespec *s)
 {
 	if (S_ISDIR(s->mode))
-		return;  /* rename/copy patch for tree does not make sense. */
+		return;  /* no trees, please */
 
 	if (pool->alloc <= pool->nr) {
 		pool->alloc = alloc_nr(pool->alloc);
@@ -71,6 +71,13 @@ static int estimate_similarity(struct di
 	unsigned long delta_size, base_size;
 	int score;
 
+	/* We deal only with regular files.  Symlink renames are handled
+	 * only when they are exact matches --- in other words, no edits
+	 * after renaming.
+	 */
+	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
+		return 0;
+
 	delta_size = ((src->size < dst->size) ?
 		      (dst->size - src->size) : (src->size - dst->size));
 	base_size = ((src->size < dst->size) ? src->size : dst->size);
@@ -268,7 +275,7 @@ void diffcore_rename(int detect_rename, 
 		struct diff_filepair *p = q->queue[i];
 		if (!DIFF_FILE_VALID(p->one))
 			if (!DIFF_FILE_VALID(p->two))
-				continue; /* ignore nonsense */
+				continue; /* unmerged */
 			else
 				diff_rename_pool_add(&created, p->two);
 		else if (!DIFF_FILE_VALID(p->two))
@@ -360,12 +367,9 @@ void diffcore_rename(int detect_rename, 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *dp, *p = q->queue[i];
 		if (!DIFF_FILE_VALID(p->one)) {
-			if (DIFF_FILE_VALID(p->two)) {
-				/* creation */
-				dp = diff_queue(&outq, p->one, p->two);
-				dp->xfrm_work = 4;
-			}
-			/* otherwise it is a nonsense; just ignore it */
+			/* creation or unmerged entries */
+			dp = diff_queue(&outq, p->one, p->two);
+			dp->xfrm_work = 4;
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/* deletion */
@@ -394,7 +398,7 @@ void diffcore_rename(int detect_rename, 
 	for (i = 0; i < outq.nr; i++) {
 		struct diff_filepair *p = outq.queue[i];
 		if (!DIFF_FILE_VALID(p->one)) {
-			/* created */
+			/* created or unmerged */
 			if (p->two->xfrm_flags & RENAME_DST_MATCHED)
 				; /* rename/copy created it already */
 			else
@@ -443,7 +447,7 @@ void diffcore_rename(int detect_rename, 
 		else
 			/* otherwise it is a modified (or stayed) entry */
 			diff_queue(q, p->one, p->two);
-		free(p);
+		diff_free_filepair(p);
 	}
 
 	free(outq.queue);
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
new file mode 100755
--- /dev/null
+++ b/t/t4004-diff-rename-symlink.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='More rename detection tests.
+
+The rename detection logic should be able to detect pure rename or
+copy of symbolic links, but should not produce rename/copy followed
+by an edit for them.
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare reference tree' \
+    'echo xyzzy | tr -d '\\\\'012 >yomin &&
+     ln -s xyzzy frotz &&
+    git-update-cache --add frotz yomin &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'mv frotz rezrov &&
+     rm -f yomin &&
+     ln -s xyzzy nitfol &&
+     ln -s xzzzy bozbar &&
+    git-update-cache --add --remove frotz rezrov nitfol bozbar yomin'
+
+# tree has frotz pointing at xyzzy, and yomin that contains xyzzy to
+# confuse things.  work tree has rezrov (xyzzy) nitfol (xyzzy) and
+# bozbar (xzzzy).
+# rezrov and nitfol are rename/copy of frotz and bozbar should be
+# a new creation.
+
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree >current
+cat >expected <<\EOF
+diff --git a/frotz b/nitfol
+similarity index 100%
+copy from frotz
+copy to nitfol
+diff --git a/frotz b/rezrov
+similarity index 100%
+rename old frotz
+rename new rezrov
+diff --git a/yomin b/yomin
+deleted file mode 100644
+--- a/yomin
++++ /dev/null
+@@ -1 +0,0 @@
+-xyzzy
+\ No newline at end of file
+diff --git a/bozbar b/bozbar
+new file mode 120000
+--- /dev/null
++++ b/bozbar
+@@ -0,0 +1 @@
++xzzzy
+\ No newline at end of file
+EOF
+
+test_expect_success \
+    'validate diff output' \
+    'diff -u current expected'
+
+test_done
------------------------------------------------

