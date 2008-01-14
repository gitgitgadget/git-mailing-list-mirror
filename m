From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Move sha1_file_to_archive into libgit
Date: Mon, 14 Jan 2008 17:36:34 +0100
Message-ID: <1200328594-17810-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 17:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JES8Q-0006fz-Rd
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 17:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbYANQZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 11:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYANQZd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 11:25:33 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:44987 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYANQZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 11:25:32 -0500
X-Greylist: delayed 2852 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2008 11:25:31 EST
Received: from localhost.localdomain (ti231210a341-0985.bb.online.no [88.88.171.217])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m0EFbc7b024614;
	Mon, 14 Jan 2008 16:37:38 +0100 (MET)
X-Mailer: git-send-email 1.5.4.rc2.69.g047fe-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70463>

When the specfile (export-subst) attribute was introduced, it added a
dependency from archive-{tar|zip}.c to builtin-archive.c. This broke the
support for archive-operations in libgit.a since builtin-archive.o doesn't
belong in libgit.a.

This patch moves the functions required by libgit.a from builtin-archive.c
to the new file archive.c (which becomes part of libgit.a).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Makefile          |    2 +-
 archive.c         |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin-archive.c |   80 --------------------------------------------------
 3 files changed, 85 insertions(+), 81 deletions(-)
 create mode 100644 archive.c

diff --git a/Makefile b/Makefile
index 21c80e6..c9b482a 100644
--- a/Makefile
+++ b/Makefile
@@ -316,7 +316,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o
+	transport.o bundle.o walker.o parse-options.o ws.o archive.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/archive.c b/archive.c
new file mode 100644
index 0000000..fb159fe
--- /dev/null
+++ b/archive.c
@@ -0,0 +1,84 @@
+#include "cache.h"
+#include "commit.h"
+#include "attr.h"
+
+static void format_subst(const struct commit *commit,
+                         const char *src, size_t len,
+                         struct strbuf *buf)
+{
+	char *to_free = NULL;
+	struct strbuf fmt;
+
+	if (src == buf->buf)
+		to_free = strbuf_detach(buf, NULL);
+	strbuf_init(&fmt, 0);
+	for (;;) {
+		const char *b, *c;
+
+		b = memmem(src, len, "$Format:", 8);
+		if (!b || src + len < b + 9)
+			break;
+		c = memchr(b + 8, '$', len - 8);
+		if (!c)
+			break;
+
+		strbuf_reset(&fmt);
+		strbuf_add(&fmt, b + 8, c - b - 8);
+
+		strbuf_add(buf, src, b - src);
+		format_commit_message(commit, fmt.buf, buf);
+		len -= c + 1 - src;
+		src  = c + 1;
+	}
+	strbuf_add(buf, src, len);
+	strbuf_release(&fmt);
+	free(to_free);
+}
+
+static int convert_to_archive(const char *path,
+                              const void *src, size_t len,
+                              struct strbuf *buf,
+                              const struct commit *commit)
+{
+	static struct git_attr *attr_export_subst;
+	struct git_attr_check check[1];
+
+	if (!commit)
+		return 0;
+
+	if (!attr_export_subst)
+		attr_export_subst = git_attr("export-subst", 12);
+
+	check[0].attr = attr_export_subst;
+	if (git_checkattr(path, ARRAY_SIZE(check), check))
+		return 0;
+	if (!ATTR_TRUE(check[0].value))
+		return 0;
+
+	format_subst(commit, src, len, buf);
+	return 1;
+}
+
+void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
+                           unsigned int mode, enum object_type *type,
+                           unsigned long *sizep,
+                           const struct commit *commit)
+{
+	void *buffer;
+
+	buffer = read_sha1_file(sha1, type, sizep);
+	if (buffer && S_ISREG(mode)) {
+		struct strbuf buf;
+		size_t size = 0;
+
+		strbuf_init(&buf, 0);
+		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
+		convert_to_working_tree(path, buf.buf, buf.len, &buf);
+		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
+		buffer = strbuf_detach(&buf, &size);
+		*sizep = size;
+	}
+
+	return buffer;
+}
+
diff --git a/builtin-archive.c b/builtin-archive.c
index 14a1b30..c2e0c1e 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -79,86 +79,6 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static void format_subst(const struct commit *commit,
-                         const char *src, size_t len,
-                         struct strbuf *buf)
-{
-	char *to_free = NULL;
-	struct strbuf fmt;
-
-	if (src == buf->buf)
-		to_free = strbuf_detach(buf, NULL);
-	strbuf_init(&fmt, 0);
-	for (;;) {
-		const char *b, *c;
-
-		b = memmem(src, len, "$Format:", 8);
-		if (!b || src + len < b + 9)
-			break;
-		c = memchr(b + 8, '$', len - 8);
-		if (!c)
-			break;
-
-		strbuf_reset(&fmt);
-		strbuf_add(&fmt, b + 8, c - b - 8);
-
-		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf);
-		len -= c + 1 - src;
-		src  = c + 1;
-	}
-	strbuf_add(buf, src, len);
-	strbuf_release(&fmt);
-	free(to_free);
-}
-
-static int convert_to_archive(const char *path,
-                              const void *src, size_t len,
-                              struct strbuf *buf,
-                              const struct commit *commit)
-{
-	static struct git_attr *attr_export_subst;
-	struct git_attr_check check[1];
-
-	if (!commit)
-		return 0;
-
-	if (!attr_export_subst)
-		attr_export_subst = git_attr("export-subst", 12);
-
-	check[0].attr = attr_export_subst;
-	if (git_checkattr(path, ARRAY_SIZE(check), check))
-		return 0;
-	if (!ATTR_TRUE(check[0].value))
-		return 0;
-
-	format_subst(commit, src, len, buf);
-	return 1;
-}
-
-void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
-                           unsigned int mode, enum object_type *type,
-                           unsigned long *sizep,
-                           const struct commit *commit)
-{
-	void *buffer;
-
-	buffer = read_sha1_file(sha1, type, sizep);
-	if (buffer && S_ISREG(mode)) {
-		struct strbuf buf;
-		size_t size = 0;
-
-		strbuf_init(&buf, 0);
-		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(path, buf.buf, buf.len, &buf);
-		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
-		buffer = strbuf_detach(&buf, &size);
-		*sizep = size;
-	}
-
-	return buffer;
-}
-
 static int init_archiver(const char *name, struct archiver *ar)
 {
 	int rv = -1, i;
-- 
1.5.4.rc2.69.g047fe-dirty
