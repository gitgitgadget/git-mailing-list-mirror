From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 11/16] t0060: Fix tests on Windows
Date: Sat, 21 Mar 2009 22:26:34 +0100
Message-ID: <9af33285b3e0a797090b5ff28d982b06ff3a63b0.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kJ-0003u8-LS
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbZCUV1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZCUV1R
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27947 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D9F082C400C;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 986005BC07;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114063>

Since the MSYS bash mangles absolute paths that it passes as command line
arguments to non-MSYS progams (such as git or test-path-utils), we have to
bend over backwards to squeeze some usefulness out of the existing tests.

In particular, a set of path normalization tests is added that test
relative paths. Some paths in the ancestor path tests are adjusted to help
MSYS bash's path mangling heuristics.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0060-path-utils.sh |  116 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 8336114..86000e2 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,41 +7,91 @@ test_description='Test various path utilities'
 
 . ./test-lib.sh
 
-norm_abs() {
-	test_expect_success "normalize absolute: $1 => $2" \
+norm_path() {
+	test_expect_success $3 "normalize path: $1 => $2" \
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
+# On Windows, we are using MSYS's bash, which mangles the paths.
+# Absolute paths are anchored at the MSYS installation directory,
+# which means that the path / accounts for this many characters:
+rootoff=$(test-path-utils normalize_path_copy / | wc -c)
+# Account for the trailing LF:
+if test "$rootoff" = 2; then
+	rootoff=	# we are on Unix
+else
+	rootoff=$(($rootoff-1))
+fi
+
 ancestor() {
-	test_expect_success "longest ancestor: $1 $2 => $3" \
-	"test \"\$(test-path-utils longest_ancestor_length '$1' '$2')\" = '$3'"
+	# We do some math with the expected ancestor length.
+	expected=$3
+	if test -n "$rootoff" && test "x$expected" != x-1; then
+		expected=$(($expected+$rootoff))
+	fi
+	test_expect_success "longest ancestor: $1 $2 => $expected" \
+	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
+	 test \"\$actual\" = '$expected'"
 }
 
-norm_abs "" ""
-norm_abs / /
-norm_abs // /
-norm_abs /// /
-norm_abs /. /
-norm_abs /./ /
-norm_abs /./.. ++failed++
-norm_abs /../. ++failed++
-norm_abs /./../.// ++failed++
-norm_abs /dir/.. /
-norm_abs /dir/sub/../.. /
-norm_abs /dir/sub/../../.. ++failed++
-norm_abs /dir /dir
-norm_abs /dir// /dir/
-norm_abs /./dir /dir
-norm_abs /dir/. /dir/
-norm_abs /dir///./ /dir/
-norm_abs /dir//sub/.. /dir/
-norm_abs /dir/sub/../ /dir/
-norm_abs //dir/sub/../. /dir/
-norm_abs /dir/s1/../s2/ /dir/s2/
-norm_abs /d1/s1///s2/..//../s3/ /d1/s3/
-norm_abs /d1/s1//../s2/../../d2 /d2
-norm_abs /d1/.../d2 /d1/.../d2
-norm_abs /d1/..././../d2 /d1/d2
+# Absolute path tests must be skipped on Windows because due to path mangling
+# the test program never sees a POSIX-style absolute path
+case $(uname -s) in
+*MINGW*)
+	;;
+*)
+	test_set_prereq POSIX
+	;;
+esac
+
+norm_path "" ""
+norm_path . ""
+norm_path ./ ""
+norm_path ./. ""
+norm_path ./.. ++failed++
+norm_path ../. ++failed++
+norm_path ./../.// ++failed++
+norm_path dir/.. ""
+norm_path dir/sub/../.. ""
+norm_path dir/sub/../../.. ++failed++
+norm_path dir dir
+norm_path dir// dir/
+norm_path ./dir dir
+norm_path dir/. dir/
+norm_path dir///./ dir/
+norm_path dir//sub/.. dir/
+norm_path dir/sub/../ dir/
+norm_path dir/sub/../. dir/
+norm_path dir/s1/../s2/ dir/s2/
+norm_path d1/s1///s2/..//../s3/ d1/s3/
+norm_path d1/s1//../s2/../../d2 d2
+norm_path d1/.../d2 d1/.../d2
+norm_path d1/..././../d2 d1/d2
+
+norm_path / / POSIX
+norm_path // / POSIX
+norm_path /// / POSIX
+norm_path /. / POSIX
+norm_path /./ / POSIX
+norm_path /./.. ++failed++ POSIX
+norm_path /../. ++failed++ POSIX
+norm_path /./../.// ++failed++ POSIX
+norm_path /dir/.. / POSIX
+norm_path /dir/sub/../.. / POSIX
+norm_path /dir/sub/../../.. ++failed++ POSIX
+norm_path /dir /dir POSIX
+norm_path /dir// /dir/ POSIX
+norm_path /./dir /dir POSIX
+norm_path /dir/. /dir/ POSIX
+norm_path /dir///./ /dir/ POSIX
+norm_path /dir//sub/.. /dir/ POSIX
+norm_path /dir/sub/../ /dir/ POSIX
+norm_path //dir/sub/../. /dir/ POSIX
+norm_path /dir/s1/../s2/ /dir/s2/ POSIX
+norm_path /d1/s1///s2/..//../s3/ /d1/s3/ POSIX
+norm_path /d1/s1//../s2/../../d2 /d2 POSIX
+norm_path /d1/.../d2 /d1/.../d2 POSIX
+norm_path /d1/..././../d2 /d1/d2 POSIX
 
 ancestor / "" -1
 ancestor / / -1
@@ -80,10 +130,10 @@ ancestor /foo/bar /:/foo:/bar/ 4
 ancestor /foo/bar /foo:/:/bar/ 4
 ancestor /foo/bar /:/bar/:/fo 0
 ancestor /foo/bar /:/bar/ 0
-ancestor /foo/bar :://foo/. 4
-ancestor /foo/bar :://foo/.:: 4
-ancestor /foo/bar //foo/./::/bar 4
-ancestor /foo/bar ::/bar -1
+ancestor /foo/bar .:/foo/. 4
+ancestor /foo/bar .:/foo/.:.: 4
+ancestor /foo/bar /foo/./:.:/bar 4
+ancestor /foo/bar .:/bar -1
 
 test_expect_success 'strip_path_suffix' '
 	test c:/msysgit = $(test-path-utils strip_path_suffix \
-- 
1.6.2.1.224.g2225f
