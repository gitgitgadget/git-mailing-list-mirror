From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff: fix 2 whitespace issues
Date: Thu, 12 Oct 2006 14:22:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610121418180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 12 14:23:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXzaP-0004FV-QU
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWJLMWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWJLMWS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 08:22:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:64900 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751007AbWJLMWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 08:22:16 -0400
Received: (qmail invoked by alias); 12 Oct 2006 12:22:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 12 Oct 2006 14:22:15 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, Ray Lehtiniemi <rayl@mail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28777>


When whitespace or whitespace change was ignored, the function
xdl_recmatch() returned memcmp() style differences, which is wrong,
since it should return 0 on non-match.

Also, there were three horrible off-by-one bugs, even leading to wrong
hashes in the whitespace special handling.

The issue was noticed by Ray Lehtiniemi.

For good measure, this commit adds a test.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	These bugs are embarassing. I have no idea how my tests succeeded 
	when I submitted the support for -b and -w...

	Note that "git diff --check" complains about six whitespaces
	at the end of line in the test, which are there on purpose.

 t/t4015-diff-whitespace.sh |  122 ++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xutils.c             |   29 ++++------
 2 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
new file mode 100755
index 0000000..c945085
--- /dev/null
+++ b/t/t4015-diff-whitespace.sh
@@ -0,0 +1,122 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+#
+
+test_description='Test special whitespace in diff engine.
+
+'
+. ./test-lib.sh
+. ../diff-lib.sh
+
+# Ray Lehtiniemi's example
+
+cat << EOF > x
+do {
+   nothing;
+} while (0);
+EOF
+
+git-update-index --add x
+
+cat << EOF > x
+do
+{
+   nothing;
+}
+while (0);
+EOF
+
+cat << EOF > expect
+diff --git a/x b/x
+index adf3937..6edc172 100644
+--- a/x
++++ b/x
+@@ -1,3 +1,5 @@
+-do {
++do
++{
+    nothing;
+-} while (0);
++}
++while (0);
+EOF
+
+git-diff > out
+test_expect_success "Ray's example without options" 'diff -u expect out'
+
+git-diff -w > out
+test_expect_success "Ray's example with -w" 'diff -u expect out'
+
+git-diff -b > out
+test_expect_success "Ray's example with -b" 'diff -u expect out'
+
+cat << EOF > x
+whitespace at beginning
+whitespace change
+whitespace in the middle
+whitespace at end
+unchanged line
+CR at end
+EOF
+
+git-update-index x
+
+cat << EOF > x
+	whitespace at beginning
+whitespace 	 change
+white space in the middle
+whitespace at end  
+unchanged line
+CR at end
+EOF
+
+cat << EOF > expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+--- a/x
++++ b/x
+@@ -1,6 +1,6 @@
+-whitespace at beginning
+-whitespace change
+-whitespace in the middle
+-whitespace at end
++	whitespace at beginning
++whitespace 	 change
++white space in the middle
++whitespace at end  
+ unchanged line
+-CR at end
++CR at end
+EOF
+git-diff > out
+test_expect_success 'another test, without options' 'diff -u expect out'
+
+cat << EOF > expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+EOF
+git-diff -w > out
+test_expect_success 'another test, with -w' 'diff -u expect out'
+
+cat << EOF > expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+--- a/x
++++ b/x
+@@ -1,6 +1,6 @@
+-whitespace at beginning
++	whitespace at beginning
+ whitespace change
+-whitespace in the middle
+-whitespace at end
++white space in the middle
++whitespace at end  
+ unchanged line
+-CR at end
++CR at end
+EOF
+git-diff -b > out
+test_expect_success 'another test, with -b' 'diff -u expect out'
+
+test_done
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index f7bdd39..9e4bb47 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -191,36 +191,30 @@ int xdl_recmatch(const char *l1, long s1
 	int i1, i2;
 
 	if (flags & XDF_IGNORE_WHITESPACE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; i1++, i2++) {
+		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
 			if (isspace(l1[i1]))
 				while (isspace(l1[i1]) && i1 < s1)
 					i1++;
-			else if (isspace(l2[i2]))
+			if (isspace(l2[i2]))
 				while (isspace(l2[i2]) && i2 < s2)
 					i2++;
-			else if (l1[i1] != l2[i2])
-				return l2[i2] - l1[i1];
+			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
+				return 0;
 		}
-		if (i1 >= s1)
-			return 1;
-		else if (i2 >= s2)
-			return -1;
+		return (i1 >= s1 && i2 >= s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; i1++, i2++) {
+		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
 			if (isspace(l1[i1])) {
 				if (!isspace(l2[i2]))
-					return -1;
+					return 0;
 				while (isspace(l1[i1]) && i1 < s1)
 					i1++;
 				while (isspace(l2[i2]) && i2 < s2)
 					i2++;
-			} else if (l1[i1] != l2[i2])
-				return l2[i2] - l1[i1];
+			} else if (l1[i1++] != l2[i2++])
+				return 0;
 		}
-		if (i1 >= s1)
-			return 1;
-		else if (i2 >= s2)
-			return -1;
+		return (i1 >= s1 && i2 >= s2);
 	} else
 		return s1 == s2 && !memcmp(l1, l2, s1);
 
@@ -233,7 +227,8 @@ unsigned long xdl_hash_record(char const
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		if (isspace(*ptr) && (flags & XDF_WHITESPACE_FLAGS)) {
-			while (ptr < top && isspace(*ptr) && ptr[1] != '\n')
+			while (ptr + 1 < top && isspace(ptr[1])
+					&& ptr[1] != '\n')
 				ptr++;
 			if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
 				ha += (ha << 5);
-- 
1.4.3.rc2.g4e05
