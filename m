From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2] editor.c: Libify launch_editor()
Date: Fri, 18 Jul 2008 14:35:44 +0200
Message-ID: <1216384544-3856-1-git-send-email-s-beyer@gmx.net>
References: <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJpCb-0001Cl-Vz
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 14:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbYGRMfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 08:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbYGRMfs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 08:35:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:58562 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753741AbYGRMfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 08:35:47 -0400
Received: (qmail invoked by alias); 18 Jul 2008 12:35:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 18 Jul 2008 14:35:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19l4AMJNOFlOLhkD4oBvxNiMWymlNIQa8YcqwFYsJ
	vugK8RvTV+XaR/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJpBY-00010a-NX; Fri, 18 Jul 2008 14:35:44 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89035>

This patch removes exit()/die() calls and builtin-specific messages
from launch_editor(), so that it can be used as a general libgit.a
function to launch an editor.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Hi,

Johannes Schindelin wrote:
> On Fri, 18 Jul 2008, Stephan Beyer wrote:
> 
> > This patch removes exit()/die() calls and builtin-specific messages from 
> > launch_editor(), so that it can be used as a general libgit.a function 
> > to launch an editor.
> 
> Thanks.  Now we have to convince Junio that it is a good idea :-)
> 
> > diff --git a/builtin-commit.c b/builtin-commit.c
> > index ed3fe3f..64f69f3 100644
> > --- a/builtin-commit.c
> > +++ b/builtin-commit.c
> > @@ -647,7 +647,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
> >  		char index[PATH_MAX];
> >  		const char *env[2] = { index, NULL };
> >  		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> > -		launch_editor(git_path(commit_editmsg), NULL, env);
> > +		if (launch_editor(git_path(commit_editmsg), NULL, env))
> > +			die("running editor failed.\n"
> > +			"Please supply the message using either -m or -F option.");
> 
> In the error case, run_editor() already said more than "running editor 
> failed.", right?  Maybe you just want to skip that line and keep the 
> second?

Well, I wanted to do it like that, but die_builtin() usually adds "fatal: ",
so the message becomes like:

	error: There was a problem with the editor xxx.
	fatal: Please supply the message using either -m or -F option.
        ^^^^^^^^^^^^^
        That looks odd.

Btw, using the former patch, it is:

	error: There was a problem with the editor xxx.
	fatal: running editor failed.
	Please supply the message using either -m or -F option.


So I wonder if I should not die() at all, but do a
	fprintf(stderr, "Please supply the message using either -m or -F option.\n");
	exit(1);
which is done in *this* version of the patch. So that the message becomes:

	error: There was a problem with the editor 'xxx'.
	Please supply the message using either -m or -F option.

> > diff --git a/editor.c b/editor.c
> > index 483b62d..5d7f5f9 100644
> > --- a/editor.c
> > +++ b/editor.c
> > @@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
> >  	terminal = getenv("TERM");
> >  	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
> >  		fprintf(stderr,
> > -		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
> > -		"Please supply the message using either -m or -F option.\n");
> > -		exit(1);
> > +		"Terminal is dumb but no VISUAL nor EDITOR defined.\n");
> > +		return 1;
> 
> Why not "return error()"?

I was unsure here, too, but you're right.

Regards.

 builtin-commit.c |    6 +++++-
 builtin-tag.c    |    6 +++++-
 editor.c         |   24 ++++++++++++------------
 foo              |    1 +
 strbuf.h         |    2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 foo

diff --git a/builtin-commit.c b/builtin-commit.c
index ed3fe3f..23ec629 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -647,7 +647,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
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
1.5.6.3.390.g7b30
