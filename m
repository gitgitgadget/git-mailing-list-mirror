From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] config: add a notion of "scope"
Date: Wed, 18 May 2016 18:44:23 -0400
Message-ID: <20160518224423.GE22443@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:44:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ACc-000280-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbcERWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:44:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:41576 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750752AbcERWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:44:26 -0400
Received: (qmail 32644 invoked by uid 102); 18 May 2016 22:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:44:26 -0400
Received: (qmail 27714 invoked by uid 107); 18 May 2016 22:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:44:23 -0400
Content-Disposition: inline
In-Reply-To: <20160518223712.GA18317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295023>

A config callback passed to git_config() doesn't know very
much about the context in which it sees a variable. It can
ask whether the variable comes from a file, and get the file
name. But without analyzing the filename (which is hard to
do accurately), it cannot tell whether it is in system-level
config, user-level config, or repo-specific config.

Generally this doesn't matter; the point of not passing this
to the callback is that it should treat the config the same
no matter where it comes from. But some programs, like
upload-pack, are a special case: we should be able to run
them in an untrusted repository, which means we cannot use
any "dangerous" config from the repository config file (but
it is OK to use it from system or user config).

This patch teaches the config code to record the "scope" of
each variable, and make it available inside config
callbacks, similar to how we give access to the filename.
The scope is the starting source for a particular parsing
operation, and remains the same even if we include other
files (so a .git/config which includes another file will
remain CONFIG_SCOPE_REPO, as it would be similarly
untrusted).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                | 11 +++++++++++
 config.c               | 23 +++++++++++++++++++++++
 t/helper/test-config.c | 16 ++++++++++++++++
 t/t1308-config-set.sh  |  3 +++
 4 files changed, 53 insertions(+)

diff --git a/cache.h b/cache.h
index 29c579b..81bd96a 100644
--- a/cache.h
+++ b/cache.h
@@ -1601,6 +1601,16 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+
+enum config_scope {
+	CONFIG_SCOPE_UNKNOWN = 0,
+	CONFIG_SCOPE_SYSTEM,
+	CONFIG_SCOPE_GLOBAL,
+	CONFIG_SCOPE_REPO,
+	CONFIG_SCOPE_CMDLINE,
+};
+
+extern enum config_scope current_config_scope(void);
 extern const char *current_config_origin_type(void);
 extern const char *current_config_name(void);
 
@@ -1694,6 +1704,7 @@ struct key_value_info {
 	const char *filename;
 	int linenr;
 	const char *origin_type;
+	enum config_scope scope;
 };
 
 extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
diff --git a/config.c b/config.c
index 75afdd7..995e886 100644
--- a/config.c
+++ b/config.c
@@ -57,6 +57,15 @@ struct config_source {
 static struct config_source *cf;
 static struct key_value_info *current_config_kvi;
 
+/*
+ * Similar to the variables above, this gives access to the "scope" of the
+ * current value (repo, global, etc). For cached values, it can be found via
+ * the current_config_kvi as above. During parsing, the current value can be
+ * found in this variable. It's not part of "cf" because it transcends a single
+ * file (i.e., a file included from .git/config is still in "repo" scope).
+ */
+static enum config_scope current_parsing_scope;
+
 static int zlib_compression_seen;
 
 /*
@@ -1233,22 +1242,27 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	char *user_config = expand_user_path("~/.gitconfig");
 	char *repo_config = git_pathdup("config");
 
+	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
 
+	current_parsing_scope = CONFIG_SCOPE_GLOBAL;
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, xdg_config, data);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
 
+	current_parsing_scope = CONFIG_SCOPE_REPO;
 	if (repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
+	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
 	if (git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
+	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
@@ -1387,6 +1401,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		kv_info->linenr = -1;
 		kv_info->origin_type = NULL;
 	}
+	kv_info->scope = current_parsing_scope;
 	si->util = kv_info;
 
 	return 0;
@@ -2486,3 +2501,11 @@ const char *current_config_name(void)
 		die("BUG: current_config_name called outside config callback");
 	return name ? name : "";
 }
+
+enum config_scope current_config_scope(void)
+{
+	if (current_config_kvi)
+		return current_config_kvi->scope;
+	else
+		return current_parsing_scope;
+}
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 3605ef8..509aeef 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -35,6 +35,21 @@
  *
  */
 
+static const char *scope_name(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+	case CONFIG_SCOPE_REPO:
+		return "repo";
+	case CONFIG_SCOPE_CMDLINE:
+		return "cmdline";
+	default:
+		return "unknown";
+	}
+}
 static int iterate_cb(const char *var, const char *value, void *data)
 {
 	static int nr;
@@ -46,6 +61,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	printf("value=%s\n", value ? value : "(null)");
 	printf("origin=%s\n", current_config_origin_type());
 	printf("name=%s\n", current_config_name());
+	printf("scope=%s\n", scope_name(current_config_scope()));
 
 	return 0;
 }
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b241338..486b41c 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -237,16 +237,19 @@ test_expect_success 'iteration shows correct origins' '
 	value=!test-config
 	origin=file
 	name=$(pwd)/.gitconfig
+	scope=global
 
 	key=foo.bar
 	value=from-repo
 	origin=file
 	name=.git/config
+	scope=repo
 
 	key=foo.bar
 	value=from-cmdline
 	origin=command line
 	name=
+	scope=cmdline
 	EOF
 	git -c foo.bar=from-cmdline test-config iterate >actual &&
 	test_cmp expect actual
-- 
2.8.2.888.gecb1fe3
