From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 4/4] Move launch_editor() and stripspace() to new file editor.c.
Date: Thu, 27 Sep 2007 00:50:32 -0400
Message-ID: <1190868632-29287-4-git-send-email-krh@redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
 <1190868632-29287-2-git-send-email-krh@redhat.com>
 <1190868632-29287-3-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 27 07:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ialcn-0004QP-0Q
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbXI0FI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbXI0FIy
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:08:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbXI0FIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:08:49 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58kNQ031491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2007 01:08:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58kEh001674;
	Thu, 27 Sep 2007 01:08:46 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58gMt002271;
	Thu, 27 Sep 2007 01:08:45 -0400
X-Mailer: git-send-email 1.5.3.2.1119.gab6f-dirty
In-Reply-To: <1190868632-29287-3-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59261>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile             |    2 +-
 builtin-commit.c     |    1 +
 builtin-stripspace.c |   68 +------------------------------
 builtin-tag.c        |   40 +------------------
 editor.c             |  109 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 editor.h             |    9 ++++
 strbuf.h             |    3 -
 7 files changed, 122 insertions(+), 110 deletions(-)
 create mode 100644 editor.c
 create mode 100644 editor.h

diff --git a/Makefile b/Makefile
index 6172589..f6d991e 100644
--- a/Makefile
+++ b/Makefile
@@ -310,7 +310,7 @@ LIB_OBJS =3D \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o =
\
-	transport.o bundle.o parse-options.o
+	transport.o bundle.o parse-options.o editor.o
=20
 BUILTIN_OBJS =3D \
 	builtin-add.o \
diff --git a/builtin-commit.c b/builtin-commit.c
index 69e8b19..7d87812 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -19,6 +19,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "editor.h"
=20
 static const char builtin_commit_usage[] =3D
 	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <log=
file> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--te=
mplate <file>] [[-i | -o] <path>...]";
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index c0b2130..4e5bb07 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,72 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
-
-/*
- * Returns the length of a line, without trailing spaces.
- *
- * If the line ends with newline, it will be removed too.
- */
-static size_t cleanup(char *line, size_t len)
-{
-	while (len) {
-		unsigned char c =3D line[len - 1];
-		if (!isspace(c))
-			break;
-		len--;
-	}
-
-	return len;
-}
-
-/*
- * Remove empty lines from the beginning and end
- * and also trailing spaces from every line.
- *
- * Note that the buffer will not be NUL-terminated.
- *
- * Turn multiple consecutive empty lines between paragraphs
- * into just one empty line.
- *
- * If the input has only empty lines and spaces,
- * no output will be produced.
- *
- * If last line does not have a newline at the end, one is added.
- *
- * Enable skip_comments to skip every line starting with "#".
- */
-void stripspace(struct strbuf *sb, int skip_comments)
-{
-	int empties =3D 0;
-	size_t i, j, len, newlen;
-	char *eol;
-
-	/* We may have to add a newline. */
-	strbuf_grow(sb, 1);
-
-	for (i =3D j =3D 0; i < sb->len; i +=3D len, j +=3D newlen) {
-		eol =3D memchr(sb->buf + i, '\n', sb->len - i);
-		len =3D eol ? eol - (sb->buf + i) + 1 : sb->len - i;
-
-		if (skip_comments && len && sb->buf[i] =3D=3D '#') {
-			newlen =3D 0;
-			continue;
-		}
-		newlen =3D cleanup(sb->buf + i, len);
-
-		/* Not just an empty line? */
-		if (newlen) {
-			if (empties > 0 && j > 0)
-				sb->buf[j++] =3D '\n';
-			empties =3D 0;
-			memmove(sb->buf + j, sb->buf + i, newlen);
-			sb->buf[newlen + j++] =3D '\n';
-		} else {
-			empties++;
-		}
-	}
-
-	strbuf_setlen(sb, j);
-}
+#include "editor.h"
=20
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-tag.c b/builtin-tag.c
index 0a36a5d..c9a0497 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
+#include "editor.h"
 #include "run-command.h"
=20
 static const char builtin_tag_usage[] =3D
@@ -17,45 +18,6 @@ static const char builtin_tag_usage[] =3D
=20
 static char signingkey[1000];
