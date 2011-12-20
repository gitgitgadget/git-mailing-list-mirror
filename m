From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2] t4018: introduce test cases for the internal hunk header patterns
Date: Mon, 19 Dec 2011 20:42:19 -0600
Message-ID: <1324348939-27115-1-git-send-email-drafnel@gmail.com>
References: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	jrnieder@gmail.com, trast@student.ethz.ch,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 20 03:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcpfF-0000Zv-SS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 03:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab1LTCmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 21:42:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42725 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1LTCmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 21:42:43 -0500
Received: by ggdk6 with SMTP id k6so4462274ggd.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 18:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aWxqkS/7kH87NY6FDpINzKNcbUiOHqXjA6ahFJbAwjs=;
        b=Wn1cBCYQGlCNS6KcvD2VzrF0ZUURUnxu6V8TxGuc+ztn1Eycf+GOKTwi8FX4bFi/LG
         Eg3KQoUtqjjUYxjw9crVURaFY4Ci7+e6UHwLtVKRbv4HkZfZ+t8xjyz54ymyDic/ALyX
         G/owLFU29uqv2P8E8wnkDwynBY15jCewymcdQ=
Received: by 10.236.175.198 with SMTP id z46mr349081yhl.31.1324348963147;
        Mon, 19 Dec 2011 18:42:43 -0800 (PST)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id n24sm449526yhj.13.2011.12.19.18.42.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 18:42:42 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187497>

Recently it has been pointed out that one (or more?) of the internal hunk
header patterns is sub-optimal.  Specifically, the C/C++ "cpp" pattern was
called out.

Let's introduce some infrastructure to make it easy to create test cases
for the hunk header patterns and provide a few cases for the cpp pattern.

   * new test cases can be dropped into the t4018 directory
   * filenames end with the pattern name e.g. .cpp .objc .matlab etc.
   * filenames should be descriptive since it will be used in the test
     suite output
   * broken test cases should be given a filename prefixed with "broken_"
   * a test case must have one (and only one) line that contains "RIGHT"
     (all uppercase) and that line should become the hunk header for the
     test to succeed
   * after the line that contains "RIGHT" token, there should be one (and
     only one) line that contains the string "ChangeMe". The test modifies
     this string to "IWasChanged", compares the original with the modified
     result, and expects the "RIGHT" token above to appear on the hunk
     header

Example test case:

   int WRONG_function_hunk_header (void)
   {
           return 0;
   }

   int RIGHT_function_hunk_header (void)
   {
           const char *msg = "ChangeMe";
           printf("Hello, world, %s\n", msg);
           return 0;
   }

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Updated based on Junio's comments and squashed the additional tests I
sent.  Plus I added -U1 to the git diff line so that the filler lines are
no longer necessary.

-Brandon


 t/t4018-diff-funcname.sh             |   18 ++++++++++++++++++
 t/t4018/broken_class_constructor.cpp |   16 ++++++++++++++++
 t/t4018/broken_class_destructor.cpp  |   16 ++++++++++++++++
 t/t4018/broken_gnu_style.cpp         |   17 +++++++++++++++++
 t/t4018/broken_reference.cpp         |   16 ++++++++++++++++
 t/t4018/broken_template.cpp          |   16 ++++++++++++++++
 t/t4018/class_method.cpp             |   16 ++++++++++++++++
 t/t4018/ignore_declaration.cpp       |   17 +++++++++++++++++
 t/t4018/ignore_global.cpp            |   19 +++++++++++++++++++
 t/t4018/ignore_label.cpp             |   17 +++++++++++++++++
 t/t4018/pointer_return.cpp           |   16 ++++++++++++++++
 t/t4018/simple.cpp                   |   32 ++++++++++++++++++++++++++++++++
 t/t4018/static.cpp                   |   16 ++++++++++++++++
 13 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 t/t4018/broken_class_constructor.cpp
 create mode 100644 t/t4018/broken_class_destructor.cpp
 create mode 100644 t/t4018/broken_gnu_style.cpp
 create mode 100644 t/t4018/broken_reference.cpp
 create mode 100644 t/t4018/broken_template.cpp
 create mode 100644 t/t4018/class_method.cpp
 create mode 100644 t/t4018/ignore_declaration.cpp
 create mode 100644 t/t4018/ignore_global.cpp
 create mode 100644 t/t4018/ignore_label.cpp
 create mode 100644 t/t4018/pointer_return.cpp
 create mode 100644 t/t4018/simple.cpp
 create mode 100644 t/t4018/static.cpp

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4bd2a1c..a3c4577 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -121,6 +121,24 @@ do
 		! grep fatal msg &&
 		! grep error msg
 	'
