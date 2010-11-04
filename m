From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] Introduce "abstract class" to make _locate_element() more independant of diff_rename_dst.
Date: Thu,  4 Nov 2010 21:33:14 +0100
Message-ID: <1288902795-8597-4-git-send-email-ydirson@altern.org>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 21:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6VV-0003Xr-7v
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0KDUdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:33:38 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44113 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab0KDUdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:33:35 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1BA38D481E3;
	Thu,  4 Nov 2010 21:33:28 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6Uu-0002FV-Jg; Thu, 04 Nov 2010 21:33:24 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160759>

The dst_obj struct acts as an absract base class for the elements which
_locate_element() manipulates arrays of.
---
 diffcore-rename.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6e7ab4a..a674fbb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,12 +6,16 @@
 #include "diffcore.h"
 #include "hash.h"
 
+
+/* "Abstract class" for lists of filespecs */
+struct dst_obj {
+	struct diff_filespec *two;
+};
 #define locate_element(list,elem,insert_ok)			\
 	_locate_element(elem, &list##_nr, &list##_alloc,	\
 			sizeof(*list), insert_ok)
 
-/* Table of rename/copy destinations */
-
+/* Table of rename/copy destinations, "subclass" of dst_obj */
 static struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
@@ -20,18 +24,18 @@ static int rename_dst_nr, rename_dst_alloc;
 #define locate_rename_dst(elem,insert_ok)		\
 	locate_element(rename_dst, elem, insert_ok)
 
-static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
-					       int *elem_nr_p, int *elem_alloc_p,
-					       size_t elem_size, int insert_ok)
+static void *_locate_element(struct diff_filespec *two,
+			     int *elem_nr_p, int *elem_alloc_p,
+			     size_t elem_size, int insert_ok)
 {
 	int first, last;
-	struct diff_rename_dst *first_elem_p;
+	struct dst_obj *first_elem_p;
 
 	first = 0;
 	last = (*elem_nr_p);
 	while (last > first) {
 		int next = (last + first) >> 1;
-		struct diff_rename_dst *dst = (void*)rename_dst + (next * elem_size);
+		struct dst_obj *dst = (void*)rename_dst + (next * elem_size);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
 			return dst;
@@ -58,7 +62,8 @@ static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
 			((*elem_nr_p) - first - 1) * elem_size);
 	first_elem_p->two = alloc_filespec(two->path);
 	fill_filespec(first_elem_p->two, two->sha1, two->mode);
-	first_elem_p->pair = NULL;
+	memset(((struct dst_obj *)first_elem_p) + 1, 0,
+	       elem_size - sizeof(struct dst_obj));
 	return first_elem_p;
 }
 
-- 
1.7.2.3
