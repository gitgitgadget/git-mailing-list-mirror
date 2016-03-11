From: Jeff King <peff@peff.net>
Subject: [PATCH v2 08/10] setup: unify repository version callbacks
Date: Fri, 11 Mar 2016 17:37:14 -0500
Message-ID: <20160311223714.GH449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgW-00048K-I5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbcCKWhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:58676 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbcCKWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:22 -0500
Received: (qmail 21007 invoked by uid 102); 11 Mar 2016 22:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:17 -0500
Received: (qmail 7558 invoked by uid 107); 11 Mar 2016 22:37:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:37:14 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288715>

Once upon a time, check_repository_format_gently would parse
the config with a single callback, and that callback would
set up a bunch of global variables. But now that we have
separate workdirs, we have to be more careful. Commit
31e26eb (setup.c: support multi-checkout repo setup,
2014-11-30) introduced a reduced callback which omits some
values like core.worktree. In the "main" callback we call
the reduced one, and then add back in the missing variables.

Now that we have split the config-parsing from the munging
of the global variables, we can do it all with a single
callback, and keep all of the "are we in a separate workdir"
logic together.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  1 -
 setup.c | 65 +++++++++++++++++++++++------------------------------------------
 2 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/cache.h b/cache.h
index 4fc42b5..7704bc6 100644
--- a/cache.h
+++ b/cache.h
@@ -1582,7 +1582,6 @@ extern void git_config_set_multivar_in_file(const char *, const char *, const ch
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
-extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
 extern int git_config_system(void);
diff --git a/setup.c b/setup.c
index 8aa49a9..fbe7ec1 100644
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
 
-static int read_repository_format_1(struct repository_format *, config_fn_t,
-				    const char *);
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
@@ -432,36 +431,34 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
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
 
-static int read_repository_format_1(struct repository_format *format,
-				    config_fn_t fn, const char *path)
+int read_repository_format(struct repository_format *format, const char *path)
 {
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
 	format->is_bare = -1;
 	string_list_init(&format->unknown_extensions, 1);
-	git_config_from_file(fn, path, format);
+	git_config_from_file(check_repo_format, path, format);
 	return format->version;
 }
 
-int read_repository_format(struct repository_format *format, const char *path)
-{
-	return read_repository_format_1(format, check_repository_format_version, path);
-}
-
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err)
 {
@@ -999,22 +996,6 @@ int git_config_perm(const char *var, const char *value)
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
2.8.0.rc2.328.g39e2a47
