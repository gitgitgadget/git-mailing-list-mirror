From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 3/4] use new config API for worktree configurations of
 submodules
Date: Thu, 21 May 2015 19:08:46 +0200
Message-ID: <20150521170846.GD22979@book.hvoigt.net>
References: <20150521170616.GA22979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTxq-0005wh-8L
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbbEURIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:08:54 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:45924 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbbEURIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:08:52 -0400
Received: from [80.135.94.69] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YvTxf-0006Nl-Ux; Thu, 21 May 2015 19:08:48 +0200
Content-Disposition: inline
In-Reply-To: <20150521170616.GA22979@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269613>

We remove the extracted functions and directly parse into and read out
of the cache. This allows us to have one unified way of accessing
submodule configuration values specific to single submodules. Regardless
whether we need to access a configuration from history or from the
worktree.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/technical/api-submodule-config.txt |  19 ++-
 builtin/checkout.c                               |   1 +
 diff.c                                           |   1 +
 submodule-config.c                               |  12 ++
 submodule-config.h                               |   1 +
 submodule.c                                      | 160 ++++-------------------
 submodule.h                                      |   1 -
 t/t7411-submodule-config.sh                      |  37 +++++-
 test-submodule-config.c                          |  10 ++
 9 files changed, 104 insertions(+), 138 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 2ff4907..2ea520a 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -10,10 +10,18 @@ submodule path or name.
 Usage
 -----
 
+To initialize the cache with configurations from the worktree the caller
+typically first calls `gitmodules_config()` to read values from the
+worktree .gitmodules and then to overlay the local git config values
+`parse_submodule_config_option()` from the config parsing
+infrastructure.
+
 The caller can look up information about submodules by using the
 `submodule_from_path()` or `submodule_from_name()` functions. They return
 a `struct submodule` which contains the values. The API automatically
-initializes and allocates the needed infrastructure on-demand.
+initializes and allocates the needed infrastructure on-demand. If the
+caller does only want to lookup values from revisions the initialization
+can be skipped.
 
 If the internal cache might grow too big or when the caller is done with
 the API, all internally cached values can be freed with submodule_free().
@@ -34,6 +42,11 @@ Functions
 
 	Use these to free the internally cached values.
 
