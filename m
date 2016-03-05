From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] setup: make startup_info available everywhere
Date: Sat, 5 Mar 2016 17:10:27 -0500
Message-ID: <20160305221027.GA31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:10:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKPC-0007TK-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbcCEWKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:10:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:55307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750801AbcCEWKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:10:30 -0500
Received: (qmail 12972 invoked by uid 102); 5 Mar 2016 22:10:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:10:29 -0500
Received: (qmail 12083 invoked by uid 107); 5 Mar 2016 22:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:10:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:10:27 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288329>

Commit a60645f (setup: remember whether repository was
found, 2010-08-05) introduced the startup_info structure,
which records some parts of the setup_git_directory()
process (notably, whether we actually found a repository or
not).

One of the uses of this data is for functions to behave
appropriately based on whether we are in a repo. But the
startup_info struct is just a pointer to storage provided by
the main program, and the only program that sets it up is
the git.c wrapper. Thus builtins have access to
startup_info, but externally linked programs do not.

Worse, library code which is accessible from both has to be
careful about accessing startup_info. This can be used to
trigger a die("BUG") via get_sha1():

	$ git fast-import <<-\EOF
	tag foo
	from HEAD:./whatever
	EOF

	fatal: BUG: startup_info struct is not initialized.

Obviously that's fairly nonsensical input to feed to
fast-import, but we should never hit a die("BUG"). And there
may be other ways to trigger it if other non-builtins
resolve sha1s.

So let's point the storage for startup_info to a static
variable in setup.c, making it available to all users of the
library code. We _could_ turn startup_info into a regular
extern struct, but doing so would mean tweaking all of the
existing use sites. So let's leave the pointer indirection
in place.  We can, however, drop any checks for NULL, as
they will always be false (and likewise, we can drop the
test covering this case, which was a rather artificial
situation using one of the test-* programs).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                        |  2 +-
 environment.c                  |  1 -
 git.c                          |  3 ---
 setup.c                        | 10 ++++++----
 sha1_name.c                    |  3 ---
 t/t1506-rev-parse-diagnosis.sh |  5 -----
 6 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..9f09540 100644
--- a/cache.h
+++ b/cache.h
@@ -1771,7 +1771,7 @@ int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
 
-/* git.c */
+/* setup.c */
 struct startup_info {
 	int have_repository;
 	const char *prefix;
diff --git a/environment.c b/environment.c
index 6dec9d0..6cc0a77 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
-struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
diff --git a/git.c b/git.c
index 6cc0c07..968a8a4 100644
--- a/git.c
+++ b/git.c
@@ -15,7 +15,6 @@ const char git_more_info_string[] =
 	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 	   "to read about a specific subcommand or concept.");
 
-static struct startup_info git_startup_info;
 static int use_pager = -1;
 static char *orig_cwd;
 static const char *env_names[] = {
@@ -637,8 +636,6 @@ int main(int argc, char **av)
 	const char *cmd;
 	int done_help = 0;
 
-	startup_info = &git_startup_info;
-
 	cmd = git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd = "git-help";
diff --git a/setup.c b/setup.c
index de1a2a7..fa7a306 100644
--- a/setup.c
+++ b/setup.c
@@ -7,6 +7,9 @@ static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
 static struct string_list unknown_extensions = STRING_LIST_INIT_DUP;
 
+static struct startup_info the_startup_info;
+struct startup_info *startup_info = &the_startup_info;
+
 /*
  * The input parameter must contain an absolute path, and it must already be
  * normalized.
@@ -905,10 +908,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	else
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 
-	if (startup_info) {
-		startup_info->have_repository = !nongit_ok || !*nongit_ok;
-		startup_info->prefix = prefix;
-	}
+	startup_info->have_repository = !nongit_ok || !*nongit_ok;
+	startup_info->prefix = prefix;
+
 	return prefix;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index 3acf221..776101e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1353,9 +1353,6 @@ static char *resolve_relative_path(const char *rel)
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!startup_info)
-		die("BUG: startup_info struct is not initialized.");
-
 	if (!is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 613d9bf..86c2ff2 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -166,11 +166,6 @@ test_expect_success 'relative path when cwd is outside worktree' '
 	grep "relative path syntax can.t be used outside working tree." error
 '
 
-test_expect_success 'relative path when startup_info is NULL' '
-	test_must_fail test-match-trees HEAD:./file.txt HEAD:./file.txt 2>error &&
-	grep "BUG: startup_info struct is not initialized." error
-'
-
 test_expect_success '<commit>:file correctly diagnosed after a pathname' '
 	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
 	test_i18ngrep ! "exists on disk" error &&
-- 
2.8.0.rc1.318.g2193183
