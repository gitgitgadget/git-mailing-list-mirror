From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] unpack-trees: handle failure in verify_absent
Date: Thu,  1 Jan 2009 21:54:31 +0100
Message-ID: <1230843273-11056-2-git-send-email-drizzd@aon.at>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 21:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUaU-0004GO-1o
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZAAUys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZAAUys
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:54:48 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:10325 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZAAUyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 15:54:47 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 21:54:41 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LIUYr-0002wK-Mx; Thu, 01 Jan 2009 21:54:33 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1230843273-11056-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 01 Jan 2009 20:54:43.0808 (UTC) FILETIME=[2C4CB600:01C96C53]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104319>

Commit 203a2fe1 (Allow callers of unpack_trees() to handle failure)
changed the "die on error" behavior to "return failure code".
verify_absent did not handle errors returned by
verify_clean_subdirectory, however.
---
 t/t1001-read-tree-m-2way.sh |   24 ++++++++++++++++++++++++
 unpack-trees.c              |    8 +++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 4b44e13..7f6ab31 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -341,4 +341,28 @@ test_expect_success \
      check_cache_at DF/DF dirty &&
      :'
 
+test_expect_success \
+    'a/b (untracked) vs a case setup.' \
+    'rm -f .git/index &&
+     : >a &&
+     git update-index --add a &&
+     treeM=`git write-tree` &&
+     echo treeM $treeM &&
+     git ls-tree $treeM &&
+     git ls-files --stage >treeM.out &&
+
+     rm -f a &&
+     git update-index --remove a &&
+     mkdir a &&
+     : >a/b &&
+     treeH=`git write-tree` &&
+     echo treeH $treeH &&
+     git ls-tree $treeH'
+
+test_expect_success \
+    'a/b (untracked) vs a, plus c/d case test.' \
+    '! git read-tree -u -m "$treeH" "$treeM" &&
+     git ls-files --stage &&
+     test -f a/b'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301d..a736947 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -588,7 +588,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		int cnt;
+		int ret;
 		int dtype = ce_to_dtype(ce);
 		struct cache_entry *result;
 
@@ -616,7 +616,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(ce, action, o);
+			ret = verify_clean_subdirectory(ce, action, o);
+			if (ret < 0)
+				return ret;
 
 			/*
 			 * If this removed entries from the index,
@@ -635,7 +637,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 			 * We need to increment it by the number of
 			 * deleted entries here.
 			 */
-			o->pos += cnt;
+			o->pos += ret;
 			return 0;
 		}
 
-- 
1.6.1
