From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC] git --trace: trace command execution
Date: Sun, 25 Jun 2006 12:57:09 +0200
Message-ID: <E1FuSIf-0004jK-Tp@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 25 12:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSIn-000255-KW
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWFYK5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWFYK5P
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:57:15 -0400
Received: from moooo.ath.cx ([85.116.203.178]:45988 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932346AbWFYK5O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 06:57:14 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22610>

Show parameters to execve/builtin-cmds before executing them. This
version does not yet have a parameter --trace to git to enable this I
just want to get feedback first :)

I think this is quite useful to debug what is going on since a command
may be another program (shell/python/perl/.. script etc) or just an
alias for a internal command. Before that many commands became
built-ins this was quite easy to do with strace.

Example:
% git repo-config alias.showtag
trace: exec: /home/matled/local/stow/git/bin/git-repo-config
alias.showtag
% git showtag v1.4.1-rc1 > /dev/null
trace: exec: /home/matled/local/stow/git/bin/git-showtag v1.4.1-rc1
trace: exec failed: No such file or directory
trace: built-in command: git cat-file tag v1.4.1-rc1
% git showtag 'a b "c" `d` $e \f'
trace: exec: /home/matled/local/stow/git/bin/git-showtag "a b \"c\" \`d\` \$e \\f"
trace: exec failed: No such file or directory
trace: built-in command: git cat-file tag "a b \"c\" \`d\` \$e \\f"
fatal: Not a valid object name a b "c" `d` $e \f
% git cat-file tag "a b \"c\" \`d\` \$e \\f"
trace: built-in command: git cat-file tag "a b \"c\" \`d\` \$e \\f"
fatal: Not a valid object name a b "c" `d` $e \f

print_shell_escape will escape the arguments to be used as strings in
the shell to prevent ambiguity with spaces and other special
characters and make them copy-and-pastable.

---
 exec_cmd.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 exec_cmd.h |    1 +
 git.c      |   10 ++++++++++
 3 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index c1539d1..85afbf3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -87,6 +87,16 @@ int execv_git_cmd(const char **argv)
 			break;
 		}
 
+		fprintf(stderr, "trace: exec: ");
+		print_shell_escape(stderr, git_command);
+		const char **p = argv;
+		while (*(++p)) {
+			putc(' ', stderr);
+			print_shell_escape(stderr, *p);
+		}
+		putc('\n', stderr);
+		fflush(stderr);
+
 		/* argv[0] must be the git command, but the argv array
 		 * belongs to the caller, and my be reused in
 		 * subsequent loop iterations. Save argv[0] and
@@ -98,6 +108,8 @@ int execv_git_cmd(const char **argv)
 
 		/* execve() can only ever return if it fails */
 		execve(git_command, (char **)argv, environ);
+		fprintf(stderr, "trace: exec failed: %s\n", strerror(errno));
+		fflush(stderr);
 
 		argv[0] = tmp;
 	}
@@ -128,3 +140,33 @@ int execl_git_cmd(const char *cmd,...)
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
 }
+
+void print_shell_escape(FILE *stream, const char *s)
+{
+	const char *c = s;
+	short int quote = 0;
+	while (*c) {
+		if (*c == '"' || *c == '`' || *c == '$' || *c == '\\' ||
+			isspace(*c))
+		{
+			quote = 1;
+			break;
+		}
+		++c;
+	}
+
+	if (!quote) {
+		fputs(s, stream);
+		return;
+	}
+
+	putc('"', stream);
+	c = s;
+	while (*c) {
+		if (*c == '"' || *c == '`' || *c == '$' || *c == '\\')
+			putc('\\', stream);
+		putc(*c, stream);
+		++c;
+	}
+	putc('"', stream);
+}
diff --git a/exec_cmd.h b/exec_cmd.h
index 989621f..8b237fa 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -5,6 +5,7 @@ extern void git_set_exec_path(const char
 extern const char* git_exec_path(void);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
+extern void print_shell_escape(FILE *stream, const char *s);
 
 
 #endif /* __GIT_EXEC_CMD_H_ */
diff --git a/git.c b/git.c
index 94e9a4a..361fb25 100644
--- a/git.c
+++ b/git.c
@@ -198,6 +198,16 @@ static void handle_internal_command(int 
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
+
+		fprintf(stderr, "trace: built-in command: git");
+		int i;
+		for (i = 0; i < argc; ++i) {
+			putc(' ', stderr);
+			print_shell_escape(stderr, argv[i]);
+		}
+		putc('\n', stderr);
+		fflush(stderr);
+
 		exit(p->fn(argc, argv, envp));
 	}
 }
-- 
1.4.GIT
