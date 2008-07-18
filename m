From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Move launch_editor() from builtin-tag.c to editor.c
Date: Fri, 18 Jul 2008 02:36:18 +0200
Message-ID: <1216341378-15444-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 02:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJdyM-0000DJ-Sy
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 02:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbYGRAgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 20:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbYGRAgX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 20:36:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:49188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755578AbYGRAgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 20:36:23 -0400
Received: (qmail invoked by alias); 18 Jul 2008 00:36:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 18 Jul 2008 02:36:21 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/wNxIE6BrwZ7IjkTcEyzsQZ36lUrwSoFgak5KwKp
	B9vEyw4nlScaD7
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJdxK-00041V-4S; Fri, 18 Jul 2008 02:36:18 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88940>

launch_editor() is declared in strbuf.h but defined in builtin-tag.c.
This patch moves launch_editor() into a new source file editor.c,
but keeps the declaration in strbuf.h.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

why editor.c and not strbuf.c?
See http://thread.gmane.org/gmane.comp.version-control.git/86636/focus=88939

And I wonder why launch_editor is part of the strbuf API at all. ;)

Regards,
  Stephan

 Makefile      |    1 +
 builtin-tag.c |   53 -----------------------------------------------------
 editor.c      |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 53 deletions(-)
 create mode 100644 editor.c

diff --git a/Makefile b/Makefile
index 75c4ead..4bec4b3 100644
--- a/Makefile
+++ b/Makefile
@@ -409,6 +409,7 @@ LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff.o
 LIB_OBJS += dir.o
+LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
diff --git a/builtin-tag.c b/builtin-tag.c
index c2cca6c..219f51d 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -23,59 +23,6 @@ static const char * const git_tag_usage[] = {
 
 static char signingkey[1000];
 
-void launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
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
-		size_t len = strlen(editor);
-		int i = 0;
-		const char *args[6];
-		struct strbuf arg0;
-
-		strbuf_init(&arg0, 0);
-		if (strcspn(editor, "$ \t'") != len) {
-			/* there are specials */
-			strbuf_addf(&arg0, "%s \"$@\"", editor);
-			args[i++] = "sh";
-			args[i++] = "-c";
-			args[i++] = arg0.buf;
-		}
-		args[i++] = editor;
-		args[i++] = path;
-		args[i] = NULL;
-
-		if (run_command_v_opt_cd_env(args, 0, NULL, env))
-			die("There was a problem with the editor %s.", editor);
-		strbuf_release(&arg0);
-	}
-
-	if (!buffer)
-		return;
-	if (strbuf_read_file(buffer, path, 0) < 0)
-		die("could not read message file '%s': %s",
-		    path, strerror(errno));
-}
-
 struct tag_filter {
 	const char *pattern;
 	int lines;
diff --git a/editor.c b/editor.c
new file mode 100644
index 0000000..483b62d
--- /dev/null
+++ b/editor.c
@@ -0,0 +1,56 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "run-command.h"
+
+void launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
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
+		size_t len = strlen(editor);
+		int i = 0;
+		const char *args[6];
+		struct strbuf arg0;
+
+		strbuf_init(&arg0, 0);
+		if (strcspn(editor, "$ \t'") != len) {
+			/* there are specials */
+			strbuf_addf(&arg0, "%s \"$@\"", editor);
+			args[i++] = "sh";
+			args[i++] = "-c";
+			args[i++] = arg0.buf;
+		}
+		args[i++] = editor;
+		args[i++] = path;
+		args[i] = NULL;
+
+		if (run_command_v_opt_cd_env(args, 0, NULL, env))
+			die("There was a problem with the editor %s.", editor);
+		strbuf_release(&arg0);
+	}
+
+	if (!buffer)
+		return;
+	if (strbuf_read_file(buffer, path, 0) < 0)
+		die("could not read message file '%s': %s",
+		    path, strerror(errno));
+}
-- 
1.5.6.3.390.g7b30
