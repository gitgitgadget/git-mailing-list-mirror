From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 2/3] implement fetching of moved submodules
Date: Mon, 25 Feb 2013 02:05:32 +0100
Message-ID: <f5baa2acc09531a16f4f693eebbe60706bb8ed1e.1361751905.git.hvoigt@hvoigt.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 02:06:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9mW0-0004Am-R8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 02:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512Ab3BYBFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 20:05:36 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:42635 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492Ab3BYBFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 20:05:35 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U9mVY-0007tn-Cg; Mon, 25 Feb 2013 02:05:33 +0100
Content-Disposition: inline
In-Reply-To: <cover.1361751905.git.hvoigt@hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217020>

Change calculation of changed submodule paths to read revisions config.

We now read the submodule name for every changed submodule path in a
commit. We then use the submodules names for fetching instead of the
submodule paths.

We lazily read all configurations of changed submodule path into a cache
which can then be used to lookup the configuration for a certain revision
and path or name.

It is expected that .gitmodules files do not change often between
commits. Thats why we lookup the .gitmodules sha1 and use a submodule
configuration cache to lazily lookup the parsed result for a submodule
stored by its name.

This cache could be reused for other purposes which need knowledge about
submodule configurations. For example automatic clone on fetch of a new
submodule if it is configured to be automatically initialized.

The submodule configuration in the current worktree can be stored using
the null sha1.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Makefile                    |   1 +
 submodule-config-cache.c    |  96 ++++++++++++++++++++++
 submodule-config-cache.h    |  34 ++++++++
 submodule.c                 | 196 ++++++++++++++++++++++++++++++++++++++------
 t/t5526-fetch-submodules.sh |  31 +++++++
 5 files changed, 335 insertions(+), 23 deletions(-)
 create mode 100644 submodule-config-cache.c
 create mode 100644 submodule-config-cache.h

