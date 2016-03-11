From: Jeff King <peff@peff.net>
Subject: [PATCH v2 06/10] setup: refactor repo format reading and verification
Date: Fri, 11 Mar 2016 17:37:07 -0500
Message-ID: <20160311223706.GF449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgM-0003w9-Er
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbcCKWhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:58665 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbcCKWhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:09 -0500
Received: (qmail 20984 invoked by uid 102); 11 Mar 2016 22:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:09 -0500
Received: (qmail 7522 invoked by uid 107); 11 Mar 2016 22:37:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:37:07 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288713>

When we want to know if we're in a git repository of
reasonable vintage, we can call check_repository_format_gently(),
which does three things:

  1. Reads the config from the .git/config file.

  2. Verifies that the version info we read is sane.

  3. Writes some global variables based on this.

There are a few things we could improve here.

One is that steps 1 and 3 happen together. So if the
verification in step 2 fails, we still clobber the global
variables. This is especially bad if we go on to try another
repository directory; we may end up with a state of mixed
config variables.

The second is there's no way to ask about the repository
version for anything besides the main repository we're in.
git-init wants to do this, and it's possible that we would
want to start doing so for submodules (e.g., to find out
which ref backend they're using).

We can improve both by splitting the first two steps into
separate functions. Now check_repository_format_gently()
calls out to steps 1 and 2, and does 3 only if step 2
succeeds.

Note that the public interface for read_repository_format()
and what check_repository_format_gently() needs from it are
not quite the same, leading us to have an extra
read_repository_format_1() helper. The extra needs from
check_repository_format_gently() will go away in a future
patch, and we can simplify this then to just the public
interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  24 +++++++++++++
 setup.c | 118 +++++++++++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 103 insertions(+), 39 deletions(-)

diff --git a/cache.h b/cache.h
index 867e73e..4fc42b5 100644
--- a/cache.h
+++ b/cache.h
@@ -750,6 +750,30 @@ extern int grafts_replace_parents;
 extern int repository_format_version;
 extern int repository_format_precious_objects;
 
+struct repository_format {
+	int version;
+	int precious_objects;
+	int is_bare;
+	char *work_tree;
+	struct string_list unknown_extensions;
+};
+
+/*
+ * Read the repository format characteristics from the config file "path" into
+ * "format" struct. Returns the numeric version. On error, -1 is returned,
+ * format->version is set to -1, and all other fields in the struct are
+ * undefined.
+ */
+int read_repository_format(struct repository_format *format, const char *path);
+
+/*
+ * Verify that the repository described by repository_format is something we
+ * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
+ * any errors encountered.
+ */
+int verify_repository_format(const struct repository_format *format,
+			     struct strbuf *err);
+
 /*
  * Check the repository format version in the path found in get_git_dir(),
  * and die if it is a version we don't understand. Generally one would
diff --git a/setup.c b/setup.c
index a6013e6..8aa49a9 100644
--- a/setup.c
+++ b/setup.c
@@ -5,7 +5,6 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
-static struct string_list unknown_extensions = STRING_LIST_INIT_DUP;
 
 /*
  * The input parameter must contain an absolute path, and it must already be
@@ -370,12 +369,13 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
-static int check_repo_format(const char *var, const char *value, void *cb)
+static int check_repo_format(const char *var, const char *value, void *vdata)
 {
+	struct repository_format *data = vdata;
 	const char *ext;
 
 	if (strcmp(var, "core.repositoryformatversion") == 0)
-		repository_format_version = git_config_int(var, value);
+		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		/*
 		 * record any known extensions here; otherwise,
@@ -385,61 +385,104 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 		if (!strcmp(ext, "noop"))
 			;
 		else if (!strcmp(ext, "preciousobjects"))
-			repository_format_precious_objects = git_config_bool(var, value);
+			data->precious_objects = git_config_bool(var, value);
 		else
-			string_list_append(&unknown_extensions, ext);
+			string_list_append(&data->unknown_extensions, ext);
 	}
 	return 0;
 }
 
+static int read_repository_format_1(struct repository_format *, config_fn_t,
+				    const char *);
+
 static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *repo_config;
+	struct strbuf err = STRBUF_INIT;
+	struct repository_format candidate;
 	config_fn_t fn;
-	int ret = 0;
-
-	string_list_clear(&unknown_extensions, 0);
 
 	if (get_common_dir(&sb, gitdir))
 		fn = check_repo_format;
 	else
 		fn = check_repository_format_version;
+
 	strbuf_addstr(&sb, "/config");
-	repo_config = sb.buf;
+	read_repository_format_1(&candidate, fn, sb.buf);
+	strbuf_release(&sb);
 
 	/*
-	 * Ignore return value; for historical reasons, we must treat a missing
-	 * config file as a noop (git-init relies on this).
+	 * For historical use of check_repository_format() in git-init,
+	 * we treat a missing config as a silent "ok", even when nongit_ok
+	 * is unset.
 	 */
-	git_config_from_file(fn, repo_config, NULL);
-	if (GIT_REPO_VERSION_READ < repository_format_version) {
-		if (!nongit_ok)
-			die ("Expected git repo version <= %d, found %d",
-			     GIT_REPO_VERSION_READ, repository_format_version);
-		warning("Expected git repo version <= %d, found %d",
-			GIT_REPO_VERSION_READ, repository_format_version);
-		warning("Please upgrade Git");
-		*nongit_ok = -1;
-		ret = -1;
+	if (candidate.version < 0)
+		return 0;
+
+	if (verify_repository_format(&candidate, &err) < 0) {
+		if (nongit_ok) {
+			warning("%s", err.buf);
+			strbuf_release(&err);
+			*nongit_ok = -1;
+			return -1;
+		}
+		die("%s", err.buf);
 	}
 
-	if (repository_format_version >= 1 && unknown_extensions.nr) {
+	repository_format_version = candidate.version;
+	repository_format_precious_objects = candidate.precious_objects;
+	string_list_clear(&candidate.unknown_extensions, 0);
+	if (candidate.is_bare != -1) {
+		is_bare_repository_cfg = candidate.is_bare;
+		if (is_bare_repository_cfg == 1)
+			inside_work_tree = -1;
+	}
+	if (candidate.work_tree) {
+		free(git_work_tree_cfg);
+		git_work_tree_cfg = candidate.work_tree;
+		inside_work_tree = -1;
+	}
+
+	return 0;
+}
+
+static int read_repository_format_1(struct repository_format *format,
+				    config_fn_t fn, const char *path)
+{
+	memset(format, 0, sizeof(*format));
+	format->version = -1;
+	format->is_bare = -1;
+	string_list_init(&format->unknown_extensions, 1);
+	git_config_from_file(fn, path, format);
+	return format->version;
+}
+
+int read_repository_format(struct repository_format *format, const char *path)
+{
+	return read_repository_format_1(format, check_repository_format_version, path);
+}
+
+int verify_repository_format(const struct repository_format *format,
+			     struct strbuf *err)
+{
+	if (GIT_REPO_VERSION_READ < format->version) {
+		strbuf_addf(err, "Expected git repo version <= %d, found %d",
+			    GIT_REPO_VERSION_READ, format->version);
+		return -1;
+	}
+
+	if (format->version >= 1 && format->unknown_extensions.nr) {
 		int i;
 
-		if (!nongit_ok)
-			die("unknown repository extension: %s",
-			    unknown_extensions.items[0].string);
+		strbuf_addstr(err, "unknown repository extensions found:");
 
-		for (i = 0; i < unknown_extensions.nr; i++)
-			warning("unknown repository extension: %s",
-				unknown_extensions.items[i].string);
-		*nongit_ok = -1;
-		ret = -1;
+		for (i = 0; i < format->unknown_extensions.nr; i++)
+			strbuf_addf(err, "\n\t%s",
+				    format->unknown_extensions.items[i].string);
+		return -1;
 	}
 
-	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 /*
@@ -958,19 +1001,16 @@ int git_config_perm(const char *var, const char *value)
 
 int check_repository_format_version(const char *var, const char *value, void *cb)
 {
+	struct repository_format *data = cb;
 	int ret = check_repo_format(var, value, cb);
 	if (ret)
 		return ret;
 	if (strcmp(var, "core.bare") == 0) {
-		is_bare_repository_cfg = git_config_bool(var, value);
-		if (is_bare_repository_cfg == 1)
-			inside_work_tree = -1;
+		data->is_bare = git_config_bool(var, value);
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
-		free(git_work_tree_cfg);
-		git_work_tree_cfg = xstrdup(value);
-		inside_work_tree = -1;
+		data->work_tree = xstrdup(value);
 	}
 	return 0;
 }
-- 
2.8.0.rc2.328.g39e2a47
