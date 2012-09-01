From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2] test-regex: Add a test to check for a bug in the regex routines
Date: Sat, 01 Sep 2012 18:46:54 +0100
Message-ID: <50424A0E.60402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: brian@gernhardtsoftware.com, trast@student.ethz.ch,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQQ-00041g-BL
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab2IAS1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:27:53 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44485 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854Ab2IAS1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:27:52 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5AB65128077;
	Sat,  1 Sep 2012 19:27:51 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 713C2128075;	Sat,  1 Sep 2012 19:27:50 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:27:49 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204640>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 .gitignore             |  1 +
 Makefile               |  1 +
 t/t0070-fundamental.sh |  5 +++++
 test-regex.c           | 20 ++++++++++++++++++++
 4 files changed, 27 insertions(+)
 create mode 100644 test-regex.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..68fe464 100644
--- a/.gitignore
+++ b/.gitignore
@@ -189,6 +189,7 @@
 /test-mktemp
 /test-parse-options
 /test-path-utils
+/test-regex
 /test-revision-walking
 /test-run-command
 /test-sha1
diff --git a/Makefile b/Makefile
index 6b0c961..3b760d3 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 9bee8bf..da2c504 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,4 +25,9 @@ test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'check for a bug in the regex routines' '
+	# if this test fails, re-build git with NO_REGEX=1
+	test-regex
+'
+
 test_done
diff --git a/test-regex.c b/test-regex.c
new file mode 100644
index 0000000..b5bfd54
--- /dev/null
+++ b/test-regex.c
@@ -0,0 +1,20 @@
+#include <git-compat-util.h>
+
+int main(int argc, char **argv)
+{
+	char *pat = "[^={} \t]+";
+	char *str = "={}\nfred";
+	regex_t r;
+	regmatch_t m[1];
+
+	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		die("no match of pattern '%s' to string '%s'", pat, str);
+
+	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
+	if (m[0].rm_so == 3) /* matches '\n' when it should not */
+		die("regex bug confirmed: re-build git with NO_REGEX=1");
+
+	exit(0);
+}
-- 
1.7.12
