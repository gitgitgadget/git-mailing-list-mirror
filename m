From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFH] Fix initialization of a bare repository
Date: Mon, 27 Aug 2007 00:58:06 -0700
Message-ID: <7v7inhmmsx.fsf_-_@gitster.siamese.dyndns.org>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vhcn0pm3h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 09:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZUI-0002uC-9t
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 09:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXH0H6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 03:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXH0H6N
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 03:58:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbXH0H6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 03:58:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3658E128E69;
	Mon, 27 Aug 2007 03:58:30 -0400 (EDT)
In-Reply-To: <7vhcn0pm3h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 Aug 2007 13:41:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56771>

Here is my attempt to fix this with a minimally intrusive patch.

 * As "git --bare init" cannot tell if it was called with --bare or
   just "GIT_DIR=. git init", I added an explicit assignment of
   is_bare_repository_cfg on the codepath for "git --bare".

 * GIT_WORK_TREE alone without GIT_DIR does not make any sense,
   nor GIT_WORK_TREE with an explicit "git --bare".  Catch that
   mistake.  It might make sense to move this check to "git.c"
   side as well, but I tried to shoot for the minimum change for
   now.

 * Some scripts, especially from the olden days, rely on
   traditional GIT_DIR behaviour in "git init".  Namely, these
   are some notable patterns:

   (create a bare repository)
   - mkdir some.git && cd some.git && GIT_DIR=. git init
   - mkdir some.git && cd some.git && git --bare init

   (create a non-bare repository)
   - mkdir .git && GIT_DIR=.git git init
   - mkdir .git && GIT_DIR=`pwd`/.git git init

This comes with a new test script and also passes the existing
test suite, but there may be cases that are still broken with
the current tip of master and this patch does not yet fix.  I'd
appreciate help in straightening this mess out.

---

 * The test script I sent earlier was botched in some details.

   Most notably, it allowed GIT_CONFIG that is exported by the
   test scaffolding to affect behaviour of git-init, and tried
   to see if the resulting repository had correct config, which
   was nonsense.  Also "GIT_DIR bare (2)" test (removed in this
   iteration) was about "GIT_DIR=somewhere git --bare init", but
   "git --bare" is defined as "export GIT_DIR=`pwd`" in git.c,
   which meant that the initial GIT_DIR setting was not honored.

 builtin-init-db.c |   63 +++++++++++++++++++++++++++++---
 git.c             |    1 +
 t/t0001-init.sh   |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 5 deletions(-)
 create mode 100755 t/t0001-init.sh

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 0d9b1e0..ec90b66 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -267,6 +267,42 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	return reinit;
 }
 
+static void guess_repository_type(const char *git_dir)
+{
+	char cwd[PATH_MAX];
+	const char *slash;
+
+	if (0 <= is_bare_repository_cfg)
+		return;
+	if (!git_dir)
+		return;
+
+	/*
+	 * "GIT_DIR=. git init" is always bare.
+	 * "GIT_DIR=`pwd` git init" too.
+	 */
+	if (!strcmp(".", git_dir))
+		goto force_bare;
+	if (!getcwd(cwd, sizeof(cwd)))
+		die("cannot tell cwd");
+	if (!strcmp(git_dir, cwd))
+		goto force_bare;
+	/*
+	 * "GIT_DIR=something/.git is usually not.
+	 */
+	slash = strrchr(git_dir, '/');
+	if (slash && !strcmp(slash, "/.git"))
+		return;
+
+	/*
+	 * Otherwise it is often bare.  At this point
+	 * we are just guessing.
+	 */
+ force_bare:
+	is_bare_repository_cfg = 1;
+	return;
+}
+
 static const char init_db_usage[] =
 "git-init [-q | --quiet] [--template=<template-directory>] [--shared]";
 
