From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/4] log -L: test merge of parallel modify/rename
Date: Fri, 12 Apr 2013 18:05:10 +0200
Message-ID: <75f73cefbce0f5c799dc2003548be53586f2845d.1365781999.git.trast@inf.ethz.ch>
References: <cover.1365781999.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgTd-0000XF-Hc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3DLQFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:05:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6615 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab3DLQFU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:05:20 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:19 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:18 +0200
X-Mailer: git-send-email 1.8.2.1.567.g8ad0f43
In-Reply-To: <cover.1365781999.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220988>

This tests a toy example of a history like

  * Merge
  | \
  |  * Modify foo
  |  |
  *  | Rename foo->bar
  | /
  * Create foo

Current log -L fails on this; we'll fix it in the next commit.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t4211-line-log.sh                      |  16 +++-
 t/t4211/expect.parallel-change-f-to-main | 160 +++++++++++++++++++++++++++++++
 t/t4211/history.export                   |  80 +++++++++++++++-
 3 files changed, 250 insertions(+), 6 deletions(-)
 create mode 100644 t/t4211/expect.parallel-change-f-to-main

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 2a67e31..bba0b09 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -8,13 +8,20 @@ test_expect_success 'setup (import history)' '
 	git reset --hard
 '
 
-canned_test () {
-	test_expect_success "$1" "
-		git log $1 >actual &&
-		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$2 actual
+canned_test_1 () {
+	test_expect_$1 "$2" "
+		git log $2 >actual &&
+		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$3 actual
 	"
 }
 
+canned_test () {
+	canned_test_1 success "$@"
+}
+canned_test_failure () {
+	canned_test_1 failure "$@"
+}
+
 test_bad_opts () {
 	test_expect_success "invalid args: $1" "
 		test_must_fail git log $1 2>errors &&
@@ -38,6 +45,7 @@ canned_test "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple" two-ranges
 canned_test "-L 24,+1:a.c simple" vanishes-early
 
 canned_test "-M -L '/long f/,/^}/:b.c' move-support" move-support-f
+canned_test_failure "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
 canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
diff --git a/t/t4211/expect.parallel-change-f-to-main b/t/t4211/expect.parallel-change-f-to-main
new file mode 100644
index 0000000..052def8
--- /dev/null
+++ b/t/t4211/expect.parallel-change-f-to-main
@@ -0,0 +1,160 @@
+commit 0469c60bc4837d52d97b1f081dec5f98dea20fed
+Merge: ba227c6 6ce3c4f
+Author: Thomas Rast <trast@inf.ethz.ch>
+Date:   Fri Apr 12 16:16:24 2013 +0200
+
+    Merge across the rename
+
+
+commit 6ce3c4ff690136099bb17e1a8766b75764726ea7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:49:50 2013 +0100
+
+    another simple change
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -4,14 +4,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+-		x >>= 1;
++		x /= 2;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+
+commit ba227c6632349700fbb957dec2b50f5e2358be3f
+Author: Thomas Rast <trast@inf.ethz.ch>
+Date:   Fri Apr 12 16:15:57 2013 +0200
+
+    change on another line of history while rename happens
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,14 +4,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * This is only an example!
++ * This is only a short example!
+  */
+ 
+
+commit 39b6eb2d5b706d3322184a169f666f25ed3fbd00
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit f04fb20f2c77850996cba739709acc6faecc58f7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,13 +3,14 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,13 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
diff --git a/t/t4211/history.export b/t/t4211/history.export
index c159794..f9f41e2 100644
--- a/t/t4211/history.export
+++ b/t/t4211/history.export
@@ -325,6 +325,82 @@ move within the file
 from :17
 M 100644 :18 b.c
 
-reset refs/heads/master
-from :19
+blob
+mark :20
+data 243
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x >>= 1;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only a short example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+/* incomplete lines are bad! */
+
+commit refs/heads/parallel-change
+mark :21
+author Thomas Rast <trast@inf.ethz.ch> 1365776157 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1365776157 +0200
+data 55
+change on another line of history while rename happens
+from :14
+M 100644 :20 a.c
+
+blob
+mark :22
+data 242
+#include <unistd.h>
+#include <stdio.h>
+
+long f(long x)
+{
+	int s = 0;
+	while (x) {
+		x /= 2;
+		s++;
+	}
+	return s;
+}
+
+/*
+ * This is only a short example!
+ */
+
+int main ()
+{
+	printf("%ld\n", f(15));
+	return 0;
+}
+
+/* incomplete lines are bad! */
+
+commit refs/heads/parallel-change
+mark :23
+author Thomas Rast <trast@inf.ethz.ch> 1365776184 +0200
+committer Thomas Rast <trast@inf.ethz.ch> 1365776191 +0200
+data 24
+Merge across the rename
+from :21
+merge :17
+D a.c
+M 100644 :22 b.c
+
+reset refs/heads/parallel-change
+from :23
 
-- 
1.8.2.1.567.g8ad0f43
