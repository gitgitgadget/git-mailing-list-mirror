From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Fri, 18 Jul 2008 02:26:20 +0200
Message-ID: <20080718002620.GE8421@leksak.fem-net>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com> <7vod5mpmp7.fsf@gitster.siamese.dyndns.org> <20080627223107.GH5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 02:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJdom-0006hL-Qz
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 02:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197AbYGRA01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 20:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757696AbYGRA00
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 20:26:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:40142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753222AbYGRA0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 20:26:25 -0400
Received: (qmail invoked by alias); 18 Jul 2008 00:26:24 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 18 Jul 2008 02:26:24 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+3bs1Mzwi3wgdGrmiOBerRmhvGdMLXod5RBuY9JT
	C6oUjLsu9LswPz
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJdng-0003OP-Gc; Fri, 18 Jul 2008 02:26:20 +0200
Content-Disposition: inline
In-Reply-To: <20080627223107.GH5737@dpotapov.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88939>

Hi,

Dmitry Potapov wrote:
> diff --git a/shell.c b/shell.c
> index b27d01c..91ca7de 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -3,6 +3,14 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  
> +/* Stubs for functions that make no sense for git-shell. These stubs
> + * are provided here to avoid linking in external redundant modules.
> + */
> +void release_pack_memory(size_t need, int fd){}
> +void trace_argv_printf(const char **argv, const char *fmt, ...){}
> +void trace_printf(const char *fmt, ...){}
> +
> +

I don't really understand why this works.
You redefine libgit.a functions here

So the linker should complain like that:
	libgit.a(sha1_file.o): In function `release_pack_memory':
	/home/sbeyer/src/git/sha1_file.c:624: multiple definition of `release_pack_memory'
	shell.o:/home/sbeyer/src/git/shell.c:9: first defined here
	collect2: ld returned 1 exit status

And, in fact, it does when I move a function from a builtin to a lib
source file, for example launch_editor() from builtin-tag.c to strbuf.c,
like the following one:

---
 builtin-tag.c |   53 -----------------------------------------------------
 strbuf.c      |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 53 deletions(-)

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
diff --git a/strbuf.c b/strbuf.c
index 720737d..6419e02 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 
 int prefixcmp(const char *str, const char *prefix)
 {
@@ -308,3 +309,56 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
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
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