@@ -299,11 +335,28 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
-	git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-	if (!getcwd(git_work_tree_cfg, PATH_MAX))
-		die ("Cannot access current working directory.");
-	if (access(get_git_work_tree(), X_OK))
-		die ("Cannot access work tree '%s'", get_git_work_tree());
+	/*
+	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
+	 * without --bare.  Catch the error early.
+	 */
+	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	if ((!git_dir || is_bare_repository_cfg == 1)
+	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
+		die("%s (or --work-tree=<directory>) not allowed without "
+		    "specifying %s (or --git-dir=<directory>)",
+		    GIT_WORK_TREE_ENVIRONMENT,
+		    GIT_DIR_ENVIRONMENT);
+
+	guess_repository_type(git_dir);
+
+	if (is_bare_repository_cfg <= 0) {
+		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+		if (!getcwd(git_work_tree_cfg, PATH_MAX))
+			die ("Cannot access current working directory.");
+		if (access(get_git_work_tree(), X_OK))
+			die ("Cannot access work tree '%s'",
+			     get_git_work_tree());
+	}
 
 	/*
 	 * Set up the default .git directory contents
diff --git a/git.c b/git.c
index c46691e..b6e292e 100644
--- a/git.c
+++ b/git.c
@@ -93,6 +93,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
+			is_bare_repository_cfg = 1;
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
 			if (envchanged)
 				*envchanged = 1;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
new file mode 100755
index 0000000..333abb2
--- /dev/null
+++ b/t/t0001-init.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='git init'
+
+. ./test-lib.sh
+
+check_config () {
+	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
+	then
+		: happy
+	else
+		echo "expected a directory $1, a file $1/config and $1/refs"
+		return 1
+	fi
+	bare=$(GIT_CONFIG="$1/config" git config --bool core.bare)
+	worktree=$(GIT_CONFIG="$1/config" git config core.worktree) ||
+	worktree=unset
+
+	test "$bare" = "$2" && test "$worktree" = "$3" || {
+		echo "expected bare=$2 worktree=$3"
+		echo "     got bare=$bare worktree=$worktree"
+		return 1
+	}
+}
+
+test_expect_success 'plain' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		mkdir plain &&
+		cd plain &&
+		git init
+	) &&
+	check_config plain/.git false unset
+'
+
+test_expect_success 'plain with GIT_WORK_TREE' '
+	if (
+		unset GIT_DIR &&
+		mkdir plain-wt &&
+		cd plain-wt &&
+		GIT_WORK_TREE=$(pwd) git init
+	)
+	then
+		echo Should have failed -- GIT_WORK_TREE should not be used
+		false
+	fi
+'
+
+test_expect_success 'plain bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
+		mkdir plain-bare-1 &&
+		cd plain-bare-1 &&
+		git --bare init
+	) &&
+	check_config plain-bare-1 true unset
+'
+
+test_expect_success 'plain bare with GIT_WORK_TREE' '
+	if (
+		unset GIT_DIR GIT_CONFIG &&
+		mkdir plain-bare-2 &&
+		cd plain-bare-2 &&
+		GIT_WORK_TREE=$(pwd) git --bare init
+	)
+	then
+		echo Should have failed -- GIT_WORK_TREE should not be used
+		false
+	fi
+'
+
+test_expect_success 'GIT_DIR bare' '
+
+	(
+		unset GIT_CONFIG &&
+		mkdir git-dir-bare.git &&
+		GIT_DIR=git-dir-bare.git git init
+	) &&
+	check_config git-dir-bare.git true unset
+'
+
+test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
+
+	(
+		unset GIT_CONFIG &&
+		mkdir git-dir-wt-1.git &&
+		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
+	) &&
+	check_config git-dir-wt-1.git false "$(pwd)"
+'
+
+test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
+
+	if (
+		unset GIT_CONFIG &&
+		mkdir git-dir-wt-2.git &&
+		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
+	)
+	then
+		echo Should have failed -- --bare should not be used
+		false
+	fi
+'
+
+test_done
