From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Mon, 18 Oct 2010 11:20:00 +0200
Message-ID: <20101018092000.GH9348@bzzt.net>
References: <20101009201751.GK9348@bzzt.net> <20101010024124.GA20305@burratino> <20101010103327.GO9348@bzzt.net> <20101010180909.GA12320@burratino> <7v8w24oygk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ltC-0000aw-HV
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab0JRJUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 05:20:08 -0400
Received: from smtp-4.concepts.nl ([213.197.30.111]:51471 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0JRJUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 05:20:06 -0400
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P7lsu-0004yS-2f; Mon, 18 Oct 2010 11:20:00 +0200
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P7lsu-0007Ev-9H; Mon, 18 Oct 2010 11:20:00 +0200
Content-Disposition: inline
In-Reply-To: <7v8w24oygk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1P7lsu-0004yS-2f
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159242>

On Mon, Oct 11, 2010 at 08:56:59PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> >> On Sat, Oct 09, 2010 at 09:41:24PM -0500, Jonathan Nieder wrote:
> >>> 	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
> >>> 	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device
> >
> > Converting the filename to an absolute path with make_absolute_path
> > might be useful, but I am not entirely sure it is worth the
> > complication.
> 
> I am not sure if it is worth the strdup "just in case it fails" either.

I think it's valuable to give better error messages. A strdup/strncpy does not
take much resources (especially compared to creating the temporary file), and 
makes the code only slightly less readable as the change is fairly local. 

Below is an updated patch that:
- copies the original template to the stack to be able to log it in case 
  mkstemp clears it
- on failure, logs the modified template, if any, or the original one
- logs the CWD when the template is relative
- adds a test testing this gives sane output (and doesn't crash, etc)

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>

---
 Makefile          |    1 +
 t/t0007-mktemp.sh |   16 ++++++++++++++++
 test-mktemp.c     |   25 +++++++++++++++++++++++++
 wrapper.c         |   30 ++++++++++++++++++++++++++----
 4 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100755 t/t0007-mktemp.sh
 create mode 100644 test-mktemp.c

diff --git a/Makefile b/Makefile
index 1f1ce04..30aafa2 100644
--- a/Makefile
+++ b/Makefile
@@ -428,6 +428,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-mktemp
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/t0007-mktemp.sh b/t/t0007-mktemp.sh
new file mode 100755
index 0000000..7abeeca
--- /dev/null
+++ b/t/t0007-mktemp.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description='test creating temporary files'
+. ./test-lib.sh
+
+check_errormsg() {
+	test_expect_success "$1" "
+		test-mktemp $2 &>actual
+		grep \"$3\" actual
+		"
+}
+
+check_errormsg "Creating temporary file in nonexisting directory" n "Unable to create temporary file '/tmp/does/not/exist/test"
+check_errormsg "Creating temporary file in invalid relative directory" p "at /"
+
+test_done
diff --git a/test-mktemp.c b/test-mktemp.c
new file mode 100644
index 0000000..fad2908
--- /dev/null
+++ b/test-mktemp.c
@@ -0,0 +1,25 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include "wrapper.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Expected 1 parameter defining the situation to test");
+		exit(-1);
+	}
+	switch (argv[1][0]) {
+		case 'n':
+			// temporary file in nonexistent directory
+			xmkstemp(strdup("/tmp/does/not/exist/testXXXXXX"));
+			break;
+		case 'p':
+			// temporary file in directory where we have no write permissions
+			xmkstemp(strdup("../../foo/testXXXXXX"));
+			break;
+		default:
+			fprintf(stderr, "No such test case: %s\n", argv[0]);
+	}
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..b588e67 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -212,20 +212,42 @@ FILE *xfdopen(int fd, const char *mode)
 int xmkstemp(char *template)
 {
 	int fd;
+	char originalTemplate[255];
+	strncpy(originalTemplate, template, 255);
+	originalTemplate[254] = '\0';
 
 	fd = mkstemp(template);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (strlen(template) == 0) {
+			template = originalTemplate;
+		}
+		if (*template == '/') {
+			die_errno("Unable to create temporary file '%s'", template);
+		} else {
+			die_errno("Unable to create temporary file '%s' at %s", template, getcwd(NULL, 0));
+		}
+	}
 	return fd;
 }
 
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
+	char originalTemplate[255];
+	strncpy(originalTemplate, template, 255);
+	originalTemplate[254] = '\0';
 
 	fd = git_mkstemp_mode(template, mode);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (strlen(template) == 0) {
+			template = originalTemplate;
+		}
+		if (*template == '/') {
+			die_errno("Unable to create temporary file '%s'", template);
+		} else {
+			die_errno("Unable to create temporary file '%s' at %s", template, getcwd(NULL, 0));
+		}
+	}
 	return fd;
 }
 
-- 
1.7.2.3
