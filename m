From: skimo@liacs.nl
Subject: [PATCH 2/3] entry.c: checkout available submodules
Date: Fri, 25 May 2007 23:07:12 +0200
Message-ID: <1180127233893-git-send-email-skimo@liacs.nl>
References: <1180127233729-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrh0i-0008Ps-RI
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbXEYVHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXEYVHi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:07:38 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60867 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbXEYVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:07:34 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4PL7DNm031052;
	Fri, 25 May 2007 23:07:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 49C553C00A; Fri, 25 May 2007 23:07:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <1180127233729-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48417>

From: Sven Verdoolaege <skimo@kotnet.org>

That is, checkout any submodule that has a valid HEAD in it.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Makefile     |    5 +++--
 entry.c      |   30 ++++++++++++++++++++++++++++--
 submodules.c |    8 ++++++++
 submodules.h |    6 ++++++
 4 files changed, 45 insertions(+), 4 deletions(-)
 create mode 100644 submodules.c
 create mode 100644 submodules.h

diff --git a/Makefile b/Makefile
index c79a6da..6d24048 100644
--- a/Makefile
+++ b/Makefile
@@ -297,7 +297,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h submodules.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -319,7 +319,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
+	submodules.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/entry.c b/entry.c
index ae64764..97f95c6 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "blob.h"
+#include "run-command.h"
+#include "submodules.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -75,6 +77,31 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 	return NULL;
 }
 
+static int checkout_submodule(struct cache_entry *ce, const char *path, const struct checkout *state)
+{
+	const char *args[10];
+	int argc;
+	int err;
+
+	if (!is_checkedout_submodule(ce->name))
+		return 0;
+
+	argc = 0;
+	args[argc++] = "checkout";
+	if (state->force)
+	    args[argc++] = "-f";
+	args[argc++] = sha1_to_hex(ce->sha1);
+	args[argc] = NULL;
+
+	err = run_command_v_opt_cd(args, RUN_GIT_CMD|RUN_COMMAND_CLEAR_GIT_ENV,
+				   path);
+
+	if (err)
+		return error("failed to run git-checkout in submodule '%s'", path);
+
+	return 0;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	int fd;
@@ -193,9 +220,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
 			if (S_ISGITLINK(ntohl(ce->ce_mode)))
-				return 0;
+				return checkout_submodule(ce, path, state);
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
diff --git a/submodules.c b/submodules.c
new file mode 100644
index 0000000..5baf90a
--- /dev/null
+++ b/submodules.c
@@ -0,0 +1,8 @@
+#include "cache.h"
+#include "refs.h"
+
+int is_checkedout_submodule(const char *path)
+{
+	unsigned char sha1[20];
+	return resolve_gitlink_ref(path, "HEAD", sha1) == 0;
+}
diff --git a/submodules.h b/submodules.h
new file mode 100644
index 0000000..099c4c3
--- /dev/null
+++ b/submodules.h
@@ -0,0 +1,6 @@
+#ifndef SUBMODULES_H
+#define SUBMODULES_H
+
+int is_checkedout_submodule(const char *path);
+
+#endif
-- 
1.5.2.838.gbeec
