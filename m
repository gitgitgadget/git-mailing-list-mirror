From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v5.1 16/17] Add tests for line history browser
Date: Fri, 13 Aug 2010 23:07:33 +0800
Message-ID: <1281712053-24243-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 17:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojvrq-0004of-0l
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 17:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934416Ab0HMPIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 11:08:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34449 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934294Ab0HMPIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 11:08:14 -0400
Received: by pzk26 with SMTP id 26so828811pzk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OkxK+5kgbSWixsxlh1UfSLJctnVej6yA6BJBW6Fy9mA=;
        b=TVHgyY/tz/ouPRpVXrQgLevaxfnn/uki2XAuRK1Y516cQbqw/t4Fab81INz1uGjzGa
         yfihhKAwuCNc+XR+SWPDmpuzkCL1aQLliuH5lCrjLiDXHZFcBAOfqDyioW1rr/8GA31W
         j08W/78b04Si1AljjzLXzEAv6IraJJoEX6/3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HSq+Vw+7iS65DOfdDqo1G5dlpR4uxPdLWhZsf9Ynuv+yjpP+3d5vVAsaw31MHAk0GQ
         1JVtzzeSlyLysJOrVRzTMqXu/3kB9ll8ZDmIlU1ZGaO1z9VcNx+VkS56/3Iuf4F28EE3
         gyjtq8+mY1oNOA65ZVynGXVLRk4IKva/8PbV0=
Received: by 10.114.74.7 with SMTP id w7mr1831201waa.210.1281712081309;
        Fri, 13 Aug 2010 08:08:01 -0700 (PDT)
Received: from localhost.localdomain ([116.226.90.40])
        by mx.google.com with ESMTPS id d39sm4762130wam.4.2010.08.13.08.07.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 08:07:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.113.gbd542
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153473>

t/t4301-log-line-single-history.sh:
  test the linear line of history.

