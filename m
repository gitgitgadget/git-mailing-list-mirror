From: Jeff King <peff@peff.net>
Subject: [DONOTAPPLY PATCH 3/3] setup: treat GIT_DIR without GIT_WORK_TREE as
 a bare repo
Date: Tue, 26 Mar 2013 16:13:33 -0400
Message-ID: <20130326201333.GC22522@sigill.intra.peff.net>
References: <20130326200851.GA22080@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:14:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaFy-0001pA-KE
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186Ab3CZUNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:13:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40642 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210Ab3CZUNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:13:38 -0400
Received: (qmail 7200 invoked by uid 107); 26 Mar 2013 20:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:15:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:13:33 -0400
Content-Disposition: inline
In-Reply-To: <20130326200851.GA22080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219198>

Follow-through on the deprecation warning added by the last
commit.

We can drop all of the IMPLICIT_WORK_TREE code now, since
we default to that case.

Signed-off-by: Jeff King <peff@peff.net>
---
This would obviously come much later than patch 2, in Git 2.0 or
whatever.

But in case anyone did not read the discussion leading up to this
series, this breaks many tests. It's not meant for application, but
merely to look at what kinds of breakage we could see if we followed
this path.

 cache.h               | 12 ------------
 environment.c         |  1 -
 git.c                 |  1 -
 setup.c               | 26 +-------------------------
 t/t1510-repo-setup.sh | 24 ++++++++++--------------
 5 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/cache.h b/cache.h
index c1fe67f..3c6b677 100644
--- a/cache.h
+++ b/cache.h
@@ -366,18 +366,6 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
 
 /*
- * This environment variable is expected to contain a boolean indicating
- * whether we should or should not treat:
- *
- *   GIT_DIR=foo.git git ...
- *
- * as if GIT_WORK_TREE=. was given. It's not expected that users will make use
- * of this, but we use it internally to communicate to sub-processes that we
- * are in a bare repo. If not set, defaults to true.
- */
-#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
-
-/*
  * Repository-local GIT_* environment variables; these will be cleared
  * when git spawns a sub-process that runs inside another repository.
  * The array is NULL-terminated, which makes it easy to pass in the "env"
diff --git a/environment.c b/environment.c
index be2e509..255e277 100644
--- a/environment.c
+++ b/environment.c
@@ -85,7 +85,6 @@ const char * const local_repo_env[] = {
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
-	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
 	GRAFT_ENVIRONMENT,
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
diff --git a/git.c b/git.c
index 0ffea57..d33f9b3 100644
--- a/git.c
+++ b/git.c
@@ -125,7 +125,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			static char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
-			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-c")) {
diff --git a/setup.c b/setup.c
index afc245f..319dbb5 100644
--- a/setup.c
+++ b/setup.c
@@ -437,23 +437,6 @@ const char *read_gitfile(const char *path)
 	return path;
 }
 
-static const char warn_implicit_work_tree_msg[] =
-N_("You have set GIT_DIR (or used --git-dir) without specifying\n"
-   "a working tree. In Git 2.0, the behavior will change from using current\n"
-   "working directory as the working tree to having no working tree at all.\n"
-   "If you wish to continue the current behavior, please set GIT_WORK_TREE\n"
-   "or core.worktree explicitly. See `git help git` for more details.");
-
-static void warn_implicit_work_tree(void)
-{
-	static int warn_once;
-
-	if (warn_once++)
-		return;
-
-	warning("%s", _(warn_implicit_work_tree_msg));
-}
-
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  char *cwd, int len,
 					  int *nongit_ok)
@@ -514,16 +497,11 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 			set_git_work_tree(core_worktree);
 		}
 	}
-	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
-		/* #16d */
+	else { /* #2, #10, #16d */
 		set_git_dir(gitdirenv);
 		free(gitfile);
 		return NULL;
 	}
-	else { /* #2, #10 */
-		warn_implicit_work_tree();
-		set_git_work_tree(".");
-	}
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = get_git_work_tree();
@@ -600,8 +578,6 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (check_repository_format_gently(".", nongit_ok))
 		return NULL;
 
-	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
-
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		const char *gitdir;
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0910de1..7db4b3f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -28,7 +28,7 @@ A few rules for repo setup:
 7. Effective core.worktree conflicts with core.bare
 
 8. If GIT_DIR is set but neither worktree nor bare setting is given,
-   original cwd becomes worktree.
+   we treat the repository as bare.
 
 9. If .git discovery is done inside a repo, the repo becomes a bare
    repo. .git discovery is performed if GIT_DIR is not set.
@@ -240,18 +240,16 @@ test_expect_success '#2b: relative GIT_DIR' '
 	! test -s message
 '
 
-test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
+test_expect_success '#2: worktree defaults to bare with explicit GIT_DIR' '
 	try_repo 2 unset "$here/2/.git" unset "" unset \
-		"$here/2/.git" "$here/2" "$here/2" "(null)" \
-		"$here/2/.git" "$here/2/sub" "$here/2/sub" "(null)" \
-		2>message &&
-	test_i18ngrep "warning:.*GIT_DIR" message
+		"$here/2/.git" "(null)" "$here/2" "(null)" \
+		"$here/2/.git" "(null)" "$here/2/sub" "(null)"
 '
 
 test_expect_success '#2b: relative GIT_DIR' '
 	try_repo 2b unset ".git" unset "" unset \
-		".git" "$here/2b" "$here/2b" "(null)" \
-		"../.git" "$here/2b/sub" "$here/2b/sub" "(null)"
+		".git" "(null)" "$here/2b" "(null)" \
+		"../.git" "(null)" "$here/2b/sub" "(null)"
 '
 
 test_expect_success '#3: setup' '
@@ -379,16 +377,14 @@ test_expect_success '#10b: relative GIT_DIR can point to gitfile' '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
 	try_repo 10 unset "$here/10/.git" unset gitfile unset \
-		"$here/10.git" "$here/10" "$here/10" "(null)" \
-		"$here/10.git" "$here/10/sub" "$here/10/sub" "(null)" \
-		2>message &&
-	test_i18ngrep "warning:.*GIT_DIR" message
+		"$here/10.git" "(null)" "$here/10" "(null)" \
+		"$here/10.git" "(null)" "$here/10/sub" "(null)"
 '
 
 test_expect_success '#10b: relative GIT_DIR can point to gitfile' '
 	try_repo 10b unset .git unset gitfile unset \
-		"$here/10b.git" "$here/10b" "$here/10b" "(null)" \
-		"$here/10b.git" "$here/10b/sub" "$here/10b/sub" "(null)"
+		"$here/10b.git" "(null)" "$here/10b" "(null)" \
+		"$here/10b.git" "(null)" "$here/10b/sub" "(null)"
 '
 
 # case #11: GIT_WORK_TREE works, gitfile case.
-- 
1.8.2.13.g0f18d3c
