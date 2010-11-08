From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3 3/3] Convert diffcore-rename's rename_src to the new sorted-array API.
Date: Mon,  8 Nov 2010 23:39:02 +0100
Message-ID: <1289255942-19705-4-git-send-email-ydirson@altern.org>
References: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 23:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaN9-0001fg-0w
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0KHWjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:39:19 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:45058 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0KHWjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:39:16 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D2486D48050;
	Mon,  8 Nov 2010 23:39:10 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PFaMl-00058h-A4; Mon, 08 Nov 2010 23:39:07 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289255942-19705-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161003>

Alas, this time we could not keep the same prototype :)

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   52 +++++++++++++++-------------------------------------
 1 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index a146adf..6fa347e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -29,46 +29,24 @@ declare_sorted_array_type(static, struct diff_rename_dst, rename_dst,
 declare_sorted_array(static, struct diff_rename_dst, rename_dst, rename_dst);
 
 /* Table of rename/copy src files */
-static struct diff_rename_src {
+
+struct diff_rename_src {
 	struct diff_filespec *one;
 	unsigned short score; /* to remember the break score */
-} *rename_src;
-static int rename_src_nr, rename_src_alloc;
+};
 
-static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   unsigned short score)
+static int rename_src_cmp(struct diff_filepair *ref_pair, struct diff_rename_src *elem)
 {
-	int first, last;
-
-	first = 0;
-	last = rename_src_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct diff_rename_src *src = &(rename_src[next]);
-		int cmp = strcmp(one->path, src->one->path);
-		if (!cmp)
-			return src;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-
-	/* insert to make it at "first" */
-	if (rename_src_alloc <= rename_src_nr) {
-		rename_src_alloc = alloc_nr(rename_src_alloc);
-		rename_src = xrealloc(rename_src,
-				      rename_src_alloc * sizeof(*rename_src));
-	}
-	rename_src_nr++;
-	if (first < rename_src_nr)
-		memmove(rename_src + first + 1, rename_src + first,
-			(rename_src_nr - first - 1) * sizeof(*rename_src));
-	rename_src[first].one = one;
-	rename_src[first].score = score;
-	return &(rename_src[first]);
+	return strcmp(ref_pair->one->path, elem->one->path);
+}
+static void rename_src_init(struct diff_rename_src *elem, struct diff_filepair *ref_pair)
+{
+	elem->one = ref_pair->one;
+	elem->score = ref_pair->score;
 }
+declare_sorted_array_type(static, struct diff_rename_src, rename_src,
+			  rename_src_cmp, rename_src_init);
+declare_sorted_array(static, struct diff_rename_src, rename_src, rename_src);
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 {
@@ -425,7 +403,7 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			locate_rename_src(p, 1);
 		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
@@ -433,7 +411,7 @@ void diffcore_rename(struct diff_options *options)
 			 * one, to indicate ourselves as a user.
 			 */
 			p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			locate_rename_src(p, 1);
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
-- 
1.7.2.3
