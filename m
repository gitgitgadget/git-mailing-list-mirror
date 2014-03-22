From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 07/10] pickaxe: merge diffcore_pickaxe_grep() and diffcore_pickaxe_count() into diffcore_pickaxe()
Date: Sat, 22 Mar 2014 18:15:57 +0100
Message-ID: <1395508560-19893-8-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXL-00025U-4D
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaCVRQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:32 -0400
Received: from mout.web.de ([212.227.17.12]:51002 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaCVRQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:30 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MJTYJ-1WPUmp43jv-00350g; Sat, 22 Mar 2014 18:16:25
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:Ch7p4VZsnW3Pni5MF928F5mScwqDaWEMQd7mxY3lC2VvSAxCIwF
 FkI9qTz4cLsiLxMgnBZB8wKUAQFIhSgHHyMGtnajD7OXxAQdjUDQKdIAiga/44mrQ2Obj2P
 3iVVzTVTpvA5pjOo2YzzHdKyXA0UtPZsjxNnePi69v9srhjWLzufNTMYSbLSPnqS3tohK0t
 DereeYAx6mnlgbny7NytA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244777>

diffcore_pickaxe_count() initializes the regular expression or kwset for
the search term, calls pickaxe() with the callback has_changes() and
cleans up afterwards.  diffcore_pickaxe_grep() does the same, only it
doesn't support kwset and uses the callback diff_grep() instead.  Merge
the two functions to form the new diffcore_pickaxe() and thus get rid of
the duplicate regex setup and cleanup code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-pickaxe.c | 48 +++++++++---------------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cb75851..cfc4262 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -108,29 +108,6 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	return ecbdata.hit;
 }
 
-static void diffcore_pickaxe_grep(struct diff_options *o)
-{
-	int err;
-	regex_t regex;
-	int cflags = REG_EXTENDED | REG_NEWLINE;
-
-	if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
-		cflags |= REG_ICASE;
-
-	err = regcomp(&regex, o->pickaxe, cflags);
-	if (err) {
-		char errbuf[1024];
-		regerror(err, &regex, errbuf, 1024);
-		regfree(&regex);
-		die("invalid regex: %s", errbuf);
-	}
-
-	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
-
-	regfree(&regex);
-	return;
-}
-
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
@@ -227,7 +204,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	return ret;
 }
 
-static void diffcore_pickaxe_count(struct diff_options *o)
+void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
@@ -235,7 +212,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
 
-	if (opts & DIFF_PICKAXE_REGEX) {
+	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int err;
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
@@ -256,20 +233,13 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		kwsprep(kws);
 	}
 
-	pickaxe(&diff_queued_diff, o, regexp, kws, has_changes);
-
-	if (opts & DIFF_PICKAXE_REGEX)
-		regfree(&regex);
-	else
-		kwsfree(kws);
-	return;
-}
-
-void diffcore_pickaxe(struct diff_options *o)
-{
 	/* Might want to warn when both S and G are on; I don't care... */
-	if (o->pickaxe_opts & DIFF_PICKAXE_KIND_G)
-		diffcore_pickaxe_grep(o);
+	pickaxe(&diff_queued_diff, o, regexp, kws,
+		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
+
+	if (regexp)
+		regfree(regexp);
 	else
-		diffcore_pickaxe_count(o);
+		kwsfree(kws);
+	return;
 }
-- 
1.9.1
