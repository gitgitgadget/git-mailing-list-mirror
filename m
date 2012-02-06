From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] config: add include directive
Date: Mon, 6 Feb 2012 01:31:54 -0500
Message-ID: <20120206063154.GB9931@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 07:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuI7O-0001Nk-DK
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916Ab2BFGb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:31:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58600
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab2BFGb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:31:56 -0500
Received: (qmail 24095 invoked by uid 107); 6 Feb 2012 06:39:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 01:39:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 01:31:54 -0500
Content-Disposition: inline
In-Reply-To: <20120206062713.GA9699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190029>

[If you haven't read my cover letter, do so now. The surprise ending is
 that I think this patch may not be the right approach, and I am posting
 it for reference. I don't want anybody to waste time reading and
 reviewing this without that context.]
-- >8 --

It can be useful to split your ~/.gitconfig across multiple
files. For example, you might have a "main" file which is
used on many machines, but a small set of per-machine
tweaks. Or you may want to make some of your config public
(e.g., clever aliases) while keeping other data back (e.g.,
your name or other identifying information). Or you may want
to include a number of config options in some subset of your
repos without copying and pasting (e.g., you want to
reference them from the .git/config of participating repos).

This patch introduces an include directive for config files.
It looks like:

  [include]
    path = /path/to/file

This is syntactically backwards-compatible with existing git
config parsers (i.e., they will see it as another config
entry and ignore it unless you are looking up include.path).

The implementation adds a new "include" parameter to
git_config_from_file to turn on includes.  Include
directives are turned on for "regular" git config parsing:
when you call git_config(), or when you make a call to the
"git config" program without using any single-file options.

Includes are off in other cases, including:

  1. Parsing of other config-like files, like .gitmodules.
     There isn't a real need, and I'd rather be conservative
     and avoid unnecessary incompatibility or confusion.

  2. Reading single files via "git config". This is for two
     reasons:

       a. backwards compatibility with scripts looking at
          config-like files.

       b. inspection of a specific file probably means you
	  care about just what's in that file, not a general
          lookup for "do we have this value anywhere at
	  all". If that is not the case, the caller can
	  always specify "--includes".

  3. Writing files via "git config"; we want to treat
     include.* variables as literal items to be copied (or
     modified), and not expand them. So "git config
     --unset-all foo.bar" would operate _only_ on
     .git/config, not any of its included files (just as it
     also does not operate on ~/.gitconfig).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt     |   15 ++++
 Documentation/git-config.txt |    5 ++
 builtin/clone.c              |    2 +-
 builtin/config.c             |   19 ++++--
 builtin/init-db.c            |    2 +-
 cache.h                      |   19 ++++-
 config.c                     |  118 ++++++++++++++++++++++++++++------
 sequencer.c                  |    2 +-
 setup.c                      |    2 +-
 submodule.c                  |    2 +-
 t/t1305-config-include.sh    |  145 ++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 295 insertions(+), 36 deletions(-)
 create mode 100755 t/t1305-config-include.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..e55dae1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -84,6 +84,17 @@ customary UNIX fashion.
 
 Some variables may require a special value format.
 
+Includes
+~~~~~~~~
+
+You can include one config file from another by setting the special
+`include.path` variable to the name of the file to be included. The
+included file is expanded immediately, as if its contents had been
+found at the location of the include directive. If the value of the
+`include.path` variable is a relative path, the path is considered to be
+relative to the configuration file in which the include directive was
+found. See below for examples.
+
 Example
 ~~~~~~~
 
@@ -106,6 +117,10 @@ Example
 		gitProxy="ssh" for "kernel.org"
 		gitProxy=default-proxy ; for the rest
 
+	[include]
+		path = /path/to/foo.inc ; include by absolute path
+		path = foo ; expand "foo" relative to the current file
+
 Variables
 ~~~~~~~~~
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e7ecf5d..aa8303b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -178,6 +178,11 @@ See also <<FILES>>.
 	Opens an editor to modify the specified config file; either
 	'--system', '--global', or repository (default).
 
+--includes::
+--no-includes::
+	Respect `include.*` directives in config files when looking up
+	values. Defaults to on.
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin/clone.c b/builtin/clone.c
index c62d4b5..32b7808 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -614,7 +614,7 @@ static void write_config(struct string_list *config)
 
 	for (i = 0; i < config->nr; i++) {
 		if (git_config_parse_parameter(config->items[i].string,
-					       write_one_config, NULL) < 0)
+					       write_one_config, NULL, NULL) < 0)
 			die("unable to write parameters to config file");
 	}
 }
