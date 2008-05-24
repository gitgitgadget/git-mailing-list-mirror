From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/5] Move reset_index_file() to a new reset.c
Date: Sat, 24 May 2008 02:01:04 +0200
Message-ID: <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhD2-00012y-0m
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814AbYEXABJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbYEXABI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:08 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36661 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYEXABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:07 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 88D3B1DDC5C
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 87C45185E1B; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82776>

This is needed as we want to use it later in builtin-merge.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile        |    2 ++
 builtin-reset.c |   17 +----------------
 reset.c         |   28 ++++++++++++++++++++++++++++
 reset.h         |    6 ++++++
 4 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

diff --git a/Makefile b/Makefile
index a2de075..91d938a 100644
--- a/Makefile
+++ b/Makefile
@@ -364,6 +364,7 @@ LIB_H += quote.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
+LIB_H += reset.h
 LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += sha1-lookup.h
@@ -443,6 +444,7 @@ LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
+LIB_OBJS += reset.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
diff --git a/builtin-reset.c b/builtin-reset.c
index 79424bb..6e6e168 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "branch.h"
 #include "parse-options.h"
+#include "reset.h"
 
 static const char * const git_reset_usage[] = {
 	"git-reset [--mixed | --soft | --hard] [-q] [<commit>]",
@@ -49,22 +50,6 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
-{
-	int i = 0;
-	const char *args[6];
-
-	args[i++] = "read-tree";
-	args[i++] = "-v";
-	args[i++] = "--reset";
-	if (is_hard_reset)
-		args[i++] = "-u";
-	args[i++] = sha1_to_hex(sha1);
-	args[i] = NULL;
-
-	return run_command_v_opt(args, RUN_GIT_CMD);
-}
-
 static void print_new_head_line(struct commit *commit)
 {
 	const char *hex, *body;
diff --git a/reset.c b/reset.c
new file mode 100644
index 0000000..a75fec6
--- /dev/null
+++ b/reset.c
@@ -0,0 +1,28 @@
+/*
+ * generic fucntion(s) from the "git reset" builtin command
+ *
+ * Copyright (c) 2007 Carlos Rica
+ *
+ * Based on git-reset.sh, which is
+ *
+ * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
+ */
+
+#include "cache.h"
+#include "run-command.h"
+
+int reset_index_file(const unsigned char *sha1, int is_hard_reset)
+{
+	int i = 0;
+	const char *args[6];
+
+	args[i++] = "read-tree";
+	args[i++] = "-v";
+	args[i++] = "--reset";
+	if (is_hard_reset)
+		args[i++] = "-u";
+	args[i++] = sha1_to_hex(sha1);
+	args[i] = NULL;
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
diff --git a/reset.h b/reset.h
new file mode 100644
index 0000000..4ae235b
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,6 @@
+#ifndef RESET_H
+#define RESET_H
+
+int reset_index_file(const unsigned char *sha1, int is_hard_reset);
+
+#endif
-- 
1.5.5.1.357.g1af8b.dirty
