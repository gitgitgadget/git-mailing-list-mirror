From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/9] longest_ancestor_length(): resolve symlinks before comparing paths
Date: Sat, 29 Sep 2012 08:16:01 +0200
Message-ID: <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqMB-0002Xr-Ko
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab2I2GQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:40 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:48200 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758315Ab2I2GQh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:37 -0400
X-AuditID: 12074411-b7fa36d0000008cc-18-50669244a845
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D0.F2.02252.44296605; Sat, 29 Sep 2012 02:16:36 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G745026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:35 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqOsyKS3A4PJaK4uuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M54
	cX0BW8EnjYrvU9+yNTBuVuxi5OSQEDCR6F3ynRXCFpO4cG89WxcjF4eQwGVGiZunFjBBOGeZ
	JC50fGEEqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCwwiVGiZ8MDdpCEsECUxKNlR9lAbBYBVYml
	a2awgNi8As4SF2Z1MkKsU5T48X0NM4jNKeAi8btnOtgZQkA1j/beYZ3AyLuAkWEVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkgoCe5gnHFS7hCjAAejEg+v1vHUACHWxLLi
	ytxDjJIcTEqivJ8npAUI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHNKAYq501JrKxKLcqHSUlz
	sCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8BpOBBoqWJSanlqRlplTgpBm4uAEEVwgG3iA
	NtiCFPIWFyTmFmemQxSdYlSUEucVAUkIgCQySvPgBsCi/hWjONA/wryBIFU8wIQB1/0KaDAT
	0OClm5JABpckIqSkGhj91A7sMdr8rePHmZI+Le/z8Tc/3n2bKPTRpFV04xMZtacTU54dMeQ4
	Yn1QKub6iazJ9dxCv9tFWb34xOKXfVO7M/vyr80rNa5YuXJc+a2jlnM/m83JqWLhzGNfWY9O
	u5Q/02CbEbeP65cubX374rAbW4zS+E/e35mwcH9HT+G/dzptywt5st8rsRRnJBpq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206642>

longest_ancestor_length() relies on a textual comparison of directory
parts to find the part of path that overlaps with one of the paths in
prefix_list.  But this doesn't work if any of the prefixes involves a
symbolic link, because the directories will look different even though
they might logically refer to the same directory.  So canonicalize the
paths listed in prefix_list using real_path_if_valid() before trying
to find matches.

path is already in canonical form, so doesn't need to be canonicalized
again.

This fixes some problems with using GIT_CEILING_DIRECTORIES that
contains paths involving symlinks, including t4035 if run with --root
set to a path involving symlinks.

Remove a number of tests of longest_ancestor_length().  It is awkward
to test longest_ancestor_length() now, because its new path
normalization behavior depends on the contents of the whole
filesystem.  On the other hand:

* longest_ancestor_length() is now built of reusable components that
  are themselves tested separately (string_list_split(),
  string_list_longest_prefix(), and real_path_if_valid()), so it
  contains less code that can go wrong.

* longest_ancestor_length() gets some testing (albeit not systematic)
  via the GIT_CEILING_DIRECTORIES tests.

Therefore the work of updating these tests exceeds any expected
benefits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c                | 18 +++++++++------
 t/t0060-path-utils.sh | 64 ---------------------------------------------------
 2 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/path.c b/path.c