diff --git a/builtin/config.c b/builtin/config.c
index d35c06a..be5d0fb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -25,6 +25,7 @@ static const char *given_config_file;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
+static struct config_include_context include = CONFIG_INCLUDE_INIT(-1);
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -74,6 +75,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "path", &types, "value is a path (file or directory name)", TYPE_PATH),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
+	OPT_BOOL(0, "includes", &include.enabled, "respect include directives on lookup"),
 	OPT_END(),
 };
 
@@ -214,18 +216,18 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	if (do_all && system_wide)
-		git_config_from_file(show_config, system_wide, NULL);
+		git_config_from_file(show_config, system_wide, NULL, &include);
 	if (do_all && global)
-		git_config_from_file(show_config, global, NULL);
+		git_config_from_file(show_config, global, NULL, &include);
 	if (do_all)
-		git_config_from_file(show_config, local, NULL);
-	git_config_from_parameters(show_config, NULL);
+		git_config_from_file(show_config, local, NULL, &include);
+	git_config_from_parameters(show_config, NULL, &include);
 	if (!do_all && !seen)
-		git_config_from_file(show_config, local, NULL);
+		git_config_from_file(show_config, local, NULL, &include);
 	if (!do_all && !seen && global)
-		git_config_from_file(show_config, global, NULL);
+		git_config_from_file(show_config, global, NULL, &include);
 	if (!do_all && !seen && system_wide)
-		git_config_from_file(show_config, system_wide, NULL);
+		git_config_from_file(show_config, system_wide, NULL, &include);
 
 	free(key);
 	if (regexp) {
@@ -384,6 +386,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			config_exclusive_filename = given_config_file;
 	}
 
+	if (include.enabled == -1)
+		include.enabled = !config_exclusive_filename;
+
 	if (end_null) {
 		term = '\0';
 		delim = '\n';
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0dacb8b..de6290f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -146,7 +146,7 @@ static void copy_templates(const char *template_dir)
 	strcpy(template_path + template_len, "config");
 	repository_format_version = 0;
 	git_config_from_file(check_repository_format_version,
-			     template_path, NULL);
+			     template_path, NULL, NULL);
 	template_path[template_len] = 0;
 
 	if (repository_format_version &&
diff --git a/cache.h b/cache.h
index 9bd8c2d..f75923e 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "string-list.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1108,13 +1109,22 @@ extern int update_server_info(int);
 #define CONFIG_NOTHING_SET 5
 #define CONFIG_INVALID_PATTERN 6
 
+struct config_include_context {
+	struct string_list seen_paths;
+	int enabled;
+};
+#define CONFIG_INCLUDE_INIT(enable) { STRING_LIST_INIT_DUP, (enable) }
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
-extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_file(config_fn_t fn, const char *, void *,
+				struct config_include_context *);
 extern void git_config_push_parameter(const char *text);
-extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern int git_config_from_parameters(config_fn_t fn, void *data,
+				      struct config_include_context *inc);
 extern int git_config(config_fn_t fn, void *);
-extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
+extern int git_config_early(config_fn_t fn, void *, const char *repo_config,
+			    struct config_include_context *inc);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
@@ -1137,7 +1147,8 @@ extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
-extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data,
+				      struct config_include_context *inc);
 
 extern const char *config_exclusive_filename;
 
diff --git a/config.c b/config.c
index 40f9c6d..9b90751 100644
--- a/config.c
+++ b/config.c
@@ -28,6 +28,71 @@ static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
 
