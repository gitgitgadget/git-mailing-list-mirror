From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3 1/3] Introduce sorted-array binary-search function.
Date: Mon,  8 Nov 2010 23:39:00 +0100
Message-ID: <1289255942-19705-2-git-send-email-ydirson@altern.org>
References: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 23:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaN9-0001fg-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0KHWj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:39:26 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:45012 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888Ab0KHWjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:39:14 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5BE65D48101;
	Mon,  8 Nov 2010 23:39:08 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PFaMl-00058b-7H; Mon, 08 Nov 2010 23:39:07 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161001>

We use a cpp-based template mechanism to declare the array and its
management data, as well as a search function, derived from locate_rename_dst()
from diffcore-rename.c.  Thanks to Jonathan Nieder for this design idea.

Naming is kept compatible with the original use of that function.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Makefile          |    1 +
 diffcore-rename.c |   51 +++++++++++++--------------------------------------
 sorted-array.h    |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 38 deletions(-)
 create mode 100644 sorted-array.h

diff --git a/Makefile b/Makefile
index 1f1ce04..fa5b2e6 100644
--- a/Makefile
+++ b/Makefile
@@ -536,6 +536,7 @@ LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
+LIB_H += sorted-array.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
 LIB_H += submodule.h
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..1626bdc 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,52 +5,27 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "sorted-array.h"
 
 /* Table of rename/copy destinations */
 
-static struct diff_rename_dst {
+struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
-} *rename_dst;
-static int rename_dst_nr, rename_dst_alloc;
+};
 
-static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
-						 int insert_ok)
+static int rename_dst_cmp(struct diff_filespec *ref_spec, struct diff_rename_dst *elem)
 {
-	int first, last;
-
-	first = 0;
-	last = rename_dst_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct diff_rename_dst *dst = &(rename_dst[next]);
-		int cmp = strcmp(two->path, dst->two->path);
-		if (!cmp)
-			return dst;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-	/* not found */
-	if (!insert_ok)
-		return NULL;
-	/* insert to make it at "first" */
-	if (rename_dst_alloc <= rename_dst_nr) {
-		rename_dst_alloc = alloc_nr(rename_dst_alloc);
-		rename_dst = xrealloc(rename_dst,
-				      rename_dst_alloc * sizeof(*rename_dst));
-	}
-	rename_dst_nr++;
-	if (first < rename_dst_nr)
-		memmove(rename_dst + first + 1, rename_dst + first,
-			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
-	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
-	rename_dst[first].pair = NULL;
-	return &(rename_dst[first]);
+	return strcmp(ref_spec->path, elem->two->path);
+}
+static void rename_dst_init(struct diff_rename_dst *elem, struct diff_filespec *ref_spec)
+{
+	elem->two = alloc_filespec(ref_spec->path);
+	fill_filespec(elem->two, ref_spec->sha1, ref_spec->mode);
+	elem->pair = NULL;
 }
+declare_sorted_array(static, struct diff_rename_dst, rename_dst,
+		     rename_dst_cmp, rename_dst_init)
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
diff --git a/sorted-array.h b/sorted-array.h
new file mode 100644
index 0000000..03d5d1e
--- /dev/null
+++ b/sorted-array.h
@@ -0,0 +1,36 @@
+#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST,CMP,INIT)	\
+MAYBESTATIC ELEMTYPE *LIST;						\
+MAYBESTATIC int LIST##_nr, LIST##_alloc;				\
+MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
+{									\
+	int first, last;						\
+									\
+	first = 0;							\
+	last = LIST##_nr;						\
+	while (last > first) {						\
+		int next = (last + first) >> 1;				\
+		ELEMTYPE *nextelem = &(LIST[next]);			\
+		int cmp = CMP(data, nextelem);				\
+		if (!cmp)						\
+			return nextelem;				\
+		if (cmp < 0) {						\
+			last = next;					\
+			continue;					\
+		}							\
+		first = next+1;						\
+	}								\
+	/* not found */							\
+	if (!insert_ok)							\
+		return NULL;						\
+	/* insert to make it at "first" */				\
+	if (LIST##_alloc <= LIST##_nr) {				\
+		LIST##_alloc = alloc_nr(LIST##_alloc);			\
+		LIST = xrealloc(LIST, LIST##_alloc * sizeof(*LIST));	\
+	}								\
+	LIST##_nr++;							\
+	if (first < LIST##_nr)						\
+		memmove(LIST + first + 1, LIST + first,			\
+			(LIST##_nr - first - 1) * sizeof(*LIST));	\
+	INIT(&LIST[first], data);					\
+	return &(LIST[first]);						\
+}
-- 
1.7.2.3