diff --git a/Makefile b/Makefile
index 98da708..2e1d83b 100644
--- a/Makefile
+++ b/Makefile
@@ -858,6 +858,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
+LIB_OBJS += submodule-config-cache.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule-config-cache.c b/submodule-config-cache.c
new file mode 100644
index 0000000..8ea5ac4
--- /dev/null
+++ b/submodule-config-cache.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "submodule-config-cache.h"
+#include "strbuf.h"
+#include "hash.h"
+
+void submodule_config_cache_init(struct submodule_config_cache *cache)
+{
+	init_hash(&cache->for_name);
+	init_hash(&cache->for_path);
+}
+
+static int free_one_submodule_config(void *ptr, void *data)
+{
+	struct submodule_config *entry = ptr;
+
+	strbuf_release(&entry->path);
+	strbuf_release(&entry->name);
+	free(entry);
+
+	return 0;
+}
+
+void submodule_config_cache_free(struct submodule_config_cache *cache)
+{
+	/* NOTE: its important to iterate over the name hash here
+	 * since paths might have multiple entries */
+	for_each_hash(&cache->for_name, free_one_submodule_config, NULL);
+	free_hash(&cache->for_path);
+	free_hash(&cache->for_name);
+}
+
+static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
+{
+	int c;
+	unsigned int hash, string_hash = 5381;
+	memcpy(&hash, sha1, sizeof(hash));
+
+	/* djb2 hash */
+	while ((c = *string++))
+		string_hash = ((string_hash << 5) + hash) + c; /* hash * 33 + c */
+
+	return hash + string_hash;
+}
+
+void submodule_config_cache_update_path(struct submodule_config_cache *cache,
+		struct submodule_config *config)
+{
+	void **pos;
+	int hash = hash_sha1_string(config->gitmodule_sha1, config->path.buf);
+	pos = insert_hash(hash, config, &cache->for_path);
+	if (pos) {
+		config->next = *pos;
+		*pos = config;
+	}
+}
+
+void submodule_config_cache_insert(struct submodule_config_cache *cache, struct submodule_config *config)
+{
+	unsigned int hash;
+	void **pos;
+
+	hash = hash_sha1_string(config->gitmodule_sha1, config->name.buf);
+	pos = insert_hash(hash, config, &cache->for_name);
+	if (pos) {
+		config->next = *pos;
+		*pos = config;
+	}
+}
+
+struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *path)
+{
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, path);
+	struct submodule_config *config = lookup_hash(hash, &cache->for_path);
+
+	while (config &&
+		hashcmp(config->gitmodule_sha1, gitmodule_sha1) &&
+		strcmp(path, config->path.buf))
+		config = config->next;
+
+	return config;
+}
+
+struct submodule_config *submodule_config_cache_lookup_name(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *name)
+{
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, name);
+	struct submodule_config *config = lookup_hash(hash, &cache->for_name);
+
+	while (config &&
+		hashcmp(config->gitmodule_sha1, gitmodule_sha1) &&
+		strcmp(name, config->name.buf))
+		config = config->next;
+
+	return config;
+}
diff --git a/submodule-config-cache.h b/submodule-config-cache.h
new file mode 100644
index 0000000..2b48c27
--- /dev/null
+++ b/submodule-config-cache.h
@@ -0,0 +1,34 @@
+#ifndef SUBMODULE_CONFIG_CACHE_H
+#define SUBMODULE_CONFIG_CACHE_H
+
+#include "hash.h"
+#include "strbuf.h"
+
+struct submodule_config_cache {
+	struct hash_table for_path;
+	struct hash_table for_name;
+};
+
+/* one submodule_config_cache entry */
+struct submodule_config {
+	struct strbuf path;
+	struct strbuf name;
+	unsigned char gitmodule_sha1[20];
+	int fetch_recurse_submodules;
+	struct submodule_config *next;
+};
+
+void submodule_config_cache_init(struct submodule_config_cache *cache);
+void submodule_config_cache_free(struct submodule_config_cache *cache);
+
+void submodule_config_cache_update_path(struct submodule_config_cache *cache,
+		struct submodule_config *config);
+void submodule_config_cache_insert(struct submodule_config_cache *cache,
+		struct submodule_config *config);
+
+struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *path);
+struct submodule_config *submodule_config_cache_lookup_name(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *name);
+
+#endif /* SUBMODULE_CONFIG_CACHE_H */
diff --git a/submodule.c b/submodule.c
index 9ba1496..b603000 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "submodule.h"
+#include "submodule-config-cache.h"
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
@@ -11,11 +12,12 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 
+struct submodule_config_cache submodule_config_cache;
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
-static struct string_list changed_submodule_paths;
+static struct string_list changed_submodule_names;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
 static struct sha1_array ref_tips_after_fetch;
@@ -487,34 +489,177 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 	return is_present;
 }
 
