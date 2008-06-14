From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] mask necessary whitespace policy violations in test
	scripts
Date: Sat, 14 Jun 2008 02:54:28 -0400
Message-ID: <20080614065428.GB9006@sigill.intra.peff.net>
References: <20080614064857.GA8930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:55:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7PfZ-0008Ns-I1
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbYFNGyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYFNGyb
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:54:31 -0400
Received: from peff.net ([208.65.91.99]:1271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYFNGya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:54:30 -0400
Received: (qmail 28101 invoked by uid 111); 14 Jun 2008 06:54:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 02:54:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 02:54:28 -0400
Content-Disposition: inline
In-Reply-To: <20080614064857.GA8930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84967>

All of these violations are necessary parts of the tests
(which are generally checking the behavior of trailing
whitespace, or contain diff fragments with empty lines).

Our solution is two-fold:

  1. Process input with whitespace problems using tr. This
     has the added bonus that it becomes very obvious where
     the bogus whitespace is intended to go.

  2. Move large diff fragments into their own supplemental
     files. This gets rid of the whitespace problem, since
     supplemental files are not checked, and it also makes
     the test script a bit easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, the diff fragments could simply use empty lines to indicate an
empty context line, instead of a single space. This matches the GNU diff
format which Linus added support for a while back. However, I think
this change actually makes the test script more readable, and there is
something wrong to me about taking advantage of a diff convention that
we complained so much about at the time. ;)

 t/t4015-diff-whitespace.sh |    8 +-
 t/t4109-apply-multifrag.sh |  132 +------------------------------------------
 t/t4109/patch1.patch       |   28 +++++++++
 t/t4109/patch2.patch       |   30 ++++++++++
 t/t4109/patch3.patch       |   31 ++++++++++
 t/t4109/patch4.patch       |   30 ++++++++++
 t/t4119-apply-config.sh    |    4 +-
 7 files changed, 129 insertions(+), 134 deletions(-)
 create mode 100644 t/t4109/patch1.patch
 create mode 100644 t/t4109/patch2.patch
 create mode 100644 t/t4109/patch3.patch
 create mode 100644 t/t4109/patch4.patch

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ca0302f..b7cc6b2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -62,16 +62,16 @@ EOF
 
 git update-index x
 
-cat << EOF > x
+tr '_' ' ' << EOF > x
 	whitespace at beginning
 whitespace 	 change
 white space in the middle
-whitespace at end  
+whitespace at end__
 unchanged line
 CR at end
 EOF
 
-tr 'Q' '\015' << EOF > expect
+tr 'Q_' '\015 ' << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 --- a/x
@@ -84,7 +84,7 @@ index d99af23..8b32fb5 100644
 +	whitespace at beginning
 +whitespace 	 change
 +white space in the middle
-+whitespace at end  
++whitespace at end__
  unchanged line
 -CR at endQ
 +CR at end
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index bd40a21..ff5fdf3 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -9,134 +9,10 @@ test_description='git apply test patches with multiple fragments.
 '
 . ./test-lib.sh
 
