From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3 2/3] Separate sorted-array type declaration from array declaration.
Date: Mon,  8 Nov 2010 23:39:01 +0100
Message-ID: <1289255942-19705-3-git-send-email-ydirson@altern.org>
References: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 23:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaN8-0001fg-GO
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0KHWjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:39:18 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:45083 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab0KHWjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:39:17 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C1708D480E1;
	Mon,  8 Nov 2010 23:39:11 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PFaMl-00058e-8h; Mon, 08 Nov 2010 23:39:07 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161002>

Instead of a single locate() function hardcoding references to a fixed
array, we declare a generic function taking references to the array and
its metadata.  Declaring an array produces a lightweight wrapper for
this specific array, not modifying calling API any further and keeping
it readable.

This will allow to declare several arrays of the same type without
causing duplication of the locate function.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |    5 +++--
 sorted-array.h    |   39 ++++++++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1626bdc..a146adf 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -24,8 +24,9 @@ static void rename_dst_init(struct diff_rename_dst *elem, struct diff_filespec *
 	fill_filespec(elem->two, ref_spec->sha1, ref_spec->mode);
 	elem->pair = NULL;
 }
-declare_sorted_array(static, struct diff_rename_dst, rename_dst,
-		     rename_dst_cmp, rename_dst_init)
+declare_sorted_array_type(static, struct diff_rename_dst, rename_dst,
+			  rename_dst_cmp, rename_dst_init);
+declare_sorted_array(static, struct diff_rename_dst, rename_dst, rename_dst);
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
diff --git a/sorted-array.h b/sorted-array.h
index 03d5d1e..54fad20 100644
--- a/sorted-array.h
+++ b/sorted-array.h
@@ -1,15 +1,15 @@
-#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,LIST,CMP,INIT)	\
-MAYBESTATIC ELEMTYPE *LIST;						\
-MAYBESTATIC int LIST##_nr, LIST##_alloc;				\
-MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
+#define declare_sorted_array_type(MAYBESTATIC,ELEMTYPE,TYPENICK,CMP,INIT) \
+MAYBESTATIC ELEMTYPE *locate_type_##TYPENICK(				\
+	ELEMTYPE **list_p, int *list_nr_p, int *list_nr_alloc,		\
+	void *data, int insert_ok)					\
 {									\
 	int first, last;						\
 									\
 	first = 0;							\
-	last = LIST##_nr;						\
+	last = *list_nr_p;						\
 	while (last > first) {						\
 		int next = (last + first) >> 1;				\
-		ELEMTYPE *nextelem = &(LIST[next]);			\
+		ELEMTYPE *nextelem = &((*list_p)[next]);		\
 		int cmp = CMP(data, nextelem);				\
 		if (!cmp)						\
 			return nextelem;				\
@@ -23,14 +23,23 @@ MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
 	if (!insert_ok)							\
 		return NULL;						\
 	/* insert to make it at "first" */				\
-	if (LIST##_alloc <= LIST##_nr) {				\
-		LIST##_alloc = alloc_nr(LIST##_alloc);			\
-		LIST = xrealloc(LIST, LIST##_alloc * sizeof(*LIST));	\
+	if (*list_nr_alloc <= *list_nr_p) {				\
+		(*list_nr_alloc) = alloc_nr((*list_nr_alloc));		\
+		*list_p = xrealloc(*list_p, (*list_nr_alloc) * sizeof(**list_p)); \
 	}								\
-	LIST##_nr++;							\
-	if (first < LIST##_nr)						\
-		memmove(LIST + first + 1, LIST + first,			\
-			(LIST##_nr - first - 1) * sizeof(*LIST));	\
-	INIT(&LIST[first], data);					\
-	return &(LIST[first]);						\
+	(*list_nr_p)++;							\
+	if (first < *list_nr_p)						\
+		memmove(*list_p + first + 1, *list_p + first,		\
+			(*list_nr_p - first - 1) * sizeof(**list_p));	\
+	INIT(&(*list_p)[first], data);					\
+	return &((*list_p)[first]);					\
+}
+
+#define declare_sorted_array(MAYBESTATIC,ELEMTYPE,TYPENICK,LIST)	\
+MAYBESTATIC ELEMTYPE *LIST;						\
+MAYBESTATIC int LIST##_nr, LIST##_alloc;				\
+MAYBESTATIC ELEMTYPE *locate_##LIST(void *data, int insert_ok)		\
+{									\
+	return locate_type_##TYPENICK(&LIST, &LIST##_nr, &LIST##_alloc,	\
+				 data, insert_ok);			\
 }
-- 
1.7.2.3