t/t4302-log-line-merge-history.sh:
  test the case that there are merges in the history.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4301-log-line-single-history.sh |  685 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |  174 +++++++++
 2 files changed, 859 insertions(+), 0 deletions(-)
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
new file mode 100755
index 0000000..3197ea8
--- /dev/null
+++ b/t/t4301-log-line-single-history.sh
@@ -0,0 +1,685 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with single line of history'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+EOF
+
+cat >path1 <<\EOF
+void output()
+{
+	printf("hello world");
+}
+EOF
+
+test_expect_success 'add path0/path1 and commit.' '
+	git add path0 path1 &&
+	git commit -m "Base commit"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	int c;
+	c = a + b;
+}
+EOF
+
+cat >path1 <<\EOF
+void output()
+{
+	const char *str = "hello world!";
+	printf("%s", str);
+}
+EOF
+
+test_expect_success 'Change the 2,3 lines of path0 and path1.' '
+	git add path0 path1 &&
+	git commit -m "Change 2,3 lines of path0 and path1"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	int c;
+	c = 10 * (a + b);
+}
+EOF
+
+test_expect_success 'Change the 5th line of path0.' '
+	git add path0 &&
+	git commit -m "Change the 5th line of path0"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	int a = 10;
+	int b = 11;
+	printf("%d", a - b);
+}
+EOF
+
+test_expect_success 'Final change of path0.' '
+	git add path0 &&
+	git commit -m "Final change of path0"
+'
+
+cat >expected-path0 <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,6 @@
+ void func()
+ {
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
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
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
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
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
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,7 @@
++void func()
++{
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
+index 52be2a5..cc54b12 100644
+--- a/path1
++++ b/path1
+@@ -1,4 +1,5 @@
+ void output()
+ {
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..52be2a5
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,4 @@
++void output()
++{
++	printf("hello world");
++}
+EOF
+
+cat >expected-pathall <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,6 @@
+ void func()
+ {
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
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
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
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -1,7 +1,7 @@
+ void func()
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+diff --git a/path1 b/path1
+index 52be2a5..cc54b12 100644
+--- a/path1
++++ b/path1
+@@ -1,4 +1,5 @@
+ void output()
+ {
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,7 @@
++void func()
++{
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..52be2a5
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,4 @@
++void output()
++{
++	printf("hello world");
++}
+EOF
+
+cat >expected-linenum <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +2,3 @@
++{
++	int a = 0;
++	int b = 1;
+EOF
+
+cat >expected-always <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index ccdf243..ccf8bcf 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+ 	int a = 10;
+ 	int b = 11;
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index b0eb888..ccdf243 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+ 	int a = 10;
+ 	int b = 11;
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index fb33939..b0eb888 100644
+--- a/path0
++++ b/path0
+@@ -2,3 +2,3 @@
+ {
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..fb33939
+--- /dev/null
++++ b/path0
+@@ -0,0 +2,3 @@
++{
++	int a = 0;
++	int b = 1;
+EOF
+
+test_expect_success 'Show the line level log of path0' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current-path0
+'
+
+test_expect_success 'validate the path0 output.' '
+	test_cmp current-path0 expected-path0
+'
+
+test_expect_success 'Show the line level log of path1' '
+	git log --pretty=format:%s%n%b -L /output/,/^}/ path1 > current-path1
+'
+
+test_expect_success 'validate the path1 output.' '
+	test_cmp current-path1 expected-path1
+'
+
+test_expect_success 'Show the line level log of two files' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/ path0 -L /output/,/^}/ path1 > current-pathall
+'
+
+test_expect_success 'validate the all path output.' '
+	test_cmp current-pathall expected-pathall
+'
+
+test_expect_success 'Test the line number argument' '
+	git log --pretty=format:%s%n%b -L 2,4 path0 > current-linenum
+'
+
+test_expect_success 'validate the line number output.' '
+	test_cmp current-linenum expected-linenum
+'
+test_expect_success 'Test the --full-line-diff option' '
+	git log --pretty=format:%s%n%b --full-line-diff -L 2,4 path0 > current-always
+'
+
+test_expect_success 'validate the --full-line-diff output.' '
+    test_cmp current-always expected-always
+'
+
+# Rerun all log with graph
+test_expect_success 'Show the line level log of path0 with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 > current-path0-graph
+'
+
+test_expect_success 'Show the line level log of path1 with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /output/,/^}/ path1 > current-path1-graph
+'
+
+test_expect_success 'Show the line level log of two files with --graph' '
+	git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 --graph -L /output/,/^}/ path1 > current-pathall-graph
+'
+
+test_expect_success 'Test the line number argument with --graph' '
+	git log --pretty=format:%s%n%b --graph -L 2,4 path0 > current-linenum-graph
+'
+
+test_expect_success 'Test the --full-line-diff option with --graph option' '
+	git log --pretty=format:%s%n%b --full-line-diff --graph -L 2,4 path0 > current-always-graph
+'
+
+cat > expected-path0-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,6 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,7 @@
+  +void func()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+EOF
+
+cat > expected-path1-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path1 b/path1
+| index 52be2a5..cc54b12 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,4 +1,5 @@
+|  void output()
+|  {
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..52be2a5
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,4 @@
+  +void output()
+  +{
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-pathall-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,6 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,7 +1,7 @@
+|  void func()
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+| diff --git a/path1 b/path1
+| index 52be2a5..cc54b12 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,4 +1,5 @@
+|  void output()
+|  {
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,7 @@
+  +void func()
+  +{
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..52be2a5
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,4 @@
+  +void output()
+  +{
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-linenum-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,3 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+EOF
+
+cat > expected-always-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index ccdf243..ccf8bcf 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index b0eb888..ccdf243 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+|  	int a = 10;
+|  	int b = 11;
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index fb33939..b0eb888 100644
+| --- a/path0
+| +++ b/path0
+| @@ -2,3 +2,3 @@
+|  {
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..fb33939
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,3 @@
+  +{
+  +	int a = 0;
+  +	int b = 1;
+EOF
+
+test_expect_success 'validate the path0 output.' '
+	test_cmp current-path0-graph expected-path0-graph
+'
+
+test_expect_success 'validate the path1 output.' '
+	test_cmp current-path1-graph expected-path1-graph
+'
+
+test_expect_success 'validate the all path output.' '
+	test_cmp current-pathall-graph expected-pathall-graph
+'
+
+test_expect_success 'validate graph output' '
+	test_cmp current-linenum-graph expected-linenum-graph
+'
+
+test_expect_success 'validate --full-line-diff output' '
+	test_cmp current-always-graph expected-always-graph
+'
+
+test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
new file mode 100755
index 0000000..8634116
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with merge commit'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello");
+}
+EOF
+
+test_expect_success 'Add path0 and commit.' '
+	git add path0 &&
+	git commit -m "Base commit"
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello earth");
+}
+EOF
+
+test_expect_success 'Change path0 in master.' '
+	git add path0 &&
+	git commit -m "Change path0 in master"
+'
+
+test_expect_success 'Make a new branch from the base commit' '
+	git checkout -b feature master^
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	print("hello moon");
+}
+EOF
+
+test_expect_success 'Change path0 in feature.' '
+	git add path0 &&
+	git commit -m "Change path0 in feature"
+'
+
+test_expect_success 'Merge the master to feature' '
+	! git merge master
+'
+
+cat >path0 <<\EOF
+void func()
+{
+	printf("hello earth and moon");
+}
+EOF
+
+test_expect_success 'Resolve the conflict' '
+	git add path0 &&
+	git commit -m "Merge two branches"
+'
+
+test_expect_success 'Show the line level log of path0' '
+	git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current
+'
+
+cat >expected <<\EOF
+Merge two branches
+
+nontrivial merge found
+path0
+@@ 3,1 @@
+ 	printf("hello earth and moon");
+
+
+Change path0 in master
+
+diff --git a/path0 b/path0
+index 56aeee5..11e66c5 100644
+--- a/path0
++++ b/path0
+@@ -1,4 +1,4 @@
+ void func()
+ {
+-	printf("hello");
++	printf("hello earth");
+ }
+
+Change path0 in feature
+
+diff --git a/path0 b/path0
+index 56aeee5..258fced 100644
+--- a/path0
++++ b/path0
+@@ -1,4 +1,4 @@
+ void func()
+ {
+-	printf("hello");
++	print("hello moon");
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..56aeee5
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,4 @@
++void func()
++{
++	printf("hello");
++}
+EOF
+
+cat > expected-graph <<\EOF
+*   Merge two branches
+|\  
+| | 
+| | nontrivial merge found
+| | path0
+| | @@ 3,1 @@
+| |  	printf("hello earth and moon");
+| | 
+| |   
+| * Change path0 in master
+| | 
+| | diff --git a/path0 b/path0
+| | index 56aeee5..11e66c5 100644
+| | --- a/path0
+| | +++ b/path0
+| | @@ -3,1 +3,1 @@
+| | -	printf("hello");
+| | +	printf("hello earth");
+| |   
+* | Change path0 in feature
+|/  
+|   
+|   diff --git a/path0 b/path0
+|   index 56aeee5..258fced 100644
+|   --- a/path0
+|   +++ b/path0
+|   @@ -3,1 +3,1 @@
+|   -	printf("hello");
+|   +	print("hello moon");
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..56aeee5
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +3,1 @@
+  +	printf("hello");
+EOF
+
+test_expect_success 'Show the line log of the 2 line of path0 with graph' '
+	git log --pretty=format:%s%n%b --graph -L 3,+1 path0 > current-graph
+'
+
+test_expect_success 'validate the output.' '
+	test_cmp current expected
+'
+
+test_expect_success 'validate the graph output.' '
+	test_cmp current-graph expected-graph
+'
+
+test_done
-- 
1.7.2.1.113.gbd542
