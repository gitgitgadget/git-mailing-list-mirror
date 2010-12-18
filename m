From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] Improved error messages when temporary file creation
	fails
Date: Sat, 18 Dec 2010 22:28:00 +0100
Message-ID: <20101218212800.GB29089@bzzt.net>
References: <20101207181633.GF25767@bzzt.net> <20101218165514.GT25767@bzzt.net> <20101218200516.GA10031@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 22:28:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4K8-0007XS-5f
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab0LRV2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 16:28:04 -0500
Received: from smtp-4.concepts.nl ([213.197.30.111]:58882 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab0LRV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 16:28:03 -0500
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PU4Js-0004UB-9t; Sat, 18 Dec 2010 22:28:00 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PU4Js-0008Rq-G1; Sat, 18 Dec 2010 22:28:00 +0100
Content-Disposition: inline
In-Reply-To: <20101218200516.GA10031@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1PU4Js-0004UB-9t
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163936>

Improve error messages when creating a temporary file fails.

Before, when creating a temporary file failed, a generic 'Unable to create 
temporary file' message was printed. In some cases this could lead to 
confusion as to which directory should be checked for correct permissions etc.

This patch adds the template for the temporary filename to the error message,
converting it to an absolute path if needed. A test verifies that the template
is indeed printed when pointing to a nonexistent or unwritable directory.

(a copy of the original template is made in case mkstemp clears the template)

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>
---
The use of a fixed-length buffer to temporarily store the template
for the error path is now sort of moot since make_nonrelative_path doesn't
allow filenames larger than PATH_MAX anyway.

Some more tweaks based on Jonathan's feedback: xstrdup, #include of 
git-compat-util.h in the unittest and for whitespace around the '*' in 
pointer declarations.

 Makefile               |    1 +
 t/t0070-fundamental.sh |   13 +++++++++++++
 test-mktemp.c          |   14 ++++++++++++++
 wrapper.c              |   32 ++++++++++++++++++++++++++++----
 4 files changed, 56 insertions(+), 4 deletions(-)
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
index 0000000..c8c5421
--- /dev/null
+++ b/test-mktemp.c
@@ -0,0 +1,14 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include "git-compat-util.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2)
+		usage("Expected 1 parameter defining the temporary file template");
+
+	xmkstemp(xstrdup(argv[1]));
+
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 4c1639f..0c208c2 100644
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
+		const char *nonrelative_template;
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
+		const char *nonrelative_template;
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
