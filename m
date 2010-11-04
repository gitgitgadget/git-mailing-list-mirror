From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] Remove remaining rename_dst references in _locate_element() and pass a pointer to it.
Date: Thu,  4 Nov 2010 21:33:15 +0100
Message-ID: <1288902795-8597-5-git-send-email-ydirson@altern.org>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 21:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6VU-0003Xr-NO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab0KDUdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:33:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44087 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab0KDUde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:33:34 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 44669D480CC;
	Thu,  4 Nov 2010 21:33:28 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6Uu-0002FY-LD; Thu, 04 Nov 2010 21:33:24 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160760>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index a674fbb..a4e0a96 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -11,8 +11,8 @@
 struct dst_obj {
 	struct diff_filespec *two;
 };
-#define locate_element(list,elem,insert_ok)			\
-	_locate_element(elem, &list##_nr, &list##_alloc,	\
+#define locate_element(list,elem,insert_ok)				\
+	_locate_element((void**)&list, elem, &list##_nr, &list##_alloc,	\
 			sizeof(*list), insert_ok)
 
 /* Table of rename/copy destinations, "subclass" of dst_obj */
@@ -24,7 +24,7 @@ static int rename_dst_nr, rename_dst_alloc;
 #define locate_rename_dst(elem,insert_ok)		\
 	locate_element(rename_dst, elem, insert_ok)
 
-static void *_locate_element(struct diff_filespec *two,
+static void *_locate_element(void **listp, struct diff_filespec *two,
 			     int *elem_nr_p, int *elem_alloc_p,
 			     size_t elem_size, int insert_ok)
 {
@@ -35,7 +35,7 @@ static void *_locate_element(struct diff_filespec *two,
 	last = (*elem_nr_p);
 	while (last > first) {
 		int next = (last + first) >> 1;
-		struct dst_obj *dst = (void*)rename_dst + (next * elem_size);
+		struct dst_obj *dst = *listp + (next * elem_size);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
 			return dst;
@@ -51,13 +51,12 @@ static void *_locate_element(struct diff_filespec *two,
 	/* insert to make it at "first" */
 	if ((*elem_alloc_p) <= (*elem_nr_p)) {
 		(*elem_alloc_p) = alloc_nr(*elem_alloc_p);
-		rename_dst = xrealloc(rename_dst,
-				      (*elem_alloc_p) * elem_size);
+		*listp = xrealloc(*listp, (*elem_alloc_p) * elem_size);
 	}
 	(*elem_nr_p)++;
-	first_elem_p = (void*)rename_dst + first * elem_size;
+	first_elem_p = *listp + first * elem_size;
 	if (first < (*elem_nr_p))
-		memmove((void*)rename_dst + (first + 1) * elem_size,
+		memmove(*listp + (first + 1) * elem_size,
 			first_elem_p,
 			((*elem_nr_p) - first - 1) * elem_size);
 	first_elem_p->two = alloc_filespec(two->path);
-- 
1.7.2.3
