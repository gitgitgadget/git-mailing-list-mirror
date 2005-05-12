From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Support symlinks in git-ls-files --others.
Date: Thu, 12 May 2005 00:48:18 -0700
Message-ID: <7v1x8ckhq5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 09:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW8LK-0002iY-Br
	for gcvg-git@gmane.org; Thu, 12 May 2005 09:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVELHuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVELHuF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 03:50:05 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29836 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261238AbVELHsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 03:48:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512074819.CBSB26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 03:48:19 -0400
To: pasky@ucw.cz, Kay Sievers <kay.sievers@vrfy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It is kind of surprising that this was missed in the last round,
but the work tree scanner in git-ls-files is still deliberately
ignoring symlinks.  This patch fixes it.

This depends on the test suite infrastructure I sent in earlier.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Petr, I am not CCing Linus and you know what I mean by it ;-).

cache.h             |    1 +
ls-files.c          |    8 +++++---
t/t0400-ls-files.sh |   29 +++++++++++++++++++++++++++++
3 files changed, 35 insertions(+), 3 deletions(-)
t/t0400-ls-files.sh (. --> 100755)

--- a/cache.h
+++ b/cache.h
@@ -27,6 +27,7 @@
 #define DT_UNKNOWN	0
 #define DT_DIR		1
 #define DT_REG		2
+#define DT_LNK		3
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
--- a/ls-files.c
+++ b/ls-files.c
@@ -109,8 +109,9 @@
 
 /*
  * Read a directory tree. We currently ignore anything but
- * directories and regular files. That's because git doesn't
- * handle them at all yet. Maybe that will change some day.
+ * directories, regular files and symlinks. That's because git
+ * doesn't handle them at all yet. Maybe that will change some
+ * day.
  *
  * Also, we currently ignore all names starting with a dot.
  * That likely will not change.
@@ -141,7 +142,7 @@
 			case DT_UNKNOWN:
 				if (lstat(fullname, &st))
 					continue;
-				if (S_ISREG(st.st_mode))
+				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
 					break;
 				if (!S_ISDIR(st.st_mode))
 					continue;
@@ -152,6 +153,7 @@
 					       baselen + len + 1);
 				continue;
 			case DT_REG:
+			case DT_LNK:
 				break;
 			}
 			add_name(fullname, baselen + len);
--- a/t/t0400-ls-files.sh
+++ b/t/t0400-ls-files.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'git-ls-files test.
+
+This test runs git-ls-files --others with the following on the
+filesystem.
+
+    path0       - a file
+    path1	- a symlink
+    path2/file2 - a file in a directory
+'
+
+date >path0
+ln -s xyzzy path1
+mkdir path2
+date >path2/file2
+git-ls-files --others >.output
+cat >.expected <<EOF
+path0
+path1
+path2/file2
+EOF
+
+test_expect_success 'diff .output .expected'
+test_done
------------------------------------------------

Compilation finished at Thu May 12 00:43:56

