From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/4] Change NUL char handling of isspecial()
Date: Sat, 17 Jan 2009 16:50:34 +0100
Message-ID: <1232207434.16172.106.camel@ubuntu.ubuntu-domain>
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
X-From: git-owner@vger.kernel.org Sat Jan 17 16:52:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODT2-0003lH-6T
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763644AbZAQPui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763137AbZAQPui
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:50:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:38803 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762849AbZAQPug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:50:36 -0500
Received: from [10.0.1.101] (p57B7D6A5.dip.t-dialin.net [87.183.214.165])
	by india601.server4you.de (Postfix) with ESMTPSA id A295A2F8059;
	Sat, 17 Jan 2009 16:50:34 +0100 (CET)
In-Reply-To: <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106069>

Replace isspecial() by the new macro is_glob_special(), which is more,
well, specialized.  The former included the NUL char in its character
class, while the letter only included characters that are special to
file name globbing.

The new name contains underscores because they enhance readability
considerably now that it's made up of three words.  Renaming the
function is necessary to document its changed scope.

The call sites of isspecial() are updated to check explicitly for NUL.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This patch applies to next (plus the previous ones in this series).

 ctype.c           |    4 ++--
 dir.c             |    4 ++--
 git-compat-util.h |    4 ++--
 grep.c            |    5 +++--
 test-ctype.c      |    6 ++++++
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/ctype.c b/ctype.c
index 6528687..9de187c 100644
--- a/ctype.c
+++ b/ctype.c
@@ -9,11 +9,11 @@ enum {
 	S = GIT_SPACE,
 	A = GIT_ALPHA,
 	D = GIT_DIGIT,
-	G = GIT_SPECIAL,	/* \0, *, ?, [, \\ */
+	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
 };
 
 unsigned char sane_ctype[256] = {
-	G, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
 	S, 0, 0, 0, 0, 0, 0, 0, 0, 0, G, 0, 0, 0, 0, 0,		/*  32.. 47 */
 	D, D, D, D, D, D, D, D, D, D, 0, 0, 0, 0, 0, G,		/*  48.. 63 */
diff --git a/dir.c b/dir.c
index 7c59829..d55a41a 100644
--- a/dir.c
+++ b/dir.c
@@ -75,7 +75,7 @@ static int match_one(const char *match, const char *name, int namelen)
 	for (;;) {
 		unsigned char c1 = *match;
 		unsigned char c2 = *name;
-		if (isspecial(c1))
+		if (c1 == '\0' || is_glob_special(c1))
 			break;
 		if (c1 != c2)
 			return 0;
@@ -678,7 +678,7 @@ static int simple_length(const char *match)
 	for (;;) {
 		unsigned char c = *match++;
 		len++;
-		if (isspecial(c))
+		if (c == '\0' || is_glob_special(c))
 			return len;
 	}
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index e20b1e8..7c92588 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -327,13 +327,13 @@ extern unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
-#define GIT_SPECIAL 0x08
+#define GIT_GLOB_SPECIAL 0x08
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
-#define isspecial(x) sane_istest(x,GIT_SPECIAL)
+#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 
diff --git a/grep.c b/grep.c
index 6485760..f9a4525 100644
--- a/grep.c
+++ b/grep.c
@@ -30,8 +30,9 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 
 static int isregexspecial(int c)
 {
-	return isspecial(c) || c == '$' || c == '(' || c == ')' || c == '+' ||
-			       c == '.' || c == '^' || c == '{' || c == '|';
+	return c == '\0' || is_glob_special(c) ||
+		c == '$' || c == '(' || c == ')' || c == '+' ||
+		c == '.' || c == '^' || c == '{' || c == '|';
 }
 
 static int is_fixed(const char *s)
diff --git a/test-ctype.c b/test-ctype.c
index 723eff4..d6425d5 100644
--- a/test-ctype.c
+++ b/test-ctype.c
@@ -21,6 +21,11 @@ static int test_isalnum(int c)
 	return isalnum(c);
 }
 
+static int test_is_glob_special(int c)
+{
+	return is_glob_special(c);
+}
+
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
@@ -34,6 +39,7 @@ static const struct ctype_class {
 	{ "isspace", test_isspace, " \n\r\t" },
 	{ "isalpha", test_isalpha, LOWER UPPER },
 	{ "isalnum", test_isalnum, LOWER UPPER DIGIT },
+	{ "is_glob_special", test_is_glob_special, "*?[\\" },
 	{ NULL }
 };
 
-- 
1.6.1
