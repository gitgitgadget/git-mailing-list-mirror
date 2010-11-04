From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/4] Start to replace locate_rename_dst() with a generic function.
Date: Thu,  4 Nov 2010 21:33:12 +0100
Message-ID: <1288902795-8597-2-git-send-email-ydirson@altern.org>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 21:33:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6V9-0003Fe-4H
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0KDUdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:33:33 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44004 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab0KDUdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:33:31 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AD240D481F5;
	Thu,  4 Nov 2010 21:33:25 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6Uu-0002FP-Ge; Thu, 04 Nov 2010 21:33:24 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288902795-8597-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160757>

First we introduce the trivial changes: replace hardcoded references to
rename_dst_nr, rename_dst_alloc to parameters.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..fc554e4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,6 +6,10 @@
 #include "diffcore.h"
 #include "hash.h"
 
+#define locate_element(list,elem,insert_ok)			\
+	_locate_element(elem, &list##_nr, &list##_alloc,	\
+			insert_ok)
+
 /* Table of rename/copy destinations */
 
 static struct diff_rename_dst {
@@ -13,14 +17,17 @@ static struct diff_rename_dst {
 	struct diff_filepair *pair;
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
+#define locate_rename_dst(elem,insert_ok)		\
+	locate_element(rename_dst, elem, insert_ok)
 
-static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
-						 int insert_ok)
+static struct diff_rename_dst *_locate_element(struct diff_filespec *two,
+					       int *elem_nr_p, int *elem_alloc_p,
+					       int insert_ok)
 {
 	int first, last;
 
 	first = 0;
-	last = rename_dst_nr;
+	last = (*elem_nr_p);
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct diff_rename_dst *dst = &(rename_dst[next]);
@@ -37,15 +44,15 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	if (!insert_ok)
 		return NULL;
 	/* insert to make it at "first" */
-	if (rename_dst_alloc <= rename_dst_nr) {
-		rename_dst_alloc = alloc_nr(rename_dst_alloc);
+	if ((*elem_alloc_p) <= (*elem_nr_p)) {
+		(*elem_alloc_p) = alloc_nr(*elem_alloc_p);
 		rename_dst = xrealloc(rename_dst,
-				      rename_dst_alloc * sizeof(*rename_dst));
+				      (*elem_alloc_p) * sizeof(*rename_dst));
 	}
-	rename_dst_nr++;
-	if (first < rename_dst_nr)
+	(*elem_nr_p)++;
+	if (first < (*elem_nr_p))
 		memmove(rename_dst + first + 1, rename_dst + first,
-			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
+			((*elem_nr_p) - first - 1) * sizeof(*rename_dst));
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
 	rename_dst[first].pair = NULL;
-- 
1.7.2.3
