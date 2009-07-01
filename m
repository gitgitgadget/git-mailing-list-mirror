From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/6] grep: handle pre context lines on demand
Date: Thu, 02 Jul 2009 00:05:17 +0200
Message-ID: <4A4BDD9D.8090407@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:05:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7vh-0003dS-Ko
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZGAWFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbZGAWFP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:05:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:55657 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZGAWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:05:14 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id 9A1B12F8068;
	Thu,  2 Jul 2009 00:05:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122606>

Factor out pre context line handling into the new function
show_pre_context() and change the algorithm to rewind by looking for
newline characters and roll forward again, instead of maintaining an
array of line beginnings and ends.

This is slower for hits, but the cost for non-matching lines becomes
zero.  Normally, there are far more non-matching lines, so the time
spent in total decreases.

Before this patch (current Linux kernel repo, best of five runs):

	$ time git grep --no-ext-grep -B1 memset >/dev/null

	real	0m2.134s
	user	0m1.932s
	sys	0m0.196s

	$ time git grep --no-ext-grep -B1000 memset >/dev/null

	real	0m12.059s
	user	0m11.837s
	sys	0m0.224s

The same with this patch:

	$ time git grep --no-ext-grep -B1 memset >/dev/null

	real	0m2.117s
	user	0m1.892s
	sys	0m0.228s

	$ time git grep --no-ext-grep -B1000 memset >/dev/null

	real	0m2.986s
	user	0m2.696s
	sys	0m0.288s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   61 ++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/grep.c b/grep.c
index 4bca759..9b9d2e3 100644
--- a/grep.c
+++ b/grep.c
@@ -531,16 +531,42 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	printf("%.*s\n", rest, bol);
 }
 
+static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
+			     char *bol, unsigned lno)
+{
+	unsigned cur = lno, from = 1;
+
+	if (opt->pre_context < lno)
+		from = lno - opt->pre_context;
+	if (from <= opt->last_shown)
+		from = opt->last_shown + 1;
+
+	/* Rewind. */
+	while (bol > buf && cur > from) {
+		bol--;
+		while (bol > buf && bol[-1] != '\n')
+			bol--;
+		cur--;
+	}
+
+	/* Back forward. */
+	while (cur < lno) {
+		char *eol = bol;
+
+		while (*eol != '\n')
+			eol++;
+		show_line(opt, bol, eol, name, cur, '-');
+		bol = eol + 1;
+		cur++;
+	}
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
 	char *bol = buf;
 	unsigned long left = size;
 	unsigned lno = 1;
-	struct pre_context_line {
-		char *bol;
-		char *eol;
-	} *prev = NULL, *pcl;
 	unsigned last_hit = 0;
 	int binary_match_only = 0;
 	unsigned count = 0;
@@ -561,9 +587,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		}
 	}
 
-	if (opt->pre_context)
-		prev = xcalloc(opt->pre_context, sizeof(*prev));
-
 	while (left) {
 		char *eol, ch;
 		int hit;
@@ -610,21 +633,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 * the context which is nonsense, but the user
 			 * deserves to get that ;-).
 			 */
-			if (opt->pre_context) {
-				unsigned from;
-				if (opt->pre_context < lno)
-					from = lno - opt->pre_context;
-				else
-					from = 1;
-				if (from <= opt->last_shown)
-					from = opt->last_shown + 1;
-				while (from < lno) {
-					pcl = &prev[lno-from-1];
-					show_line(opt, pcl->bol, pcl->eol,
-						  name, from, '-');
-					from++;
-				}
-			}
+			if (opt->pre_context)
+				show_pre_context(opt, name, buf, bol, lno);
 			if (!opt->count)
 				show_line(opt, bol, eol, name, lno, ':');
 			last_hit = lno;
@@ -636,12 +646,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 */
 			show_line(opt, bol, eol, name, lno, '-');
 		}
-		if (opt->pre_context) {
-			memmove(prev+1, prev,
-				(opt->pre_context-1) * sizeof(*prev));
-			prev->bol = bol;
-			prev->eol = eol;
-		}
 
 	next_line:
 		bol = eol + 1;
@@ -651,7 +655,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		lno++;
 	}
 
-	free(prev);
 	if (collect_hits)
 		return 0;
 
-- 
1.6.3.3
