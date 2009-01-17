From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/4] Add is_regex_special()
Date: Sat, 17 Jan 2009 16:50:37 +0100
Message-ID: <1232207437.16172.107.camel@ubuntu.ubuntu-domain>
References: <4967D8F8.9070508@lsrfire.ath.cx>
	 <4967DB4A.2000702@lsrfire.ath.cx>
	 <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
	 <496B9780.3030000@lsrfire.ath.cx>
	 <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODT2-0003lH-SR
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763702AbZAQPum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763676AbZAQPul
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:50:41 -0500
Received: from india601.server4you.de ([85.25.151.105]:38806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763137AbZAQPuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:50:40 -0500
Received: from [10.0.1.101] (p57B7D6A5.dip.t-dialin.net [87.183.214.165])
	by india601.server4you.de (Postfix) with ESMTPSA id 7791F2F8059;
	Sat, 17 Jan 2009 16:50:38 +0100 (CET)
In-Reply-To: <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106070>

Add is_regex_special(), a character class macro for chars that have a
special meaning in regular expressions.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This patch applies to next (plus the previous ones in this series).

 ctype.c           |    7 ++++---
 git-compat-util.h |    2 ++
 grep.c            |    9 +--------
 test-ctype.c      |    6 ++++++
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/ctype.c b/ctype.c
index 9de187c..b90ec00 100644
--- a/ctype.c
+++ b/ctype.c
@@ -10,16 +10,17 @@ enum {
 	A = GIT_ALPHA,
 	D = GIT_DIGIT,
 	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
+	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | * */
 };
 
 unsigned char sane_ctype[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
-	S, 0, 0, 0, 0, 0, 0, 0, 0, 0, G, 0, 0, 0, 0, 0,		/*  32.. 47 */
+	S, 0, 0, 0, R, 0, 0, 0, R, R, G, R, 0, 0, R, 0,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, 0, 0, 0, 0, 0, G,		/*  48.. 63 */
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, 0, 0,		/*  80.. 95 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, 0,		/*  80.. 95 */
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, 0, 0, 0, 0, 0,		/* 112..127 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
diff --git a/git-compat-util.h b/git-compat-util.h
index 7c92588..079cbe9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -328,12 +328,14 @@ extern unsigned char sane_ctype[256];
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
 #define GIT_GLOB_SPECIAL 0x08
+#define GIT_REGEX_SPECIAL 0x10
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
+#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 
diff --git a/grep.c b/grep.c
index f9a4525..062b2b6 100644
--- a/grep.c
+++ b/grep.c
@@ -28,16 +28,9 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 	p->next = NULL;
 }
 
-static int isregexspecial(int c)
-{
-	return c == '\0' || is_glob_special(c) ||
-		c == '$' || c == '(' || c == ')' || c == '+' ||
-		c == '.' || c == '^' || c == '{' || c == '|';
-}
-
 static int is_fixed(const char *s)
 {
-	while (!isregexspecial(*s))
+	while (*s && !is_regex_special(*s))
 		s++;
 	return !*s;
 }
diff --git a/test-ctype.c b/test-ctype.c
index d6425d5..033c749 100644
--- a/test-ctype.c
+++ b/test-ctype.c
@@ -26,6 +26,11 @@ static int test_is_glob_special(int c)
 	return is_glob_special(c);
 }
 
+static int test_is_regex_special(int c)
+{
+	return is_regex_special(c);
+}
+
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
@@ -40,6 +45,7 @@ static const struct ctype_class {
 	{ "isalpha", test_isalpha, LOWER UPPER },
 	{ "isalnum", test_isalnum, LOWER UPPER DIGIT },
 	{ "is_glob_special", test_is_glob_special, "*?[\\" },
+	{ "is_regex_special", test_is_regex_special, "$()*+.?[\\^{|" },
 	{ NULL }
 };
 
-- 
1.6.1
