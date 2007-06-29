From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] diffcore_count_changes: pass diffcore_filespec
Date: Thu, 28 Jun 2007 23:35:58 -0700
Message-ID: <11830989612019-git-send-email-gitster@pobox.com>
References: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 08:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A5Q-0004Qn-NJ
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbXF2GgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbXF2GgF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:36:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40390 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbXF2GgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:36:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629063602.CKPU22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:36:02 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJc11X00M1kojtg0000000; Fri, 29 Jun 2007 02:36:02 -0400
X-Mailer: git-send-email 1.5.2.2.1414.g1e7d9
In-Reply-To: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51152>

We may want to use richer information on the data we are dealing
with in this function, so instead of passing a buffer address
and length, just pass the diffcore_filespec structure.  Existing
callers always call this function with parameters taken from a
filespec anyway, so there is no functionality changes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-break.c  |    3 +--
 diffcore-delta.c  |    8 ++++----
 diffcore-rename.c |    3 +--
 diffcore.h        |    4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 9c19b8c..ae8a7d0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -66,8 +66,7 @@ static int should_break(struct diff_filespec *src,
 	if (base_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
 
-	if (diffcore_count_changes(src->data, src->size,
-				   dst->data, dst->size,
+	if (diffcore_count_changes(src, dst,
 				   NULL, NULL,
 				   0,
 				   &src_copied, &literal_added))
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7338a40..0e1fae7 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -156,8 +156,8 @@ static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
 	return hash;
 }
 
-int diffcore_count_changes(void *src, unsigned long src_size,
-			   void *dst, unsigned long dst_size,
+int diffcore_count_changes(struct diff_filespec *src,
+			   struct diff_filespec *dst,
 			   void **src_count_p,
 			   void **dst_count_p,
 			   unsigned long delta_limit,
@@ -172,14 +172,14 @@ int diffcore_count_changes(void *src, unsigned long src_size,
 	if (src_count_p)
 		src_count = *src_count_p;
 	if (!src_count) {
-		src_count = hash_chars(src, src_size);
+		src_count = hash_chars(src->data, src->size);
 		if (src_count_p)
 			*src_count_p = src_count;
 	}
 	if (dst_count_p)
 		dst_count = *dst_count_p;
 	if (!dst_count) {
-		dst_count = hash_chars(dst, dst_size);
+		dst_count = hash_chars(dst->data, dst->size);
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 79c984c..cb22736 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -189,8 +189,7 @@ static int estimate_similarity(struct diff_filespec *src,
 
 	delta_limit = (unsigned long)
 		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
-	if (diffcore_count_changes(src->data, src->size,
-				   dst->data, dst->size,
+	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
 				   delta_limit,
 				   &src_copied, &literal_added))
diff --git a/diffcore.h b/diffcore.h
index 7b9294e..990dec5 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -103,8 +103,8 @@ void diff_debug_queue(const char *, struct diff_queue_struct *);
 #define diff_debug_queue(a,b) do {} while(0)
 #endif
 
-extern int diffcore_count_changes(void *src, unsigned long src_size,
-				  void *dst, unsigned long dst_size,
+extern int diffcore_count_changes(struct diff_filespec *src,
+				  struct diff_filespec *dst,
 				  void **src_count_p,
 				  void **dst_count_p,
 				  unsigned long delta_limit,
-- 
1.5.2.2.1414.g1e7d9
