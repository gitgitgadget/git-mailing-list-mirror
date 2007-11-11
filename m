From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Move stripspace() and launch_editor() to strbuf.c
Date: Sun, 11 Nov 2007 17:29:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111728380.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGcw-0003xd-60
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbXKKR3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXKKR3Z
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:29:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:39902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753612AbXKKR3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:29:24 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:29:22 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp036) with SMTP; 11 Nov 2007 18:29:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19B3kpf+UFB1tOYkrR9BBodSFiT7X4FF9cUxaUygp
	MYIOffEdPVbV/4
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64476>


These functions are already declared in strbuf.h, so it is only
logical to move their implementations to the corresponding file.
Particularly, since strbuf.h is in LIB_H, but both functions
were missing from libgit.a.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-stripspace.c |   67 --------------------------------
 builtin-tag.c        |   35 -----------------
 strbuf.c             |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 102 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index c0b2130..5de5a3f 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,73 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
 
-/*
- * Returns the length of a line, without trailing spaces.
- *
- * If the line ends with newline, it will be removed too.
- */
-static size_t cleanup(char *line, size_t len)
-{
-	while (len) {
-		unsigned char c = line[len - 1];
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
-	int empties = 0;
-	size_t i, j, len, newlen;
-	char *eol;
-
-	/* We may have to add a newline. */
-	strbuf_grow(sb, 1);
-
-	for (i = j = 0; i < sb->len; i += len, j += newlen) {
-		eol = memchr(sb->buf + i, '\n', sb->len - i);
-		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
-
-		if (skip_comments && len && sb->buf[i] == '#') {
-			newlen = 0;
-			continue;
-		}
-		newlen = cleanup(sb->buf + i, len);
-
-		/* Not just an empty line? */
-		if (newlen) {
-			if (empties > 0 && j > 0)
-				sb->buf[j++] = '\n';
-			empties = 0;
-			memmove(sb->buf + j, sb->buf + i, newlen);
-			sb->buf[newlen + j++] = '\n';
-		} else {
-			empties++;
-		}
-	}
-
-	strbuf_setlen(sb, j);
-}
-
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf;
diff --git a/builtin-tag.c b/builtin-tag.c
index 566b9d1..c70564b 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -17,41 +17,6 @@ static const char builtin_tag_usage[] =
 
 static char signingkey[1000];
 
-void launch_editor(const char *path, struct strbuf *buffer)
-{
-	const char *editor, *terminal;
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
-	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, path, NULL };
-
-		if (run_command_v_opt(args, 0))
-			die("There was a problem with the editor %s.", editor);
-	}
-
-	if (strbuf_read_file(buffer, path, 0) < 0)
-		die("could not read message file '%s': %s",
-		    path, strerror(errno));
-}
-
 struct tag_filter {
 	const char *pattern;
 	int lines;
diff --git a/strbuf.c b/strbuf.c
index 536b432..6e99358 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 
 /*
  * Used as the default ->buf value, so that people can always assume
@@ -224,3 +225,105 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
+
+/*
+ * Returns the length of a line, without trailing spaces.
+ *
+ * If the line ends with newline, it will be removed too.
+ */
+static size_t cleanup(char *line, size_t len)
+{
+	while (len) {
+		unsigned char c = line[len - 1];
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
+	int empties = 0;
+	size_t i, j, len, newlen;
+	char *eol;
+
+	/* We may have to add a newline. */
+	strbuf_grow(sb, 1);
+
+	for (i = j = 0; i < sb->len; i += len, j += newlen) {
+		eol = memchr(sb->buf + i, '\n', sb->len - i);
+		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+
+		if (skip_comments && len && sb->buf[i] == '#') {
+			newlen = 0;
+			continue;
+		}
+		newlen = cleanup(sb->buf + i, len);
+
+		/* Not just an empty line? */
+		if (newlen) {
+			if (empties > 0 && j > 0)
+				sb->buf[j++] = '\n';
+			empties = 0;
+			memmove(sb->buf + j, sb->buf + i, newlen);
+			sb->buf[newlen + j++] = '\n';
+		} else {
+			empties++;
+		}
+	}
+
+	strbuf_setlen(sb, j);
+}
+
+void launch_editor(const char *path, struct strbuf *buffer)
+{
+	const char *editor, *terminal;
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
+	if (strcmp(editor, ":")) {
+		const char *args[] = { editor, path, NULL };
+
+		if (run_command_v_opt(args, 0))
+			die("There was a problem with the editor %s.", editor);
+	}
+
+	if (strbuf_read_file(buffer, path, 0) < 0)
+		die("could not read message file '%s': %s",
+		    path, strerror(errno));
+}
-- 
1.5.3.5.1693.g26ed
