From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Fri, 28 Jul 2006 13:12:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
 <20060525131241.GA8443@linux-mips.org> <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 13:13:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6QGX-0004Rh-FF
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 13:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWG1LML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 07:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWG1LML
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 07:12:11 -0400
Received: from mail.gmx.net ([213.165.64.21]:61914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751079AbWG1LMK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 07:12:10 -0400
Received: (qmail invoked by alias); 28 Jul 2006 11:12:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 28 Jul 2006 13:12:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24383>


Now you can say

	git --name-rev log

instead of

	git log | git name-rev --stdin | less

with the benefit that diff.color=auto still works.

There is also a shortcut "-n" for --name-rev. The option 
--name-rev-by-tags (or -t) tries to name the revs by tags instead of all 
refs, which is nicer when talking to other people, since their heads may 
be different from yours (I feel like talking to Zaphod ;-).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Wed, 26 Jul 2006, Junio C Hamano wrote:

	>  * Passing the standard error from "fetch-pack -v" to "name-rev
	>    --stdin" makes it a bit more pleasant to see what is going on.

	This patch makes it even easier.

 Documentation/git.txt |   12 ++++++++++--
 cache.h               |    1 +
 git.c                 |    9 +++++++--
 pager.c               |   41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7310a2b..eae930f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,8 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
-	[--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
+	[-n|--name-rev] [-t|--name-rev-by-tags] [--bare]
+	[--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -45,12 +46,19 @@ OPTIONS
 -p|--paginate::
 	Pipe all output into 'less' (or if set, $PAGER).
 
+-n|--name-rev:
+	Try naming all SHA1s, and page the result (see
+	link:git-name-rev[1] for a detailed explanation).
+
+-t|--name-rev-by-tags:
+	Same as '--name-rev', but try to name the SHA1s by tags.
+
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
 	setting the GIT_DIR environment variable.
 
 --bare::
-	Same as --git-dir=`pwd`.
+	Same as  '--git-dir=`pwd`'.
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/cache.h b/cache.h
index 8891073..d6c5edb 100644
--- a/cache.h
+++ b/cache.h
@@ -391,6 +391,7 @@ extern int receive_keep_pack(int fd[2], 
 
 /* pager.c */
 extern void setup_pager(void);
+extern void setup_name_rev_pager(int by_tags);
 extern int pager_in_use;
 
 /* base85 */
diff --git a/git.c b/git.c
index 4ea5efb..4206b43 100644
--- a/git.c
+++ b/git.c
@@ -63,9 +63,14 @@ static int handle_options(const char*** 
 				puts(git_exec_path());
 				exit(0);
 			}
-		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
+		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate"))
 			setup_pager();
-		} else if (!strcmp(cmd, "--git-dir")) {
+		else if (!strcmp(cmd, "-n") || !strcmp(cmd, "--name-rev"))
+			setup_name_rev_pager(0);
+		else if (!strcmp(cmd, "-t") ||
+				!strcmp(cmd, "--name-rev-by-tags"))
+			setup_name_rev_pager(1);
+		else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 1)
 				return -1;
 			setenv("GIT_DIR", (*argv)[1], 1);
diff --git a/pager.c b/pager.c
index 280f57f..48b2467 100644
--- a/pager.c
+++ b/pager.c
@@ -53,3 +53,44 @@ void setup_pager(void)
 	die("unable to execute pager '%s'", pager);
 	exit(255);
 }
+
+void setup_name_rev_pager(int by_tags)
+{
+	pid_t pid;
+	int fd[2];
+
+	if (!isatty(1))
+		return;
+
+	pager_in_use = 1; /* means we are emitting to terminal */
+
+	if (pipe(fd) < 0)
+		return;
+	pid = fork();
+	if (pid < 0) {
+		close(fd[0]);
+		close(fd[1]);
+		return;
+	}
+
+	/* return in the child */
+	if (!pid) {
+		dup2(fd[1], 1);
+		close(fd[0]);
+		close(fd[1]);
+		return;
+	}
+
+	/* The original process turns into paging name-rev */
+	dup2(fd[0], 0);
+	close(fd[0]);
+	close(fd[1]);
+
+	setup_pager();
+	if (by_tags)
+		execl("git", "git", "name-rev", "--tags", "--stdin", NULL);
+	else
+		execl("git", "git", "name-rev", "--stdin", NULL);
+	die("unable to execute git-name-rev");
+	exit(255);
+}
-- 
1.4.2.rc2.g61d8
