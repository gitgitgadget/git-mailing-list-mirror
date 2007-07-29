From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Add editor.c grouping functions for editing text files.
Date: Sun, 29 Jul 2007 20:21:06 +0200
Message-ID: <46ACDA92.4000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 20:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFDOQ-0000Mw-3A
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 20:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765195AbXG2SVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762983AbXG2SVW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 14:21:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:55448 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759296AbXG2SVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 14:21:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123976nfb
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 11:21:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Sd9MQI56k6BNpixVCp7arXg5++v0tuWw0VBppHKp6WgJxxkBB0G+vQPi3QOC8bLLaLWOdq7b/0ryT379nkXMCW4Vnkm19znjI1qexXrMgs2H8JUXa+4LzlglMmy+nWo2BtU0MhfauW887nKOu2N85pxUNEPZbQYJGXkcYYNzrTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Y8VAH1lDjqL1aHFwQBUiBN6/GdMgwxhvpSZ6y8r5m8hNNwxeTJa2kTpJhlVAKR+Au9Uv6wEvPPPKrGM4/GdU/7vh1ZnJXPEmX0tTfFRoNXjObv/+qpKGQZxSAqkeeDJlm5XTIW/69MCnLTIQPOevmfs9QZ2tZdUsMwfTCLWLZTc=
Received: by 10.86.84.5 with SMTP id h5mr3367367fgb.1185733279038;
        Sun, 29 Jul 2007 11:21:19 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id f4sm9030027nfh.2007.07.29.11.21.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jul 2007 11:21:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54129>

The new file is grouping the previous function stripspace
from "builtin-stripspace.c", the previous launch_editor
from "builtin-tag.c", and a new function read_file, designed
to be also shared with the upcoming "builtin-commit.c".

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   This change is committed on top of the current "next".

   It is the first proposal for the file editor.c with
   some functions intended to be shared at least between the
   recent "builtin-tag.c" and the upcoming "builtin-commit.c"
   which Kristian is working on.

   read_file is a reimplementation of the function read_path
   which was helping to Kristian in his builtin-commit.c:
   http://article.gmane.org/gmane.comp.version-control.git/52892

   launch_editor now is just the same that "builtin-tag.c" was using,
   but since it is currently different than the launch_editor from
   "builtin-commit.c", it will need more changes which should be
   discussed here. Every suggestion will be appreciated.

 Makefile             |    5 +-
 builtin-stripspace.c |   71 ---------------------
 builtin-tag.c        |   47 +--------------
 builtin.h            |    1 -
 editor.c             |  165 ++++++++++++++++++++++++++++++++++++++++++++++++++
 editor.h             |   10 +++
 6 files changed, 179 insertions(+), 120 deletions(-)
 create mode 100644 editor.c
 create mode 100644 editor.h

diff --git a/Makefile b/Makefile
index 98670bb..7417d95 100644
--- a/Makefile
+++ b/Makefile
@@ -284,7 +284,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h editor.h

 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -306,7 +306,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
+	editor.o

 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 916355c..7cb538a 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,77 +1,6 @@
 #include "builtin.h"
 #include "cache.h"

-/*
- * Returns the length of a line, without trailing spaces.
- *
- * If the line ends with newline, it will be removed too.
- */
-static size_t cleanup(char *line, size_t len)
-{
-	if (len) {
-		if (line[len - 1] == '\n')
-			len--;
-
-		while (len) {
-			unsigned char c = line[len - 1];
-			if (!isspace(c))
-				break;
-			len--;
-		}
-	}
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
- * If last line has a newline at the end, it will be removed.
- *
- * Enable skip_comments to skip every line starting with "#".
- */
-size_t stripspace(char *buffer, size_t length, int skip_comments)
-{
-	int empties = -1;
-	size_t i, j, len, newlen;
-	char *eol;
-
-	for (i = j = 0; i < length; i += len, j += newlen) {
-		eol = memchr(buffer + i, '\n', length - i);
-		len = eol ? eol - (buffer + i) + 1 : length - i;
-
-		if (skip_comments && len && buffer[i] == '#') {
-			newlen = 0;
-			continue;
-		}
-		newlen = cleanup(buffer + i, len);
-
-		/* Not just an empty line? */
-		if (newlen) {
-			if (empties != -1)
-				buffer[j++] = '\n';
-			if (empties > 0)
-				buffer[j++] = '\n';
-			empties = 0;
-			memmove(buffer + j, buffer + i, newlen);
-			continue;
-		}
-		if (empties < 0)
-			continue;
-		empties++;
-	}
-
-	return j;
-}
-
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	char *buffer;
diff --git a/builtin-tag.c b/builtin-tag.c
index d6d38ad..4957d56 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -11,58 +11,13 @@
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
+#include "editor.h"

 static const char builtin_tag_usage[] =
   "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]";

 static char signingkey[1000];

-static void launch_editor(const char *path, char **buffer, unsigned long *len)
-{
-	const char *editor, *terminal;
-	struct child_process child;
-	const char *args[3];
-	int fd;
-
-	editor = getenv("GIT_EDITOR");
-	if (!editor && editor_program)
-		editor = editor_program;
-	if (!editor)
-		editor = getenv("VISUAL");
-	if (!editor)
-		editor = getenv("EDITOR");
-
-	terminal = getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
-		fprintf(stderr,
-		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
-		"Please supply the message using either -m or -F option.\n");
-		exit(1);
-	}
-
-	if (!editor)
-		editor = "vi";
-
-	memset(&child, 0, sizeof(child));
-	child.argv = args;
-	args[0] = editor;
-	args[1] = path;
-	args[2] = NULL;
-
-	if (run_command(&child))
-		die("There was a problem with the editor %s.", editor);
-
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		die("could not open '%s': %s", path, strerror(errno));
-	if (read_fd(fd, buffer, len)) {
-		free(*buffer);
-		die("could not read message file '%s': %s",
-						path, strerror(errno));
-	}
-	close(fd);
-}
-
 struct tag_filter {
 	const char *pattern;
 	int lines;
diff --git a/builtin.h b/builtin.h
index bb72000..91bc595 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,7 +7,6 @@ extern const char git_version_string[];
 extern const char git_usage_string[];

 extern void help_unknown_cmd(const char *cmd);
-extern size_t stripspace(char *buffer, size_t length, int skip_comments);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);