+static int check_and_mark_include_path(struct config_include_context *inc,
+				       const char *path)
+{
+	const char *canonical;
+
+	if (!inc || !inc->enabled)
+		return 0;
+
+	/*
+	 * Using real_path would catch more duplicates, but we can't use it
+	 * here. It will die if some path components don't exist, and we have
+	 * no promise from the path in question actually exists.
+	 */
+	canonical = absolute_path(path);
+	if (unsorted_string_list_lookup(&inc->seen_paths, canonical))
+		return 1;
+
+	string_list_append(&inc->seen_paths, canonical);
+	return 0;
+}
+
+static int handle_path_include(const char *path, config_fn_t fn, void *data,
+			       struct config_include_context *inc)
+{
+	int ret = 0;
+	struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * Use an absolute path as-is, but interpret relative paths
+	 * based on the including config file.
+	 */
+	if (!is_absolute_path(path)) {
+		char *slash;
+
+		if (!cf || !cf->name)
+			return error("relative config includes must from from files");
+
+		slash = find_last_dir_sep(cf->name);
+		if (slash)
+			strbuf_add(&buf, cf->name, slash - cf->name + 1);
+		strbuf_addf(&buf, "%s", path);
+		path = buf.buf;
+	}
+
+	if (!access(path, R_OK))
+		ret = git_config_from_file(fn, path, data, inc);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static int handle_config_variable(const char *var, const char *value,
+				  config_fn_t fn, void *data,
+				  struct config_include_context *inc)
+{
+	int r;
+
+	r = fn(var, value, data);
+	if (!r && inc && inc->enabled && value && !prefixcmp(var, "include.")) {
+		const char *type = var + 8;
+		if (!strcmp(type, "path"))
+			r = handle_path_include(value, fn, data, inc);
+	}
+	return r;
+}
+
 static void lowercase(char *p)
 {
 	for (; *p; p++)
@@ -47,8 +112,8 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
-int git_config_parse_parameter(const char *text,
-			       config_fn_t fn, void *data)
+int git_config_parse_parameter(const char *text, config_fn_t fn, void *data,
+			       struct config_include_context *inc)
 {
 	struct strbuf **pair;
 	pair = strbuf_split_str(text, '=', 2);
@@ -62,7 +127,10 @@ int git_config_parse_parameter(const char *text,
 		return error("bogus config parameter: %s", text);
 	}
 	lowercase(pair[0]->buf);
-	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
+
+	if (handle_config_variable(pair[0]->buf,
+				   pair[1] ? pair[1]->buf : NULL,
+				   fn, data, inc) < 0) {
 		strbuf_list_free(pair);
 		return -1;
 	}
@@ -70,7 +138,8 @@ int git_config_parse_parameter(const char *text,
 	return 0;
 }
 
-int git_config_from_parameters(config_fn_t fn, void *data)
+int git_config_from_parameters(config_fn_t fn, void *data,
+			       struct config_include_context *inc)
 {
 	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
 	char *envw;
@@ -89,7 +158,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	}
 
 	for (i = 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+		if (git_config_parse_parameter(argv[i], fn, data, inc) < 0) {
 			free(argv);
 			free(envw);
 			return -1;
@@ -191,7 +260,8 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c == '-';
 }
 
-static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
+static int get_value(config_fn_t fn, void *data, char *name, unsigned int len,
+		     struct config_include_context *inc)
 {
 	int c;
 	char *value;
@@ -219,7 +289,8 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value, data);
+
+	return handle_config_variable(name, value, fn, data, inc);
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
@@ -277,7 +348,8 @@ static int get_base_var(char *name)
 	}
 }
 
-static int git_parse_file(config_fn_t fn, void *data)
+static int git_parse_file(config_fn_t fn, void *data,
+			  struct config_include_context *inc)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -327,7 +399,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 		if (!isalpha(c))
 			break;
 		var[baselen] = tolower(c);
-		if (get_value(fn, data, var, baselen+1) < 0)
+		if (get_value(fn, data, var, baselen+1, inc) < 0)
 			break;
 	}
 	die("bad config file line %d in %s", cf->linenr, cf->name);
@@ -826,11 +898,15 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	return 0;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+int git_config_from_file(config_fn_t fn, const char *filename, void *data,
+			 struct config_include_context *inc)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
 
+	if (check_and_mark_include_path(inc, filename))
+		return 0;
+
 	ret = -1;
 	if (f) {
 		config_file top;
@@ -844,7 +920,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		strbuf_init(&top.value, 1024);
 		cf = &top;
 
-		ret = git_parse_file(fn, data);
+		ret = git_parse_file(fn, data, inc);
 
 		/* pop config-file parsing state stack */
 		strbuf_release(&top.value);
@@ -874,17 +950,17 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_early(config_fn_t fn, void *data, const char *repo_config)
+int git_config_early(config_fn_t fn, void *data, const char *repo_config,
+		     struct config_include_context *inc)
 {
 	int ret = 0, found = 0;
 	const char *home = NULL;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
-		return git_config_from_file(fn, config_exclusive_filename, data);
+		return git_config_from_file(fn, config_exclusive_filename, data, NULL);
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
-		ret += git_config_from_file(fn, git_etc_gitconfig(),
-					    data);
+		ret += git_config_from_file(fn, git_etc_gitconfig(), data, inc);
 		found += 1;
 	}
 
@@ -893,17 +969,17 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		char buf[PATH_MAX];
 		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
 		if (!access(user_config, R_OK)) {
-			ret += git_config_from_file(fn, user_config, data);
+			ret += git_config_from_file(fn, user_config, data, inc);
 			found += 1;
 		}
 	}
 
 	if (repo_config && !access(repo_config, R_OK)) {
-		ret += git_config_from_file(fn, repo_config, data);
+		ret += git_config_from_file(fn, repo_config, data, inc);
 		found += 1;
 	}
 
-	switch (git_config_from_parameters(fn, data)) {
+	switch (git_config_from_parameters(fn, data, inc)) {
 	case -1: /* error */
 		die("unable to parse command-line config");
 		break;
@@ -921,11 +997,13 @@ int git_config(config_fn_t fn, void *data)
 {
 	char *repo_config = NULL;
 	int ret;
+	struct config_include_context inc = CONFIG_INCLUDE_INIT(1);
 
 	repo_config = git_pathdup("config");
-	ret = git_config_early(fn, data, repo_config);
+	ret = git_config_early(fn, data, repo_config, &inc);
 	if (repo_config)
 		free(repo_config);
+	string_list_clear(&inc.seen_paths, 0);
 	return ret;
 }
 
@@ -1313,7 +1391,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, NULL)) {
+		if (git_config_from_file(store_aux, config_filename, NULL, NULL)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL) {
diff --git a/sequencer.c b/sequencer.c
index 5fcbcb8..50562b9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -636,7 +636,7 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 
 	if (!file_exists(opts_file))
 		return;
-	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
+	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr, NULL) < 0)
 		die(_("Malformed options sheet: %s"), opts_file);
 }
 
