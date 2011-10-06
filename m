From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/7] pickaxe: pass diff_options to contains and has_changes
Date: Thu, 06 Oct 2011 18:50:06 +0200
Message-ID: <4E8DDC3E.8050308@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBr9L-00084O-3q
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040Ab1JFQuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:50:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:56172 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935224Ab1JFQuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:50:14 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 6E2BA2F8034;
	Thu,  6 Oct 2011 18:50:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182973>

Remove the unused parameter needle from contains() and has_changes().

Also replace the parameter len with a pointer to the diff_options.  We
can use its member pickaxe to check if the needle is an empty string
and use the kwsmatch structure to find out the length of the match
instead.

This change is done as a preparation to unify the signatures of
has_changes() and diff_grep(), which will be used in the patch after
the next one to factor out common code.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 4347ec1..4d66ba9 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -144,14 +144,13 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 	return;
 }
 
-static unsigned int contains(struct diff_filespec *one,
-			     const char *needle, unsigned long len,
+static unsigned int contains(struct diff_filespec *one, struct diff_options *o,
 			     regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
 	unsigned long sz;
 	const char *data;
-	if (!len)
+	if (!o->pickaxe[0])
 		return 0;
 	if (diff_populate_filespec(one, 0))
 		return 0;
@@ -175,14 +174,15 @@ static unsigned int contains(struct diff_filespec *one,
 
 	} else { /* Classic exact string match */
 		while (sz) {
-			size_t offset = kwsexec(kws, data, sz, NULL);
+			struct kwsmatch kwsm;
+			size_t offset = kwsexec(kws, data, sz, &kwsm);
 			const char *found;
 			if (offset == -1)
 				break;
 			else
 				found = data + offset;
-			sz -= found - data + len;
-			data = found + len;
+			sz -= found - data + kwsm.size[0];
+			data = found + kwsm.size[0];
 			cnt++;
 		}
 	}
@@ -190,20 +190,20 @@ static unsigned int contains(struct diff_filespec *one,
 	return cnt;
 }
 
-static int has_changes(struct diff_filepair *p, const char *needle,
-		       unsigned long len, regex_t *regexp, kwset_t kws)
+static int has_changes(struct diff_filepair *p, struct diff_options *o,
+		       regex_t *regexp, kwset_t kws)
 {
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
 			return 0; /* ignore unmerged */
 		/* created */
-		return contains(p->two, needle, len, regexp, kws) != 0;
+		return contains(p->two, o, regexp, kws) != 0;
 	}
 	if (!DIFF_FILE_VALID(p->two))
-		return contains(p->one, needle, len, regexp, kws) != 0;
+		return contains(p->one, o, regexp, kws) != 0;
 	if (!diff_unmodified_pair(p)) {
-		return contains(p->one, needle, len, regexp, kws) !=
-		       contains(p->two, needle, len, regexp, kws);
+		return contains(p->one, o, regexp, kws) !=
+		       contains(p->two, o, regexp, kws);
 	}
 	return 0;
 }
@@ -241,7 +241,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (has_changes(p, needle, len, regexp, kws))
+			if (has_changes(p, o, regexp, kws))
 				goto out; /* do not munge the queue */
 		}
 
@@ -257,7 +257,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (has_changes(p, needle, len, regexp, kws))
+			if (has_changes(p, o, regexp, kws))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
-- 
1.7.7