+static int read_sha1_strbuf(struct strbuf *s, const unsigned char *sha1,
+			    enum object_type *type)
+{
+	unsigned long size;
+	void *sha1_data;
+
+	sha1_data = read_sha1_file(sha1, type, &size);
+	if (!sha1_data)
+		return 0;
+
+	strbuf_attach(s, sha1_data, size, size);
+
+	return size;
+}
+
+struct parse_submodule_config_parameter {
+	unsigned char *gitmodule_sha1;
+	struct submodule_config_cache *cache;
+};
+
+static int name_and_item_from_var(const char *var, struct strbuf *name, struct strbuf *item)
+{
+	/* find the name and add it */
+	strbuf_addstr(name, var + strlen("submodule."));
+	char *end = strrchr(name->buf, '.');
+	if (!end) {
+		strbuf_release(name);
+		return 0;
+	}
+	*end = '\0';
+	if (((end + 1) - name->buf) < name->len)
+		strbuf_addstr(item, end + 1);
+
+	return 1;
+}
+
+static struct submodule_config *lookup_or_create_by_name(struct submodule_config_cache *cache,
+		unsigned char *gitmodule_sha1, const char *name)
+{
+	struct submodule_config *config;
+	config = submodule_config_cache_lookup_name(cache, gitmodule_sha1, name);
+	if (config)
+		return config;
+
+	config = xmalloc(sizeof(*config));
+
+	strbuf_init(&config->name, 1024);
+	strbuf_addstr(&config->name, name);
+
+	strbuf_init(&config->path, 1024);
+
+	hashcpy(config->gitmodule_sha1, gitmodule_sha1);
+	config->fetch_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+	config->next = NULL;
+
+	submodule_config_cache_insert(cache, config);
+
+	return config;
+}
+
+static void warn_multiple_config(struct submodule_config *config, const char *option)
+{
+	warning("%s:.gitmodules, multiple configurations found for submodule.%s.%s. "
+			"Skipping second one!", sha1_to_hex(config->gitmodule_sha1),
+			option, config->name.buf);
+}
+
+static int parse_submodule_config_into_cache(const char *var, const char *value, void *data)
+{
+	struct parse_submodule_config_parameter *me = data;
+	struct submodule_config *submodule_config;
+
+	/* We only read submodule.<name> entries */
+	if (prefixcmp(var, "submodule."))
+		return 0;
+
+	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
+	if (!name_and_item_from_var(var, &name, &item))
+		return 0;
+
+	submodule_config = lookup_or_create_by_name(me->cache, me->gitmodule_sha1, name.buf);
+
+	if (!suffixcmp(var, ".path")) {
+		if (*submodule_config->path.buf != '\0') {
+			warn_multiple_config(submodule_config, "path");
+			return 0;
+		}
+		strbuf_addstr(&submodule_config->path, value);
+		submodule_config_cache_update_path(me->cache, submodule_config);
+	}
+
+	if (!suffixcmp(var, ".fetchrecursesubmodules")) {
+		if (submodule_config->fetch_recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+			warn_multiple_config(submodule_config, "fetchrecursesubmodules");
+			return 0;
+		}
+		submodule_config->fetch_recurse_submodules =
+			parse_fetch_recurse_submodules_arg(var, value);
+	}
+
+	strbuf_release(&name);
+	strbuf_release(&item);
+
+	return 0;
+}
+
+static struct submodule_config *get_submodule_config_for_commit_path(struct submodule_config_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	struct strbuf rev = STRBUF_INIT;
+	struct strbuf config = STRBUF_INIT;
+	unsigned char sha1[20];
+	enum object_type type;
+	struct submodule_config *submodule_config;
+	struct parse_submodule_config_parameter parameter;
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, sha1) < 0) {
+		strbuf_release(&rev);
+		return NULL;
+	}
+	strbuf_release(&rev);
+
+	submodule_config = submodule_config_cache_lookup_path(cache, sha1, path);
+	if (submodule_config)
+		return submodule_config;
+
+	if (!read_sha1_strbuf(&config, sha1, &type))
+		return NULL;
+
+	if (type != OBJ_BLOB) {
+		strbuf_release(&config);
+		return NULL;
+	}
+
+	/* fill the submodule config into the cache */
+	parameter.cache = cache;
+	parameter.gitmodule_sha1 = sha1;
+	git_config_from_strbuf(parse_submodule_config_into_cache, &config, &parameter);
+	strbuf_release(&config);
+
+	return submodule_config_cache_lookup_path(cache, sha1, path);
+}
+
 static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
 {
+	const unsigned char *commit_sha1 = data;
 	int i;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		struct string_list_item *name_item;
+		struct submodule_config *submodule_config;
+
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		if (S_ISGITLINK(p->one->mode)) {
-			/* NEEDSWORK: We should honor the name configured in
-			 * the .gitmodules file of the commit we are examining
-			 * here to be able to correctly follow submodules
-			 * being moved around. */
-			struct string_list_item *path;
-			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path && !is_submodule_commit_present(p->two->path, p->two->sha1))
-				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
-		} else {
-			/* Submodule is new or was moved here */
-			/* NEEDSWORK: When the .git directories of submodules
-			 * live inside the superprojects .git directory some
-			 * day we should fetch new submodules directly into
-			 * that location too when config or options request
-			 * that so they can be checked out from there. */
+		submodule_config = get_submodule_config_for_commit_path(&submodule_config_cache,
+				commit_sha1, p->two->path);
+		if (!submodule_config)
 			continue;
-		}
+
+		name_item = unsorted_string_list_lookup(&changed_submodule_names, submodule_config->name.buf);
+		if (name_item)
+			continue;
+
+		if (is_submodule_commit_present(p->two->path, p->two->sha1))
+			continue;
+
+		string_list_append(&changed_submodule_names, xstrdup(submodule_config->name.buf));
 	}
 }
 
