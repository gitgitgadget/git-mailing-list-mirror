From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 4/4] t4033-diff-patience: factor out tests
Date: Thu,  7 Jul 2011 12:23:58 +0800
Message-ID: <1310012638-3668-5-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-2-git-send-email-rctay89@gmail.com>
 <1310012638-3668-3-git-send-email-rctay89@gmail.com>
 <1310012638-3668-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeg8p-0008P1-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1GGEYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 00:24:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1GGEYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 00:24:36 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so535294iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 21:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rd5Kd0M2QwujlzSXIK3St+aeZHRkWnTLnFndOFcROD0=;
        b=b1HHq8ni9oKc683m1vdZVCyHHcF+JIlHDIvQlJy3+wRQtLo3MHLp6IKlKEMDabEP7u
         fQSmV7cE+bGPdxTZwHbTduQukUHmZYNA8a34QcdxgvKyebDlk695Kxvz9Y8Tyk1dk0VH
         IYsM3e9cKQqS70QqT0FacQe00fmv3+ZSsSsaU=
Received: by 10.42.155.2 with SMTP id s2mr409220icw.26.1310012675990;
        Wed, 06 Jul 2011 21:24:35 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id a9sm1110556icy.18.2011.07.06.21.24.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 21:24:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310012638-3668-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176746>

Group the test cases into two functions, test_diff_(frobnitz|unique).
This in preparation for the histogram diff algorithm, which would also
re-use these test cases.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v2: refactored tests live in lib-diff-alternative.sh
instead of lib-diff-patience.sh.

 t/lib-diff-alternative.sh |  165 +++++++++++++++++++++++++++++++++++++++++++++
 t/t4033-diff-patience.sh  |  162 +-------------------------------------------
 2 files changed, 168 insertions(+), 159 deletions(-)
 create mode 100644 t/lib-diff-alternative.sh

diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
new file mode 100644
index 0000000..75ffd91
--- /dev/null
+++ b/t/lib-diff-alternative.sh
@@ -0,0 +1,165 @@
+#!/bin/sh
+
+test_diff_frobnitz() {
+	cat >file1 <<\EOF
+#include <stdio.h>
+
+// Frobs foo heartily
+int frobnitz(int foo)
+{
+    int i;
+    for(i = 0; i < 10; i++)
+    {
+        printf("Your answer is: ");
+        printf("%d\n", foo);
+    }
+}
+
+int fact(int n)
+{
+    if(n > 1)
+    {
+        return fact(n-1) * n;
+    }
+    return 1;
+}
+
+int main(int argc, char **argv)
+{
+    frobnitz(fact(10));
+}
+EOF
+
+	cat >file2 <<\EOF
+#include <stdio.h>
+
+int fib(int n)
+{
+    if(n > 2)
+    {
+        return fib(n-1) + fib(n-2);
+    }
+    return 1;
+}
+
+// Frobs foo heartily
+int frobnitz(int foo)
+{
+    int i;
+    for(i = 0; i < 10; i++)
+    {
+        printf("%d\n", foo);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    frobnitz(fib(10));
+}
+EOF
+
+	cat >expect <<\EOF
+diff --git a/file1 b/file2
+index 6faa5a3..e3af329 100644
+--- a/file1
++++ b/file2
+@@ -1,26 +1,25 @@
+ #include <stdio.h>
+ 
++int fib(int n)
++{
++    if(n > 2)
++    {
++        return fib(n-1) + fib(n-2);
++    }
++    return 1;
++}
++
+ // Frobs foo heartily
+ int frobnitz(int foo)
+ {
+     int i;
+     for(i = 0; i < 10; i++)
+     {
+-        printf("Your answer is: ");
+         printf("%d\n", foo);
+     }
+ }
+ 
+-int fact(int n)
+-{
+-    if(n > 1)
+-    {
+-        return fact(n-1) * n;
+-    }
+-    return 1;
+-}
+-
+ int main(int argc, char **argv)
+ {
+-    frobnitz(fact(10));
++    frobnitz(fib(10));
+ }
+EOF
+
+	STRATEGY=$1
+
+	test_expect_success "$STRATEGY diff" '
+		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff output is valid" '
+		mv file2 expect &&
+		git apply < output &&
+		test_cmp expect file2
+	'
+}
+
+test_diff_unique() {
+	cat >uniq1 <<\EOF
+1
+2
+3
+4
+5
+6
+EOF
+
+	cat >uniq2 <<\EOF
+a
+b
+c
+d
+e
+f
+EOF
+
+	cat >expect <<\EOF
+diff --git a/uniq1 b/uniq2
+index b414108..0fdf397 100644
+--- a/uniq1
++++ b/uniq2
+@@ -1,6 +1,6 @@
+-1
+-2
+-3
+-4
+-5
+-6
++a
++b
++c
++d
++e
++f
+EOF
+
+	STRATEGY=$1
+
+	test_expect_success 'completely different files' '
+		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output &&
+		test_cmp expect output
+	'
+}
+
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 1eb1498..3c9932e 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -3,166 +3,10 @@
 test_description='patience diff algorithm'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
-cat >file1 <<\EOF
-#include <stdio.h>
+test_diff_frobnitz "patience"
 
-// Frobs foo heartily
-int frobnitz(int foo)
-{
-    int i;
-    for(i = 0; i < 10; i++)
-    {
-        printf("Your answer is: ");
-        printf("%d\n", foo);
-    }
-}
-
-int fact(int n)
-{
-    if(n > 1)
-    {
-        return fact(n-1) * n;
-    }
-    return 1;
-}
-
-int main(int argc, char **argv)
-{
-    frobnitz(fact(10));
-}
-EOF
-
-cat >file2 <<\EOF
-#include <stdio.h>
-
-int fib(int n)
-{
-    if(n > 2)
-    {
-        return fib(n-1) + fib(n-2);
-    }
-    return 1;
-}
-
-// Frobs foo heartily
-int frobnitz(int foo)
-{
-    int i;
-    for(i = 0; i < 10; i++)
-    {
-        printf("%d\n", foo);
-    }
-}
-
-int main(int argc, char **argv)
-{
-    frobnitz(fib(10));
-}
-EOF
-
-cat >expect <<\EOF
-diff --git a/file1 b/file2
-index 6faa5a3..e3af329 100644
---- a/file1
-+++ b/file2
-@@ -1,26 +1,25 @@
- #include <stdio.h>
- 
-+int fib(int n)
-+{
-+    if(n > 2)
-+    {
-+        return fib(n-1) + fib(n-2);
-+    }
-+    return 1;
-+}
-+
- // Frobs foo heartily
- int frobnitz(int foo)
- {
-     int i;
-     for(i = 0; i < 10; i++)
-     {
--        printf("Your answer is: ");
-         printf("%d\n", foo);
-     }
- }
- 
--int fact(int n)
--{
--    if(n > 1)
--    {
--        return fact(n-1) * n;
--    }
--    return 1;
--}
--
- int main(int argc, char **argv)
- {
--    frobnitz(fact(10));
-+    frobnitz(fib(10));
- }
-EOF
-
-test_expect_success 'patience diff' '
-
-	test_must_fail git diff --no-index --patience file1 file2 > output &&
-	test_cmp expect output
-
-'
-
-test_expect_success 'patience diff output is valid' '
-
-	mv file2 expect &&
-	git apply < output &&
-	test_cmp expect file2
-
-'
-
-cat >uniq1 <<\EOF
-1
-2
-3
-4
-5
-6
-EOF
-
-cat >uniq2 <<\EOF
-a
-b
-c
-d
-e
-f
-EOF
-
-cat >expect <<\EOF
-diff --git a/uniq1 b/uniq2
-index b414108..0fdf397 100644
---- a/uniq1
-+++ b/uniq2
-@@ -1,6 +1,6 @@
--1
--2
--3
--4
--5
--6
-+a
-+b
-+c
-+d
-+e
-+f
-EOF
-
-test_expect_success 'completely different files' '
-
-	test_must_fail git diff --no-index --patience uniq1 uniq2 > output &&
-	test_cmp expect output
-
-'
+test_diff_unique "patience"
 
 test_done
-- 
1.7.3.4.676.gf08cd.dirty
