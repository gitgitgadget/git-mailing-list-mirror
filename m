From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 6/6] [WIP] subvert sorted-array to replace binary-search in unpack-objects.
Date: Sun,  5 Dec 2010 11:34:07 +0100
Message-ID: <1291545247-4151-7-git-send-email-ydirson@altern.org>
References: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 11:34:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPBvd-0002k7-0l
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab0LEKee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:34:34 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:40181 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0LEKe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:34:28 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 2FDFDD480BF;
	Sun,  5 Dec 2010 11:34:21 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPBv8-00016A-P5; Sun, 05 Dec 2010 11:34:18 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162936>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 builtin/unpack-objects.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..b0c15e6 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -11,6 +11,7 @@
 #include "progress.h"
 #include "decorate.h"
 #include "fsck.h"
+#include "sorted-array.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
@@ -157,7 +158,25 @@ struct obj_info {
 #define FLAG_OPEN (1u<<20)
 #define FLAG_WRITTEN (1u<<21)
 
-static struct obj_info *obj_list;
+/*
+ * FIXME: obj_info is a sorted array, but we read it as a whole, we
+ * don't need insertion features.  This allows us to abuse unused
+ * obj_info_nr later as a means of specifying an upper bound for
+ * binary search.  obj_info_alloc shall be eliminated by the compiler
+ * as unused.
+ */
+static int obj_info_cmp(off_t ref, struct obj_info *elem)
+{
+	if (ref == elem->offset)
+		return 0;
+	if (ref < elem->offset)
+		return -1;
+	return 1;
+}
+declare_sorted_array(static, struct obj_info, obj_list);
+declare_gen_binsearch(static, struct obj_info, _obj_list_check, off_t);
+declare_sorted_array_search_check(static, obj_list_check, off_t, _obj_list_check,
+				  obj_list, obj_info_cmp);
 static unsigned nr_objects;
 
 /*
@@ -356,7 +375,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		unsigned base_found = 0;
 		unsigned char *pack, c;
 		off_t base_offset;
-		unsigned lo, mid, hi;
+		int pos;
 
 		pack = fill(1);
 		c = *pack;
@@ -380,19 +399,11 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			free(delta_data);
 			return;
 		}
-		lo = 0;
-		hi = nr;
-		while (lo < hi) {
-			mid = (lo + hi)/2;
-			if (base_offset < obj_list[mid].offset) {
-				hi = mid;
-			} else if (base_offset > obj_list[mid].offset) {
-				lo = mid + 1;
-			} else {
-				hashcpy(base_sha1, obj_list[mid].sha1);
-				base_found = !is_null_sha1(base_sha1);
-				break;
-			}
+		obj_list_nr = nr; /* kludge to bound the search */
+		pos = obj_list_check(base_offset);
+		if (pos >= 0) {
+			hashcpy(base_sha1, obj_list[pos].sha1);
+			base_found = !is_null_sha1(base_sha1);
 		}
 		if (!base_found) {
 			/*
-- 
1.7.2.3
