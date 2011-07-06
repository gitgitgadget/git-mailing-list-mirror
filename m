From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 4/4] t4033-diff-patience: factor out tests
Date: Thu,  7 Jul 2011 00:38:57 +0800
Message-ID: <1309970337-6016-5-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1309970337-6016-2-git-send-email-rctay89@gmail.com>
 <1309970337-6016-3-git-send-email-rctay89@gmail.com>
 <1309970337-6016-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 18:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeV8Z-0006Ti-2b
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 18:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab1GFQjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 12:39:37 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33952 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab1GFQjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 12:39:36 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so39836qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MTK+n9UL7Aljk2OXI4c+bEOvvs9CCAKo4UObn8MfCF4=;
        b=pK+De258c+k5IWaO9UvEeOqJXJ41Yt2bkgG32lLONuhOYLAmVx3iYekECzgyfqNCvi
         reL18SYczALYLavijIZ13LffQXydIUpFVwBkhRRIJYwfJhJPIC48S6ek5ClRxRznqMBc
         CyMoUyZVm8CytYGrtbjy3TaJ0j4MUvwOQKzF0=
Received: by 10.224.28.194 with SMTP id n2mr433160qac.284.1309970376023;
        Wed, 06 Jul 2011 09:39:36 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id u15sm6511719qcq.12.2011.07.06.09.39.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 09:39:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1309970337-6016-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176714>

Group the test cases into two functions, test_diff_(frobnitz|unique).
This in preparation for the histogram diff algorithm, which would also
re-use these test cases.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Ram: the rename is detected in git-log, but not in the diffstat. The
expected and actual content, which makes up the bulk of content, is
unchanged, but the 'surrounding' changes should be pretty easy to spot.

 t/lib-diff-patience.sh   |  163 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t4033-diff-patience.sh |  162 +--------------------------------------------
 2 files changed, 166 insertions(+), 159 deletions(-)
 create mode 100644 t/lib-diff-patience.sh

diff --git a/t/lib-diff-patience.sh b/t/lib-diff-patience.sh
new file mode 100644
index 0000000..761bb09
--- /dev/null
+++ b/t/lib-diff-patience.sh
@@ -0,0 +1,163 @@
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
index 1eb1498..9fe9921 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -3,166 +3,10 @@
 test_description='patience diff algorithm'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-patience.sh
 
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
1.7.3.4.721.g4666.dirty
