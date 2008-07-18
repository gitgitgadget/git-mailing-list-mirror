From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] editor.c: Libify launch_editor()
Date: Fri, 18 Jul 2008 13:26:48 +0200
Message-ID: <1216380408-21671-1-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 13:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJo7p-0008Ok-PC
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 13:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbYGRL0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 07:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYGRL0v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 07:26:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:60953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751753AbYGRL0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 07:26:50 -0400
Received: (qmail invoked by alias); 18 Jul 2008 11:26:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 18 Jul 2008 13:26:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/1pNdK7BT1SKbCRrPI84F8eLaG2nExxTrbsb1crd
	+GfKKIDKgjelFM
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJo6q-0000Hv-8K; Fri, 18 Jul 2008 13:26:48 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89031>

This patch removes exit()/die() calls and builtin-specific messages
from launch_editor(), so that it can be used as a general libgit.a
function to launch an editor.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Is that ok? :)

 builtin-commit.c |    4 +++-
 builtin-tag.c    |    4 +++-
 editor.c         |   21 ++++++++++++---------
 strbuf.h         |    2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index ed3fe3f..64f69f3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -647,7 +647,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		launch_editor(git_path(commit_editmsg), NULL, env);
+		if (launch_editor(git_path(commit_editmsg), NULL, env))
+			die("running editor failed.\n"
+			"Please supply the message using either -m or -F option.");
 	}
 
 	if (!no_verify &&
diff --git a/builtin-tag.c b/builtin-tag.c
index 219f51d..3b7a25e 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -295,7 +295,9 @@ static void create_tag(const unsigned char *object, const char *tag,
 			write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
 
-		launch_editor(path, buf, NULL);
+		if (launch_editor(path, buf, NULL))
+			die("running editor failed.\n"
+			"Please supply the message using either -m or -F option.");
 
 		unlink(path);
 		free(path);
diff --git a/editor.c b/editor.c
index 483b62d..5d7f5f9 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 
-void launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
 {
 	const char *editor, *terminal;
 
@@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 	terminal = getenv("TERM");
 	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
 		fprintf(stderr,
-		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
-		"Please supply the message using either -m or -F option.\n");
-		exit(1);
+		"Terminal is dumb but no VISUAL nor EDITOR defined.\n");
+		return 1;
 	}
 
 	if (!editor)
@@ -28,6 +27,7 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 	if (strcmp(editor, ":")) {
 		size_t len = strlen(editor);
 		int i = 0;
+		int failed;
 		const char *args[6];
 		struct strbuf arg0;
 
@@ -43,14 +43,17 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		args[i++] = path;
 		args[i] = NULL;
 
-		if (run_command_v_opt_cd_env(args, 0, NULL, env))
-			die("There was a problem with the editor %s.", editor);
+		failed = run_command_v_opt_cd_env(args, 0, NULL, env);
 		strbuf_release(&arg0);
+		if (failed)
+			return error("There was a problem with the editor %s.",
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
1.5.6.3.390.g7b30