diff --git a/editor.c b/editor.c
new file mode 100644
index 0000000..f0c3dc6
--- /dev/null
+++ b/editor.c
@@ -0,0 +1,165 @@
+/*
+ * Utility functions for reading and editing text files.
+ *
+ * Copyright (c) 2007 Carlos Rica <jasampler@gmail.com>
+ */
+
+#include "cache.h"
+#include "run-command.h"
+#include "editor.h"
+
+void launch_editor(const char *path, char **buffer, unsigned long *len)
+{
+	const char *editor, *terminal;
+	struct child_process child;
+	const char *args[3];
+	int fd;
+
+	editor = getenv("GIT_EDITOR");
+	if (!editor && editor_program)
+		editor = editor_program;
+	if (!editor)
+		editor = getenv("VISUAL");
+	if (!editor)
+		editor = getenv("EDITOR");
+
+	terminal = getenv("TERM");
+	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
+		fprintf(stderr,
+		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
+		"Please supply the message using either -m or -F option.\n");
+		exit(1);
+	}
+
+	if (!editor)
+		editor = "vi";
+
+	memset(&child, 0, sizeof(child));
+	child.argv = args;
+	args[0] = editor;
+	args[1] = path;
+	args[2] = NULL;
+
+	if (run_command(&child))
+		die("There was a problem with the editor %s.", editor);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("could not open '%s': %s", path, strerror(errno));
+	if (read_fd(fd, buffer, len)) {
+		free(*buffer);
+		die("could not read message file '%s': %s",
+						path, strerror(errno));
+	}
+	close(fd);
+}
+
+/*
+ * reads a file into memory, allocating a buffer to hold it and then
+ * returning it in *return_buf and setting also *return_size to save
+ * the size of its contents. Note that both variables are overwritten.
+ *
+ * If the path is "-" and the flag ALLOW_STDIN is enabled,
+ * then standard input is used to read the data.
+ * Currently, no other flags are defined.
+ *
+ * In case of failure, when -1 is returned, the allocated buffer is freed,
+ * otherwise the buffer must be freed by the caller.
+ */
+int read_file(const char *path, int flags,
+		char** return_buf, unsigned long* return_size)
+{
+	int fd;
+
+	if (flags & ALLOW_STDIN && path[0] == '-' && path[1] == '\0')
+		fd = 0;
+	else {
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+	}
+
+	*return_size = 4096;
+	*return_buf = xmalloc(*return_size);
+	if (read_fd(fd, return_buf, return_size)) {
+		free(*return_buf);
+		if (fd)
+			close(fd);
+		return -1;
+	}
+	if (fd)
+		close(fd);
+
+	return 0;
+}
+
+/*
+ * Returns the length of a line, without trailing spaces.
+ *
+ * If the line ends with newline, it will be removed too.
+ */
+static size_t cleanup(char *line, size_t len)
+{
+	if (len) {
+		if (line[len - 1] == '\n')
+			len--;
+
+		while (len) {
+			unsigned char c = line[len - 1];
+			if (!isspace(c))
+				break;
+			len--;
+		}
+	}
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
+ * If last line has a newline at the end, it will be removed.
+ *
+ * Enable skip_comments to skip every line starting with "#".
+ */
+size_t stripspace(char *buffer, size_t length, int skip_comments)
+{
+	int empties = -1;
+	size_t i, j, len, newlen;
+	char *eol;
+
+	for (i = j = 0; i < length; i += len, j += newlen) {
+		eol = memchr(buffer + i, '\n', length - i);
+		len = eol ? eol - (buffer + i) + 1 : length - i;
+
+		if (skip_comments && len && buffer[i] == '#') {
+			newlen = 0;
+			continue;
+		}
+		newlen = cleanup(buffer + i, len);
+
+		/* Not just an empty line? */
+		if (newlen) {
+			if (empties != -1)
+				buffer[j++] = '\n';
+			if (empties > 0)
+				buffer[j++] = '\n';
+			empties = 0;
+			memmove(buffer + j, buffer + i, newlen);
+			continue;
+		}
+		if (empties < 0)
+			continue;
+		empties++;
+	}
+
+	return j;
+}
diff --git a/editor.h b/editor.h
new file mode 100644
index 0000000..1d3e771
--- /dev/null
+++ b/editor.h
@@ -0,0 +1,10 @@
+#ifndef EDITOR_H
+#define EDITOR_H
+
+void launch_editor(const char *path, char **buffer, unsigned long *len);
+#define ALLOW_STDIN 0x01
+int read_file(const char *path, int flags,
+		char** return_buf, unsigned long* return_size);
+size_t stripspace(char *buffer, size_t length, int skip_comments);
+
+#endif
-- 
1.5.0
