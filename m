From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/4] Add ctype test
Date: Sat, 17 Jan 2009 16:50:13 +0100
Message-ID: <1232207413.16172.104.camel@ubuntu.ubuntu-domain>
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
X-From: git-owner@vger.kernel.org Sat Jan 17 16:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODSh-0003eK-Tf
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762402AbZAQPu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762231AbZAQPu0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:50:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:38798 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762073AbZAQPuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:50:25 -0500
Received: from [10.0.1.101] (p57B7D6A5.dip.t-dialin.net [87.183.214.165])
	by india601.server4you.de (Postfix) with ESMTPSA id 03D9B2F8059;
	Sat, 17 Jan 2009 16:50:21 +0100 (CET)
In-Reply-To: <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106068>

Manipulating the character class table in ctype.c by hand is error prone.
To ensure that typos are found quickly, add a test program and script.

test-ctype checks the output of the character class macros isspace() et.
al. by applying them on all possible char values and consulting a list of
all characters in the particular class.  It doesn't check tolower() and
toupper(); this could be added later.

The test script t0070-fundamental.sh is created because there is no good
place for the ctype test, yet -- except for t0000-basic.sh perhaps, but
it doesn't run well on Windows, yet.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile               |    3 ++
 t/t0070-fundamental.sh |   15 +++++++++++
 test-ctype.c           |   66 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100755 t/t0070-fundamental.sh
 create mode 100644 test-ctype.c

diff --git a/Makefile b/Makefile
index 4b1d488..dca61f5 100644
--- a/Makefile
+++ b/Makefile
@@ -1360,6 +1360,7 @@ endif
 ### Testing rules
 
 TEST_PROGRAMS += test-chmtime$X
+TEST_PROGRAMS += test-ctype$X
 TEST_PROGRAMS += test-date$X
 TEST_PROGRAMS += test-delta$X
 TEST_PROGRAMS += test-genrandom$X
@@ -1379,6 +1380,8 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+test-ctype$X: ctype.o
+
 test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
new file mode 100755
index 0000000..680d7d6
--- /dev/null
+++ b/t/t0070-fundamental.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='check that the most basic functions work
+
+
+Verify wrappers and compatibility functions.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'character classes (isspace, isalpha etc.)' '
+	test-ctype
+'
+
+test_done
diff --git a/test-ctype.c b/test-ctype.c
new file mode 100644
index 0000000..723eff4
--- /dev/null
+++ b/test-ctype.c
@@ -0,0 +1,66 @@
+#include "cache.h"
+
+
+static int test_isdigit(int c)
+{
+	return isdigit(c);
+}
+
+static int test_isspace(int c)
+{
+	return isspace(c);
+}
+
+static int test_isalpha(int c)
+{
+	return isalpha(c);
+}
+
+static int test_isalnum(int c)
+{
+	return isalnum(c);
+}
+
+#define DIGIT "0123456789"
+#define LOWER "abcdefghijklmnopqrstuvwxyz"
+#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+
+static const struct ctype_class {
+	const char *name;
+	int (*test_fn)(int);
+	const char *members;
+} classes[] = {
+	{ "isdigit", test_isdigit, DIGIT },
+	{ "isspace", test_isspace, " \n\r\t" },
+	{ "isalpha", test_isalpha, LOWER UPPER },
+	{ "isalnum", test_isalnum, LOWER UPPER DIGIT },
+	{ NULL }
+};
+
+static int test_class(const struct ctype_class *test)
+{
+	int i, rc = 0;
+
+	for (i = 0; i < 256; i++) {
+		int expected = i ? !!strchr(test->members, i) : 0;
+		int actual = test->test_fn(i);
+
+		if (actual != expected) {
+			rc = 1;
+			printf("%s classifies char %d (0x%02x) wrongly\n",
+			       test->name, i, i);
+		}
+	}
+	return rc;
+}
+
+int main(int argc, char **argv)
+{
+	const struct ctype_class *test;
+	int rc = 0;
+
+	for (test = classes; test->name; test++)
+		rc |= test_class(test);
+
+	return rc;
+}
-- 
1.6.1