diff --git a/setup.c b/setup.c
index 61c22e6..947fa51 100644
--- a/setup.c
+++ b/setup.c
@@ -329,7 +329,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	 * is a good one.
 	 */
 	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
-	git_config_early(check_repository_format_version, NULL, repo_config);
+	git_config_early(check_repository_format_version, NULL, repo_config, NULL);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <= %d, found %d",
diff --git a/submodule.c b/submodule.c
index 9a28060..4c5b9be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -116,7 +116,7 @@ void gitmodules_config(void)
 		}
 
 		if (!gitmodules_is_unmerged)
-			git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
+			git_config_from_file(submodule_config, gitmodules_path.buf, NULL, NULL);
 		strbuf_release(&gitmodules_path);
 	}
 }
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
new file mode 100755
index 0000000..3d5a46d
--- /dev/null
+++ b/t/t1305-config-include.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description='test config file include directives'
+. ./test-lib.sh
+
+test_expect_success 'include file by absolute path' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = \"$PWD/one\"" >.gitconfig &&
+	echo 1 >expect &&
+	git config test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'include file by relative path' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	echo 1 >expect &&
+	git config test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'chained relative paths' '
+	mkdir subdir &&
+	echo "[test]three = 3" >subdir/three &&
+	echo "[include]path = three" >subdir/two &&
+	echo "[include]path = subdir/two" >.gitconfig &&
+	echo 3 >expect &&
+	git config test.three >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'include options can still be examined' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	echo one >expect &&
+	git config include.path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'listing includes option and expansion' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	cat >expect <<-\EOF &&
+	include.path=one
+	test.one=1
+	EOF
+	git config --list >actual.full &&
+	grep -v ^core actual.full >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'single file lookup does not expand includes by default' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	test_must_fail git config -f .gitconfig test.one &&
+	test_must_fail git config --global test.one &&
+	echo 1 >expect &&
+	git config --includes -f .gitconfig test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'writing config file does not expand includes' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	git config test.two 2 &&
+	echo 2 >expect &&
+	git config --no-includes test.two >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config --no-includes test.one
+'
+
+test_expect_success 'config modification does not affect includes' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path = one" >.gitconfig &&
+	git config test.one 2 &&
+	echo 1 >expect &&
+	git config -f one test.one >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	1
+	2
+	EOF
+	git config --get-all test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'missing include files are ignored' '
+	cat >.gitconfig <<-\EOF &&
+	[include]path = foo
+	[test]value = yes
+	EOF
+	echo yes >expect &&
+	git config test.value >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'absolute includes from command line work' '
+	echo "[test]one = 1" >one &&
+	echo 1 >expect &&
+	git -c include.path="$PWD/one" config test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from command line fail' '
+	echo "[test]one = 1" >one &&
+	test_must_fail git -c include.path=one config test.one
+'
+
+test_expect_success 'include cycles are detected and broken' '
+	cat >.gitconfig <<-\EOF &&
+	[test]value = gitconfig
+	[include]path = cycle
+	EOF
+	cat >cycle <<-\EOF &&
+	[test]value = cycle
+	[include]path = .gitconfig
+	EOF
+	cat >expect <<-\EOF &&
+	gitconfig
+	cycle
+	EOF
+	git config --get-all test.value >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple includes of the same file are suppressed' '
+	cat >.gitconfig <<-\EOF &&
+	[test]
+	value = base
+	[include]
+	path = A
+	path = B
+	EOF
+	echo "[include]path = C" >A &&
+	echo "[include]path = C" >B &&
+	echo "[test]value = C" >C &&
+	cat >expect <<-\EOF &&
+	base
+	C
+	EOF
+	git config --get-all test.value >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.9.rc1.29.g43677
