From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] setup: suppress implicit "." work-tree for bare repos
Date: Fri, 8 Mar 2013 04:32:22 -0500
Message-ID: <20130308093222.GA2086@sigill.intra.peff.net>
References: <20130308092824.GA9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 10:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtfa-0008AT-KA
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933953Ab3CHJc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 04:32:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40790 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454Ab3CHJcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:32:25 -0500
Received: (qmail 15164 invoked by uid 107); 8 Mar 2013 09:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 04:34:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 04:32:22 -0500
Content-Disposition: inline
In-Reply-To: <20130308092824.GA9127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217653>

If an explicit GIT_DIR is given without a working tree, we
implicitly assume that the current working directory should
be used as the working tree. E.g.,:

  GIT_DIR=/some/repo.git git status

would compare against the cwd.

Unfortunately, we fool this rule for sub-invocations of git
by setting GIT_DIR internally ourselves. For example:

  git init foo
  cd foo/.git
  git status ;# fails, as we expect
  git config alias.st status
  git status ;# does not fail, but should

What happens is that we run setup_git_directory when doing
alias lookup (since we need to see the config), set GIT_DIR
as a result, and then leave GIT_WORK_TREE blank (because we
do not have one). Then when we actually run the status
command, we do setup_git_directory again, which sees our
explicit GIT_DIR and uses the cwd as an implicit worktree.

It's tempting to argue that we should be suppressing that
second invocation of setup_git_directory, as it could use
the values we already found in memory. However, the problem
still exists for sub-processes (e.g., if "git status" were
an external command).

You can see another example with the "--bare" option, which
sets GIT_DIR explicitly. For example:

  git init foo
  cd foo/.git
  git status ;# fails
  git --bare status ;# does NOT fail

We need some way of telling sub-processes "even though
GIT_DIR is set, do not use cwd as an implicit working tree".
We could do it by putting a special token into
GIT_WORK_TREE, but the obvious choice (an empty string) has
some portability problems.

Instead, we add a new boolean variable, GIT_IMPLICIT_WORK_TREE,
which suppresses the use of cwd as a working tree when
GIT_DIR is set. We trigger the new variable when we know we
are in a bare setting.

The variable is left intentionally undocumented, as this is
an internal detail (for now, anyway). If somebody comes up
with a good alternate use for it, and once we are confident
we have shaken any bugs out of it, we can consider promoting
it further.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h               | 12 ++++++++++++
 environment.c         |  1 +
 git.c                 |  1 +
 setup.c               |  8 ++++++++
 t/t1510-repo-setup.sh | 19 +++++++++++++++++++
 5 files changed, 41 insertions(+)

diff --git a/cache.h b/cache.h
index 23e6e62..635f2e9 100644
--- a/cache.h
+++ b/cache.h
@@ -367,6 +367,18 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
 
 /*
+ * This environment variable is expected to contain a boolean indicating
+ * whether we should or should not treat:
+ *
+ *   GIT_DIR=foo.git git ...
+ *
+ * as if GIT_WORK_TREE=. was given. It's not expected that users will make use
+ * of this, but we use it internally to communicate to sub-processes that we
+ * are in a bare repo. If not set, defaults to true.
+ */
+#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
+
+/*
  * Repository-local GIT_* environment variables; these will be cleared
  * when git spawns a sub-process that runs inside another repository.
  * The array is NULL-terminated, which makes it easy to pass in the "env"
diff --git a/environment.c b/environment.c
index 2bd1c37..e2e75c1 100644
--- a/environment.c
+++ b/environment.c
@@ -92,6 +92,7 @@ const char * const local_repo_env[] = {
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
+	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
 	GRAFT_ENVIRONMENT,
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
diff --git a/git.c b/git.c
index b10c18b..24b7984 100644
--- a/git.c
+++ b/git.c
@@ -125,6 +125,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			static char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
+			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-c")) {
diff --git a/setup.c b/setup.c
index 1996295..9107f54 100644
--- a/setup.c
+++ b/setup.c
@@ -523,6 +523,12 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 			set_git_work_tree(core_worktree);
 		}
 	}
+	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
+		/* #16d */
+		set_git_dir(gitdirenv);
+		free(gitfile);
+		return NULL;
+	}
 	else /* #2, #10 */
 		set_git_work_tree(".");
 
@@ -601,6 +607,8 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (check_repository_format_gently(".", nongit_ok))
 		return NULL;
 
+	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
+
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		const char *gitdir;
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 80aedfc..cf2ee78 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -517,6 +517,25 @@ test_expect_success '#16c: bare .git has no worktree' '
 		"$here/16c/.git" "(null)" "$here/16c/sub" "(null)"
 '
 
+test_expect_success '#16d: bareness preserved across alias' '
+	setup_repo 16d unset "" unset &&
+	(
+		cd 16d/.git &&
+		test_must_fail git status &&
+		git config alias.st status &&
+		test_must_fail git st
+	)
+'
+
+test_expect_success '#16e: bareness preserved by --bare' '
+	setup_repo 16e unset "" unset &&
+	(
+		cd 16e/.git &&
+		test_must_fail git status &&
+		test_must_fail git --bare status
+	)
+'
+
 test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (bare case)' '
 	# Just like #16.
 	setup_repo 17a unset "" true &&
-- 
1.8.2.rc2.4.g3e774bb
