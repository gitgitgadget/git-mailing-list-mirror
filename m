From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/6] Convert pack-objects.c to the new sorted-array API.
Date: Wed,  8 Dec 2010 23:51:33 +0100
Message-ID: <1291848695-24601-5-git-send-email-ydirson@altern.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSs4-0003GC-ON
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab0LHWvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:53 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49507 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab0LHWvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:52 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 162A9D48125;
	Wed,  8 Dec 2010 23:51:45 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQSrL-0006Pr-4N; Wed, 08 Dec 2010 23:51:39 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163234>

In this file the "list size" variable was named in a non-standard way.
The new API forces to use a more common convention.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 builtin/pack-objects.c |   50 +++++++++++++----------------------------------
 1 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f027b3a..c26175c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "sorted-array.h"
 
 #ifndef NO_PTHREADS
 #include <pthread.h>
@@ -871,45 +872,22 @@ static void add_pbase_object(struct tree_desc *tree,
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
+declare_sorted_array_insertonly_checkbool(static, unsigned, check_pbase_path,
+					  unsigned,
+					  done_pbase_paths, unsigned_cmp, unsigned_init);
 
 static void add_preferred_base_object(const char *name)
 {
@@ -987,7 +965,7 @@ static void cleanup_preferred_base(void)
 
 	free(done_pbase_paths);
 	done_pbase_paths = NULL;
-	done_pbase_paths_num = done_pbase_paths_alloc = 0;
+	done_pbase_paths_nr = done_pbase_paths_alloc = 0;
 }
 
 static void check_object(struct object_entry *entry)
-- 
1.7.2.3
