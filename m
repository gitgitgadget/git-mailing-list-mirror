From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/6] submodule.*: Introduce simple C interface for submodule
	lookup by path
Date: Fri, 12 Sep 2008 23:08:57 +0200
Message-ID: <20080912210857.31628.7605.stgit@localhost>
References: <20080912210817.31628.69014.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 23:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeFuM-0006J2-NP
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297AbYILVJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbYILVJD
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:09:03 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:53663 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756247AbYILVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:09:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 90EC22AC89F;
	Fri, 12 Sep 2008 23:08:57 +0200 (CEST)
In-Reply-To: <20080912210817.31628.69014.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95764>

The interface will be used for git-mv and git-rm submodule support.
So far, only the submodule_by_path() function is defined, however more
can be probably expected in the future if/when the git-submodule command
is ported from shell.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile    |    2 ++
 submodule.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |    8 ++++++++
 3 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h

diff --git a/Makefile b/Makefile
index 247cd2d..c7c6478 100644
--- a/Makefile
+++ b/Makefile
@@ -384,6 +384,7 @@ LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += strbuf.h
+LIB_H += submodule.h
 LIB_H += tag.h
 LIB_H += transport.h
 LIB_H += tree.h
@@ -476,6 +477,7 @@ LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += strbuf.o
+LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule.c b/submodule.c
new file mode 100644
index 0000000..2883ae6
--- /dev/null
+++ b/submodule.c
@@ -0,0 +1,50 @@
+#include "cache.h"
+#include "submodule.h"
+
+
+struct gitmodules_info {
+	const char *path;
+	char *key;
+};
+
+static int gitmodules_worker(const char *key, const char *value, void *info_)
+{
+	struct gitmodules_info *info = info_;
+	const char *subkey;
+
+	if (prefixcmp(key, "submodule."))
+		return 0;
+
+	subkey = strrchr(key, '.');
+	if (!subkey)
+		return 0;
+
+	if (strcmp(subkey, ".path"))
+		return 0;
+
+	if (strcmp(value, info->path))
+		return 0;
+
+	/* Found the key to change. */
+	if (info->key) {
+		error("multiple submodules live at path `%s'", info->path);
+		/* The last one is supposed to win. */
+		free(info->key);
+	}
+	info->key = xstrdup(key);
+	return 0;
+}
+
+char *submodule_by_path(const char *path)
+{
+	struct gitmodules_info info = { path, NULL };
+
+	config_exclusive_filename = ".gitmodules";
+	if (git_config(gitmodules_worker, &info))
+		die("cannot process .gitmodules");
+	if (!info.key)
+		die("the submodule of `%s' not found in .gitmodules", path);
+	config_exclusive_filename = NULL;
+
+	return info.key;
+}
diff --git a/submodule.h b/submodule.h
new file mode 100644
index 0000000..bc74fa0
--- /dev/null
+++ b/submodule.h
@@ -0,0 +1,8 @@
+#ifndef SUBMODULE_H
+#define SUBMODULE_H
+
+/* Find submodule living at given path in .gitmodules and return the key
+ * of its path config variable (dynamically allocated). */
+extern char *submodule_by_path(const char *path);
+
+#endif