-# setup
-
-cat > patch1.patch <<\EOF
-diff --git a/main.c b/main.c
-new file mode 100644
---- /dev/null
-+++ b/main.c
-@@ -0,0 +1,23 @@
-+#include <stdio.h>
-+
-+int func(int num);
-+void print_int(int num);
-+
-+int main() {
-+	int i;
-+
-+	for (i = 0; i < 10; i++) {
-+		print_int(func(i));
-+	}
-+
-+	return 0;
-+}
-+
-+int func(int num) {
-+	return num * num;
-+}
-+
-+void print_int(int num) {
-+	printf("%d", num);
-+}
-+
-EOF
-cat > patch2.patch <<\EOF
-diff --git a/main.c b/main.c
---- a/main.c
-+++ b/main.c
-@@ -1,7 +1,9 @@
-+#include <stdlib.h>
- #include <stdio.h>
- 
- int func(int num);
- void print_int(int num);
-+void print_ln();
- 
- int main() {
- 	int i;
-@@ -10,6 +12,8 @@
- 		print_int(func(i));
- 	}
- 
-+	print_ln();
-+
- 	return 0;
- }
- 
-@@ -21,3 +25,7 @@
- 	printf("%d", num);
- }
- 
-+void print_ln() {
-+	printf("\n");
-+}
-+
-EOF
-cat > patch3.patch <<\EOF
-diff --git a/main.c b/main.c
---- a/main.c
-+++ b/main.c
-@@ -1,9 +1,7 @@
--#include <stdlib.h>
- #include <stdio.h>
- 
- int func(int num);
- void print_int(int num);
--void print_ln();
- 
- int main() {
- 	int i;
-@@ -12,8 +10,6 @@
- 		print_int(func(i));
- 	}
- 
--	print_ln();
--
- 	return 0;
- }
- 
-@@ -25,7 +21,3 @@
- 	printf("%d", num);
- }
- 
--void print_ln() {
--	printf("\n");
--}
--
-EOF
-cat > patch4.patch <<\EOF
-diff --git a/main.c b/main.c
---- a/main.c
-+++ b/main.c
-@@ -1,13 +1,14 @@
- #include <stdio.h>
- 
- int func(int num);
--void print_int(int num);
-+int func2(int num);
- 
- int main() {
- 	int i;
- 
- 	for (i = 0; i < 10; i++) {
--		print_int(func(i));
-+		printf("%d", func(i));
-+		printf("%d", func3(i));
- 	}
- 
- 	return 0;
-@@ -17,7 +18,7 @@
- 	return num * num;
- }
- 
--void print_int(int num) {
--	printf("%d", num);
-+int func2(int num) {
-+	return num * num * num;
- }
- 
-EOF
+cp ../t4109/patch1.patch .
+cp ../t4109/patch2.patch .
+cp ../t4109/patch3.patch .
+cp ../t4109/patch4.patch .
 
 test_expect_success "S = git apply (1)" \
     'git apply patch1.patch patch2.patch'
diff --git a/t/t4109/patch1.patch b/t/t4109/patch1.patch
new file mode 100644
index 0000000..1d411fc
--- /dev/null
+++ b/t/t4109/patch1.patch
@@ -0,0 +1,28 @@
+diff --git a/main.c b/main.c
+new file mode 100644
+--- /dev/null
++++ b/main.c
+@@ -0,0 +1,23 @@
++#include <stdio.h>
++
++int func(int num);
++void print_int(int num);
++
++int main() {
++	int i;
++
++	for (i = 0; i < 10; i++) {
++		print_int(func(i));
++	}
++
++	return 0;
++}
++
++int func(int num) {
++	return num * num;
++}
++
++void print_int(int num) {
++	printf("%d", num);
++}
++
diff --git a/t/t4109/patch2.patch b/t/t4109/patch2.patch
new file mode 100644
index 0000000..8c6b06d
--- /dev/null
+++ b/t/t4109/patch2.patch
@@ -0,0 +1,30 @@
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,7 +1,9 @@
++#include <stdlib.h>
+ #include <stdio.h>
+ 
+ int func(int num);
+ void print_int(int num);
++void print_ln();
+ 
+ int main() {
+ 	int i;
+@@ -10,6 +12,8 @@
+ 		print_int(func(i));
+ 	}
+ 
++	print_ln();
++
+ 	return 0;
+ }
+ 
+@@ -21,3 +25,7 @@
+ 	printf("%d", num);
+ }
+ 
++void print_ln() {
++	printf("\n");
++}
++
diff --git a/t/t4109/patch3.patch b/t/t4109/patch3.patch
new file mode 100644
index 0000000..d696c55
--- /dev/null
+++ b/t/t4109/patch3.patch
@@ -0,0 +1,31 @@
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,9 +1,7 @@
+-#include <stdlib.h>
+ #include <stdio.h>
+ 
+ int func(int num);
+ void print_int(int num);
+-void print_ln();
+ 
+ int main() {
+ 	int i;
+@@ -12,8 +10,6 @@
+ 		print_int(func(i));
+ 	}
+ 
+-	print_ln();
+-
+ 	return 0;
+ }
+ 
+@@ -25,7 +21,3 @@
+ 	printf("%d", num);
+ }
+ 
+-void print_ln() {
+-	printf("\n");
+-}
+-
diff --git a/t/t4109/patch4.patch b/t/t4109/patch4.patch
new file mode 100644
index 0000000..4b08590
--- /dev/null
+++ b/t/t4109/patch4.patch
@@ -0,0 +1,30 @@
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,13 +1,14 @@
+ #include <stdio.h>
+ 
+ int func(int num);
+-void print_int(int num);
++int func2(int num);
+ 
+ int main() {
+ 	int i;
+ 
+ 	for (i = 0; i < 10; i++) {
+-		print_int(func(i));
++		printf("%d", func(i));
++		printf("%d", func3(i));
+ 	}
+ 
+ 	return 0;
+@@ -17,7 +18,7 @@
+ 	return num * num;
+ }
+ 
+-void print_int(int num) {
+-	printf("%d", num);
++int func2(int num) {
++	return num * num * num;
+ }
+ 
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index b540f72..3c73a78 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -19,12 +19,12 @@ test_expect_success setup '
 '
 
 # Also handcraft GNU diff output; note this has trailing whitespace.
-cat >gpatch.file <<\EOF &&
+tr '_' ' ' >gpatch.file <<\EOF &&
 --- file1	2007-02-21 01:04:24.000000000 -0800
 +++ file1+	2007-02-21 01:07:44.000000000 -0800
 @@ -1 +1 @@
 -A
-+B 
++B_
 EOF
 
 sed -e 's|file1|sub/&|' gpatch.file >gpatch-sub.file &&
-- 
1.5.6.rc2.183.g04614