@@ -550,6 +695,8 @@ static void calculate_changed_submodule_paths(void)
 	if (!config_name_for_path.nr)
 		return;
 
+	submodule_config_cache_init(&submodule_config_cache);
+
 	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
 	sha1_array_for_each_unique(&ref_tips_after_fetch,
@@ -563,7 +710,7 @@ static void calculate_changed_submodule_paths(void)
 
 	/*
 	 * Collect all submodules (whether checked out or not) for which new
-	 * commits have been recorded upstream in "changed_submodule_paths".
+	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
 	while ((commit = get_revision(&rev))) {
 		struct commit_list *parent = commit->parents;
@@ -573,6 +720,7 @@ static void calculate_changed_submodule_paths(void)
 			DIFF_OPT_SET(&diff_opts, RECURSIVE);
 			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
 			diff_opts.format_callback = submodule_collect_changed_cb;
+			diff_opts.format_callback_data = commit->object.sha1;
 			diff_setup_done(&diff_opts);
 			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
 			diffcore_std(&diff_opts);
@@ -585,6 +733,8 @@ static void calculate_changed_submodule_paths(void)
 	sha1_array_clear(&ref_tips_before_fetch);
 	sha1_array_clear(&ref_tips_after_fetch);
 	initialized_fetch_ref_tips = 0;
+
+	submodule_config_cache_free(&submodule_config_cache);
 }
 
 int fetch_populated_submodules(const struct argv_array *options,
@@ -639,7 +789,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
 					continue;
 				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+					if (!unsorted_string_list_lookup(&changed_submodule_names, name))
 						continue;
 					default_argv = "on-demand";
 				}
@@ -648,13 +798,13 @@ int fetch_populated_submodules(const struct argv_array *options,
 				    gitmodules_is_unmerged)
 					continue;
 				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+					if (!unsorted_string_list_lookup(&changed_submodule_names, name))
 						continue;
 					default_argv = "on-demand";
 				}
 			}
 		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
-			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+			if (!unsorted_string_list_lookup(&changed_submodule_names, name))
 				continue;
 			default_argv = "on-demand";
 		}
@@ -685,7 +835,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	}
 	argv_array_clear(&argv);
 out:
-	string_list_clear(&changed_submodule_paths, 1);
+	string_list_clear(&changed_submodule_names, 1);
 	return result;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ca5b027..7ee4c2b 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -450,4 +450,35 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "fetch new commits when submodule got renamed" '
+	(
+		cd submodule &&
+		git checkout -b rename_sub &&
+		echo a >a &&
+		git add a &&
+		git commit -ma &&
+		git rev-parse HEAD >../expect
+	) &&
+	git clone . downstream2 &&
+	(
+		cd downstream2 &&
+		git submodule update --init --recursive &&
+		git checkout -b rename &&
+		mv submodule submodule_renamed &&
+		git config -f .gitmodules submodule.submodule.path submodule_renamed &&
+		git add submodule_renamed .gitmodules &&
+		git commit -m "rename submodule -> submodule-renamed" &&
+		git push origin rename
+	) &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules=on-demand &&
+		(
+			cd submodule &&
+			git rev-parse origin/rename_sub >../../actual
+		)
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.2.rc0.25.g5062c01
