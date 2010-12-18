From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] Improved error messages when temporary file creation
	fails
Date: Sat, 18 Dec 2010 17:55:14 +0100
Message-ID: <20101218165514.GT25767@bzzt.net>
References: <20101207181633.GF25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 20:50:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU2nO-00072Z-TK
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 20:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab0LRTsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 14:48:50 -0500
Received: from smtp-4.concepts.nl ([213.197.30.111]:59687 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab0LRTst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 14:48:49 -0500
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PU2lm-0004SC-Jb
	for git@vger.kernel.org; Sat, 18 Dec 2010 20:48:42 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@ETC_MAILNAME>)
	id 1PU03u-00020u-Fu
	for git@vger.kernel.org; Sat, 18 Dec 2010 17:55:14 +0100
Content-Disposition: inline
In-Reply-To: <20101207181633.GF25767@bzzt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1PU2lm-0004SC-Jb
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163925>

Updated version of the patch, taking into account the feedback from this 
thread. (the use of a fixed-length buffer to temporarily store the template
for the error path is now sort of moot since make_nonrelative_path doesn't 
allow filenames larger than PATH_MAX anyway)

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>
---
 Makefile               |    1 +
 t/t0070-fundamental.sh |   13 +++++++++++++
 test-mktemp.c          |   15 +++++++++++++++
 wrapper.c              |   32 ++++++++++++++++++++++++++++----
 4 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100644 test-mktemp.c

diff --git a/Makefile b/Makefile
index 57d9c65..03a51cb 100644
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
index 0000000..00fdd78
--- /dev/null
+++ b/test-mktemp.c
@@ -0,0 +1,15 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include <string.h>
+#include "git-compat-util.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2)
+		usage("Expected 1 parameter defining the temporary file template");
+
+	xmkstemp(strdup(argv[1]));
+
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 4c1639f..9af40ee 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -196,10 +196,22 @@ FILE *xfdopen(int fd, const char *mode)
 int xmkstemp(char *template)
 {
 	int fd;
+	char origtemplate[PATH_MAX];
+	strlcpy(origtemplate, template, sizeof(origtemplate));
 
 	fd = mkstemp(template);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		int saved_errno = errno;
+		const char * nonrelative_template;
+
+		if (!template[0])
+			template = origtemplate;
+
+		nonrelative_template = make_nonrelative_path(template);
+		errno = saved_errno;
+		die_errno("Unable to create temporary file '%s'", 
+			nonrelative_template);
+	}
 	return fd;
 }
 
@@ -319,10 +331,22 @@ int gitmkstemps(char *pattern, int suffix_len)
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
+	char origtemplate[PATH_MAX];
+	strlcpy(origtemplate, template, sizeof(origtemplate));
 
 	fd = git_mkstemp_mode(template, mode);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		int saved_errno = errno;
+		const char * nonrelative_template;
+
+		if (!template[0])
+			template = origtemplate;
+
+		nonrelative_template = make_nonrelative_path(template);
+		errno = saved_errno;
+		die_errno("Unable to create temporary file '%s'", 
+			nonrelative_template);
+	}
 	return fd;
 }
 
-- 
1.7.2.3
