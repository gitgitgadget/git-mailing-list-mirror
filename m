From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] make git barf when an alias changes environment variables
Date: Fri, 8 Jun 2007 22:57:55 +0200
Message-ID: <20070608205755.GA21901@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 22:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwlXq-0005id-4S
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032094AbXFHU6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031585AbXFHU57
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 16:57:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:38571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031346AbXFHU56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 16:57:58 -0400
Received: (qmail invoked by alias); 08 Jun 2007 20:57:56 -0000
Received: from pD9EBB323.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.179.35]
  by mail.gmx.net (mp049) with SMTP; 08 Jun 2007 22:57:56 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19iYMoFw5diPGQFzFznATJ/0lHN45v2p0JHiiLaUL
	MphCNp/rOC5gPX
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49499>

Aliases changing environment variables (GIT_DIR or
GIT_WORK_TREE) can cause problems:
git has to use GIT_DIR to read the aliases from the config.
After running handle_options for the alias the options of the
alias may have changed environment variables.  Depending on
the implementation of setenv the memory location obtained
through getenv earlier may contain the old value or the new
value (or even be used for something else?).  To avoid these
problems git errors out if an alias uses any option which
changes environment variables.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This is on top of ml/worktree even though the problem is also present in
master.  It could also be split into one patch which can be applied to
master directly and another one adding the missing parts in the
ml/worktree branch.

Another option instead of dying would be to execute git again.  I
decided not to because of
(1) It causes problems with aliases starting the pager: After the exec
    git wouldn't know that the pager is running and colors would be
    missing.
(2) Up to now aliases not starting with '!' have recursion detection
    and are only evaluated as aliases once.  Executing git again would
    break this.

Example:

Here is an example how to break git aliases, it works with libc of
FreeBSD but not with glibc.  libc of FreeBSD reuses the old location
for the environment variable if the new value is smaller than the old
one.

There is a repository in a/.git and a repository in b/.git.  Both have
valid HEADs:

% git --git-dir a/.git rev-list --pretty=oneline HEAD
496a0d181f6878ddda8926103a7cf28a668c46ef a

% git --git-dir b/.git rev-list --pretty=oneline HEAD
3c2858eded8ae7ff964549f85f479808d185283c b

Set up some aliases using --git-dir:

% git --git-dir a/.git config alias.works \
'--git-dir a/.git rev-list --pretty=oneline HEAD'

% git --git-dir a/.git config alias.breaks \
'--git-dir b/.git rev-list --pretty=oneline HEAD'

% git --git-dir a/.git config alias.good
'!git --git-dir b/.git rev-list --pretty=oneline HEAD'

The first one works because the value of the environment variable does
not change, the second one does not work because git reads the ref
HEAD from b/.git but searches the object in a/.git.  The third one
always works.

% git --git-dir a/.git works
496a0d181f6878ddda8926103a7cf28a668c46ef a

% git --git-dir a/.git breaks
fatal: bad object HEAD
[1]    15643 exit 128   git --git-dir a/.git breaks

% git --git-dir a/.git good  
3c2858eded8ae7ff964549f85f479808d185283c b

With the patch:

% git --git-dir a/.git breaks       
fatal: alias 'breaks' changes environment variables
You can use '!git' in the alias to do this.
[1]    17295 exit 128   git --git-dir a/.git breaks

---
 git.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index cd3910a..33edd62 100644
--- a/git.c
+++ b/git.c
@@ -28,7 +28,7 @@ static void prepend_to_path(const char *dir, int len)
 	free(path);
 }
 
-static int handle_options(const char*** argv, int* argc)
+static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
 
@@ -64,24 +64,34 @@ static int handle_options(const char*** argv, int* argc)
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--work-tree=")) {
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
@@ -160,7 +170,7 @@ static int split_cmdline(char *cmdline, const char ***argv)
 
 static int handle_alias(int *argcp, const char ***argv)
 {
-	int nongit = 0, ret = 0, saved_errno = errno;
+	int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
@@ -181,7 +191,11 @@ static int handle_alias(int *argcp, const char ***argv)
 			    alias_string + 1, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
-		option_count = handle_options(&new_argv, &count);
+		option_count = handle_options(&new_argv, &count, &envchanged);
+		if (envchanged)
+			die("alias '%s' changes environment variables\n"
+				 "You can use '!git' in the alias to do this.",
+				 alias_command);
 		memmove(new_argv - option_count, new_argv,
 				count * sizeof(char *));
 		new_argv -= option_count;
@@ -375,7 +389,7 @@ int main(int argc, const char **argv, char **envp)
 	/* Look for flags.. */
 	argv++;
 	argc--;
-	handle_options(&argv, &argc);
+	handle_options(&argv, &argc, NULL);
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
-- 
1.5.2.1.888.gd5e4e
