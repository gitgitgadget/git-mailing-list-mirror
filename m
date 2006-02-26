From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach the "git" command to handle some commands internally
Date: Sun, 26 Feb 2006 12:34:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 26 21:35:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSbl-0005CD-Am
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWBZUfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWBZUfG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:35:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbWBZUfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:35:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QKYsDZ010996
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 12:34:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QKYp6u023622;
	Sun, 26 Feb 2006 12:34:51 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>,
	Michal Ostrowski <mostrows@watson.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16798>


This is another patch in the "prepare to do more in C" series, where the 
git wrapper command is taught about the notion of handling some 
functionality internally.

Right now, the only internal commands are "version" and "help", but the 
point being that we can now easily extend it to handle some of the trivial 
scripts internally. Things like "git log" and "git diff" wouldn't need 
separate external scripts any more.

This also implies that to support the old "git-log" and "git-diff" syntax, 
the "git" wrapper now automatically looks at the name it was executed as, 
and if it is "git-xxxx", it will assume that it is to internally do what 
"git xxxx" would do.

In other words, you can (once you implement an internal command) soft- or 
hard-link that command to the "git" wrapper command, and it will do the 
right thing, whether you use the "git xxxx" or the "git-xxxx" format.

There's one other change: the search order for external programs is 
modified slightly, so that the first entry remains GIT_EXEC_DIR, but the 
second entry is the same directory as the git wrapper itself was executed 
out of - if we can figure it out from argv[0], of course.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---

I personally think this is also a cleanup, but I'm cc'ing other people who 
have worked on the wrapper for comments. Maybe people hate it.

		Linus

---
diff --git a/git.c b/git.c
index 4616df6..993cd0d 100644
--- a/git.c
+++ b/git.c
@@ -230,62 +230,141 @@ static void show_man_page(char *git_cmd)
 	execlp("man", "man", page, NULL);
 }
 
+static int cmd_version(int argc, char **argv, char **envp)
+{
+	printf("git version %s\n", GIT_VERSION);
+	return 0;
+}
+
+static int cmd_help(int argc, char **argv, char **envp)
+{
+	char *help_cmd = argv[1];
+	if (!help_cmd)
+		cmd_usage(git_exec_path(), NULL);
+	show_man_page(help_cmd);
+	return 0;
+}
+
+#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+
+static void handle_internal_command(int argc, char **argv, char **envp)
+{
+	const char *cmd = argv[0];
+	static struct cmd_struct {
+		const char *cmd;
+		int (*fn)(int, char **, char **);
+	} commands[] = {
+		{ "version", cmd_version },
+		{ "help", cmd_help },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		struct cmd_struct *p = commands+i;
+		if (strcmp(p->cmd, cmd))
+			continue;
+		exit(p->fn(argc, argv, envp));
+	}
+}
+
 int main(int argc, char **argv, char **envp)
 {
+	char *cmd = argv[0];
+	char *slash = strrchr(cmd, '/');
 	char git_command[PATH_MAX + 1];
-	char wd[PATH_MAX + 1];
-	int i, show_help = 0;
-	const char *exec_path;
+	const char *exec_path = NULL;
 
-	getcwd(wd, PATH_MAX);
+	/*
+	 * Take the basename of argv[0] as the command
+	 * name, and the dirname as the default exec_path
+	 * if it's an absolute path and we don't have
+	 * anything better.
+	 */
+	if (slash) {
+		*slash++ = 0;
+		if (*cmd == '/')
+			exec_path = cmd;
+		cmd = slash;
+	}
 
-	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+	/*
+	 * "git-xxxx" is the same as "git xxxx", but we obviously:
+	 *
+	 *  - cannot take flags in between the "git" and the "xxxx".
+	 *  - cannot execute it externally (since it would just do
+	 *    the same thing over again)
+	 *
+	 * So we just directly call the internal command handler, and
+	 * die if that one cannot handle it.
+	 */
+	if (!strncmp(cmd, "git-", 4)) {
+		cmd += 4;
+		argv[0] = cmd;
+		handle_internal_command(argc, argv, envp);
+		die("cannot handle %s internally", cmd);
+	}
 
-		if (!strcmp(arg, "help")) {
-			show_help = 1;
-			continue;
-		}
+	/* Default command: "help" */
+	cmd = "help";
 
-		if (strncmp(arg, "--", 2))
+	/* Look for flags.. */
+	while (argc > 1) {
+		cmd = *++argv;
+		argc--;
+
+		if (strncmp(cmd, "--", 2))
 			break;
 
-		arg += 2;
+		cmd += 2;
+
+		/*
+		 * For legacy reasons, the "version" and "help"
+		 * commands can be written with "--" prepended
+		 * to make them look like flags.
+		 */
+		if (!strcmp(cmd, "help"))
+			break;
+		if (!strcmp(cmd, "version"))
+			break;
 
-		if (!strncmp(arg, "exec-path", 9)) {
-			arg += 9;
-			if (*arg == '=') {
-				exec_path = arg + 1;
-				git_set_exec_path(exec_path);
-			} else {
-				puts(git_exec_path());
-				exit(0);
+		/*
+		 * Check remaining flags (which by now must be
+		 * "--exec-path", but maybe we will accept
+		 * other arguments some day)
+		 */
+		if (!strncmp(cmd, "exec-path", 9)) {
+			cmd += 9;
+			if (*cmd == '=') {
+				git_set_exec_path(cmd + 1);
+				continue;
 			}
-		}
-		else if (!strcmp(arg, "version")) {
-			printf("git version %s\n", GIT_VERSION);
+			puts(git_exec_path());
 			exit(0);
 		}
-		else if (!strcmp(arg, "help"))
-			show_help = 1;
-		else if (!show_help)
-			cmd_usage(NULL, NULL);
-	}
-
-	if (i >= argc || show_help) {
-		if (i >= argc)
-			cmd_usage(git_exec_path(), NULL);
-
-		show_man_page(argv[i]);
+		cmd_usage(NULL, NULL);
 	}
+	argv[0] = cmd;
 
+	/*
+	 * We search for git commands in the following order:
+	 *  - git_exec_path()
+	 *  - the path of the "git" command if we could find it
+	 *    in $0
+	 *  - the regular PATH.
+	 */
+	if (exec_path)
+		prepend_to_path(exec_path, strlen(exec_path));
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
-	execv_git_cmd(argv + i);
+	/* See if it's an internal command */
+	handle_internal_command(argc, argv, envp);
+
+	/* .. then try the external ones */
+	execv_git_cmd(argv);
 
 	if (errno == ENOENT)
-		cmd_usage(exec_path, "'%s' is not a git-command", argv[i]);
+		cmd_usage(exec_path, "'%s' is not a git-command", cmd);
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		git_command, strerror(errno));
