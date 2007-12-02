From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Call builtin functions directly, was Re: [PATCH] transport.c: call dash-less form of receive-pack and upload-pack on remote
Date: Sat, 01 Dec 2007 21:19:54 -0800
Message-ID: <7v3aul1xmt.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
	<alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
	<7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
	<DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
	<Pine.LNX.4.64.0711301207020.27959@racer.site>
	<7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712010959180.27959@racer.site>
	<7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712012300440.27959@racer.site>
	<Pine.LNX.4.64.0712012314190.27959@racer.site>
	<Pine.LNX.4.64.0712020146240.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyhFu-000612-HD
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXLBFUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXLBFUJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:20:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43992 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXLBFUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:20:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B1D6B2EF;
	Sun,  2 Dec 2007 00:20:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9928698F72;
	Sun,  2 Dec 2007 00:20:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66758>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I bit the apple and tried to move the builtins into the library, and 
> rename handle_internal_command into execv_git_builtin(), moving it into 
> exec-cmd.c.
>
> Big mistake.

I really feel this should not go in.  Anything called exec _should_
assure the callers that the new command will start from a clean slate,
and the way to give that assurance is by actually doing exec(), not
introducing "clean-up" functions for random things we can think of (like
cached objects) and risking of forgetting some others.  I do not think
the complexity is worth it.

The first step we have decided to take is to move git-foo form out of
users' PATH.  This would reduce the cluttered PATH problem, and it means
not all of external commands have to become built-ins on a single flag
day.  I also think it has always been a nice touch that we allowed users
to drop their own custom git-foo script to their path and call "git foo"
as if it is part of the official git suite, so spawning commands in
git-foo form needs to be supported via GIT_EXEC_PATH even if everything
eventually becomes built-in.

So I would prefer doing something like this instead for v1.5.5 (see
the top of updated release notes for 1.5.4 for deprecation notice).

 * execv_git_cmd() function will exec "git" with the given subcommand
   and its arguments;

 * The command dispatcher of git potty itself will first try the
   built-ins, and then try externals in dash form (which cannot be done
   with execv_git_cmd() anymore), and then aliases.

 * Just to be nice, we allow git-shell to treat "git foo arg" as if
   "git-foo arg" was given, but it continues to use execv_git_cmd(), and
   starts from a clean slate.

---
 exec_cmd.c |   31 ++++++++++++-------------------
 git.c      |   32 +++++++++++++++++++++++++++++++-
 shell.c    |   26 +++++++++++++++-----------
 3 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..10b2908 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -65,32 +65,25 @@ void setup_path(const char *cmd_path)
 
 int execv_git_cmd(const char **argv)
 {
-	struct strbuf cmd;
-	const char *tmp;
-
-	strbuf_init(&cmd, 0);
-	strbuf_addf(&cmd, "git-%s", argv[0]);
+	int argc;
+	const char **nargv;
 
-	/*
-	 * argv[0] must be the git command, but the argv array
-	 * belongs to the caller, and may be reused in
-	 * subsequent loop iterations. Save argv[0] and
-	 * restore it on error.
-	 */
-	tmp = argv[0];
-	argv[0] = cmd.buf;
+	for (argc = 0; argv[argc]; argc++)
+		; /* just counting */
+	nargv = xmalloc(sizeof(*nargv) * (argc + 2));
 
-	trace_argv_printf(argv, -1, "trace: exec:");
+	nargv[0] = "git";
+	for (argc = 0; argv[argc]; argc++)
+		nargv[argc + 1] = argv[argc];
+	nargv[argc + 1] = NULL;
+	trace_argv_printf(nargv, -1, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
+	execvp("git", (char **)nargv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	argv[0] = tmp;
-
-	strbuf_release(&cmd);
-
+	free(nargv);
 	return -1;
 }
 
diff --git a/git.c b/git.c
index 01bbbc7..d690426 100644
--- a/git.c
+++ b/git.c
@@ -382,6 +382,36 @@ static void handle_internal_command(int argc, const char **argv)
 	}
 }
 
+static void execv_dashed_external(const char **argv)
+{
+	struct strbuf cmd;
+	const char *tmp;
+
+	strbuf_init(&cmd, 0);
+	strbuf_addf(&cmd, "git-%s", argv[0]);
+
+	/*
+	 * argv[0] must be the git command, but the argv array
+	 * belongs to the caller, and may be reused in
+	 * subsequent loop iterations. Save argv[0] and
+	 * restore it on error.
+	 */
+	tmp = argv[0];
+	argv[0] = cmd.buf;
+
+	trace_argv_printf(argv, -1, "trace: exec:");
+
+	/* execvp() can only ever return if it fails */
+	execvp(cmd.buf, (char **)argv);
+
+	trace_printf("trace: exec failed: %s\n", strerror(errno));
+
+	argv[0] = tmp;
+
+	strbuf_release(&cmd);
+}
+
+
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
@@ -445,7 +475,7 @@ int main(int argc, const char **argv)
 		handle_internal_command(argc, argv);
 
 		/* .. then try the external ones */
-		execv_git_cmd(argv);
+		execv_dashed_external(argv);
 
 		/* It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
diff --git a/shell.c b/shell.c
index 9826109..729797c 100644
--- a/shell.c
+++ b/shell.c
@@ -19,17 +19,13 @@ static int do_generic_cmd(const char *me, char *arg)
 	return execv_git_cmd(my_argv);
 }
 
-static int do_cvs_cmd(const char *me, char *arg)
+static int do_cvs_cmd(void)
 {
 	const char *cvsserver_argv[3] = {
 		"cvsserver", "server", NULL
 	};
 
-	if (!arg || strcmp(arg, "server"))
-		die("git-cvsserver only handles server: %s", arg);
-
 	setup_path(NULL);
-
 	return execv_git_cmd(cvsserver_argv);
 }
 
@@ -40,7 +36,6 @@ static struct commands {
 } cmd_list[] = {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
-	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
 
@@ -49,15 +44,24 @@ int main(int argc, char **argv)
 	char *prog;
 	struct commands *cmd;
 
+	/*
+	 * Special hack to pretend to be a CVS server
+	 */
 	if (argc == 2 && !strcmp(argv[1], "cvs server"))
-		argv--;
-	/* We want to see "-c cmd args", and nothing else */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
+		exit(do_cvs_cmd());
+
+	/*
+	 * We do not accept anything but "-c" followed by "cmd arg",
+	 * where "cmd" is a very limited subset of git commands.
+	 */
+	if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
 	prog = argv[2];
-	argv += 2;
-	argc -= 2;
+	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
+		/* Accept "git foo" as if the caller said "git-foo". */
+		prog[3] = '-';
+
 	for (cmd = cmd_list ; cmd->name ; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
