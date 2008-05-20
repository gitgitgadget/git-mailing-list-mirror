From: David Reiss <dreiss@facebook.com>
Subject: [PATCH 1/4] Implement normalize_absolute_path
Date: Mon, 19 May 2008 23:48:54 -0700
Message-ID: <48327456.1060202@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 08:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLgb-0000HC-I5
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 08:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbYETGuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 02:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbYETGuI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 02:50:08 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:36786 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbYETGuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 02:50:06 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4K6o5Wn019840
	for <git@vger.kernel.org>; Mon, 19 May 2008 23:50:05 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 May 2008 23:47:01 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-OriginalArrivalTime: 20 May 2008 06:47:01.0553 (UTC) FILETIME=[4EAD0210:01C8BA45]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-20_01:2008-05-20,2008-05-20,2008-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805190302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82465>

normalize_absolute_path removes several oddities form absolute paths,
giving nice clean paths like "/dir/sub1/sub2".  Also add a test case
for this utility, based on a new test program (in the style of test-sha1).

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Junio thought it would be good to do normalization of paths in the
GIT_CEILING_DIRECTORIES patch.  This function does the normalization.

The closest thing I could find to this in the existing code base was
sanitary_path_copy, but it does not remove trailing slashes.

If this test suite takes too long to run, I'm fine with commenting
most of it out.

 .gitignore            |    1 +
 Makefile              |    2 +-
 cache.h               |    1 +
 path.c                |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0060-path-utils.sh |   40 +++++++++++++++++++++++++++++++++++++++
 test-path-utils.c     |   13 ++++++++++++
 6 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100755 t/t0060-path-utils.sh
 create mode 100644 test-path-utils.c

diff --git a/.gitignore b/.gitignore
index 4ff2fec..c54c473 100644
--- a/.gitignore
+++ b/.gitignore
@@ -150,6 +150,7 @@ test-dump-cache-tree
 test-genrandom
 test-match-trees
 test-parse-options
+test-path-utils
 test-sha1
 common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index 649ee56..d76c16b 100644
--- a/Makefile
+++ b/Makefile
@@ -1182,7 +1182,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-path-utils$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/cache.h b/cache.h
index 9cee9a5..5fd1e5b 100644
--- a/cache.h
+++ b/cache.h
@@ -514,6 +514,7 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 const char *make_absolute_path(const char *path);
+int normalize_absolute_path(char *buf, const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index b7c24a2..17921ac 100644
--- a/path.c
+++ b/path.c
@@ -357,3 +357,53 @@ const char *make_absolute_path(const char *path)
 
 	return buf;
 }
+
+/*
+ * path = absolute path
+ * buf = buffer of at least max(2, strlen(path)+1) bytes
+ * It is okay if buf == path, but they should not overlap otherwise.
+ *
+ * Performs the following normalizations on path, storing the result in buf:
+ * - Removes trailing slashes.
+ * - Removes empty components.
+ * - Removes "." components.
+ * - Removes ".." components, and the components the precede them.
+ * "" and paths that contain only slashes are normalized to "/".
+ * Returns the length of the output.
+ *
+ * Note that this function is purely textual.  It does not follow symlinks,
+ * verify the existence of the path, or make any system calls.
+ */
+int normalize_absolute_path(char *buf, const char *path)
+{
+	const char *comp_start = path, *comp_end = path;
+	char *dst = buf;
+	int comp_len;
+	assert(buf);
+	assert(path);
+
+	while (*comp_start) {
+		while (*++comp_end && *comp_end != '/');
+		comp_len = comp_end - comp_start;
+
+		if (!strncmp("/",  comp_start, comp_len) ||
+		    !strncmp("/.", comp_start, comp_len))
+			goto next;
+
+		if (!strncmp("/..", comp_start, comp_len)) {
+			while (dst > buf && *--dst != '/');
+			goto next;
+		}
+
+		memcpy(dst, comp_start, comp_len);
+		dst += comp_len;
+	next:
+		comp_start = comp_end;
+	}
+
+	if (dst == buf)
+		*dst++ = '/';
+
+	*dst = '\0';
+	return dst - buf;
+}
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
new file mode 100755
index 0000000..9076b3b
--- /dev/null
+++ b/t/t0060-path-utils.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 David Reiss
+#
+
+test_description='Test various path utilities'
+
+. ./test-lib.sh
+
+norm_abs() {
+	test_expect_success "normalize absolute" \
+	"test \$(test-path-utils normalize_absolute_path '$1') = '$2'"
+}
+
+norm_abs "" /
+norm_abs / /
+norm_abs // /
+norm_abs /// /
+norm_abs /. /
+norm_abs /./ /
+norm_abs /./.. /
+norm_abs /../. /
+norm_abs /./../.// /
+norm_abs /dir/.. /
+norm_abs /dir/sub/../.. /
+norm_abs /dir /dir
+norm_abs /dir// /dir
+norm_abs /./dir /dir
+norm_abs /dir/. /dir
+norm_abs /dir///./ /dir
+norm_abs /dir//sub/.. /dir
+norm_abs /dir/sub/../ /dir
+norm_abs //dir/sub/../. /dir
+norm_abs /dir/s1/../s2/ /dir/s2
+norm_abs /d1/s1///s2/..//../s3/ /d1/s3
+norm_abs /d1/s1//../s2/../../d2 /d2
+norm_abs /d1/.../d2 /d1/.../d2
+norm_abs /d1/..././../d2 /d1/d2
+
+test_done
diff --git a/test-path-utils.c b/test-path-utils.c
new file mode 100644
index 0000000..1bd4321
--- /dev/null
+++ b/test-path-utils.c
@@ -0,0 +1,13 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	if (argc == 3 && !strcmp(argv[1], "normalize_absolute_path")) {
+		char *buf = xmalloc(strlen(argv[2])+1);
+		int rv = normalize_absolute_path(buf, argv[2]);
+		assert(strlen(buf) == rv);
+		puts(buf);
+	}
+
+	return 0;
+}
-- 
1.5.4
