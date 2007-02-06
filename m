From: Jeff King <peff@peff.net>
Subject: [PATCH] Add utility functions for enumerating remotes.
Date: Tue, 6 Feb 2007 02:25:14 -0500
Message-ID: <20070206072513.GA29895@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 08:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEKhs-0002Dm-51
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXBFHZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXBFHZS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:25:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1762 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbXBFHZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:25:16 -0500
Received: (qmail 22557 invoked from network); 6 Feb 2007 02:25:16 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Feb 2007 02:25:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2007 02:25:14 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38814>

This creates remotes.[ch], which implement for_each_remote, a function
for enumerating all remotes.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote this to play with Carl's "look for branches under refs/remotes/"
idea. Since these functions have no users, I don't know if it's worth
applying this patch. However, I thought I would publish it, at least,
since it may eventually become useful.

 Makefile  |    3 +-
 remotes.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remotes.h |    6 +++++
 3 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100644 remotes.c
 create mode 100644 remotes.h

diff --git a/Makefile b/Makefile
index de89d8a..aca96c8 100644
--- a/Makefile
+++ b/Makefile
@@ -261,7 +261,8 @@ LIB_OBJS = \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
+	remotes.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/remotes.c b/remotes.c
new file mode 100644
index 0000000..1963753
--- /dev/null
+++ b/remotes.c
@@ -0,0 +1,71 @@
+#include "remotes.h"
+#include "cache.h"
+
+/* We can't be reentrant here, because git_config doesn't allow
+ * passing callback data. */
+static each_remote_fn *config_fn;
+static void *config_cb_data;
+static int config_ret;
+static int find_remote_in_config(const char *k, const char *v)
+{
+	const char *dot;
+	char remote[1024];
+
+	if (config_ret < 0)
+		return 0;
+
+	if (strncmp(k, "remote.", 7))
+		return 0;
+	k += 7;
+	dot = strchr(k, '.');
+	if (!dot)
+		return 0;
+	if (strcmp(dot + 1, "url"))
+		return 0;
+
+	memcpy(remote, k, dot - k);
+	remote[dot - k] = '\0';
+
+	config_ret = config_fn(remote, config_cb_data);
+	return 0;
+}
+
+static int do_for_each_remotes(each_remote_fn fn, void *cb_data)
+{
+	const char *remotes;
+        DIR *dir;
+	struct dirent *de;
+	int ret;
+
+	remotes = git_path("remotes");
+	dir = opendir(remotes);
+	if (!dir) {
+		if (errno == ENOENT)
+			return 0;
+		die("unable to open %s: %s", remotes, strerror(errno));
+	}
+
+	ret = 0;
+	while ((de = readdir(dir)) != NULL) {
+		if (de->d_name[0] == '.')
+			continue;
+		ret = fn(de->d_name, cb_data);
+		if (ret < 0)
+			break;
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+int for_each_remote(each_remote_fn fn, void *cb_data)
+{
+	config_fn = fn;
+	config_cb_data = cb_data;
+	config_ret = 0;
+	git_config(find_remote_in_config);
+	if (config_ret < 0)
+		return config_ret;
+
+	return do_for_each_remotes(fn, cb_data);
+}
diff --git a/remotes.h b/remotes.h
new file mode 100644
index 0000000..632a449
--- /dev/null
+++ b/remotes.h
@@ -0,0 +1,6 @@
+#ifndef REMOTES_H
+
+typedef int each_remote_fn(const char *remote, void *cb_data);
+int for_each_remote(each_remote_fn fn, void *cb_data);
+
+#endif /* REMOTES_H */
-- 
1.5.0.rc3.554.ga40e-dirty
