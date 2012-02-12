From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/2] Rename lineno_width to decimal_width and export it
Date: Sun, 12 Feb 2012 15:16:20 +0100
Message-ID: <1329056180-29796-1-git-send-email-zbyszek@in.waw.pl>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sun Feb 12 15:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwaEl-0007AX-5J
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 15:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2BLORB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 09:17:01 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52391 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572Ab2BLORA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 09:17:00 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RwaEd-0001x2-Oa; Sun, 12 Feb 2012 15:16:59 +0100
X-Mailer: git-send-email 1.7.9.3.g2429d.dirty
In-Reply-To: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190570>

This function will be used in calculating diff --stat graph width.
The name is changed because the function works for any number.
The function is moved from builtins/blame.c to pager.c because it
will be used not only in builtins/blame.c.
---
 builtin/blame.c | 18 +++---------------
 cache.h         |  1 +
 pager.c         | 12 ++++++++++++
 3 files changed, 16 insertions(+), 15 deletions(-)

This is another function to be exported. I hope it can be exported
together with term_columns(). I'll use it the next version of the diff
--stat patch.

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a67c20..f028e8a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1829,18 +1829,6 @@ static int read_ancestry(const char *graft_file)
 }
 
 /*
- * How many columns do we need to show line numbers in decimal?
- */
-static int lineno_width(int lines)
-{
-	int i, width;
-
-	for (width = 1, i = 10; i <= lines; width++)
-		i *= 10;
-	return width;
-}
-
-/*
  * How many columns do we need to show line numbers, authors,
  * and filenames?
  */
@@ -1880,9 +1868,9 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
 	}
-	max_orig_digits = lineno_width(longest_src_lines);
-	max_digits = lineno_width(longest_dst_lines);
-	max_score_digits = lineno_width(largest_score);
+	max_orig_digits = decimal_width(longest_src_lines);
+	max_digits = decimal_width(longest_dst_lines);
+	max_score_digits = decimal_width(largest_score);
 }
 
 /*
diff --git a/cache.h b/cache.h
index 2f30b3a..3857dfd 100644
--- a/cache.h
+++ b/cache.h
@@ -1176,6 +1176,7 @@ extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
+extern int decimal_width(int number);
 
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/pager.c b/pager.c
index b8049a4..b6d44ef 100644
--- a/pager.c
+++ b/pager.c
@@ -155,3 +155,15 @@ int term_columns(void)
 	term_columns_cache = 80;
 	return term_columns_cache;
 }
+
+/*
+ * How many columns do we need to show numbers in decimal?
+ */
+int decimal_width(int number)
+{
+	int i, width;
+
+	for (width = 1, i = 10; i <= number; width++)
+		i *= 10;
+	return width;
+}
-- 
1.7.9.3.g2429d.dirty
