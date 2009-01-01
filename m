From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Thu,  1 Jan 2009 21:54:32 +0100
Message-ID: <1230843273-11056-3-git-send-email-drizzd@aon.at>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 21:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUaU-0004GO-R4
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbZAAUyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbZAAUyw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:54:52 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:10351 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbZAAUyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 15:54:51 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 21:54:48 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LIUYr-0002wM-Nk; Thu, 01 Jan 2009 21:54:33 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1230843273-11056-2-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 01 Jan 2009 20:54:48.0855 (UTC) FILETIME=[2F4ED270:01C96C53]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104318>

Commit 0cf73755 (unpack-trees.c: assume submodules are clean during
check-out) changed an argument to verify_absent from 'path' to 'ce',
which is however shadowed by a local variable of the same name.

The bug triggers if verify_absent is used on a tree entry, for which
the index contains one or more subsequent directories of the same
length. The affected subdirectories are removed from the index. The
testcase included in this commit bisects to 55218834 (checkout: do not
lose staged removal), which reveals the bug in this case, but is
otherwise unrelated.
---
 t/t1001-read-tree-m-2way.sh |   27 +++++++++++++++++++++++++++
 unpack-trees.c              |   23 ++++++++++++-----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 7f6ab31..271bc4e 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -365,4 +365,31 @@ test_expect_success \
      git ls-files --stage &&
      test -f a/b'
 
+test_expect_success \
+    'a/b vs a, plus c/d case setup.' \
+    'rm -f .git/index &&
+     rm -fr a &&
+     : >a &&
+     mkdir c &&
+     : >c/d &&
+     git update-index --add a c/d &&
+     treeM=`git write-tree` &&
+     echo treeM $treeM &&
+     git ls-tree $treeM &&
+     git ls-files --stage >treeM.out &&
+
+     rm -f a &&
+     mkdir a
+     : >a/b &&
+     git update-index --add --remove a a/b &&
+     treeH=`git write-tree` &&
+     echo treeH $treeH &&
+     git ls-tree $treeH'
+
+test_expect_success \
+    'a/b vs a, plus c/d case test.' \
+    'git read-tree -u -m "$treeH" "$treeM" &&
+     git ls-files --stage | tee >treeMcheck.out &&
+     test_cmp treeM.out treeMcheck.out'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index a736947..f8e2484 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -289,7 +289,8 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 	return 0;
 }
 
-static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+static int unpack_callback(int n, unsigned long mask, unsigned long dirmask,
+		struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[5] = { NULL, };
 	struct unpack_trees_options *o = info->data;
@@ -517,22 +518,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	namelen = strlen(ce->name);
 	pos = index_name_pos(o->src_index, ce->name, namelen);
 	if (0 <= pos)
-		return cnt; /* we have it as nondirectory */
+		return 0; /* we have it as nondirectory */
 	pos = -pos - 1;
 	for (i = pos; i < o->src_index->cache_nr; i++) {
-		struct cache_entry *ce = o->src_index->cache[i];
-		int len = ce_namelen(ce);
+		struct cache_entry *ce2 = o->src_index->cache[i];
+		int len = ce_namelen(ce2);
 		if (len < namelen ||
-		    strncmp(ce->name, ce->name, namelen) ||
-		    ce->name[namelen] != '/')
+		    strncmp(ce->name, ce2->name, namelen) ||
+		    ce2->name[namelen] != '/')
 			break;
 		/*
-		 * ce->name is an entry in the subdirectory.
+		 * ce2->name is an entry in the subdirectory.
 		 */
-		if (!ce_stage(ce)) {
-			if (verify_uptodate(ce, o))
+		if (!ce_stage(ce2)) {
+			if (verify_uptodate(ce2, o))
 				return -1;
-			add_entry(o, ce, CE_REMOVE, 0);
+			add_entry(o, ce2, CE_REMOVE, 0);
 		}
 		cnt++;
 	}
@@ -624,7 +625,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 			 * If this removed entries from the index,
 			 * what that means is:
 			 *
-			 * (1) the caller unpack_trees_rec() saw path/foo
+			 * (1) the caller unpack_callback() saw path/foo
 			 * in the index, and it has not removed it because
 			 * it thinks it is handling 'path' as blob with
 			 * D/F conflict;
-- 
1.6.1
