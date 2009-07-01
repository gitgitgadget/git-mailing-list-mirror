From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/6] grep: move context hunk mark handling into show_line()
Date: Thu, 02 Jul 2009 00:02:38 +0200
Message-ID: <4A4BDCFE.3050808@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7t7-0002qM-RK
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZGAWCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbZGAWCg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:02:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:55651 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZGAWCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:02:35 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id 458E02F8068;
	Thu,  2 Jul 2009 00:02:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122604>

Move last_shown into struct grep_opt, to make it available in
show_line(), and then make the function handle the printing of hunk
marks for context lines in a central place.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   26 +++++++++++---------------
 grep.h |    1 +
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/grep.c b/grep.c
index 92a47c7..6ee80f7 100644
--- a/grep.c
+++ b/grep.c
@@ -490,6 +490,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 {
 	int rest = eol - bol;
 
+	if (opt->pre_context || opt->post_context) {
+		if (opt->last_shown && lno > opt->last_shown + 1)
+			fputs("--\n", stdout);
+	}
+	opt->last_shown = lno;
+
 	if (opt->null_following_name)
 		sign = '\0';
 	if (opt->pathname)
@@ -531,12 +537,12 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		char *eol;
 	} *prev = NULL, *pcl;
 	unsigned last_hit = 0;
-	unsigned last_shown = 0;
 	int binary_match_only = 0;
-	const char *hunk_mark = "";
 	unsigned count = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 
+	opt->last_shown = 0;
+
 	if (buffer_is_binary(buf, size)) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
@@ -552,8 +558,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	if (opt->pre_context)
 		prev = xcalloc(opt->pre_context, sizeof(*prev));
-	if (opt->pre_context || opt->post_context)
-		hunk_mark = "--\n";
 
 	while (left) {
 		char *eol, ch;
@@ -607,33 +611,25 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 					from = lno - opt->pre_context;
 				else
 					from = 1;
-				if (from <= last_shown)
-					from = last_shown + 1;
-				if (last_shown && from != last_shown + 1)
-					fputs(hunk_mark, stdout);
+				if (from <= opt->last_shown)
+					from = opt->last_shown + 1;
 				while (from < lno) {
 					pcl = &prev[lno-from-1];
 					show_line(opt, pcl->bol, pcl->eol,
 						  name, from, '-');
 					from++;
 				}
-				last_shown = lno-1;
 			}
-			if (last_shown && lno != last_shown + 1)
-				fputs(hunk_mark, stdout);
 			if (!opt->count)
 				show_line(opt, bol, eol, name, lno, ':');
-			last_shown = last_hit = lno;
+			last_hit = lno;
 		}
 		else if (last_hit &&
 			 lno <= last_hit + opt->post_context) {
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			if (last_shown && lno != last_shown + 1)
-				fputs(hunk_mark, stdout);
 			show_line(opt, bol, eol, name, lno, '-');
-			last_shown = lno;
 		}
 		if (opt->pre_context) {
 			memmove(prev+1, prev,
diff --git a/grep.h b/grep.h
index 464e272..0883214 100644
--- a/grep.h
+++ b/grep.h
@@ -84,6 +84,7 @@ struct grep_opt {
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
+	unsigned last_shown;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
-- 
1.6.3.3
