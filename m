From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v2 2/3] Convert diffcore-rename's rename_src to the new sorted-array API.
Date: Sat,  6 Nov 2010 22:00:34 +0100
Message-ID: <1289077235-3208-3-git-send-email-ydirson@altern.org>
References: <1289077235-3208-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 22:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEpt5-0001XF-3p
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 22:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0KFVAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 17:00:52 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:58185 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab0KFVAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 17:00:50 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B85C6D480FF;
	Sat,  6 Nov 2010 22:00:44 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PEpsO-0000qX-74; Sat, 06 Nov 2010 22:00:40 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289077235-3208-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160860>

Alas, this time we could not keep the same prototype :)

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 diffcore-rename.c |   53 ++++++++++++++++-------------------------------------
 1 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 72a9b94..ec40cf7 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -30,46 +30,25 @@ declare_sorted_array(static, struct diff_rename_dst, rename_dst,
 		     rename_dst_cmp, rename_dst_init)
 
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
+static int rename_src_cmp(void* data, struct diff_rename_src *elem)
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
+	struct diff_filepair *p = data;
+	return strcmp(p->one->path, elem->one->path);
+}
+static void rename_src_init(struct diff_rename_src *elem, void* data)
+{
+	struct diff_filepair *p = data;
+	elem->one = p->one;
+	elem->score = p->score;
 }
+declare_sorted_array(static, struct diff_rename_src, rename_src,
+		     rename_src_cmp, rename_src_init)
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 {
@@ -426,7 +405,7 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			locate_rename_src(p, 1);
 		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
@@ -434,7 +413,7 @@ void diffcore_rename(struct diff_options *options)
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
