From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/5] Test and fix normalize_path_copy()
Date: Sat,  7 Feb 2009 16:08:30 +0100
Message-ID: <1234019311-6449-5-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
 <1234019311-6449-1-git-send-email-j6t@kdbg.org>
 <1234019311-6449-2-git-send-email-j6t@kdbg.org>
 <1234019311-6449-3-git-send-email-j6t@kdbg.org>
 <1234019311-6449-4-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVovX-0006PA-17
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZBGPPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZBGPPg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:36 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39617 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZBGPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:33 -0500
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id DFBC310A7BA;
	Sat,  7 Feb 2009 16:08:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <1234019311-6449-4-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108857>

This changes the test-path-utils utility to invoke normalize_path_copy()
instead of normalize_absolute_path() because the latter is about to be
removed.

The test cases in t0060 are adjusted in two regards:

- normalize_path_copy() more often leaves a trailing slash in the result.
  This has no negative side effects because the new user of this function,
  longest_ancester_length(), already accounts for this behavior.

- The function can fail.

The tests uncover a flaw in normalize_path_copy(): If there are
sufficiently many '..' path components so that the root is reached, such as
in "/d1/s1/../../d2", then the leading slash was lost. This manifested
itself that (assuming there is a repository at /tmp/foo)

  $ git add /d1/../tmp/foo/some-file

reported 'pathspec is outside repository'. This is now fixed.

Moreover, the test case descriptions of t0060 now include the test data and
expected outcome.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 path.c                |   16 +++++-----------
 t/t0060-path-utils.sh |   33 +++++++++++++++++----------------
 test-path-utils.c     |    7 ++++---
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/path.c b/path.c
index dc3807a..16628b2 100644
--- a/path.c
+++ b/path.c
@@ -484,18 +484,12 @@ int normalize_path_copy(char *dst, const char *src)
 		 * dst0..dst is prefix portion, and dst[-1] is '/';
 		 * go up one level.
 		 */
-		dst -= 2; /* go past trailing '/' if any */
-		if (dst < dst0)
+		dst--;	/* go to trailing '/' */
+		if (dst <= dst0)
 			return -1;
-		while (1) {
-			if (dst <= dst0)
-				break;
-			c = *dst--;
-			if (c == '/') {	/* MinGW: cannot be '\\' anymore */
-				dst += 2;
-				break;
-			}
-		}
+		/* Windows: dst[-1] cannot be backslash anymore */
+		while (dst0 < dst && dst[-1] != '/')
+			dst--;
 	}
 	*dst = '\0';
 	return 0;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 6e7501f..4ed1f0b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -8,36 +8,37 @@ test_description='Test various path utilities'
 . ./test-lib.sh
 
 norm_abs() {
-	test_expect_success "normalize absolute" \
-	"test \$(test-path-utils normalize_absolute_path '$1') = '$2'"
+	test_expect_success "normalize absolute: $1 => $2" \
+	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
 ancestor() {
-	test_expect_success "longest ancestor" \
-	"test \$(test-path-utils longest_ancestor_length '$1' '$2') = '$3'"
+	test_expect_success "longest ancestor: $1 $2 => $3" \
+	"test \"\$(test-path-utils longest_ancestor_length '$1' '$2')\" = '$3'"
 }
 
-norm_abs "" /
+norm_abs "" ""
 norm_abs / /
 norm_abs // /
 norm_abs /// /
 norm_abs /. /
 norm_abs /./ /
-norm_abs /./.. /
-norm_abs /../. /
-norm_abs /./../.// /
+norm_abs /./.. ++failed++
+norm_abs /../. ++failed++
+norm_abs /./../.// ++failed++
 norm_abs /dir/.. /
 norm_abs /dir/sub/../.. /
+norm_abs /dir/sub/../../.. ++failed++
 norm_abs /dir /dir
-norm_abs /dir// /dir
+norm_abs /dir// /dir/
 norm_abs /./dir /dir
-norm_abs /dir/. /dir
-norm_abs /dir///./ /dir
-norm_abs /dir//sub/.. /dir
-norm_abs /dir/sub/../ /dir
-norm_abs //dir/sub/../. /dir
-norm_abs /dir/s1/../s2/ /dir/s2
-norm_abs /d1/s1///s2/..//../s3/ /d1/s3
+norm_abs /dir/. /dir/
+norm_abs /dir///./ /dir/
+norm_abs /dir//sub/.. /dir/
+norm_abs /dir/sub/../ /dir/
+norm_abs //dir/sub/../. /dir/
+norm_abs /dir/s1/../s2/ /dir/s2/
+norm_abs /d1/s1///s2/..//../s3/ /d1/s3/
 norm_abs /d1/s1//../s2/../../d2 /d2
 norm_abs /d1/.../d2 /d1/.../d2
 norm_abs /d1/..././../d2 /d1/d2
diff --git a/test-path-utils.c b/test-path-utils.c
index 7e6fc8d..5168a8e 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -2,10 +2,11 @@
 
 int main(int argc, char **argv)
 {
-	if (argc == 3 && !strcmp(argv[1], "normalize_absolute_path")) {
+	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmalloc(PATH_MAX + 1);
-		int rv = normalize_absolute_path(buf, argv[2]);
-		assert(strlen(buf) == rv);
+		int rv = normalize_path_copy(buf, argv[2]);
+		if (rv)
+			buf = "++failed++";
 		puts(buf);
 		return 0;
 	}
-- 
1.6.1.297.g9b01e
