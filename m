From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 16/17] Add tests for line history browser
Date: Wed, 11 Aug 2010 23:03:41 +0800
Message-ID: <1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCsW-0005Yv-68
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab0HKPGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:06:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0HKPGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:06:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so73597pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4PI2Oxda3TmvYr1Rcl+4tTBKpz8/+kDOYR062MUzPTg=;
        b=JxPkdcycZ0FoE+G5KhzXKYcbK0X5nxGIR4jdOZzf4soJD3UCw2tyXCZs9cK4NMfcii
         HLyc65y4NYAWtLvvLgXvPFhphaEBaBBjN5Annt30B/vMguTgauN3Whr8PNRcukr9Pbdj
         +p0yG93sc9Pcbz1jUHMYeqGITNcGTTtlrJem8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CwK2L7FIPQsACstUjr1RsN3JDip3aET7yvc2bfVNH/QMamfr3xx2le69wFqrtb+ond
         C6PiaS1Kbv7p0JAn7xbhZGPfeM7+2GfVNw8y47MpV7vEMSmjAEqwBGT80k6ayJLueEkA
         gRPKmz6GVYpSUm/wGUGgz7ris26ihwDeiz5go=
Received: by 10.114.46.3 with SMTP id t3mr21804890wat.103.1281539159179;
        Wed, 11 Aug 2010 08:05:59 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153254>

t/t4301-log-line-single-history.sh:
  test the linear line of history.

t/t4302-log-line-merge-history.sh:
  test the case that there are merges in the history.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
Note that applying this with --whitespace=fix will make the tests
fail, as there are diffs contained which must preserve the SP TAB
sequence of context lines.
 t/t4301-log-line-single-history.sh |  627 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |  163 ++++++++++
 2 files changed, 790 insertions(+), 0 deletions(-)
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
new file mode 100755
index 0000000..19b0cb7
--- /dev/null
+++ b/t/t4301-log-line-single-history.sh
@@ -0,0 +1,627 @@
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
+    'Show the line level log of path0' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current-path0'
+
+test_expect_success 'validate the path0 output.' '
+    test_cmp current-path0 expected-path0
+'
+test_expect_success \
+    'Show the line level log of path1' \
+    'git log --pretty=format:%s%n%b -L /output/,/^}/ path1 > current-path1'
+
+test_expect_success 'validate the path1 output.' '
+    test_cmp current-path1 expected-path1
+'
+test_expect_success \
+	'Show the line level log of two files' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 -L /output/,/^}/ path1 > current-pathall'
+
+test_expect_success 'validate the all path output.' '
+    test_cmp current-pathall expected-pathall
+'
+test_expect_success \
+	'Test the line number argument' \
+	'git log --pretty=format:%s%n%b -L 1,2 path0 > current-linenum'
+
+test_expect_success 'validate the line number output.' '
+    test_cmp current-linenum expected-linenum
+'
+test_expect_success \
+	'Test the --full-line-diff option' \
+	'git log --pretty=format:%s%n%b --full-line-diff -L 1,2 path0 > current-always'
+
+test_expect_success 'validate the --full-line-diff output.' '
+    test_cmp current-always expected-always
+'
+
+# Rerun all log with graph
+test_expect_success \
+    'Show the line level log of path0 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 > current-path0-graph'
+
+test_expect_success \
+    'Show the line level log of path1 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /output/,/^}/ path1 > current-path1-graph'
+
+test_expect_success \
+    'Show the line level log of two files with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 --graph -L /output/,/^}/ path1 > current-pathall-graph'
+
+test_expect_success \
+    'Test the line number argument with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L 1,2 path0 > current-linenum-graph'
+
+test_expect_success \
+	'Test the --full-line-diff option with --graph option' \
+	'git log --pretty=format:%s%n%b --full-line-diff --graph -L 1,2 path0 > current-always-graph'
+
+cat > expected-path0-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
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
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
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
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
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
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
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
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-pathall-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
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
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
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
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+| diff --git a/path1 b/path1
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-linenum-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+| -	int a = 0;
+| +	int a = 10;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,2 @@
+  +void func(){
+  +	int a = 0;
+EOF
+
+cat > expected-always-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+|  	int a = 10;
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+|  	int a = 10;
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+| -	int a = 0;
+| +	int a = 10;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,2 @@
+  +void func(){
+  +	int a = 0;
+EOF
+
+test_expect_success \
+    'validate the path0 output.' \
+    'test_cmp current-path0-graph expected-path0-graph'
+test_expect_success \
+	'validate the path1 output.' \
+	'test_cmp current-path1-graph expected-path1-graph'
+test_expect_success \
+	'validate the all path output.' \
+	'test_cmp current-pathall-graph expected-pathall-graph'
+test_expect_success \
+	'validate graph output' \
+	'test_cmp current-linenum-graph expected-linenum-graph'
+test_expect_success \
+	'validate --full-line-diff output' \
+	'test_cmp current-always-graph expected-always-graph'
+
+test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
new file mode 100755
index 0000000..1536cc4
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,163 @@
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
+
+cat > expected-graph <<\EOF
+*   Merge two branches
+|\  
+| | 
+| | nontrivial merge found
+| | path0
+| | @@ 2,1 @@
+| |  	printf("hello earth and moon");
+| | 
+| |   
+| * Change path0 in master
+| | 
+| | diff --git a/path0 b/path0
+| | index f628dea..bef7fa3 100644
+| | --- a/path0
+| | +++ b/path0
+| | @@ -2,1 +2,1 @@
+| | -	printf("hello");
+| | +	printf("hello earth");
+| |   
+* | Change path0 in feature
+|/  
+|   
+|   diff --git a/path0 b/path0
+|   index f628dea..a940ef6 100644
+|   --- a/path0
+|   +++ b/path0
+|   @@ -2,1 +2,1 @@
+|   -	printf("hello");
+|   +	print("hello moon");
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..f628dea
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,1 @@
+  +	printf("hello");
+EOF
+
+test_expect_success \
+    'Show the line log of the 2 line of path0 with graph' \
+    'git log --pretty=format:%s%n%b --graph -L 2,+1 path0 > current-graph'
+
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current expected'
+test_expect_success \
+    'validate the graph output.' \
+    'test_cmp current-graph expected-graph'
+
+test_done
-- 
1.7.2.19.g79e5d