+
+	for f in "$TEST_DIRECTORY"/t4018/*.$p; do
+		test -f "$f" || continue
+		name=`basename "$f" .$p`
+		test_expect_which=test_expect_success
+		if test "$name" != "${name#broken_}"; then
+			name=${name#broken_}
+			test_expect_which=test_expect_failure
+		fi
+		$test_expect_which \
+			"builtin $p pattern works correctly for $name case" "
+			echo \"*.$p diff=$p\" >.gitattributes &&
+			sed -e 's/ChangeMe/IWasChanged/' < \"$f\" > \"$name.$p\" &&
+			test_expect_code 1 git diff -U1 --no-index \"$f\" \
+				\"$name.$p\" >actual &&
+			egrep '^@@ .* @@ .*RIGHT' actual
+		"
+	done
 done
 
 test_expect_success 'default behaviour' '
diff --git a/t/t4018/broken_class_constructor.cpp b/t/t4018/broken_class_constructor.cpp
new file mode 100644
index 0000000..774c7f9
--- /dev/null
+++ b/t/t4018/broken_class_constructor.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+RIGHT_function_hunk_header::RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_class_destructor.cpp b/t/t4018/broken_class_destructor.cpp
new file mode 100644
index 0000000..3045fd1
--- /dev/null
+++ b/t/t4018/broken_class_destructor.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+RIGHT_function_hunk_header::~RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_gnu_style.cpp b/t/t4018/broken_gnu_style.cpp
new file mode 100644
index 0000000..58e574a
--- /dev/null
+++ b/t/t4018/broken_gnu_style.cpp
@@ -0,0 +1,17 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int
+RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_reference.cpp b/t/t4018/broken_reference.cpp
new file mode 100644
index 0000000..4d4549f
--- /dev/null
+++ b/t/t4018/broken_reference.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int& RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_template.cpp b/t/t4018/broken_template.cpp
new file mode 100644
index 0000000..5c62e73
--- /dev/null
+++ b/t/t4018/broken_template.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+template <class T> int RIGHT_function_hunk_header (T unused)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/class_method.cpp b/t/t4018/class_method.cpp
new file mode 100644
index 0000000..fe53620
--- /dev/null
+++ b/t/t4018/class_method.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int test_class::RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_declaration.cpp b/t/t4018/ignore_declaration.cpp
new file mode 100644
index 0000000..ce7a0f6
--- /dev/null
+++ b/t/t4018/ignore_declaration.cpp
@@ -0,0 +1,17 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+	void WRONG_function_declaration_within_body (void);
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_global.cpp b/t/t4018/ignore_global.cpp
new file mode 100644
index 0000000..95e23bc
--- /dev/null
+++ b/t/t4018/ignore_global.cpp
@@ -0,0 +1,19 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+	printf("Hello, world\n");
+	return 0;
+}
+
+int WRONG_global_variable;
+
+int ChangeMe;
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_label.cpp b/t/t4018/ignore_label.cpp
new file mode 100644
index 0000000..a8f407d
--- /dev/null
+++ b/t/t4018/ignore_label.cpp
@@ -0,0 +1,17 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+WRONG_should_not_match_label:
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/pointer_return.cpp b/t/t4018/pointer_return.cpp
new file mode 100644
index 0000000..ea30d2d
--- /dev/null
+++ b/t/t4018/pointer_return.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+static int *RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/simple.cpp b/t/t4018/simple.cpp
new file mode 100644
index 0000000..c96ad87
--- /dev/null
+++ b/t/t4018/simple.cpp
@@ -0,0 +1,32 @@
+/*
+ *  Test file for testing the internal hunk header patterns
+ *
+ *  The "RIGHT" hunk header function, the one that should appear on the
+ *  hunk header line, should be named "RIGHT_function_hunk_header" and
+ *  the body of this function should have an assignment that looks like
+ *
+ *     answer = 0
+ *
+ *  within it, deep enough so the lines of context do not include the
+ *  function name.
+ *
+ *  If the name of this file begins with "broken_", then it will be
+ *  interpreted as a pattern which does not work, but which should.
+ */
+
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/static.cpp b/t/t4018/static.cpp
new file mode 100644
index 0000000..f6ee0f3
--- /dev/null
+++ b/t/t4018/static.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+static int RIGHT_function_hunk_header (void)
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
-- 
1.7.8
