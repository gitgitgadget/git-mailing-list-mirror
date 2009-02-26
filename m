From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] diffcore-pickaxe: refactor diffcore_pickaxe()
Date: Wed, 25 Feb 2009 22:52:03 -0800
Message-ID: <4b1358cc6558ec05a134431b603e4781b42deabd.1235629933.git.gitster@pobox.com>
References: <cover.1235629933.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 07:53:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lca83-0006C2-5I
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbZBZGwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZBZGwP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:52:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbZBZGwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:52:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A0A25125E
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB356125D for
 <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:09 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.91.gf9a36
In-Reply-To: <cover.1235629933.git.gitster@pobox.com>
X-Pobox-Relay-ID: 28134DA2-049B-11DE-BB43-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111529>

Introduce pickaxe_match_one() to remove duplicated code that decides if a
filepair is "interesting enough" for the purpose of pickaxe from the main
loop of the function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c |   83 ++++++++++++++++++++++++++-------------------------
 1 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index af9fffe..d27e725 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -5,9 +5,9 @@
 #include "diff.h"
 #include "diffcore.h"
 
-static unsigned int contains(struct diff_filespec *one,
-			     const char *needle, unsigned long len,
-			     regex_t *regexp)
+static unsigned int count_match(struct diff_filespec *one,
+				const char *needle, unsigned long len,
+				regex_t *regexp)
 {
 	unsigned int cnt;
 	unsigned long offset, sz;
@@ -48,6 +48,38 @@ static unsigned int contains(struct diff_filespec *one,
 	return cnt;
 }
 
+static int has_match(struct diff_filespec *one,
+		     const char *needle, unsigned long len,
+		     regex_t *regexp)
+{
+	return !!count_match(one, needle, len, regexp);
+}
+
+static int has_different_matches(struct diff_filepair *p,
+				 const char *needle, unsigned long len,
+				 regex_t *regexp)
+{
+	return (count_match(p->one, needle, len, regexp)
+		!= count_match(p->two, needle, len, regexp));
+
+}
+
+static int pickaxe_match_one(struct diff_filepair *p,
+			     const char *needle, unsigned long len,
+			     regex_t *regexp)
+{
+	if (!DIFF_FILE_VALID(p->one)) {
+		if (!DIFF_FILE_VALID(p->two))
+			return 0;
+		return has_match(p->two, needle, len, regexp);
+	} else if (!DIFF_FILE_VALID(p->two))
+		return has_match(p->one, needle, len, regexp);
+	else if (diff_unmodified_pair(p))
+		return 0;
+	else
+		return has_different_matches(p, needle, len, regexp);
+}
+
 void diffcore_pickaxe(const char *needle, int opts)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -75,29 +107,14 @@ void diffcore_pickaxe(const char *needle, int opts)
 		/* Showing the whole changeset if needle exists */
 		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (!DIFF_FILE_VALID(p->one)) {
-				if (!DIFF_FILE_VALID(p->two))
-					continue; /* ignore unmerged */
-				/* created */
-				if (contains(p->two, needle, len, regexp))
-					has_changes++;
-			}
-			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp))
-					has_changes++;
-			}
-			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp) !=
-				 contains(p->two, needle, len, regexp))
-				has_changes++;
+			if (pickaxe_match_one(p, needle, len, regexp))
+				return; /* not munge the queue */
 		}
-		if (has_changes)
-			return; /* not munge the queue */
 
-		/* otherwise we will clear the whole queue
-		 * by copying the empty outq at the end of this
-		 * function, but first clear the current entries
-		 * in the queue.
+		/*
+		 * otherwise we will clear the whole queue by copying
+		 * the empty outq at the end of this function, but
+		 * first clear the current entries in the queue.
 		 */
 		for (i = 0; i < q->nr; i++)
 			diff_free_filepair(q->queue[i]);
@@ -106,24 +123,8 @@ void diffcore_pickaxe(const char *needle, int opts)
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			has_changes = 0;
-			if (!DIFF_FILE_VALID(p->one)) {
-				if (!DIFF_FILE_VALID(p->two))
-					; /* ignore unmerged */
-				/* created */
-				else if (contains(p->two, needle, len, regexp))
-					has_changes = 1;
-			}
-			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp))
-					has_changes = 1;
-			}
-			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp) !=
-				 contains(p->two, needle, len, regexp))
-				has_changes = 1;
 
-			if (has_changes)
+			if (pickaxe_match_one(p, needle, len, regexp))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
-- 
1.6.2.rc2.91.gf9a36