index b20f2fb..40d7360 100644
--- a/path.c
+++ b/path.c
@@ -570,21 +570,25 @@ int normalize_path_copy(char *dst, const char *src)
 
 static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 {
-	char buf[PATH_MAX+2];
+	char *buf;
 	const char *ceil = item->string;
-	int len = strlen(ceil);
+	const char *realpath;
+	int len;
 
-	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+	if (!*ceil || !is_absolute_path(ceil))
 		return 0;
-	if (normalize_path_copy(buf, ceil) < 0)
+	realpath = real_path_if_valid(ceil);
+	if (!realpath)
 		return 0;
-	len = strlen(buf);
+	len = strlen(realpath);
+	buf = xmalloc(len + 2); /* Leave space for possible trailing slash */
+	strcpy(buf, realpath);
 	if (len == 0 || buf[len-1] != '/') {
 		buf[len++] = '/';
-		buf[len++] = '\0';
+		buf[len] = '\0';
 	}
 	free(item->string);
-	item->string = xstrdup(buf);
+	item->string = buf;
 	return 1;
 }
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ef2345..c97bbf2 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,28 +12,6 @@ norm_path() {
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
-# On Windows, we are using MSYS's bash, which mangles the paths.
-# Absolute paths are anchored at the MSYS installation directory,
-# which means that the path / accounts for this many characters:
-rootoff=$(test-path-utils normalize_path_copy / | wc -c)
-# Account for the trailing LF:
-if test $rootoff = 2; then
-	rootoff=	# we are on Unix
-else
-	rootoff=$(($rootoff-1))
-fi
-
-ancestor() {
-	# We do some math with the expected ancestor length.
-	expected=$3
-	if test -n "$rootoff" && test "x$expected" != x-1; then
-		expected=$(($expected+$rootoff))
-	fi
-	test_expect_success "longest ancestor: $1 $2 => $expected" \
-	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
-	 test \"\$actual\" = '$expected'"
-}
-
 # Absolute path tests must be skipped on Windows because due to path mangling
 # the test program never sees a POSIX-style absolute path
 case $(uname -s) in
@@ -93,48 +71,6 @@ norm_path /d1/s1//../s2/../../d2 /d2 POSIX
 norm_path /d1/.../d2 /d1/.../d2 POSIX
 norm_path /d1/..././../d2 /d1/d2 POSIX
 
-ancestor / "" -1
-ancestor / / -1
-ancestor /foo "" -1
-ancestor /foo : -1
-ancestor /foo ::. -1
-ancestor /foo ::..:: -1
-ancestor /foo / 0
-ancestor /foo /fo -1
-ancestor /foo /foo -1
-ancestor /foo /foo/ -1
-ancestor /foo /bar -1
-ancestor /foo /bar/ -1
-ancestor /foo /foo/bar -1
-ancestor /foo /foo:/bar/ -1
-ancestor /foo /foo/:/bar/ -1
-ancestor /foo /foo::/bar/ -1
-ancestor /foo /:/foo:/bar/ 0
-ancestor /foo /foo:/:/bar/ 0
-ancestor /foo /:/bar/:/foo 0
-ancestor /foo/bar "" -1
-ancestor /foo/bar / 0
-ancestor /foo/bar /fo -1
-ancestor /foo/bar foo -1
-ancestor /foo/bar /foo 4
-ancestor /foo/bar /foo/ 4
-ancestor /foo/bar /foo/ba -1
-ancestor /foo/bar /:/fo 0
-ancestor /foo/bar /foo:/foo/ba 4
-ancestor /foo/bar /bar -1
-ancestor /foo/bar /bar/ -1
-ancestor /foo/bar /fo: -1
-ancestor /foo/bar :/fo -1
-ancestor /foo/bar /foo:/bar/ 4
-ancestor /foo/bar /:/foo:/bar/ 4
-ancestor /foo/bar /foo:/:/bar/ 4
-ancestor /foo/bar /:/bar/:/fo 0
-ancestor /foo/bar /:/bar/ 0
-ancestor /foo/bar .:/foo/. 4
-ancestor /foo/bar .:/foo/.:.: 4
-ancestor /foo/bar /foo/./:.:/bar 4
-ancestor /foo/bar .:/bar -1
-
 test_expect_success 'strip_path_suffix' '
 	test c:/msysgit = $(test-path-utils strip_path_suffix \
 		c:/msysgit/libexec//git-core libexec/git-core)
-- 
1.7.11.3
