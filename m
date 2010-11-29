From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/6] Convert diffcore-rename's rename_dst to the new sorted-array API.
Date: Mon, 29 Nov 2010 23:57:17 +0100
Message-ID: <1291071441-11808-3-git-send-email-ydirson@altern.org>
References: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 23:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCfi-0001dV-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab0K2W5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:57:50 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:33370 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175Ab0K2W5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:57:49 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D09B7D48096;
	Mon, 29 Nov 2010 23:57:41 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PNCf5-000359-BH; Mon, 29 Nov 2010 23:57:31 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291071441-11808-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162446>

The sorted-array API splits search and insert into two separated
functions, which makes the caller code more clear.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   66 ++++++++++++++++++++---------------------------------
 1 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..a655017 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,52 +5,36 @@
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
+declare_sorted_array(static, struct diff_rename_dst, rename_dst);
+declare_gen_binsearch(static, struct diff_rename_dst, _locate_rename_dst,
+		      struct diff_filespec *);
+declare_sorted_array_search_elem(static, struct diff_rename_dst, locate_rename_dst,
+				 struct diff_filespec *, _locate_rename_dst,
+				 rename_dst, rename_dst_cmp);
+declare_gen_sorted_insert(static, struct diff_rename_dst, _register_rename_dst,
+			  _locate_rename_dst, struct diff_filespec *);
+declare_sorted_array_insert_checkbool(static, register_rename_dst, struct diff_filespec *,
+				      _register_rename_dst,
+				      rename_dst, rename_dst_cmp, rename_dst_init);
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
@@ -437,7 +421,7 @@ void diffcore_rename(struct diff_options *options)
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else
-				locate_rename_dst(p->two, 1);
+				register_rename_dst(p->two);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/*
@@ -582,7 +566,7 @@ void diffcore_rename(struct diff_options *options)
 			 * not been turned into a rename/copy already.
 			 */
 			struct diff_rename_dst *dst =
-				locate_rename_dst(p->two, 0);
+				locate_rename_dst(p->two);
 			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -613,7 +597,7 @@ void diffcore_rename(struct diff_options *options)
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
 				struct diff_rename_dst *dst =
-					locate_rename_dst(p->one, 0);
+					locate_rename_dst(p->one);
 				if (dst && dst->pair)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
-- 
1.7.2.3
