From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/7] pickaxe: plug regex leak
Date: Thu, 06 Oct 2011 18:14:55 +0200
Message-ID: <4E8DD3FF.6020302@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqbG-0002Mh-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114Ab1JFQPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:15:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:56166 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965067Ab1JFQPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:15:04 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 2BD3D2F8034;
	Thu,  6 Oct 2011 18:15:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182967>

With -G... --pickaxe-all, free the regex before returning even if we
found a match.  Also get rid of the variable has_changes, as we can
simply break out of the loop.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 0835a3b..96f7ea6 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -96,7 +96,7 @@ static int diff_grep(struct diff_filepair *p, regex_t *regexp, struct diff_optio
 static void diffcore_pickaxe_grep(struct diff_options *o)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i, has_changes, err;
+	int i, err;
 	regex_t regex;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
@@ -112,13 +112,11 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 
 	if (o->pickaxe_opts & DIFF_PICKAXE_ALL) {
 		/* Showing the whole changeset if needle exists */
-		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
+		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (diff_grep(p, &regex, o))
-				has_changes++;
+				goto out; /* do not munge the queue */
 		}
-		if (has_changes)
-			return; /* do not munge the queue */
 
 		/*
 		 * Otherwise we will clear the whole queue by copying
@@ -138,10 +136,11 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		}
 	}
 
-	regfree(&regex);
-
 	free(q->queue);
 	*q = outq;
+
+ out:
+	regfree(&regex);
 	return;
 }
 
-- 
1.7.7
