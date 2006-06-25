From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] GIT_TRACE: show which built-in/external commands are executed
Date: Sun, 25 Jun 2006 15:56:18 +0200
Message-ID: <E1FuV62-0004Jd-Ve@moooo.ath.cx>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 15:56:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuV6E-0006Ae-F1
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 15:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWFYN4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 09:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWFYN4Z
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 09:56:25 -0400
Received: from moooo.ath.cx ([85.116.203.178]:11408 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750969AbWFYN4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 09:56:24 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22625>

With the environment variable GIT_TRACE set git will show
 - alias expansion
 - built-in command execution
 - external command execution
on stderr.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Examples:
% GIT_TRACE=1 git status > /dev/null
trace: exec: '/home/matled/local/stow/git/bin/git-status'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'update-index' '-q' '--unmerged' '--refresh'
trace: built-in: git 'diff-index' '-M' '--cached' '--name-status' \
    '--diff-filter=MDTCRA' 'HEAD'
trace: built-in: git 'diff-files' '--name-status'
trace: built-in: git 'ls-files' '-z' '--others' '--directory' \
    '--no-empty-directory' '--exclude-from=.git/info/exclude' \
    '--exclude-per-directory=.gitignore'

This seems to be quite useful to find out how tools do things and for
debugging.

% GIT_TRACE=1 git showtag v1.4.0 > /dev/null
trace: exec: '/home/matled/local/stow/git/bin/git-showtag' 'v1.4.0'
trace: exec failed: No such file or directory
trace: alias expansion: showtag => 'cat-file' 'tag'
trace: built-in: git 'cat-file' 'tag' 'v1.4.0'

% GIT_TRACE=1 git l > /dev/null
trace: exec: '/home/matled/local/stow/git/bin/git-l'
trace: exec failed: No such file or directory
trace: alias expansion: l => 'log' '-p'
trace: built-in: git 'log' '-p'

 Documentation/git.txt |    7 +++++++
 exec_cmd.c            |   19 +++++++++++++++++++
 git.c                 |   25 +++++++++++++++++++++++++
 quote.c               |   17 +++++++++++++++++
 quote.h               |    1 +
 5 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 51f20c6..603c474 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -615,6 +615,13 @@ git Diffs
 	gitlink:git-diff-files[1];
 	gitlink:git-diff-tree[1]
 
+other
+~~~~~
+'GIT_TRACE'::
+	If this variable is set git will print `trace:` messages on
+	stderr telling about alias expansion, built-in command
+	execution and external command execution.
+
 Discussion[[Discussion]]
 ------------------------
 include::README[]
diff --git a/exec_cmd.c b/exec_cmd.c
index c1539d1..f2133ec 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "quote.h"
 #define MAX_ARGS	32
 
 extern char **environ;
@@ -96,9 +97,27 @@ int execv_git_cmd(const char **argv)
 		tmp = argv[0];
 		argv[0] = git_command;
 
+		if (getenv("GIT_TRACE")) {
+			fputs("trace: exec:", stderr);
+			const char **p = argv;
+			while (*p) {
+				fputc(' ', stderr);
+				sq_quote_print(stderr, *p);
+				++p;
+			}
+			putc('\n', stderr);
+			fflush(stderr);
+		}
+
 		/* execve() can only ever return if it fails */
 		execve(git_command, (char **)argv, environ);
 
+		if (getenv("GIT_TRACE")) {
+			fprintf(stderr, "trace: exec failed: %s\n",
+				strerror(errno));
+			fflush(stderr);
+		}
+
 		argv[0] = tmp;
 	}
 	return -1;
diff --git a/git.c b/git.c
index 94e9a4a..8b060e8 100644
--- a/git.c
+++ b/git.c
@@ -11,6 +11,7 @@ #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
 #include "cache.h"
+#include "quote.h"
 
 #include "builtin.h"
 
@@ -119,6 +120,18 @@ static int handle_alias(int *argcp, cons
 			if (!strcmp(alias_command, new_argv[0]))
 				die("recursive alias: %s", alias_command);
 
+			if (getenv("GIT_TRACE")) {
+				int i;
+				fprintf(stderr, "trace: alias expansion: %s =>",
+					alias_command);
+				for (i = 0; i < count; ++i) {
+					fputc(' ', stderr);
+					sq_quote_print(stderr, new_argv[i]);
+				}
+				fputc('\n', stderr);
+				fflush(stderr);
+			}
+
 			/* insert after command name */
 			if (*argcp > 1) {
 				new_argv = realloc(new_argv, sizeof(char*) *
@@ -198,6 +211,18 @@ static void handle_internal_command(int 
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
+
+		if (getenv("GIT_TRACE")) {
+			int i;
+			fprintf(stderr, "trace: built-in: git");
+			for (i = 0; i < argc; ++i) {
+				fputc(' ', stderr);
+				sq_quote_print(stderr, argv[i]);
+			}
+			putc('\n', stderr);
+			fflush(stderr);
+		}
+
 		exit(p->fn(argc, argv, envp));
 	}
 }
diff --git a/quote.c b/quote.c
index dcc2326..2ca18e8 100644
--- a/quote.c
+++ b/quote.c
@@ -45,6 +45,23 @@ size_t sq_quote_buf(char *dst, size_t n,
 	return len;
 }
 
+void sq_quote_print(FILE *stream, const char *src)
+{
+	char c;
+
+	fputc('\'', stream);
+	while ((c = *src++)) {
+		if (need_bs_quote(c)) {
+			fputs("'\\", stream);
+			fputc(c, stream);
+			fputc('\'', stream);
+		} else {
+			fputc(c, stream);
+		}
+	}
+	fputc('\'', stream);
+}
+
 char *sq_quote(const char *src)
 {
 	char *buf;
diff --git a/quote.h b/quote.h
index c1ab378..fc5481e 100644
--- a/quote.h
+++ b/quote.h
@@ -29,6 +29,7 @@ #include <stdio.h>
  */
 
 extern char *sq_quote(const char *src);
+extern void sq_quote_print(FILE *stream, const char *src);
 extern size_t sq_quote_buf(char *dst, size_t n, const char *src);
 
 /* This unwraps what sq_quote() produces in place, but returns
-- 
1.4.1.rc1.gfa6c9-dirty
