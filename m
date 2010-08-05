From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 11/18] Add tests for line history browser
Date: Fri,  6 Aug 2010 00:11:50 +0800
Message-ID: <1281024717-7855-12-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35I-0001XF-2v
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933449Ab0HEQNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933477Ab0HEQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XOjTMs3LYlnkooj/Zd0gyc1jwTjlM9Se5ypUdoNt6zk=;
        b=HsDs9fa/kl5bwfpkPBDTtLKt+HPbMqmsmvZofeR3XJ7mt8r+kD2LfxB/OaK4Kf+oaI
         b0rT896VEhgKkV93/9ej2i15tdrd2GujKwcriDTBLo9C1CjJMlfQkKzAql/J4C9OgTx9
         TuG4vsdBnO+RjTf2dw+KHF7NeXF8BW/4NtFFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X5ZwW8rM3vGf90i95O6/Cwr6MMLx8qJv/MRdBKjFPd6bIrUkS4Vn23m9/kJMiXBbvT
         N0le06ZN80def2ZMULN1Weler6wNvwSSUYce9dtVw+CITu5Jou/Kwv47aw42jFG9jeC8
         DyA9C0WmlxHFbYQ9W2qHW7AHhXN1+WedCevFQ=
Received: by 10.142.218.19 with SMTP id q19mr5478438wfg.153.1281024795258;
        Thu, 05 Aug 2010 09:13:15 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152674>

t4301: for simple linear history only
t4302: for history containing merge

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4301-log-line-single-history.sh |  342 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |  114 ++++++++++++
 2 files changed, 456 insertions(+), 0 deletions(-)
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
new file mode 100755
index 0000000..9cf34f8
--- /dev/null
+++ b/t/t4301-log-line-single-history.sh
@@ -0,0 +1,342 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with single line of history
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'void func(){
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+'
+
+echo >path1 'void output(){
+	printf("hello world");
+}
+'
+
+test_expect_success \
+    'add path0/path1 and commit.' \
+    'git add path0 path1 &&
+     git commit -m "Base commit"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	int c;
+	c = a + b;
+}
+'
+
+echo >path1 'void output(){
+	const char *str = "hello world!";
+	printf("%s", str);
+}
+'
+
+test_expect_success \
+    'Change the 2,3 lines of path0 and path1.' \
+    'git add path0 path1 &&
+     git commit -m "Change 2,3 lines of path0 and path1"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	int c;
+	c = 10 * (a + b);
+}
+'
+
+test_expect_success \
+	'Change the 5th line of path0.' \
+	'git add path0 &&
+	 git commit -m "Change the 5th line of path0"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	printf("%d", a - b);
+}
+'
+
+test_expect_success \
+	'Final change of path0.' \
+	'git add path0 &&
+	 git commit -m "Final change of path0"'
+
+test_expect_success \
+    'Show the line level log of path0' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current-path0'
+
+test_expect_success \
+    'Show the line level log of path1' \
+    'git log --pretty=format:%s%n%b -L /output/,/^}/ path1 > current-path1'
+
+test_expect_success \
+	'Show the line level log of two files' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 -L /output/,/^}/ path1 > current-pathall'
+
+test_expect_success \
+	'Test the line number argument' \
+	'git log --pretty=format:%s%n%b -L 1,2 path0 > current-linenum'
+
+test_expect_success \
+	'Test the --full-line-diff option' \
+	'git log --pretty=format:%s%n%b --full-line-diff -L 1,2 path0 > current-always'
+
+cat >expected-path0 <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,5 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,6 @@
++void func(){
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+EOF
+
+cat >expected-path1 <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path1 b/path1
+index 997d841..1d711b5 100644
+--- a/path1
++++ b/path1
+@@ -1,3 +1,4 @@
+ void output(){
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..997d841
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,3 @@
++void output(){
++	printf("hello world");
++}
+EOF
+
+cat >expected-pathall <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,5 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+diff --git a/path1 b/path1
+index 997d841..1d711b5 100644
+--- a/path1
++++ b/path1
+@@ -1,3 +1,4 @@
+ void output(){
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,6 @@
++void func(){
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..997d841
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,3 @@
++void output(){
++	printf("hello world");
++}
+EOF
+
+cat >expected-linenum <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+-	int a = 0;
++	int a = 10;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,2 @@
++void func(){
++	int a = 0;
+EOF
+
+cat >expected-always <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+ 	int a = 10;
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+ 	int a = 10;
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+-	int a = 0;
++	int a = 10;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,2 @@
++void func(){
++	int a = 0;
+EOF
+
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current-path0 expected-path0 &&
+	 test_cmp current-path1 expected-path1 &&
+	 test_cmp current-pathall expected-pathall &&
+	 test_cmp current-linenum expected-linenum &&
+	 test_cmp current-always expected-always'
+
+test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
new file mode 100755
index 0000000..02e7439
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with merge commit
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'void func(){
+	printf("hello");
+}
+'
+
+test_expect_success \
+    'Add path0 and commit.' \
+    'git add path0 &&
+     git commit -m "Base commit"'
+
+echo >path0 'void func(){
+	printf("hello earth");
+}
+'
+
+test_expect_success \
+    'Change path0 in master.' \
+    'git add path0 &&
+     git commit -m "Change path0 in master"'
+
+test_expect_success \
+	'Make a new branch from the base commit' \
+	'git checkout -b feature master^'
+
+echo >path0 'void func(){
+	print("hello moon");
+}
+'
+
+test_expect_success \
+    'Change path0 in feature.' \
+    'git add path0 &&
+     git commit -m "Change path0 in feature"'
+
+test_expect_success \
+	'Merge the master to feature' \
+	'! git merge master'
+
+echo >path0 'void func(){
+	printf("hello earth and moon");
+}
+'
+
+test_expect_success \
+	'Resolve the conflict' \
+	'git add path0 &&
+	 git commit -m "Merge two branches"'
+
+test_expect_success \
+    'Show the line level log of path0' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current'
+
+cat >expected <<\EOF
+Merge two branches
+
+nontrivial merge found
+path0
+
+@@ 2,1 @@
+ 	printf("hello earth and moon");
+
+
+Change path0 in master
+
+diff --git a/path0 b/path0
+index f628dea..bef7fa3 100644
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ void func(){
+-	printf("hello");
++	printf("hello earth");
+ }
+
+Change path0 in feature
+
+diff --git a/path0 b/path0
+index f628dea..a940ef6 100644
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ void func(){
+-	printf("hello");
++	print("hello moon");
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..f628dea
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,3 @@
++void func(){
++	printf("hello");
++}
+EOF
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current expected'
+
+test_done
-- 
1.7.2.20.g388bbb