+`int parse_submodule_config_option(const char *var, const char *value)`::
+
+	Can be passed to the config parsing infrastructure to parse
+	local (worktree) submodule configurations.
+
 `const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
 
 	Lookup values for one submodule by its commit_sha1 and path or
@@ -43,4 +56,8 @@ Functions
 
 	The same as above but lookup by name.
 
+If given the null_sha1 as commit_sha1 the local configuration of a
+submodule will be returned (e.g. consolidated values from local git
+configuration and the .gitmodules file in the worktree).
+
 For an example usage see test-submodule-config.c.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1dc56e..a820afd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -18,6 +18,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "resolve-undo.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "argv-array.h"
 
diff --git a/diff.c b/diff.c
index f66716f..485e0e6 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "ll-merge.h"
 #include "string-list.h"
diff --git a/submodule-config.c b/submodule-config.c
index a455c22..e47640f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -424,6 +424,18 @@ static void ensure_cache_init(void)
 	is_cache_init = 1;
 }
 
+int parse_submodule_config_option(const char *var, const char *value)
+{
+	struct parse_config_parameter parameter;
+	parameter.cache = &cache;
+	parameter.commit_sha1 = NULL;
+	parameter.gitmodules_sha1 = null_sha1;
+	parameter.overwrite = 1;
+
+	ensure_cache_init();
+	return parse_config(var, value, &parameter);
+}
+
 const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
diff --git a/submodule-config.h b/submodule-config.h
index 972496d..2083cb9 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,7 @@ struct submodule {
 	unsigned char gitmodules_sha1[20];
 };
 
+int parse_submodule_config_option(const char *var, const char *value);
 const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
diff --git a/submodule.c b/submodule.c
index 86ec2e3..188b4d2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "dir.h"
 #include "diff.h"
@@ -12,9 +13,6 @@
 #include "argv-array.h"
 #include "blob.h"
 
-static struct string_list config_name_for_path;
-static struct string_list config_fetch_recurse_submodules_for_name;
-static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
@@ -41,77 +39,6 @@ static int gitmodules_is_unmerged;
  */
 static int gitmodules_is_modified;
 
-static const char *get_name_for_path(const char *path)
-{
-	struct string_list_item *path_option;
-	if (path == NULL) {
-		if (config_name_for_path.nr > 0)
-			return config_name_for_path.items[0].util;
-		else
-			return NULL;
-	}
-	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
-	if (!path_option)
-		return NULL;
-	return path_option->util;
-}
-
-static void set_name_for_path(const char *path, const char *name, int namelen)
-{
-	struct string_list_item *config;
-	config = unsorted_string_list_lookup(&config_name_for_path, path);
-	if (config)
-		free(config->util);
-	else
-		config = string_list_append(&config_name_for_path, xstrdup(path));
-	config->util = xmemdupz(name, namelen);
-}
-
-static const char *get_ignore_for_name(const char *name)
-{
-	struct string_list_item *ignore_option;
-	ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, name);
-	if (!ignore_option)
-		return NULL;
-
-	return ignore_option->util;
-}
-
-static void set_ignore_for_name(const char *name, int namelen, const char *ignore)
-{
-	struct string_list_item *config;
-	char *name_cstr = xmemdupz(name, namelen);
-	config = unsorted_string_list_lookup(&config_ignore_for_name, name_cstr);
-	if (config) {
-		free(config->util);
-		free(name_cstr);
-	} else
-		config = string_list_append(&config_ignore_for_name, name_cstr);
-	config->util = xstrdup(ignore);
-}
-
-static int get_fetch_recurse_for_name(const char *name)
-{
-	struct string_list_item *fetch_recurse;
-	fetch_recurse = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
-	if (!fetch_recurse)
-		return RECURSE_SUBMODULES_NONE;
-
-	return (intptr_t) fetch_recurse->util;
-}
-
-static void set_fetch_recurse_for_name(const char *name, int namelen, int fetch_recurse)
-{
-	struct string_list_item *config;
-	char *name_cstr = xmemdupz(name, namelen);
-	config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name_cstr);
-	if (!config)
-		config = string_list_append(&config_fetch_recurse_submodules_for_name, name_cstr);
-	else
-		free(name_cstr);
-	config->util = (void *)(intptr_t) fetch_recurse;
-}
-
 int is_staging_gitmodules_ok(void)
 {
 	return !gitmodules_is_modified;
@@ -125,7 +52,7 @@ int is_staging_gitmodules_ok(void)
 int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 {
 	struct strbuf entry = STRBUF_INIT;
-	const char *path;
+	const struct submodule *submodule;
 
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
@@ -133,13 +60,13 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	path = get_name_for_path(oldpath);
-	if (!path) {
+	submodule = submodule_from_path(null_sha1, oldpath);
+	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
 	}
 	strbuf_addstr(&entry, "submodule.");
-	strbuf_addstr(&entry, path);
+	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
 	if (git_config_set_in_file(".gitmodules", entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
@@ -159,7 +86,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 int remove_path_from_gitmodules(const char *path)
 {
 	struct strbuf sect = STRBUF_INIT;
-	const char *path_option;
+	const struct submodule *submodule;
 
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
@@ -167,13 +94,13 @@ int remove_path_from_gitmodules(const char *path)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	path_option = get_name_for_path(path);
-	if (!path_option) {
+	submodule = submodule_from_path(null_sha1, path);
+	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
 	}
 	strbuf_addstr(&sect, "submodule.");
-	strbuf_addstr(&sect, path_option);
+	strbuf_addstr(&sect, submodule->name);
 	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
@@ -235,11 +162,10 @@ done:
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	const char *name = get_name_for_path(path);
-	if (name) {
-		const char *ignore = get_ignore_for_name(name);
-		if (ignore)
-			handle_ignore_submodules_arg(diffopt, ignore);
+	const struct submodule *submodule = submodule_from_path(null_sha1, path);
+	if (submodule) {
+		if (submodule->ignore)
+			handle_ignore_submodules_arg(diffopt, submodule->ignore);
 		else if (gitmodules_is_unmerged)
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
@@ -288,42 +214,6 @@ void gitmodules_config(void)
 	}
 }
 
-int parse_submodule_config_option(const char *var, const char *value)
-{
-	const char *name, *key;
-	int namelen;
-
-	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
-		return 0;
-
-	if (!strcmp(key, "path")) {
-		if (!value)
-			return config_error_nonbool(var);
-
-		set_name_for_path(value, name, namelen);
-
-	} else if (!strcmp(key, "fetchrecursesubmodules")) {
-		int fetch_recurse = parse_fetch_recurse_submodules_arg(var, value);
-
-		set_fetch_recurse_for_name(name, namelen, fetch_recurse);
-
-	} else if (!strcmp(key, "ignore")) {
-
-		if (!value)
-			return config_error_nonbool(var);
-
-		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
-		    strcmp(value, "all") && strcmp(value, "none")) {
-			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
-			return 0;
-		}
-
-		set_ignore_for_name(name, namelen, value);
-		return 0;
-	}
-	return 0;
-}
-
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
@@ -707,7 +597,7 @@ static void calculate_changed_submodule_paths(void)
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* No need to check if there are no submodules configured */
-	if (!get_name_for_path(NULL))
+	if (!submodule_from_path(NULL, NULL))
 		return;
 
 	init_revisions(&rev, NULL);
@@ -754,7 +644,6 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i, result = 0;
 	struct child_process cp;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
 		goto out;
@@ -780,23 +669,26 @@ int fetch_populated_submodules(const struct argv_array *options,
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = active_cache[i];
-		const char *git_dir, *name, *default_argv;
+		const char *git_dir, *default_argv;
+		const struct submodule *submodule;
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		name = ce->name;
-		name_for_path = get_name_for_path(ce->name);
-		if (name_for_path)
-			name = name_for_path;
+		submodule = submodule_from_path(null_sha1, ce->name);
+		if (!submodule)
+			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
 		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			int fetch_recurse_option = get_fetch_recurse_for_name(name);
-			if (fetch_recurse_option != RECURSE_SUBMODULES_NONE) {
-				if (fetch_recurse_option == RECURSE_SUBMODULES_OFF)
+			if (submodule &&
+			    submodule->fetch_recurse !=
+						RECURSE_SUBMODULES_NONE) {
+				if (submodule->fetch_recurse ==
+						RECURSE_SUBMODULES_OFF)
 					continue;
-				if (fetch_recurse_option == RECURSE_SUBMODULES_ON_DEMAND) {
+				if (submodule->fetch_recurse ==
+						RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 						continue;
 					default_argv = "on-demand";
diff --git a/submodule.h b/submodule.h
index 920fef3..547219d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,7 +20,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
-int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 2602bc5..7229978 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -5,8 +5,8 @@
 
 test_description='Test submodules config cache infrastructure
 
-This test verifies that parsing .gitmodules configuration directly
-from the database works.
+This test verifies that parsing .gitmodules configurations directly
+from the database and from the worktree works.
 '
 
 TEST_NO_CREATE_REPO=1
@@ -82,4 +82,37 @@ test_expect_success 'error in one submodule config lets continue' '
 	)
 '
 
+cat >super/expect_url <<EOF
+Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
+Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
+EOF
+
+cat >super/expect_local_path <<EOF
+Submodule name: 'a' for path 'c'
+Submodule name: 'submodule' for path 'submodule'
+EOF
+
+test_expect_success 'reading of local configuration' '
+	(cd super &&
+		old_a=$(git config submodule.a.url) &&
+		old_submodule=$(git config submodule.submodule.url) &&
+		git config submodule.a.url git@somewhere.else.net:a.git &&
+		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
+		test-submodule-config --url \
+			"" b \
+			"" submodule \
+				>actual &&
+		test_cmp expect_url actual &&
+		git config submodule.a.path c &&
+		test-submodule-config \
+			"" c \
+			"" submodule \
+				>actual &&
+		test_cmp expect_local_path actual &&
+		git config submodule.a.url $old_a &&
+		git config submodule.submodule.url $old_submodule &&
+		git config --unset submodule.a.path c
+	)
+'
+
 test_done
diff --git a/test-submodule-config.c b/test-submodule-config.c
index f3c3918..dab8c27 100644
--- a/test-submodule-config.c
+++ b/test-submodule-config.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "submodule-config.h"
+#include "submodule.h"
 
 static void die_usage(int argc, char **argv, const char *msg)
 {
@@ -8,6 +9,11 @@ static void die_usage(int argc, char **argv, const char *msg)
 	exit(1);
 }
 
+static int git_test_config(const char *var, const char *value, void *cb)
+{
+	return parse_submodule_config_option(var, value);
+}
+
 int main(int argc, char **argv)
 {
 	char **arg = argv;
@@ -29,6 +35,10 @@ int main(int argc, char **argv)
 	if (my_argc % 2 != 0)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
+	setup_git_directory();
+	gitmodules_config();
+	git_config(git_test_config, NULL);
+
 	while (*arg) {
 		unsigned char commit_sha1[20];
 		const struct submodule *submodule;
-- 
2.1.0.rc0.52.gaa544bf
