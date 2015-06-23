From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Tue, 23 Jun 2015 06:54:11 -0400
Message-ID: <20150623105411.GB12518@peff.net>
References: <20150623105042.GA10888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 12:54:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7LqO-00020o-ON
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbbFWKyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:54:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:50411 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754684AbbFWKyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:54:13 -0400
Received: (qmail 18565 invoked by uid 102); 23 Jun 2015 10:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 05:54:14 -0500
Received: (qmail 17940 invoked by uid 107); 23 Jun 2015 10:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 06:54:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 06:54:11 -0400
Content-Disposition: inline
In-Reply-To: <20150623105042.GA10888@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272449>

If this extension is used in a repository, then no
operations should run which may drop objects from the object
storage. This can be useful if you are sharing that storage
with other repositories whose refs you cannot see.

For instance, if you do:

  $ git clone -s parent child
  $ git -C parent config extensions.preciousObjects true
  $ git -C parent config core.repositoryformatversion 1

you now have additional safety when running git in the
parent repository. Prunes and repacks will bail with an
error, and `git gc` will skip those operations (it will
continue to pack refs and do other non-object operations).
Older versions of git, when run in the repository, will
fail on every operation.

Note that we do not set the preciousObjects extension by
default when doing a "clone -s", as doing so breaks
backwards compatibility. It is a decision the user should
make explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/repository-version.txt |  7 +++++++
 builtin/gc.c                                   | 20 +++++++++++---------
 builtin/prune.c                                |  3 +++
 builtin/repack.c                               |  3 +++
 cache.h                                        |  1 +
 environment.c                                  |  1 +
 setup.c                                        |  2 ++
 t/t1302-repo-version.sh                        | 22 ++++++++++++++++++++++
 8 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 3d7106d..00ad379 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -79,3 +79,10 @@ The defined extensions are:
 
 This extension does not change git's behavior at all. It is useful only
 for testing format-1 compatibility.
+
+`preciousObjects`
+~~~~~~~~~~~~~~~~~
+
+When the config key `extensions.preciousObjects` is set to `true`,
+objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
+`git repack -d`).
diff --git a/builtin/gc.c b/builtin/gc.c
index 36fe333..8b8dc6b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -352,15 +352,17 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (gc_before_repack())
 		return -1;
 
-	if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, repack.argv[0]);
-
-	if (prune_expire) {
-		argv_array_push(&prune, prune_expire);
-		if (quiet)
-			argv_array_push(&prune, "--no-progress");
-		if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, prune.argv[0]);
+	if (!repository_format_precious_objects) {
+		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, repack.argv[0]);
+
+		if (prune_expire) {
+			argv_array_push(&prune, prune_expire);
+			if (quiet)
+				argv_array_push(&prune, "--no-progress");
+			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
+				return error(FAILED_RUN, prune.argv[0]);
+		}
 	}
 
 	if (prune_worktrees_expire) {
diff --git a/builtin/prune.c b/builtin/prune.c
index 0c73246..fc0c8e8 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -218,6 +218,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	if (repository_format_precious_objects)
+		die("cannot prune in a precious-objects repo");
+
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name = *argv++;
diff --git a/builtin/repack.c b/builtin/repack.c
index af7340c..8ae7fe5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -193,6 +193,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
+	if (delete_redundant && repository_format_precious_objects)
+		die("cannot repack in a precious-objects repo");
+
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/cache.h b/cache.h
index bee425b..9b59a63 100644
--- a/cache.h
+++ b/cache.h
@@ -694,6 +694,7 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_version;
+extern int repository_format_precious_objects;
 extern int check_repository_format(void);
 
 #define MTIME_CHANGED	0x0001
diff --git a/environment.c b/environment.c
index 61c685b..da66e82 100644
--- a/environment.c
+++ b/environment.c
@@ -26,6 +26,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_version;
+int repository_format_precious_objects;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
diff --git a/setup.c b/setup.c
index 0d53846..8b8dca9 100644
--- a/setup.c
+++ b/setup.c
@@ -367,6 +367,8 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 		 */
 		if (!strcmp(ext, "noop"))
 			;
+		else if (!strcmp(ext, "preciousobjects"))
+			repository_format_precious_objects = git_config_bool(var, value);
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 8dd6fd7..9bcd349 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -105,4 +105,26 @@ abort 1 no-such-extension
 allow 0 no-such-extension
 EOF
 
+test_expect_success 'precious-objects allowed' '
+	mkconfig 1 preciousObjects >.git/config &&
+	check_allow
+'
+
+test_expect_success 'precious-objects blocks destructive repack' '
+	test_must_fail git repack -ad
+'
+
+test_expect_success 'other repacks are OK' '
+	test_commit foo &&
+	git repack
+'
+
+test_expect_success 'precious-objects blocks prune' '
+	test_must_fail git prune
+'
+
+test_expect_success 'gc runs without complaint' '
+	git gc
+'
+
 test_done
-- 
2.4.4.719.g3984bc6
