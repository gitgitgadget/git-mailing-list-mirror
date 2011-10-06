From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/7] pickaxe: factor out has_changes
Date: Thu, 06 Oct 2011 18:26:24 +0200
Message-ID: <4E8DD6B0.2070103@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqmR-0007Rr-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146Ab1JFQ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:26:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:56170 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935867Ab1JFQ0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:26:32 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 383022F8034;
	Thu,  6 Oct 2011 18:26:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182971>

Move duplicate if/else construct into its own helper function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |   57 +++++++++++++++++++--------------------------------
 1 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c367d8d..4347ec1 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -190,13 +190,31 @@ static unsigned int contains(struct diff_filespec *one,
 	return cnt;
 }
 
+static int has_changes(struct diff_filepair *p, const char *needle,
+		       unsigned long len, regex_t *regexp, kwset_t kws)
+{
+	if (!DIFF_FILE_VALID(p->one)) {
+		if (!DIFF_FILE_VALID(p->two))
+			return 0; /* ignore unmerged */
+		/* created */
+		return contains(p->two, needle, len, regexp, kws) != 0;
+	}
+	if (!DIFF_FILE_VALID(p->two))
+		return contains(p->one, needle, len, regexp, kws) != 0;
+	if (!diff_unmodified_pair(p)) {
+		return contains(p->one, needle, len, regexp, kws) !=
+		       contains(p->two, needle, len, regexp, kws);
+	}
+	return 0;
+}
+
 static void diffcore_pickaxe_count(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
-	int i, has_changes;
+	int i;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
 	struct diff_queue_struct outq;
@@ -223,22 +241,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (!DIFF_FILE_VALID(p->one)) {
-				if (!DIFF_FILE_VALID(p->two))
-					continue; /* ignore unmerged */
-				/* created */
-				if (contains(p->two, needle, len, regexp, kws))
-					has_changes++;
-			}
-			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp, kws))
-					has_changes++;
-			}
-			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp, kws) !=
-				 contains(p->two, needle, len, regexp, kws))
-				has_changes++;
-			if (has_changes)
+			if (has_changes(p, needle, len, regexp, kws))
 				goto out; /* do not munge the queue */
 		}
 
@@ -254,25 +257,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			has_changes = 0;
-			if (!DIFF_FILE_VALID(p->one)) {
-				if (!DIFF_FILE_VALID(p->two))
-					; /* ignore unmerged */
-				/* created */
-				else if (contains(p->two, needle, len, regexp,
-						  kws))
-					has_changes = 1;
-			}
-			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp, kws))
-					has_changes = 1;
-			}
-			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp, kws) !=
-				 contains(p->two, needle, len, regexp, kws))
-				has_changes = 1;
-
-			if (has_changes)
+			if (has_changes(p, needle, len, regexp, kws))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
-- 
1.7.7
