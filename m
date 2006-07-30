From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] allow alias expansion without a git directory
Date: Sun, 30 Jul 2006 03:30:29 +0200
Message-ID: <E1G708T-00073m-Hg@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 30 03:30:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G708a-00011d-0P
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 03:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWG3Bac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 21:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWG3Bac
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 21:30:32 -0400
Received: from moooo.ath.cx ([85.116.203.178]:43447 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750908AbWG3Bac (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 21:30:32 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24444>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
With this patch
[alias]
    init = init-db --template=/path/to/template
is usable.
The change in setup_git_directory_gently is a bug which did not cause
any problems yet (afaict): setup_git_directory_gently did die even
though nongit_ok was not NULL.  Without this GIT_DIR=.foo git init
will die.
---
 git.c   |   76 ++++++++++++++++++++++++++++++---------------------------------
 setup.c |    4 +++
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/git.c b/git.c
index 452180e..7321d6c 100644
--- a/git.c
+++ b/git.c
@@ -156,52 +156,48 @@ static int handle_alias(int *argcp, cons
 {
 	int nongit = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
+	int count, option_count;
+	const char** new_argv;
 
 	subdir = setup_git_directory_gently(&nongit);
-	if (!nongit) {
-		int count, option_count;
-		const char** new_argv;
-
-		alias_command = (*argv)[0];
-		git_config(git_alias_config);
-		if (alias_string) {
-
-			count = split_cmdline(alias_string, &new_argv);
-			option_count = handle_options(&new_argv, &count);
-			memmove(new_argv - option_count, new_argv,
-					count * sizeof(char *));
-			new_argv -= option_count;
-
-			if (count < 1)
-				die("empty alias for %s", alias_command);
-
-			if (!strcmp(alias_command, new_argv[0]))
-				die("recursive alias: %s", alias_command);
-
-			if (getenv("GIT_TRACE")) {
-				int i;
-				fprintf(stderr, "trace: alias expansion: %s =>",
-					alias_command);
-				for (i = 0; i < count; ++i) {
-					fputc(' ', stderr);
-					sq_quote_print(stderr, new_argv[i]);
-				}
-				fputc('\n', stderr);
-				fflush(stderr);
-			}
 
-			new_argv = realloc(new_argv, sizeof(char*) *
-					   (count + *argcp + 1));
-			/* insert after command name */
-			memcpy(new_argv + count, *argv + 1,
-			       sizeof(char*) * *argcp);
-			new_argv[count+*argcp] = NULL;
+	alias_command = (*argv)[0];
+	git_config(git_alias_config);
+	if (alias_string) {
+		count = split_cmdline(alias_string, &new_argv);
+		option_count = handle_options(&new_argv, &count);
+		memmove(new_argv - option_count, new_argv,
+				count * sizeof(char *));
+		new_argv -= option_count;
+
+		if (count < 1)
+			die("empty alias for %s", alias_command);
 
-			*argv = new_argv;
-			*argcp += count - 1;
+		if (!strcmp(alias_command, new_argv[0]))
+			die("recursive alias: %s", alias_command);
 
-			ret = 1;
+		if (getenv("GIT_TRACE")) {
+			int i;
+			fprintf(stderr, "trace: alias expansion: %s =>",
+				alias_command);
+			for (i = 0; i < count; ++i) {
+				fputc(' ', stderr);
+				sq_quote_print(stderr, new_argv[i]);
+			}
+			fputc('\n', stderr);
+			fflush(stderr);
 		}
+
+		new_argv = realloc(new_argv, sizeof(char*) *
+				   (count + *argcp + 1));
+		/* insert after command name */
+		memcpy(new_argv + count, *argv + 1, sizeof(char*) * *argcp);
+		new_argv[count+*argcp] = NULL;
+
+		*argv = new_argv;
+		*argcp += count - 1;
+
+		ret = 1;
 	}
 
 	if (subdir)
diff --git a/setup.c b/setup.c
index 4612f11..358e139 100644
--- a/setup.c
+++ b/setup.c
@@ -184,6 +184,10 @@ const char *setup_git_directory_gently(i
 		}
 		return NULL;
 	bad_dir_environ:
+		if (!nongit_ok) {
+			*nongit_ok = 1;
+			return NULL;
+		}
 		path[len] = 0;
 		die("Not a git repository: '%s'", path);
 	}
-- 
1.4.2.rc2.g91b7
