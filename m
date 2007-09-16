From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/3] git-apply: add tests for stripping of leading and trailing whitespace
Date: Sun, 16 Sep 2007 18:49:02 -0400
Message-ID: <11899829421064-git-send-email-bfields@citi.umich.edu>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
 <11899829424173-git-send-email-bfields@citi.umich.edu>
 <1189982942187-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2vf-0005CX-BL
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXIPWtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbXIPWtK
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:49:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48528 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbXIPWtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:49:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX2vG-00038r-MB; Sun, 16 Sep 2007 18:49:02 -0400
X-Mailer: git-send-email 1.5.3
In-Reply-To: <1189982942187-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58362>

Add tests to make sure we strip leading and trailing whitespace correctly.

Of the four tests, the first two should always have passed, the third
requires the "fix whitespace stripping" patch, and the fourth requires
the "complain about >= 8 consecutive spaces in initial indent" patch.

Note that this patch itself adds leading and trailing whitespace.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 t/t4124-apply-whitespace-strip.sh |   43 +++++++++++++++++++++++++++++++++++++
 t/t4124/1-after                   |    3 ++
 t/t4124/1-before                  |    3 ++
 t/t4124/2-after                   |    3 ++
 t/t4124/2-before                  |    3 ++
 t/t4124/3-after                   |    1 +
 t/t4124/3-before                  |    1 +
 t/t4124/4-after                   |    5 ++++
 t/t4124/4-before                  |    5 ++++
 9 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 t/t4124-apply-whitespace-strip.sh
 create mode 100644 t/t4124/1-after
 create mode 100644 t/t4124/1-before
 create mode 100644 t/t4124/2-after
 create mode 100644 t/t4124/2-before
 create mode 100644 t/t4124/3-after
 create mode 100644 t/t4124/3-before
 create mode 100644 t/t4124/4-after
 create mode 100644 t/t4124/4-before

diff --git a/t/t4124-apply-whitespace-strip.sh b/t/t4124-apply-whitespace-strip.sh
new file mode 100644
index 0000000..3b5f58b
--- /dev/null
+++ b/t/t4124-apply-whitespace-strip.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='handle space and tab combinations with --whitespace=strip'
+
+. ./test-lib.sh
+
+# The directory t4124/ contains pairs of files "n-before" and "n-after",
+# identicaly except leading and trailing whitespace are stripped from
+# the latter.
+#
+# Check that we strip whitespace correctly by checking that the diff
+# between the two files, applied to the first (with --whitespace=strip)
+# produces the second.
+
+mkpatch () {
+	cp "$1" foo
+	git diff /dev/null foo >patch
+	rm foo
+}
+
+checkstrip () {
+	mkpatch "../t4124/$1-before"
+	git apply --whitespace=strip patch
+	git diff foo "../t4124/$1-after"
+}
+
+test_expect_success \
+	'trailing tabs and spaces' \
+	'checkstrip 1'
+
+test_expect_success \
+	'spaces before tabs' \
+	'checkstrip 2' 
+
+test_expect_success \
+	'8 or more non-consecutive initial spaces' \
+	'checkstrip 3'
+
+test_expect_success \
+	'8 or more consecutive initial spaces' \
+	'checkstrip 4'
+
+test_done
diff --git a/t/t4124/1-after b/t/t4124/1-after
new file mode 100644
index 0000000..cf5dfce
--- /dev/null
+++ b/t/t4124/1-after
@@ -0,0 +1,3 @@
+trailing space
+trailing tab
+trailing spaces and tabs
diff --git a/t/t4124/1-before b/t/t4124/1-before
new file mode 100644
index 0000000..1f2505b
--- /dev/null
+++ b/t/t4124/1-before
@@ -0,0 +1,3 @@
+trailing space 
+trailing tab 
+trailing spaces and tabs 	 	 	
diff --git a/t/t4124/2-after b/t/t4124/2-after
new file mode 100644
index 0000000..f198144
--- /dev/null
+++ b/t/t4124/2-after
@@ -0,0 +1,3 @@
+	space tab
+	space space tab
+		tab space tab
diff --git a/t/t4124/2-before b/t/t4124/2-before
new file mode 100644
index 0000000..8fc35bb
--- /dev/null
+++ b/t/t4124/2-before
@@ -0,0 +1,3 @@
+ 	space tab
+  	space space tab
+	 	tab space tab
diff --git a/t/t4124/3-after b/t/t4124/3-after
new file mode 100644
index 0000000..4db0e80
--- /dev/null
+++ b/t/t4124/3-after
@@ -0,0 +1 @@
+		4 spaces, tab, 4 spaces, tab
diff --git a/t/t4124/3-before b/t/t4124/3-before
new file mode 100644
index 0000000..f0e2b9c
--- /dev/null
+++ b/t/t4124/3-before
@@ -0,0 +1 @@
+    	    	4 spaces, tab, 4 spaces, tab
diff --git a/t/t4124/4-after b/t/t4124/4-after
new file mode 100644
index 0000000..a9b8cf6
--- /dev/null
+++ b/t/t4124/4-after
@@ -0,0 +1,5 @@
+       7 spaces
+	8 spaces
+	 9 spaces
+		tab 8 spaces
+		 tab 9 spaces
diff --git a/t/t4124/4-before b/t/t4124/4-before
new file mode 100644
index 0000000..a35b624
--- /dev/null
+++ b/t/t4124/4-before
@@ -0,0 +1,5 @@
+       7 spaces
+        8 spaces
+         9 spaces
+	        tab 8 spaces
+	         tab 9 spaces
-- 
1.5.3.1.42.gfe5df
