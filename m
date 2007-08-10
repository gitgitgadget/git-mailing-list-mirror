From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE is unset
Date: Fri, 10 Aug 2007 00:57:12 -0700
Message-ID: <7vr6mbu8iv.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
	<20070809223530.GA29680@cassiopeia>
	<Pine.LNX.4.64.0708100129200.21857@racer.site>
	<7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708100210280.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJPN2-0007X9-A4
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbXHJH5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXHJH5P
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:57:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37460 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbXHJH5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:57:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810075712.VVTA7956.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 03:57:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a7xC1X0031kojtg0000000; Fri, 10 Aug 2007 03:57:13 -0400
In-Reply-To: <Pine.LNX.4.64.0708100210280.21857@racer.site> (Johannes
	Schindelin's message of "Fri, 10 Aug 2007 02:11:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55519>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Sun, 5 Aug 2007 14:12:53 +0100

The old behaviour was to unilaterally default to the cwd is the work tree
when GIT_DIR was set, but GIT_WORK_TREE wasn't, no matter if we are inside
the GIT_DIR, or if GIT_DIR is actually something like ../../../.git.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

 > I think I sent a patch for that, but was negative about it, even if I 
 > promised not to question your decision.

 Yes you did.  Here is a refresher with an affected test
 adjusted.

 We already have a few changes that worked around the semantics
 change by either setting GIT_WORK_TREE or cd'ing up, but I
 think they should not need to be reverted.

 It makes more sense to keep the old semantics -- people who use
 unusual GIT_DIR setting should know what they are doing, and
 the new GIT_WORK_TREE feature (and core.worktree) would give
 them better control.  We just should not break existing users
 that set GIT_DIR and nothing else.  Which means I need another
 rewrite on the Release Notes, and probably yet another rc
 cycle.

 setup.c              |   52 +++++++++----------------------------------------
 t/t1500-rev-parse.sh |    6 +++-
 2 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/setup.c b/setup.c
index b55b82c..06004f1 100644
--- a/setup.c
+++ b/setup.c
@@ -189,53 +189,21 @@ int is_inside_work_tree(void)
 }
 
 /*
- * If no worktree was given, and we are outside of a default work tree,
- * now is the time to set it.
- *
- * In other words, if the user calls git with something like
- *
- *	git --git-dir=/some/where/else/.git bla
- *
- * default to /some/where/else as working directory; if the specified
- * git-dir does not end in "/.git", the cwd is used as working directory.
+ * set_work_tree() is only ever called if you set GIT_DIR explicitely.
+ * The old behaviour (which we retain here) is to set the work tree root
+ * to the cwd, unless overridden by the config, the command line, or
+ * GIT_WORK_TREE.
  */
-const char *set_work_tree(const char *dir)
+static const char *set_work_tree(const char *dir)
 {
-	char dir_buffer[PATH_MAX], *rel = NULL;
-	static char buffer[PATH_MAX + 1];
-	int len, suffix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
-
-	/* strip the variable 'dir' of the postfix "/.git" if it has it */
-	len = strlen(dir);
-	if (len > suffix_len &&
-	    !strcmp(dir + len - suffix_len, "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
-		if ((len - suffix_len) >= sizeof(dir_buffer))
-			die("directory name too long");
-		memcpy(dir_buffer, dir, len - suffix_len);
-		dir_buffer[len - suffix_len] = '\0';
-
-		/* are we inside the default work tree? */
-		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
-	}
+	char buffer[PATH_MAX + 1];
 
-	/* if rel is set, the cwd is _not_ the current working tree */
-	if (rel && *rel) {
-		if (!is_absolute_path(dir))
-			set_git_dir(make_absolute_path(dir));
-		dir = dir_buffer;
-		if (chdir(dir))
-			die("cannot chdir to %s: %s", dir, strerror(errno));
-		else
-			strcat(rel, "/");
-		inside_git_dir = 0;
-	} else {
-		rel = NULL;
-		dir = getcwd(buffer, sizeof(buffer));
-	}
-	git_work_tree_cfg = xstrdup(dir);
+	if (!getcwd(buffer, sizeof(buffer)))
+		die ("Could not get the current working directory");
+	git_work_tree_cfg = xstrdup(buffer);
 	inside_work_tree = 1;
 
-	return rel;
+	return NULL;
 }
 
 /*
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index bea40cb..e474b3f 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -28,6 +28,8 @@ test_rev_parse() {
 	[ $# -eq 0 ] && return
 }
 
+# label is-bare is-inside-git is-inside-work prefix
+
 test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
@@ -53,13 +55,13 @@ export GIT_DIR=../.git
 export GIT_CONFIG="$(pwd)"/../.git/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true work/
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
 
 git config core.bare true
 test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true work/
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 mv ../.git ../repo.git || exit 1
 export GIT_DIR=../repo.git
-- 
1.5.3.rc4.29.g74276
