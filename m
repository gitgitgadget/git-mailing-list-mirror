From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/6] Convert pack-objects.c to the new sorted-array API.
Date: Sun,  5 Dec 2010 11:34:05 +0100
Message-ID: <1291545247-4151-5-git-send-email-ydirson@altern.org>
References: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 11:34:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPBvd-0002k7-IF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0LEKef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:34:35 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:40269 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255Ab0LEKeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:34:31 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 8E119D481E8;
	Sun,  5 Dec 2010 11:34:25 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPBv8-000164-KD; Sun, 05 Dec 2010 11:34:18 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162937>

In this file the "list size" variable was named in a non-standard way.
The new API forces to use a more common convention.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 builtin/pack-objects.c |   51 ++++++++++++++---------------------------------
 1 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3cbeb29..887a55c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "sorted-array.h"
 
 #ifndef NO_PTHREADS
 #include <pthread.h>
@@ -871,45 +872,23 @@ static void add_pbase_object(struct tree_desc *tree,
 	}
 }
 
-static unsigned *done_pbase_paths;
-static int done_pbase_paths_num;
-static int done_pbase_paths_alloc;
-static int done_pbase_path_pos(unsigned hash)
+static int unsigned_cmp(unsigned ref, unsigned *elem)
 {
-	int lo = 0;
-	int hi = done_pbase_paths_num;
-	while (lo < hi) {
-		int mi = (hi + lo) / 2;
-		if (done_pbase_paths[mi] == hash)
-			return mi;
-		if (done_pbase_paths[mi] < hash)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo-1;
+	if (ref == *elem)
+		return 0;
+	if (ref < *elem)
+		return -1;
+	return 1;
 }
-
-static int check_pbase_path(unsigned hash)
+static void unsigned_init(unsigned *elem, unsigned ref)
 {
-	int pos = (!done_pbase_paths) ? -1 : done_pbase_path_pos(hash);
-	if (0 <= pos)
-		return 1;
-	pos = -pos - 1;
-	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
-		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths = xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
-	done_pbase_paths_num++;
-	if (pos < done_pbase_paths_num)
-		memmove(done_pbase_paths + pos + 1,
-			done_pbase_paths + pos,
-			(done_pbase_paths_num - pos - 1) * sizeof(unsigned));
-	done_pbase_paths[pos] = hash;
-	return 0;
+	*elem = ref;
 }
+declare_sorted_array(static, unsigned, done_pbase_paths);
+declare_gen_binsearch(static, unsigned, done_pbase_path_pos, unsigned);
+declare_gen_sorted_insert(static, unsigned, _check_pbase_path, done_pbase_path_pos, unsigned);
+declare_sorted_array_insert_checkbool(static, check_pbase_path, unsigned, _check_pbase_path,
+				      done_pbase_paths, unsigned_cmp, unsigned_init);
 
 static void add_preferred_base_object(const char *name)
 {
@@ -987,7 +966,7 @@ static void cleanup_preferred_base(void)
 
 	free(done_pbase_paths);
 	done_pbase_paths = NULL;
-	done_pbase_paths_num = done_pbase_paths_alloc = 0;
+	done_pbase_paths_nr = done_pbase_paths_alloc = 0;
 }
 
 static void check_object(struct object_entry *entry)
-- 
1.7.2.3
