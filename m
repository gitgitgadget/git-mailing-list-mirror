From: Jeff King <peff@peff.net>
Subject: [PATCH 02/10] wrap shared_repository global in get/set accessors
Date: Tue, 1 Mar 2016 09:38:26 -0500
Message-ID: <20160301143826.GB12887@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 15:38:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalRZ-0004sb-J7
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbcCAOia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:38:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:52410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753513AbcCAOi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:38:29 -0500
Received: (qmail 27552 invoked by uid 102); 1 Mar 2016 14:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:38:28 -0500
Received: (qmail 8123 invoked by uid 107); 1 Mar 2016 14:38:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:38:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:38:26 -0500
Content-Disposition: inline
In-Reply-To: <20160301143546.GA30806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288019>

It would be useful to control access to the global
shared_repository, so that we can lazily load its config.
The first step to doing so is to make sure all access
goes through a set of functions.

This step is purely mechanical, and should result in no
change of behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c | 24 ++++++++++++------------
 cache.h           |  4 +++-
 environment.c     | 13 ++++++++++++-
 path.c            | 10 +++++-----
 setup.c           |  2 +-
 5 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6223b7d..e9b2256 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -199,13 +199,13 @@ static int create_default_files(const char *template_path)
 
 	/* reading existing config may have overwrote it */
 	if (init_shared_repository != -1)
-		shared_repository = init_shared_repository;
+		set_shared_repository(init_shared_repository);
 
 	/*
 	 * We would have created the above under user's umask -- under
 	 * shared-repository settings, we would need to fix them up.
 	 */
-	if (shared_repository) {
+	if (get_shared_repository()) {
 		adjust_shared_perm(get_git_dir());
 		adjust_shared_perm(git_path_buf(&buf, "refs"));
 		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
@@ -369,7 +369,7 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	create_object_directory();
 
-	if (shared_repository) {
+	if (get_shared_repository()) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
@@ -377,12 +377,12 @@ int init_db(const char *template_dir, unsigned int flags)
 		 * and compatibility values for PERM_GROUP and
 		 * PERM_EVERYBODY.
 		 */
-		if (shared_repository < 0)
+		if (get_shared_repository() < 0)
 			/* force to the mode value */
-			xsnprintf(buf, sizeof(buf), "0%o", -shared_repository);
-		else if (shared_repository == PERM_GROUP)
+			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
+		else if (get_shared_repository() == PERM_GROUP)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
-		else if (shared_repository == PERM_EVERYBODY)
+		else if (get_shared_repository() == PERM_EVERYBODY)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			die("BUG: invalid value for shared_repository");
@@ -398,7 +398,7 @@ int init_db(const char *template_dir, unsigned int flags)
 		   "", and the last '%s%s' is the verbatim directory name. */
 		printf(_("%s%s Git repository in %s%s\n"),
 		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
-		       shared_repository ? _(" shared") : "",
+		       get_shared_repository() ? _(" shared") : "",
 		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
@@ -493,8 +493,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				 * and we know shared_repository should always be 0;
 				 * but just in case we play safe.
 				 */
-				saved = shared_repository;
-				shared_repository = 0;
+				saved = get_shared_repository();
+				set_shared_repository(0);
 				switch (safe_create_leading_directories_const(argv[0])) {
 				case SCLD_OK:
 				case SCLD_PERMS:
@@ -506,7 +506,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
-				shared_repository = saved;
+				set_shared_repository(saved);
 				if (mkdir(argv[0], 0777) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;
@@ -524,7 +524,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	if (init_shared_repository != -1)
-		shared_repository = init_shared_repository;
+		set_shared_repository(init_shared_repository);
 
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
diff --git a/cache.h b/cache.h
index a3b6b0f..43c6a44 100644
--- a/cache.h
+++ b/cache.h
@@ -651,7 +651,6 @@ extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
-extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
@@ -664,6 +663,9 @@ extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 
+void set_shared_repository(int value);
+int get_shared_repository(void);
+
 /*
  * Do replace refs need to be checked this run?  This variable is
  * initialized to true unless --no-replace-object is used or
diff --git a/environment.c b/environment.c
index 6dec9d0..b42e238 100644
--- a/environment.c
+++ b/environment.c
@@ -29,7 +29,6 @@ int repository_format_version;
 int repository_format_precious_objects;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
-int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
@@ -325,3 +324,15 @@ const char *get_commit_output_encoding(void)
 {
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
+
+static int the_shared_repository = PERM_UMASK;
+
+void set_shared_repository(int value)
+{
+	the_shared_repository = value;
+}
+
+int get_shared_repository(void)
+{
+	return the_shared_repository;
+}
diff --git a/path.c b/path.c
index 8b7e168..a6f1cd6 100644
--- a/path.c
+++ b/path.c
@@ -699,17 +699,17 @@ static int calc_shared_perm(int mode)
 {
 	int tweak;
 
-	if (shared_repository < 0)
-		tweak = -shared_repository;
+	if (get_shared_repository() < 0)
+		tweak = -get_shared_repository();
 	else
-		tweak = shared_repository;
+		tweak = get_shared_repository();
 
 	if (!(mode & S_IWUSR))
 		tweak &= ~0222;
 	if (mode & S_IXUSR)
 		/* Copy read bits to execute bits */
 		tweak |= (tweak & 0444) >> 2;
-	if (shared_repository < 0)
+	if (get_shared_repository() < 0)
 		mode = (mode & ~0777) | tweak;
 	else
 		mode |= tweak;
@@ -722,7 +722,7 @@ int adjust_shared_perm(const char *path)
 {
 	int old_mode, new_mode;
 
-	if (!shared_repository)
+	if (!get_shared_repository())
 		return 0;
 	if (get_st_mode_bits(path, &old_mode) < 0)
 		return -1;
diff --git a/setup.c b/setup.c
index b2f2e69..ac777c5 100644
--- a/setup.c
+++ b/setup.c
@@ -377,7 +377,7 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
-		shared_repository = git_config_perm(var, value);
+		set_shared_repository(git_config_perm(var, value));
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		/*
 		 * record any known extensions here; otherwise,
-- 
2.8.0.rc0.278.gfeb5644
