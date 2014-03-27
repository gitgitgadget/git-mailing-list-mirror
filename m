From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 02/10] diffcore-pickaxe.c: refactor regex compilation
Date: Thu, 27 Mar 2014 14:50:48 -0400
Message-ID: <36cbd6934df8cf17a52a4478aa4e2da436feaf0b.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOj-0004oC-C2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbaC0SvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50315 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137AbaC0SvY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:24 -0400
X-AuditID: 1207440d-f79d86d0000043db-4e-5334732cdb38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.36.17371.C2374335; Thu, 27 Mar 2014 14:51:24 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TK013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:23 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsUixO6iqKtTbBJssPKdgMXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4MpYcOcXS8FbkYpTU3pYGxjvCXQxcnJICJhILOiawQ5hi0lcuLeerYuRi0NI4DKjxLf3
	u1khnJVMEnOObWAFqWITcJbY9Gs/E4gtIiAu8fb4THaQImaBhYwSb/dMZgZJCAu4SrybeQds
	LIuAqsSfQ2fBbF6BKImPq7exQawzkPj07AxYPaeAg8Tk+RuBbA6gbfYSH5faQoSjJV5vXQxW
	LgTU+nrrSZYJjPwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRuYoQEIe8O
	xv/rZA4xCnAwKvHwOliYBAuxJpYVV+YeYpTgYFYS4Z1bABTiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOq7ZE3U9IID2xJDU7NbUgtQgmy8TBKdXAqDW/tOrdpWkue4U6HqtP3vLk2yt7IzPdTdK8
	K+7nZbIvr+nMrVW9sF/7ktCSyMyDJXweCw/8+MMuePegY7nuqki+lNcxIkbvPj5Z+M52w57y
	86e6Ht1i9O6LbOM6F3928rJz23bYLt528fys3b8sFA4LBL+V8/goJjHfSexx8sEpSzgX/U5c
	dUOJpTgj0VCLuag4EQDmvO26PgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245310>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

In this file, two functions use identical blocks of code to call the
POSIX regex compiling function and handle a possible error. Here we
factor that block into its own function, in anticipation of using the
same code a third time.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diffcore-pickaxe.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 401eb72..0d36a3c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -12,6 +12,8 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
 			  regex_t *regexp, kwset_t kws);
 
+static void compile_regex(regex_t *r, const char *s, int cflags);
+
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
 
@@ -110,20 +112,13 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 
 static void diffcore_pickaxe_grep(struct diff_options *o)
 {
-	int err;
 	regex_t regex;
 	int cflags = REG_EXTENDED | REG_NEWLINE;
 
 	if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 		cflags |= REG_ICASE;
 
-	err = regcomp(&regex, o->pickaxe, cflags);
-	if (err) {
-		char errbuf[1024];
-		regerror(err, &regex, errbuf, 1024);
-		regfree(&regex);
-		die("invalid regex: %s", errbuf);
-	}
+	compile_regex(&regex, o->pickaxe, cflags);
 
 	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
 
@@ -180,6 +175,18 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 	return one_contains != two_contains;
 }
 
+static void compile_regex(regex_t *r, const char *s, int cflags)
+{
+	int err;
+	err = regcomp(r, s, cflags);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, r, errbuf, 1024);
+		regfree(r);
+		die("invalid regex: %s", errbuf);
+	}
+}
+
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
 {
@@ -236,15 +243,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 	kwset_t kws = NULL;
 
 	if (opts & DIFF_PICKAXE_REGEX) {
-		int err;
-		err = regcomp(&regex, needle, REG_EXTENDED | REG_NEWLINE);
-		if (err) {
-			/* The POSIX.2 people are surely sick */
-			char errbuf[1024];
-			regerror(err, &regex, errbuf, 1024);
-			regfree(&regex);
-			die("invalid regex: %s", errbuf);
-		}
+		compile_regex(&regex, needle, REG_EXTENDED | REG_NEWLINE);
 		regexp = &regex;
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
-- 
1.7.12.4 (Apple Git-37)