=20
-void launch_editor(const char *path, struct strbuf *buffer)
-{
-	const char *editor, *terminal;
-	struct child_process child;
-	const char *args[3];
-
-	editor =3D getenv("GIT_EDITOR");
-	if (!editor && editor_program)
-		editor =3D editor_program;
-	if (!editor)
-		editor =3D getenv("VISUAL");
-	if (!editor)
-		editor =3D getenv("EDITOR");
-
-	terminal =3D getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
-		fprintf(stderr,
-		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
-		"Please supply the message using either -m or -F option.\n");
-		exit(1);
-	}
-
-	if (!editor)
-		editor =3D "vi";
-
-	memset(&child, 0, sizeof(child));
-	child.argv =3D args;
-	args[0] =3D editor;
-	args[1] =3D path;
-	args[2] =3D NULL;
-
-	if (run_command(&child))
-		die("There was a problem with the editor %s.", editor);
-
-	if (strbuf_read_file(buffer, path) < 0)
-		die("could not read message file '%s': %s",
-		    path, strerror(errno));
-}
-
 struct tag_filter {
 	const char *pattern;
 	int lines;
diff --git a/editor.c b/editor.c
new file mode 100644
index 0000000..6bc3033
--- /dev/null
+++ b/editor.c
@@ -0,0 +1,109 @@
+#include "git-compat-util.h"
+#include "editor.h"
+#include "run-command.h"
+
+void launch_editor(const char *path, struct strbuf *buffer)
+{
+	const char *editor, *terminal;
+	struct child_process child;
+	const char *args[3];
+
+	editor =3D getenv("GIT_EDITOR");
+	if (!editor && editor_program)
+		editor =3D editor_program;
+	if (!editor)
+		editor =3D getenv("VISUAL");
+	if (!editor)
+		editor =3D getenv("EDITOR");
+
+	terminal =3D getenv("TERM");
+	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
+		fprintf(stderr,
+		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
+		"Please supply the message using either -m or -F option.\n");
+		exit(1);
+	}
+
+	if (!editor)
+		editor =3D "vi";
+
+	memset(&child, 0, sizeof(child));
+	child.argv =3D args;
+	args[0] =3D editor;
+	args[1] =3D path;
+	args[2] =3D NULL;
+
+	if (run_command(&child))
+		die("There was a problem with the editor %s.", editor);
+
+	if (strbuf_read_file(buffer, path) < 0)
+		die("could not read message file '%s': %s",
+		    path, strerror(errno));
+}
+
+/*
+ * Returns the length of a line, without trailing spaces.
+ *
+ * If the line ends with newline, it will be removed too.
+ */
+static size_t cleanup(char *line, size_t len)
+{
+	while (len) {
+		unsigned char c =3D line[len - 1];
+		if (!isspace(c))
+			break;
+		len--;
+	}
+
+	return len;
+}
+
+/*
+ * Remove empty lines from the beginning and end
+ * and also trailing spaces from every line.
+ *
+ * Note that the buffer will not be NUL-terminated.
+ *
+ * Turn multiple consecutive empty lines between paragraphs
+ * into just one empty line.
+ *
+ * If the input has only empty lines and spaces,
+ * no output will be produced.
+ *
+ * If last line does not have a newline at the end, one is added.
+ *
+ * Enable skip_comments to skip every line starting with "#".
+ */
+void stripspace(struct strbuf *sb, int skip_comments)
+{
+	int empties =3D 0;
+	size_t i, j, len, newlen;
+	char *eol;
+
+	/* We may have to add a newline. */
+	strbuf_grow(sb, 1);
+
+	for (i =3D j =3D 0; i < sb->len; i +=3D len, j +=3D newlen) {
+		eol =3D memchr(sb->buf + i, '\n', sb->len - i);
+		len =3D eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+
+		if (skip_comments && len && sb->buf[i] =3D=3D '#') {
+			newlen =3D 0;
+			continue;
+		}
+		newlen =3D cleanup(sb->buf + i, len);
+
+		/* Not just an empty line? */
+		if (newlen) {
+			if (empties > 0 && j > 0)
+				sb->buf[j++] =3D '\n';
+			empties =3D 0;
+			memmove(sb->buf + j, sb->buf + i, newlen);
+			sb->buf[newlen + j++] =3D '\n';
+		} else {
+			empties++;
+		}
+	}
+
+	strbuf_setlen(sb, j);
+}
diff --git a/editor.h b/editor.h
new file mode 100644
index 0000000..9dc39f5
--- /dev/null
+++ b/editor.h
@@ -0,0 +1,9 @@
+#ifndef EDITOR_H
+#define EDITOR_H
+
+#include "cache.h"
+
+extern void launch_editor(const char *path, struct strbuf *buffer);
+extern void stripspace(struct strbuf *sb, int skip_comments);
+
+#endif
diff --git a/strbuf.h b/strbuf.h
index eef4e6d..d4d9e56 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -112,7 +112,4 @@ extern int strbuf_read_file(struct strbuf *sb, cons=
t char *path);
=20
 extern int strbuf_getline(struct strbuf *, FILE *, int);
=20
-extern void stripspace(struct strbuf *buf, int skip_comments);
-extern void launch_editor(const char *path, struct strbuf *buffer);
-
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
