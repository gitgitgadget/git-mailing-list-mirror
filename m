From: Jeff King <peff@peff.net>
Subject: [PATCH v2 05/10] config: drop git_config_early
Date: Fri, 11 Mar 2016 17:37:03 -0500
Message-ID: <20160311223703.GE449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:37:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVgL-0003w9-S8
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbcCKWhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:37:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:58660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbcCKWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:37:06 -0500
Received: (qmail 20938 invoked by uid 102); 11 Mar 2016 22:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:05 -0500
Received: (qmail 7516 invoked by uid 107); 11 Mar 2016 22:37:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:37:03 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288712>

There are no more callers, and it's a rather confusing
interface. This could just be folded into
git_config_with_options(), but for the sake of readability,
we'll leave it as a separate (static) helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-config.txt |  7 -------
 cache.h                                |  1 -
 config.c                               | 12 ++++--------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 0d8b99b..20741f3 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -63,13 +63,6 @@ parse for configuration, rather than looking in the usual files. Regular
 Specify whether include directives should be followed in parsed files.
 Regular `git_config` defaults to `1`.
 
-There is a special version of `git_config` called `git_config_early`.
-This version takes an additional parameter to specify the repository
-config, instead of having it looked up via `git_path`. This is useful
-early in a Git program before the repository has been found. Unless
-you're working with early setup code, you probably don't want to use
-this.
-
 Reading Specific Files
 ----------------------
 
diff --git a/cache.h b/cache.h
index fdb9583..867e73e 100644
--- a/cache.h
+++ b/cache.h
@@ -1535,7 +1535,6 @@ extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
-extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 9ba40bc..7ddb287 100644
--- a/config.c
+++ b/config.c
@@ -1188,11 +1188,12 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_early(config_fn_t fn, void *data, const char *repo_config)
+static int do_git_config_sequence(config_fn_t fn, void *data)
 {
 	int ret = 0, found = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
+	char *repo_config = git_pathdup("config");
 
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
@@ -1228,6 +1229,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	free(xdg_config);
 	free(user_config);
+	free(repo_config);
 	return ret == 0 ? found : ret;
 }
 
@@ -1235,8 +1237,6 @@ int git_config_with_options(config_fn_t fn, void *data,
 			    struct git_config_source *config_source,
 			    int respect_includes)
 {
-	char *repo_config = NULL;
-	int ret;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 
 	if (respect_includes) {
@@ -1257,11 +1257,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
 
-	repo_config = git_pathdup("config");
-	ret = git_config_early(fn, data, repo_config);
-	if (repo_config)
-		free(repo_config);
-	return ret;
+	return do_git_config_sequence(fn, data);
 }
 
 static void git_config_raw(config_fn_t fn, void *data)
-- 
2.8.0.rc2.328.g39e2a47
