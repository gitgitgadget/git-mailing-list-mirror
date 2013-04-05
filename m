From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] log -L: fix overlapping input ranges
Date: Fri, 5 Apr 2013 16:34:48 +0200
Message-ID: <c6e42a44fe0b21504bf504986b6a988f08c00646.1365172322.git.trast@inf.ethz.ch>
References: <cover.1365172322.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWIu-0002u6-8K
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161846Ab3DEOe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 10:34:58 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34508 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161777Ab3DEOe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 10:34:56 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:42 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.239) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:52 +0200
X-Mailer: git-send-email 1.8.2.662.g6b31d33
In-Reply-To: <cover.1365172322.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220201>

The existing code was too defensive, and would trigger the assert in
range_set_append() if the user gave overlapping ranges.

The intent was always to define overlapping ranges as just the union
of all of them, as evidenced by the call to sort_and_merge_range_set().
(Which was already used, unlike what the comment said.)

Fix by splitting out the meat of range_set_append() to a new _unsafe()
function that lacks the paranoia.  sort_and_merge_range_set will fix
up the ranges, so we don't need the checks there.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 line-log.c                          |  17 ++--
 t/t4211-line-log.sh                 |   6 ++
 t/t4211/expect.multiple             | 104 ++++++++++++++++++++
 t/t4211/expect.multiple-overlapping | 187 ++++++++++++++++++++++++++++++++++++
 t/t4211/expect.multiple-superset    |  59 ++++++++++++
 5 files changed, 366 insertions(+), 7 deletions(-)
 create mode 100644 t/t4211/expect.multiple
 create mode 100644 t/t4211/expect.multiple-overlapping
 create mode 100644 t/t4211/expect.multiple-superset

diff --git a/line-log.c b/line-log.c
index 5a12ceb..85c7c24 100644
--- a/line-log.c
+++ b/line-log.c
@@ -56,16 +56,21 @@ static void range_set_move(struct range_set *dst, struct range_set *src)
 }
 
 /* tack on a _new_ range _at the end_ */
-static void range_set_append(struct range_set *rs, long a, long b)
+static void range_set_append_unsafe(struct range_set *rs, long a, long b)
 {
 	assert(a <= b);
-	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
 	range_set_grow(rs, 1);
 	rs->ranges[rs->nr].start = a;
 	rs->ranges[rs->nr].end = b;
 	rs->nr++;
 }
 
+static void range_set_append(struct range_set *rs, long a, long b)
+{
+	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
+	range_set_append_unsafe(rs, a, b);
+}
+
 static int range_cmp(const void *_r, const void *_s)
 {
 	const struct range *r = _r;
@@ -99,10 +104,8 @@ static void range_set_check_invariants(struct range_set *rs)
 }
 
 /*
- * Helper: In-place pass of sorting and merging the ranges in the
- * range set, to re-establish the invariants after another operation
- *
- * NEEDSWORK currently not needed
+ * In-place pass of sorting and merging the ranges in the range set,
+ * to establish the invariants when we get the ranges from the user
  */
 static void sort_and_merge_range_set(struct range_set *rs)
 {
@@ -280,7 +283,7 @@ static void line_log_data_insert(struct line_log_data **list,
 	struct line_log_data *p = search_line_log_data(*list, spec->path, &ip);
 
 	if (p) {
-		range_set_append(&p->ranges, begin, end);
+		range_set_append_unsafe(&p->ranges, begin, end);
 		sort_and_merge_range_set(&p->ranges);
 		free_filespec(spec);
 		return;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 426a828..2341351 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -39,6 +39,12 @@ canned_test "-L 24,+1:a.c simple" vanishes-early
 
 canned_test "-L '/long f/,/^}/:b.c' move-support" move-support-f
 
+canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
+canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
+canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
+canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
+canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
+
 test_bad_opts "-L" "switch.*requires a value"
 test_bad_opts "-L b.c" "argument.*not of the form"
 test_bad_opts "-L 1:" "argument.*not of the form"
diff --git a/t/t4211/expect.multiple b/t/t4211/expect.multiple
new file mode 100644
index 0000000..76ad5b5
--- /dev/null
+++ b/t/t4211/expect.multiple
@@ -0,0 +1,104 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
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
+@@ -3,9 +3,9 @@
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
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
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
+@@ -3,8 +3,9 @@
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
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/expect.multiple-overlapping b/t/t4211/expect.multiple-overlapping
new file mode 100644
index 0000000..d930b6e
--- /dev/null
+++ b/t/t4211/expect.multiple-overlapping
@@ -0,0 +1,187 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,21 @@
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
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,19 @@
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
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
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
+@@ -3,19 +3,19 @@
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
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+ }
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
+@@ -3,19 +3,19 @@
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
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
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
+@@ -3,18 +3,19 @@
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
+ int main ()
+ {
+ 	printf("%d\n", f(15));
+ 	return 0;
+ }
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
+@@ -0,0 +3,18 @@
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
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/expect.multiple-superset b/t/t4211/expect.multiple-superset
new file mode 100644
index 0000000..a1f5bc4
--- /dev/null
+++ b/t/t4211/expect.multiple-superset
@@ -0,0 +1,59 @@
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
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
+commit f04fb20f2c77850996cba739709acc6faecc58f7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
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
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
-- 
1.8.2.662.g6b31d33
