From: Arnout Engelen <arnouten@bzzt.net>
Subject: [PATCH] Improved error messages when temporary file creation fails
Date: Tue, 7 Dec 2010 19:16:33 +0100
Message-ID: <20101207181633.GF25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 19:16:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ25t-0001d7-2x
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab0LGSQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:16:38 -0500
Received: from smtp-4.concepts.nl ([213.197.30.111]:41860 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab0LGSQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:16:37 -0500
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PQ25Z-0007eP-DT
	for git@vger.kernel.org; Tue, 07 Dec 2010 19:16:33 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PQ25Z-0006HV-Tp
	for git@vger.kernel.org; Tue, 07 Dec 2010 19:16:33 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1PQ25Z-0007eP-DT
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163101>

This patch has been submitted/discussed before, but that version doesn't apply
cleanly to the newest git anymore, so here's an updated version. 

It improves diagnostic error messages when creating a temporary file fails.

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>
---
 Makefile               |    1 +
 t/t0070-fundamental.sh |   13 +++++++++++++
 test-mktemp.c          |   16 ++++++++++++++++
 wrapper.c              |   29 +++++++++++++++++++++++++----
 wrapper.h              |    4 ++++
 5 files changed, 59 insertions(+), 4 deletions(-)
 create mode 100644 test-mktemp.c
 create mode 100644 wrapper.h

diff --git a/Makefile b/Makefile
index 7a5fb69..10cfab2 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-mktemp
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 680d7d6..9bee8bf 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -12,4 +12,17 @@ test_expect_success 'character classes (isspace, isalpha etc.)' '
 	test-ctype
 '
 
+test_expect_success 'mktemp to nonexistent directory prints filename' '
+	test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
+	grep "doesnotexist/test" err
+'
+
+test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
+	mkdir cannotwrite &&
+	chmod -w cannotwrite &&
+	test_when_finished "chmod +w cannotwrite" &&
+	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
+	grep "cannotwrite/test" err
+'
+
 test_done
diff --git a/test-mktemp.c b/test-mktemp.c
new file mode 100644
index 0000000..d392fa7
--- /dev/null
+++ b/test-mktemp.c
@@ -0,0 +1,16 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include <string.h>
+#include "git-compat-util.h"
+#include "wrapper.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		usage("Expected 1 parameter defining the temporary file template");
+	}
+	xmkstemp(strdup(argv[1]));
+
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 4c1639f..6640c87 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "wrapper.h"
 
 static void do_nothing(size_t size)
 {
@@ -196,10 +197,20 @@ FILE *xfdopen(int fd, const char *mode)
 int xmkstemp(char *template)
 {
 	int fd;
+	char origtemplate[255];
+	strlcpy(origtemplate, template, 255);
 
 	fd = mkstemp(template);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (!template[0])
+			template = origtemplate;
+
+		if (is_absolute_path(template))
+			die_errno("Unable to create temporary file '%s'", template);
+		else
+			die_errno("Unable to create temporary file '%s' at %s", 
+				template, getcwd(NULL, 0));
+	}
 	return fd;
 }
 
@@ -319,10 +330,20 @@ int gitmkstemps(char *pattern, int suffix_len)
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
+	char origtemplate[255];
+	strlcpy(origtemplate, template, 255);
 
 	fd = git_mkstemp_mode(template, mode);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (!template[0])
+			template = origtemplate;
+
+		if (is_absolute_path(template))
+			die_errno("Unable to create temporary file '%s'", template);
+		else
+			die_errno("Unable to create temporary file '%s' at %s", 
+				template, getcwd(NULL, 0));
+	}
 	return fd;
 }
 
diff --git a/wrapper.h b/wrapper.h
new file mode 100644
index 0000000..b06ff0d
--- /dev/null
+++ b/wrapper.h
@@ -0,0 +1,4 @@
+/*
+ * Various trivial helper wrappers around standard functions
+ */
+int xmkstemp(char *template);
-- 
1.7.2.3
