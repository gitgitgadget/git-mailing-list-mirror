From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t4018: introduce test cases for the internal hunk header patterns
Date: Mon, 19 Dec 2011 14:52:26 -0600
Message-ID: <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil>
References: <20111217012118.GB20225@sigill.intra.peff.net>
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com, Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Dec 19 21:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RckCv-0001T7-9K
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab1LSUxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 15:53:01 -0500
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:52077 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab1LSUw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 15:52:59 -0500
Received: by mail3.nrlssc.navy.mil id pBJKqlTW019125; Mon, 19 Dec 2011 14:52:47 -0600
In-Reply-To: <20111217012118.GB20225@sigill.intra.peff.net>
X-OriginalArrivalTime: 19 Dec 2011 20:52:45.0828 (UTC) FILETIME=[28EFE440:01CCBE90]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187472>

From: Brandon Casey <drafnel@gmail.com>

Recently it has been pointed out that one or more of the internal hunk
header patterns are sub-optimal.  Specifically, the C/C++ "cpp" pattern was
called out.

Let's introduce some infrastructure to make it easy to create test cases
for the hunk header patterns and provide a few cases for the cpp pattern.

   * new test cases can be dropped into the t4018 directory
   * filenames end with the pattern name e.g. .cpp .objc .matlab etc.
   * filenames should be descriptive since it will be used in the test
     suite output
   * broken test cases should be given a filename prefixed with "broken_"
   * test cases must provide a function named "RIGHT_function_hunk_header"
     - this is the function name that should appear on the hunk header line
     - the body of this function should have an assignment like

          answer = 0

       The test suite will modify the above line to produce a difference
       from the original.  Additionally, this should be far enough within
       the body of the function so that the function name is not part of
       the lines of context.

Example test case:

   int WRONG_function_hunk_header (void)
   {
           return 0;
   }

   int RIGHT_function_hunk_header (void)
   {
           /*
            * Filler
            * Filler
            * Filler
            */

           int answer = 0;
           return 0;
   }

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


On Fri, Dec 16, 2011 at 7:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 16, 2011 at 11:05:27PM +0100, Johannes Sixt wrote:
>
<snip>
>> ... in order to ultimately
>> improve the built-in pattern. The topic came up just the other day, and
>> I took Thomas Rast's suggestion to experiment with a simplified pattern:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/186355/focus=186439
>>
>> But as is, the built-in pattern misses way too many anchor points in C++
>> code.
>
> Yeah, I can certainly agree that the patterns could be better.
>
> Maybe we should just table the extension mapping for now, then, and see
> if the patterns improve? Or maybe just drop the C ones (and probably the
> objc one based on other parts of the thread) and do the rest?

/methinks t4018 needs to be greatly expanded.  There is no way to tell what
is currently broken by the current pattern, or what is newly broken by a
new pattern.

How about this for a start?

-Brandon


 t/t4018-diff-funcname.sh             |   18 ++++++++++++
 t/t4018/broken_class_constructor.cpp |   34 +++++++++++++++++++++++
 t/t4018/broken_class_destructor.cpp  |   34 +++++++++++++++++++++++
 t/t4018/broken_gnu_style.cpp         |   35 +++++++++++++++++++++++
 t/t4018/broken_reference.cpp         |   34 +++++++++++++++++++++++
 t/t4018/broken_template.cpp          |   34 +++++++++++++++++++++++
 t/t4018/class_method.cpp             |   34 +++++++++++++++++++++++
 t/t4018/simple.cpp                   |   50 ++++++++++++++++++++++++++++++++++
 t/t4018/static.cpp                   |   34 +++++++++++++++++++++++
 9 files changed, 307 insertions(+), 0 deletions(-)
 create mode 100644 t/t4018/broken_class_constructor.cpp
 create mode 100644 t/t4018/broken_class_destructor.cpp
 create mode 100644 t/t4018/broken_gnu_style.cpp
 create mode 100644 t/t4018/broken_reference.cpp
 create mode 100644 t/t4018/broken_template.cpp
 create mode 100644 t/t4018/class_method.cpp
 create mode 100644 t/t4018/simple.cpp
 create mode 100644 t/t4018/static.cpp

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4bd2a1c..5a1f7b7 100755
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
+			sed -e 's/answer = 0/answer = 42/' < \"$f\" > \"$name.$p\" &&
+			test_expect_code 1 git diff --no-index \"$f\" \
+				\"$name.$p\" >actual &&
+			egrep '^@@ .* @@ .*RIGHT_function_hunk_header' actual
+		"
+	done
 done
 
 test_expect_success 'default behaviour' '
diff --git a/t/t4018/broken_class_constructor.cpp b/t/t4018/broken_class_constructor.cpp
new file mode 100644
index 0000000..1e4cb9c
--- /dev/null
+++ b/t/t4018/broken_class_constructor.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+RIGHT_function_hunk_header::RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_class_destructor.cpp b/t/t4018/broken_class_destructor.cpp
new file mode 100644
index 0000000..84d9506
--- /dev/null
+++ b/t/t4018/broken_class_destructor.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+RIGHT_function_hunk_header::~RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_gnu_style.cpp b/t/t4018/broken_gnu_style.cpp
new file mode 100644
index 0000000..ffba9b9
--- /dev/null
+++ b/t/t4018/broken_gnu_style.cpp
@@ -0,0 +1,35 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int
+RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_reference.cpp b/t/t4018/broken_reference.cpp
new file mode 100644
index 0000000..ea90b82
--- /dev/null
+++ b/t/t4018/broken_reference.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int& RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/broken_template.cpp b/t/t4018/broken_template.cpp
new file mode 100644
index 0000000..95a6dd5
--- /dev/null
+++ b/t/t4018/broken_template.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+template <class T> int RIGHT_function_hunk_header (T unused)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/class_method.cpp b/t/t4018/class_method.cpp
new file mode 100644
index 0000000..2e51853
--- /dev/null
+++ b/t/t4018/class_method.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int test_class::RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/simple.cpp b/t/t4018/simple.cpp
new file mode 100644
index 0000000..b8fca06
--- /dev/null
+++ b/t/t4018/simple.cpp
@@ -0,0 +1,50 @@
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
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/static.cpp b/t/t4018/static.cpp
new file mode 100644
index 0000000..fcc48f2
--- /dev/null
+++ b/t/t4018/static.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+static int RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
-- 
1.7.7.4
