From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] Abstract _locate_element() some more with elem_size parameter.
Date: Thu,  4 Nov 2010 21:33:13 +0100
Message-ID: <1288902795-8597-3-git-send-email-ydirson@altern.org>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 21:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6VV-0003Xr-Py
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab0KDUdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:33:40 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44194 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab0KDUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:33:37 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A2A2AD481B7;
	Thu,  4 Nov 2010 21:33:31 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6Uu-0002FR-I6; Thu, 04 Nov 2010 21:33:24 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160758>

Now offset calculations don't rely on pointer arithmetic any more, paving
the way for complete decoupling from diff_rename_dst.
---
 diffcore-rename.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index fc554e4..6e7ab4a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -8,7 +8,7 @@
 
 #define locate_element(list,elem,insert_ok)			\
 	_locate_element(elem, &list##_nr, &list##_alloc,	\
-			insert_ok)
+			sizeof(*list), insert_ok)
 
 /* Table of rename/copy destinations */
 
@@ -22,15 +22,16 @@ static int rename_dst_nr, rename_dst_alloc;
 
 static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
 					       int *elem_nr_p, int *elem_alloc_p,
-					       int insert_ok)
+					       size_t elem_size, int insert_ok)
 {
 	int first, last;
+	struct diff_rename_dst *first_elem_p;
 
 	first = 0;
 	last = (*elem_nr_p);
 	while (last > first) {
 		int next = (last + first) >> 1;
-		struct diff_rename_dst *dst = &(rename_dst[next]);
+		struct diff_rename_dst *dst = (void*)rename_dst + (next * elem_size);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
 			return dst;
@@ -47,16 +48,18 @@ static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
 	if ((*elem_alloc_p) <= (*elem_nr_p)) {
 		(*elem_alloc_p) = alloc_nr(*elem_alloc_p);
 		rename_dst = xrealloc(rename_dst,
-				      (*elem_alloc_p) * sizeof(*rename_dst));
+				      (*elem_alloc_p) * elem_size);
 	}
 	(*elem_nr_p)++;
+	first_elem_p = (void*)rename_dst + first * elem_size;
 	if (first < (*elem_nr_p))
-		memmove(rename_dst + first + 1, rename_dst + first,
-			((*elem_nr_p) - first - 1) * sizeof(*rename_dst));
-	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
-	rename_dst[first].pair = NULL;
-	return &(rename_dst[first]);
+		memmove((void*)rename_dst + (first + 1) * elem_size,
+			first_elem_p,
+			((*elem_nr_p) - first - 1) * elem_size);
+	first_elem_p->two = alloc_filespec(two->path);
+	fill_filespec(first_elem_p->two, two->sha1, two->mode);
+	first_elem_p->pair = NULL;
+	return first_elem_p;
 }
 
 /* Table of rename/copy src files */
-- 
1.7.2.3
