From: Jeff King <peff@peff.net>
Subject: [PATCH 08/10] setup: unify repository version callbacks
Date: Tue, 1 Mar 2016 09:45:18 -0500
Message-ID: <20160301144518.GH12887@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 15:45:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalYP-0000t2-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbcCAOpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:45:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:52451 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754358AbcCAOpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:45:21 -0500
Received: (qmail 27891 invoked by uid 102); 1 Mar 2016 14:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:20 -0500
Received: (qmail 8253 invoked by uid 107); 1 Mar 2016 14:45:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:45:18 -0500
Content-Disposition: inline
In-Reply-To: <20160301143546.GA30806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288025>

Once upon a time, check_repository_format_gently would parse
the config with a single callback, and that callback would
set up a bunch of global variables. But now that we have
separate workdirs, we have to be more careful. Commit
31e26eb (setup.c: support multi-checkout repo setup,
2014-11-30) introduced a reduced callback which omits some
values like core.worktree. In the "main" callback we call
the reduced one, and then add back in the missing variables.

Now that we have split the config-parsing from the munging
of the global variables, we can handle all the config with a
single callback, and keep all of the "are we in a separate
workdir" logic together in the caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  1 -
 setup.c | 69 ++++++++++++++++++++++-------------------------------------------
 2 files changed, 23 insertions(+), 47 deletions(-)

diff --git a/cache.h b/cache.h
index d03f5d6..1795807 100644
--- a/cache.h
+++ b/cache.h
@@ -1571,7 +1571,6 @@ extern void git_config_set_multivar_in_file(const char *, const char *, const ch
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
-extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
 extern int git_config_system(void);
diff --git a/setup.c b/setup.c
index 3d498af..a04d7dd 100644
--- a/setup.c
+++ b/setup.c
@@ -388,27 +388,26 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			data->precious_objects = git_config_bool(var, value);
 		else
 			string_list_append(&data->unknown_extensions, ext);
+	} else if (strcmp(var, "core.bare") == 0) {
+		data->is_bare = git_config_bool(var, value);
+	} else if (strcmp(var, "core.worktree") == 0) {
+		if (!value)
+			return config_error_nonbool(var);
+		data->work_tree = xstrdup(value);
 	}
 	return 0;
 }
 
-static void read_repository_format_1(struct repository_format *, config_fn_t,
-				     const char *);
-
 static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct repository_format candidate;
-	config_fn_t fn;
-
-	if (get_common_dir(&sb, gitdir))
-		fn = check_repo_format;
-	else
-		fn = check_repository_format_version;
+	int has_common;
 
+	has_common = get_common_dir(&sb, gitdir);
 	strbuf_addstr(&sb, "/config");
-	read_repository_format_1(&candidate, fn, sb.buf);
+	read_repository_format(&candidate, sb.buf);
 	strbuf_release(&sb);
 
 	/*
@@ -432,37 +431,31 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	repository_format_version = candidate.version;
 	repository_format_precious_objects = candidate.precious_objects;
 	string_list_clear(&candidate.unknown_extensions, 0);
-	if (candidate.is_bare != -1) {
-		is_bare_repository_cfg = candidate.is_bare;
-		if (is_bare_repository_cfg == 1)
+	if (!has_common) {
+		if (candidate.is_bare != -1) {
+			is_bare_repository_cfg = candidate.is_bare;
+			if (is_bare_repository_cfg == 1)
+				inside_work_tree = -1;
+		}
+		if (candidate.work_tree) {
+			free(git_work_tree_cfg);
+			git_work_tree_cfg = candidate.work_tree;
 			inside_work_tree = -1;
-	}
-	if (candidate.work_tree) {
-		free(git_work_tree_cfg);
-		git_work_tree_cfg = candidate.work_tree;
-		inside_work_tree = -1;
+		}
+	} else {
+		free(candidate.work_tree);
 	}
 
 	return 0;
 }
 
-/*
- * Internally, we need to swap out "fn" here, but we don't want to expose
- * that to the world. Hence a wrapper around this internal function.
- */
-static void read_repository_format_1(struct repository_format *format,
-				     config_fn_t fn, const char *path)
+void read_repository_format(struct repository_format *format, const char *path)
 {
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
 	format->is_bare = -1;
 	string_list_init(&format->unknown_extensions, 1);
-	git_config_from_file(fn, path, format);
-}
-
-void read_repository_format(struct repository_format *format, const char *path)
-{
-	read_repository_format_1(format, check_repository_format_version, path);
+	git_config_from_file(check_repo_format, path, format);
 }
 
 int verify_repository_format(const struct repository_format *format,
@@ -1000,22 +993,6 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-int check_repository_format_version(const char *var, const char *value, void *cb)
-{
-	struct repository_format *data = cb;
-	int ret = check_repo_format(var, value, cb);
-	if (ret)
-		return ret;
-	if (strcmp(var, "core.bare") == 0) {
-		data->is_bare = git_config_bool(var, value);
-	} else if (strcmp(var, "core.worktree") == 0) {
-		if (!value)
-			return config_error_nonbool(var);
-		data->work_tree = xstrdup(value);
-	}
-	return 0;
-}
-
 void check_repository_format(void)
 {
 	check_repository_format_gently(get_git_dir(), NULL);
-- 
2.8.0.rc0.278.gfeb5644
