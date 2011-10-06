From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/7] pickaxe: factor out pickaxe
Date: Thu, 06 Oct 2011 18:50:28 +0200
Message-ID: <4E8DDC54.2040805@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBr9d-0008Ci-UN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062Ab1JFQuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:50:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:56176 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965047Ab1JFQug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:50:36 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 764782F8079;
	Thu,  6 Oct 2011 18:50:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182975>

Move the duplicate diff queue loop into its own function that accepts
a match function: has_changes() for -S and diff_grep() for -G.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |  110 ++++++++++++++++++++-------------------------------
 1 files changed, 43 insertions(+), 67 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 226fa0c..380a837 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -8,6 +8,46 @@
 #include "xdiff-interface.h"
 #include "kwset.h"
 
+typedef int (*pickaxe_fn)(struct diff_filepair *p, struct diff_options *o, regex_t *regexp, kwset_t kws);
+
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
+			if (fn(p, o, regexp, kws))
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
+			if (fn(p, o, regexp, kws))
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
 struct diffgrep_cb {
 	regex_t *regexp;
 	int hit;
@@ -96,12 +136,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 
 static void diffcore_pickaxe_grep(struct diff_options *o)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
-	int i, err;
+	int err;
 	regex_t regex;
-	struct diff_queue_struct outq;
-	outq.queue = NULL;
-	outq.nr = outq.alloc = 0;
 
 	err = regcomp(&regex, o->pickaxe, REG_EXTENDED | REG_NEWLINE);
 	if (err) {
@@ -111,36 +147,8 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		die("invalid log-grep regex: %s", errbuf);
 	}
 
-	if (o->pickaxe_opts & DIFF_PICKAXE_ALL) {
-		/* Showing the whole changeset if needle exists */
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (diff_grep(p, o, &regex, NULL))
-				goto out; /* do not munge the queue */
-		}
+	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
 
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
-			if (diff_grep(p, o, &regex, NULL))
-				diff_q(&outq, p);
-			else
-				diff_free_filepair(p);
-		}
-	}
-
-	free(q->queue);
-	*q = outq;
-
- out:
 	regfree(&regex);
 	return;
 }
@@ -213,13 +221,9 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
-	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
-	int i;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
-	struct diff_queue_struct outq;
-	DIFF_QUEUE_CLEAR(&outq);
 
 	if (opts & DIFF_PICKAXE_REGEX) {
 		int err;
@@ -238,36 +242,8 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		kwsprep(kws);
 	}
 
-	if (opts & DIFF_PICKAXE_ALL) {
-		/* Showing the whole changeset if needle exists */
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (has_changes(p, o, regexp, kws))
-				goto out; /* do not munge the queue */
-		}
-
-		/* otherwise we will clear the whole queue
-		 * by copying the empty outq at the end of this
-		 * function, but first clear the current entries
-		 * in the queue.
-		 */
-		for (i = 0; i < q->nr; i++)
-			diff_free_filepair(q->queue[i]);
-	}
-	else
-		/* Showing only the filepairs that has the needle */
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (has_changes(p, o, regexp, kws))
-				diff_q(&outq, p);
-			else
-				diff_free_filepair(p);
-		}
-
-	free(q->queue);
-	*q = outq;
+	pickaxe(&diff_queued_diff, o, regexp, kws, has_changes);
 
- out:
 	if (opts & DIFF_PICKAXE_REGEX)
 		regfree(&regex);
 	else
-- 
1.7.7
