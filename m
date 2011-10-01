From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] test-ctype: macrofy
Date: Sat, 01 Oct 2011 18:36:14 +0200
Message-ID: <4E87417E.1060100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 18:36:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA2YE-0006uR-8R
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 18:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab1JAQg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 12:36:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:55664 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab1JAQg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 12:36:28 -0400
Received: from [192.168.2.104] (p4FFD8E7C.dip.t-dialin.net [79.253.142.124])
	by india601.server4you.de (Postfix) with ESMTPSA id 399F62F803A;
	Sat,  1 Oct 2011 18:36:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182564>

Rewrite test-ctype to use a global variable and a macro instead of
wrapper functions for each character class and complicated structs
with loops going through them.  The resulting code may be uglier,
but that's OK for a test program, and it's actually easier to read
and extend.  And much shorter.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 test-ctype.c |   79 +++++++++++++++------------------------------------------
 1 files changed, 21 insertions(+), 58 deletions(-)

diff --git a/test-ctype.c b/test-ctype.c
index 033c749..b4d1f74 100644
--- a/test-ctype.c
+++ b/test-ctype.c
@@ -1,78 +1,41 @@
 #include "cache.h"
 
+static int rc;
 
-static int test_isdigit(int c)
+static void report_error(const char *class, int ch)
 {
-	return isdigit(c);
+	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
+	rc = 1;
 }
 
-static int test_isspace(int c)
+static int is_in(const char *s, int ch)
 {
-	return isspace(c);
+	/* We can't find NUL using strchr.  It's classless anyway. */
+	if (ch == '\0')
+		return 0;
+	return !!strchr(s, ch);
 }
 
-static int test_isalpha(int c)
-{
-	return isalpha(c);
-}
-
-static int test_isalnum(int c)
-{
-	return isalnum(c);
-}
-
-static int test_is_glob_special(int c)
-{
-	return is_glob_special(c);
-}
-
-static int test_is_regex_special(int c)
-{
-	return is_regex_special(c);
+#define TEST_CLASS(t,s) {			\
+	int i;					\
+	for (i = 0; i < 256; i++) {		\
+		if (is_in(s, i) != t(i))	\
+			report_error(#t, i);	\
+	}					\
 }
 
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 
-static const struct ctype_class {
-	const char *name;
-	int (*test_fn)(int);
-	const char *members;
-} classes[] = {
-	{ "isdigit", test_isdigit, DIGIT },
-	{ "isspace", test_isspace, " \n\r\t" },
-	{ "isalpha", test_isalpha, LOWER UPPER },
-	{ "isalnum", test_isalnum, LOWER UPPER DIGIT },
-	{ "is_glob_special", test_is_glob_special, "*?[\\" },
-	{ "is_regex_special", test_is_regex_special, "$()*+.?[\\^{|" },
-	{ NULL }
-};
-
-static int test_class(const struct ctype_class *test)
-{
-	int i, rc = 0;
-
-	for (i = 0; i < 256; i++) {
-		int expected = i ? !!strchr(test->members, i) : 0;
-		int actual = test->test_fn(i);
-
-		if (actual != expected) {
-			rc = 1;
-			printf("%s classifies char %d (0x%02x) wrongly\n",
-			       test->name, i, i);
-		}
-	}
-	return rc;
-}
-
 int main(int argc, char **argv)
 {
-	const struct ctype_class *test;
-	int rc = 0;
-
-	for (test = classes; test->name; test++)
-		rc |= test_class(test);
+	TEST_CLASS(isdigit, DIGIT);
+	TEST_CLASS(isspace, " \n\r\t");
+	TEST_CLASS(isalpha, LOWER UPPER);
+	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
+	TEST_CLASS(is_glob_special, "*?[\\");
+	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
 
 	return rc;
 }
-- 
1.7.7
