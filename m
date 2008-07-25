From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] editor.c: Libify launch_editor()
Date: Fri, 25 Jul 2008 18:28:42 +0200
Message-ID: <1217003322-10291-2-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness>
 <1217003322-10291-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQB0-0001fO-NP
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYGYQ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYGYQ2w
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:28:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:56258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751028AbYGYQ2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:28:52 -0400
Received: (qmail invoked by alias); 25 Jul 2008 16:28:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp042) with SMTP; 25 Jul 2008 18:28:50 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19EHz9ZiRlE6/8vh9ABG9HJKGZdpT5hjwhlWfD5dJ
	UHJNI9v9ta1JHv
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQ9q-0002gR-TW; Fri, 25 Jul 2008 18:28:42 +0200
X-Mailer: git-send-email 1.6.0.rc0.102.ga1791
In-Reply-To: <1217003322-10291-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90065>

This patch removes exit()/die() calls and builtin-specific messages
from launch_editor(), so that it can be used as a general libgit.a
function to launch an editor.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin-commit.c |    6 +++++-
 builtin-tag.c    |    6 +++++-
 editor.c         |   24 ++++++++++++------------
 foo              |    1 +
 strbuf.h         |    2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 foo

diff --git a/builtin-commit.c b/builtin-commit.c
index 6a9dc0e..9a11ca0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -646,7 +646,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		launch_editor(git_path(commit_editmsg), NULL, env);
+		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
+			fprintf(stderr,
+			"Please supply the message using either -m or -F option.\n");
+			exit(1);
+		}
 	}
 
 	if (!no_verify &&
diff --git a/builtin-tag.c b/builtin-tag.c
index 219f51d..325b1b2 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -295,7 +295,11 @@ static void create_tag(const unsigned char *object, const char *tag,
 			write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
 
-		launch_editor(path, buf, NULL);
+		if (launch_editor(path, buf, NULL)) {
+			fprintf(stderr,
+			"Please supply the message using either -m or -F option.\n");
+			exit(1);
+		}
 
 		unlink(path);
 		free(path);
diff --git a/editor.c b/editor.c
index 483b62d..eebc3e9 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 
-void launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
 {
 	const char *editor, *terminal;
 
@@ -15,12 +15,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		editor = getenv("EDITOR");
 
 	terminal = getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
-		fprintf(stderr,
-		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
-		"Please supply the message using either -m or -F option.\n");
-		exit(1);
-	}
+	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
+		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
 
 	if (!editor)
 		editor = "vi";
@@ -28,6 +24,7 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 	if (strcmp(editor, ":")) {
 		size_t len = strlen(editor);
 		int i = 0;
+		int failed;
 		const char *args[6];
 		struct strbuf arg0;
 
@@ -43,14 +40,17 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		args[i++] = path;
 		args[i] = NULL;
 
-		if (run_command_v_opt_cd_env(args, 0, NULL, env))
-			die("There was a problem with the editor %s.", editor);
+		failed = run_command_v_opt_cd_env(args, 0, NULL, env);
 		strbuf_release(&arg0);
+		if (failed)
+			return error("There was a problem with the editor '%s'.",
+					editor);
 	}
 
 	if (!buffer)
-		return;
+		return 0;
 	if (strbuf_read_file(buffer, path, 0) < 0)
-		die("could not read message file '%s': %s",
-		    path, strerror(errno));
+		return error("could not read file '%s': %s",
+				path, strerror(errno));
+	return 0;
 }
diff --git a/foo b/foo
new file mode 100644
index 0000000..8b13789
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+
diff --git a/strbuf.h b/strbuf.h
index 0c6ffad..eba7ba4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -123,6 +123,6 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
 extern void stripspace(struct strbuf *buf, int skip_comments);
-extern void launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
 #endif /* STRBUF_H */
-- 
1.6.0.rc0.102.ga1791
