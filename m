From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/7] pickaxe: plug regex/kws leak
Date: Thu, 06 Oct 2011 18:23:11 +0200
Message-ID: <4E8DD5EF.9000700@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqjD-0006BO-R0
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094Ab1JFQXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:23:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:56168 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934637Ab1JFQXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:23:19 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 0B2A42F8034;
	Thu,  6 Oct 2011 18:23:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182969>

With -S... --pickaxe-all, free the regex or the kws before returning
even if we found a match.  Also get rid of the variable has_changes,
as we can simply break out of the loop.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 96f7ea6..c367d8d 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -221,7 +221,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 
 	if (opts & DIFF_PICKAXE_ALL) {
 		/* Showing the whole changeset if needle exists */
-		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
+		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (!DIFF_FILE_VALID(p->one)) {
 				if (!DIFF_FILE_VALID(p->two))
@@ -238,9 +238,9 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 				 contains(p->one, needle, len, regexp, kws) !=
 				 contains(p->two, needle, len, regexp, kws))
 				has_changes++;
+			if (has_changes)
+				goto out; /* do not munge the queue */
 		}
-		if (has_changes)
-			return; /* not munge the queue */
 
 		/* otherwise we will clear the whole queue
 		 * by copying the empty outq at the end of this
@@ -278,13 +278,14 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 				diff_free_filepair(p);
 		}
 
+	free(q->queue);
+	*q = outq;
+
+ out:
 	if (opts & DIFF_PICKAXE_REGEX)
 		regfree(&regex);
 	else
 		kwsfree(kws);
-
-	free(q->queue);
-	*q = outq;
 	return;
 }
 
-- 
1.7.7
