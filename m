From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 5/8] t4033-diff-patience: factor out tests
Date: Mon,  1 Aug 2011 11:16:45 +0800
Message-ID: <1312168608-10828-6-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
 <1312168608-10828-4-git-send-email-rctay89@gmail.com>
 <1312168608-10828-5-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0Y-00035T-84
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab1HADR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1HADR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:26 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M3l9hiTujO98yl8XVzH/CdvymBlLYPh47ovbXSw1J+k=;
        b=rDIQ8ih+4SfT1sVrVaUlL80Hl9KRpPiecvQn14R7nPDOz0XS0JJi3tut0eLXZSeN24
         P2ruRvn+Xpyhn8tDuGgl+n8PWiVd8Wway6OWa4av8V2LMTKZ4QMAjCeEZsGIT9+9tTfW
         k0pXX6AaGN3gKQeRpp9VdjaBGzrfigfDX1ST0=
Received: by 10.231.114.79 with SMTP id d15mr2742903ibq.3.1312168646516;
        Sun, 31 Jul 2011 20:17:26 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id d8sm6171683icy.9.2011.07.31.20.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178300>

Group the test cases into two functions, test_diff_(frobnitz|unique).
This in preparation for the histogram diff algorithm, which would also
re-use these test cases.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
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
1.7.3.4.730.g67af1.dirty
