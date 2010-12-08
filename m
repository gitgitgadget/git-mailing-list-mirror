From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/6] Convert diffcore-rename's rename_dst to the new sorted-array API.
Date: Wed,  8 Dec 2010 23:51:31 +0100
Message-ID: <1291848695-24601-3-git-send-email-ydirson@altern.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSs5-0003GC-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab0LHWv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:58 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49579 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab0LHWv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:56 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 72B1AD48130;
	Wed,  8 Dec 2010 23:51:49 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQSrL-0006Pk-11; Wed, 08 Dec 2010 23:51:39 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163237>

The sorted-array API splits search and insert into two separated
functions, which makes the caller code more clear.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   62 ++++++++++++++++++-----------------------------------
 1 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..ca3f54c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,52 +5,32 @@
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
+declare_sorted_array_search_elem(static, struct diff_rename_dst, locate_rename_dst,
+				 struct diff_filespec *,
+				 rename_dst, rename_dst_cmp);
+declare_sorted_array_insert_checkbool(static, struct diff_rename_dst, register_rename_dst,
+				      struct diff_filespec *, _gen_locate_rename_dst,
+				      rename_dst, rename_dst_cmp, rename_dst_init);
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
@@ -437,7 +417,7 @@ void diffcore_rename(struct diff_options *options)
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else
-				locate_rename_dst(p->two, 1);
+				register_rename_dst(p->two);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			/*
@@ -582,7 +562,7 @@ void diffcore_rename(struct diff_options *options)
 			 * not been turned into a rename/copy already.
 			 */
 			struct diff_rename_dst *dst =
-				locate_rename_dst(p->two, 0);
+				locate_rename_dst(p->two);
 			if (dst && dst->pair) {
 				diff_q(&outq, dst->pair);
 				pair_to_free = p;
@@ -613,7 +593,7 @@ void diffcore_rename(struct diff_options *options)
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
