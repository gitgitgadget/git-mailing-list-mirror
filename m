From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] Move launch_editor() from builtin-tag.c to editor.c
Date: Fri, 25 Jul 2008 18:28:41 +0200
Message-ID: <1217003322-10291-1-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQB1-0001fO-Cd
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbYGYQ2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYGYQ2y
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:28:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:54033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751571AbYGYQ2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:28:52 -0400
Received: (qmail invoked by alias); 25 Jul 2008 16:28:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp041) with SMTP; 25 Jul 2008 18:28:50 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19EHz9ZiRlE6/8vh9ABG9HJKGZdpT5hjwhlWfD5dJ
	UHJNI9v9ta1JHv
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQ9q-0002gP-PT; Fri, 25 Jul 2008 18:28:42 +0200
X-Mailer: git-send-email 1.6.0.rc0.102.ga1791
In-Reply-To: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90066>

launch_editor() is declared in strbuf.h but defined in builtin-tag.c.
This patch moves launch_editor() into a new source file editor.c,
but keeps the declaration in strbuf.h.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Johannes Schindelin wrote:
> > This means I should send them again?
>
> If you want to be nice to the maintainer, yes.  If not, no.

I understand ;-)

No need to play the bad guy, so here's the patchset again.

To be kind to the maintainer, I've also run the test suite again,
all tests passed except t4116*.sh, but this is not my fault.
It's the fault of 9a885fac.

Regards,
  Stephan

 Makefile      |    1 +
 builtin-tag.c |   53 -----------------------------------------------------
 editor.c      |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 53 deletions(-)
 create mode 100644 editor.c

diff --git a/Makefile b/Makefile
index b01cf1c..df5b0d0 100644
--- a/Makefile
+++ b/Makefile
@@ -410,6 +410,7 @@ LIB_OBJS += diff-no-index.o
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
1.6.0.rc0.102.ga1791
