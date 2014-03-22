From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 08/10] pickaxe: move pickaxe() after pickaxe_match()
Date: Sat, 22 Mar 2014 18:15:58 +0100
Message-ID: <1395508560-19893-9-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXL-00025U-LA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbaCVRQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:34 -0400
Received: from mout.web.de ([212.227.15.14]:54394 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbaCVRQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:29 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MRlJB-1WXhxo33xh-00Sxsa; Sat, 22 Mar 2014 18:16:25
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:e87iaWIg3fwlIHrpPcg5jtokH+BapMshSRVkcBpALBuiBOV4eHG
 YcuK1iY8l+5o5rqElYkKQb/drN08vEVOausfcS1lS/ngcRIh39bt/0vWSqU4pt9vfUJ+TzS
 WeBILDfc87kJjphjuqAdlp7b5Z1gXT1E8j7F48ca8MAJuKdD/+ygwnbYtowxe483tuS5e39
 HGHnsQCbYhh/ZrbPCF96w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244776>

pickaxe() calls pickaxe_match(); moving the definition of the former
those after the latter allows us to do without an explicit function
declaration.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-pickaxe.c | 79 ++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cfc4262..827a7d7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -12,47 +12,6 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
 			  regex_t *regexp, kwset_t kws);
 
-static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
-
-static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
-		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
-{
-	int i;
-	struct diff_queue_struct outq;
-
-	DIFF_QUEUE_CLEAR(&outq);
-
-	if (o->pickaxe_opts & DIFF_PICKAXE_ALL) {
-		/* Showing the whole changeset if needle exists */
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
-				return; /* do not munge the queue */
-		}
-
-		/*
-		 * Otherwise we will clear the whole queue by copying
-		 * the empty outq at the end of this function, but
-		 * first clear the current entries in the queue.
-		 */
-		for (i = 0; i < q->nr; i++)
-			diff_free_filepair(q->queue[i]);
-	} else {
-		/* Showing only the filepairs that has the needle */
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
-				diff_q(&outq, p);
-			else
-				diff_free_filepair(p);
-		}
-	}
-
-	free(q->queue);
-	*q = outq;
-}
-
 struct diffgrep_cb {
 	regex_t *regexp;
 	int hit;
@@ -204,6 +163,44 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	return ret;
 }
 
+static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
+		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+{
+	int i;
+	struct diff_queue_struct outq;
+
+	DIFF_QUEUE_CLEAR(&outq);
+
+	if (o->pickaxe_opts & DIFF_PICKAXE_ALL) {
+		/* Showing the whole changeset if needle exists */
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (pickaxe_match(p, o, regexp, kws, fn))
+				return; /* do not munge the queue */
+		}
+
+		/*
+		 * Otherwise we will clear the whole queue by copying
+		 * the empty outq at the end of this function, but
+		 * first clear the current entries in the queue.
+		 */
+		for (i = 0; i < q->nr; i++)
+			diff_free_filepair(q->queue[i]);
+	} else {
+		/* Showing only the filepairs that has the needle */
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (pickaxe_match(p, o, regexp, kws, fn))
+				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
+		}
+	}
+
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
-- 
1.9.1
