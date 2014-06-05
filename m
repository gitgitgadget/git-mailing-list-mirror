From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/5] implement submodule config cache for lookup of submodule
 names
Date: Thu, 5 Jun 2014 08:07:50 +0200
Message-ID: <20140605060750.GC23874@sandbox-ub>
References: <20140605060425.GA23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQqG-0007ws-3w
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 08:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbaFEGH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 02:07:56 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:39385 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaFEGHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 02:07:55 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WsQq8-00055f-7l; Thu, 05 Jun 2014 08:07:53 +0200
Content-Disposition: inline
In-Reply-To: <20140605060425.GA23874@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250814>

This submodule configuration cache allows us to lazily read .gitmodules
configurations by commit into a runtime cache which can then be used to
easily lookup values from it. Currently only the values for path or name
are stored but it can be extended for any value needed.

It is expected that .gitmodules files do not change often between
commits. Thats why we lookup the .gitmodules sha1 from a commit and then
either lookup an already parsed configuration or parse and cache an
unknown one for each sha1. The cache is lazily build on demand for each
requested commit.

This cache can be used for all purposes which need knowledge about
submodule configurations. Example use cases are:

 * Recursive submodule checkout needs lookup a submodule name from its
   path when a submodule first appears. This needs be done before this
   configuration exists in the worktree.

 * The implementation of submodule support for 'git archive' needs to
   lookup the submodule name to generate the archive when given a
   revision that is not checked out.

 * 'git fetch' when given the --recurse-submodules=on-demand option (or
   configuration) needs to lookup submodule names by path from the
   database rather than reading from the worktree. For new submodule it
   needs to lookup the name from its path to allow cloning new
   submodules into the .git folder so they can be checked out without
   any network interaction when the user does a checkout of that
   revision.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  46 +++
 Makefile                                         |   2 +
 submodule-config.c                               | 396 +++++++++++++++++++++++
 submodule-config.h                               |  27 ++
 submodule.c                                      |   1 +
 submodule.h                                      |   1 +
 t/t7410-submodule-config.sh                      |  73 +++++
 test-submodule-config.c                          |  64 ++++
 9 files changed, 611 insertions(+)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7410-submodule-config.sh
 create mode 100644 test-submodule-config.c

diff --git a/.gitignore b/.gitignore
index dc600f9..9e3352a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,6 +198,7 @@
 /test-sha1
 /test-sigchain
 /test-string-list
+/test-submodule-config
 /test-subprocess
 /test-svn-fe
 /test-urlmatch-normalization
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
new file mode 100644
index 0000000..2ff4907
--- /dev/null
+++ b/Documentation/technical/api-submodule-config.txt
@@ -0,0 +1,46 @@
+submodule config cache API
+==========================
+
+The submodule config cache API allows to read submodule
+configurations/information from specified revisions. Internally
+information is lazily read into a cache that is used to avoid
+unnecessary parsing of the same .gitmodule files. Lookups can be done by
+submodule path or name.
+
+Usage
+-----
+
+The caller can look up information about submodules by using the
+`submodule_from_path()` or `submodule_from_name()` functions. They return
+a `struct submodule` which contains the values. The API automatically
+initializes and allocates the needed infrastructure on-demand.
+
+If the internal cache might grow too big or when the caller is done with
+the API, all internally cached values can be freed with submodule_free().
+
+Data Structures
+---------------
+
+`struct submodule`::
+
+	This structure is used to return the information about one
+	submodule for a certain revision. It is returned by the lookup
+	functions.
+
+Functions
+---------
+
+`void submodule_free()`::
+
+	Use these to free the internally cached values.
+
+`const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
+
+	Lookup values for one submodule by its commit_sha1 and path or
+	name.
+
+`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
+
+	The same as above but lookup by name.
+
+For an example usage see test-submodule-config.c.
diff --git a/Makefile b/Makefile
index 08fc9ca..0c96e1f 100644
--- a/Makefile
+++ b/Makefile
@@ -570,6 +570,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
+TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
@@ -878,6 +879,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
+LIB_OBJS += submodule-config.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule-config.c b/submodule-config.c
new file mode 100644
index 0000000..e7ca2b0
--- /dev/null
+++ b/submodule-config.c
@@ -0,0 +1,396 @@
+#include "cache.h"
+#include "submodule-config.h"
+#include "submodule.h"
+#include "strbuf.h"
+
+/*
+ * submodule cache lookup structure
+ * There is one shared set of 'struct submodule' entries which can be
+ * looked up by their sha1 blob id of the .gitmodule file and either
+ * using path or name as key.
+ * for_path stores submodule entries with path as key
+ * for_name stores submodule entries with name as key
+ */
+struct submodule_cache {
+	struct hashmap for_path;
+	struct hashmap for_name;
+};
+
+/*
+ * thin wrapper struct needed to insert 'struct submodule' entries to
+ * the hashmap
+ */
+struct submodule_entry {
+	struct hashmap_entry ent;
+	struct submodule *config;
+};
+
+static struct submodule_cache cache;
+static int is_cache_init = 0;
+
+static int config_path_cmp(const struct submodule_entry *a,
+			   const struct submodule_entry *b,
+			   const void *unused)
+{
+	return strcmp(a->config->path, b->config->path) ||
+	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
+}
+
+static int config_name_cmp(const struct submodule_entry *a,
+			   const struct submodule_entry *b,
+			   const void *unused)
+{
+	return strcmp(a->config->name, b->config->name) ||
+	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
+}
+
+static void cache_init(struct submodule_cache *cache)
+{
+	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, 0);
+	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, 0);
+}
+
+static void free_one_config(struct submodule_entry *entry)
+{
+	free((void *) entry->config->path);
+	free((void *) entry->config->name);
+	free(entry->config);
+}
+
+static void cache_free(struct submodule_cache *cache)
+{
+	struct hashmap_iter iter;
+	struct submodule_entry *entry;
+
+	/*
+	 * We iterate over the name hash here to be symmetric with the
+	 * allocation of struct submodule entries. Each is allocated by
+	 * their .gitmodule blob sha1 and submodule name.
+	 */
+	hashmap_iter_init(&cache->for_name, &iter);
+	while ((entry = hashmap_iter_next(&iter)))
+		free_one_config(entry);
+
+	hashmap_free(&cache->for_path, HASHMAP_FREE_ENTRIES);
+	hashmap_free(&cache->for_name, HASHMAP_FREE_ENTRIES);
+}
+
+static unsigned int hash_sha1_string(const unsigned char *sha1,
+				     const char *string)
+{
+	return memhash(sha1, 20) + strhash(string);
+}
+
+static void cache_put_path(struct submodule_cache *cache,
+			   struct submodule *submodule)
+{
+	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
+					     submodule->path);
+	struct submodule_entry *e = xmalloc(sizeof(*e));
+	hashmap_entry_init(e, hash);
+	e->config = submodule;
+	hashmap_put(&cache->for_path, e);
+}
+
+static void cache_remove_path(struct submodule_cache *cache,
+			      struct submodule *submodule)
+{
+	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
+					     submodule->path);
+	struct submodule_entry e;
+	struct submodule_entry *removed;
+	hashmap_entry_init(&e, hash);
+	e.config = submodule;
+	removed = hashmap_remove(&cache->for_path, &e, NULL);
+	free(removed);
+}
+
+static void cache_add(struct submodule_cache *cache,
+		      struct submodule *submodule)
+{
+	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
+					     submodule->name);
+	struct submodule_entry *e = xmalloc(sizeof(*e));
+	hashmap_entry_init(e, hash);
+	e->config = submodule;
+	hashmap_add(&cache->for_name, e);
+}
+
+static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
+		const unsigned char *gitmodules_sha1, const char *path)
+{
+	struct submodule_entry *entry;
+	unsigned int hash = hash_sha1_string(gitmodules_sha1, path);
+	struct submodule_entry key;
+	struct submodule key_config;
+
+	hashcpy(key_config.gitmodules_sha1, gitmodules_sha1);
+	key_config.path = path;
+
+	hashmap_entry_init(&key, hash);
+	key.config = &key_config;
+
+	entry = hashmap_get(&cache->for_path, &key, NULL);
+	if (entry)
+		return entry->config;
+	return NULL;
+}
+
+static struct submodule *cache_lookup_name(struct submodule_cache *cache,
+		const unsigned char *gitmodules_sha1, const char *name)
+{
+	struct submodule_entry *entry;
+	unsigned int hash = hash_sha1_string(gitmodules_sha1, name);
+	struct submodule_entry key;
+	struct submodule key_config;
+
+	hashcpy(key_config.gitmodules_sha1, gitmodules_sha1);
+	key_config.name = name;
+
+	hashmap_entry_init(&key, hash);
+	key.config = &key_config;
+
+	entry = hashmap_get(&cache->for_name, &key, NULL);
+	if (entry)
+		return entry->config;
+	return NULL;
+}
+
+static int name_and_item_from_var(const char *var, struct strbuf *name,
+				  struct strbuf *item)
+{
+	const char *subsection, *key;
+	int subsection_len, parse;
+	parse = parse_config_key(var, "submodule", &subsection,
+			&subsection_len, &key);
+	if (parse < 0 || !subsection)
+		return 0;
+
+	strbuf_add(name, subsection, subsection_len);
+	strbuf_addstr(item, key);
+
+	return 1;
+}
+
+static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
+		const unsigned char *gitmodules_sha1, const char *name)
+{
+	struct submodule *submodule;
+	struct strbuf name_buf = STRBUF_INIT;
+
+	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
+	if (submodule)
+		return submodule;
+
+	submodule = xmalloc(sizeof(*submodule));
+
+	strbuf_addstr(&name_buf, name);
+	submodule->name = strbuf_detach(&name_buf, NULL);
+
+	submodule->path = NULL;
+	submodule->url = NULL;
+	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
+	submodule->ignore = NULL;
+
+	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
+
+	cache_add(cache, submodule);
+
+	return submodule;
+}
+
+static void warn_multiple_config(const unsigned char *commit_sha1,
+				 const char *name, const char *option)
+{
+	const char *commit_string = "WORKTREE";
+	if (commit_sha1)
+		commit_string = sha1_to_hex(commit_sha1);
+	warning("%s:.gitmodules, multiple configurations found for "
+			"submodule.%s.%s. Skipping second one!",
+			commit_string, name, option);
+}
+
+struct parse_config_parameter {
+	struct submodule_cache *cache;
+	const unsigned char *commit_sha1;
+	const unsigned char *gitmodules_sha1;
+	int overwrite;
+};
+
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+	struct submodule *submodule;
+	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
+	int ret = 0;
+
+	/* this also ensures that we only parse submodule entries */
+	if (!name_and_item_from_var(var, &name, &item))
+		return 0;
+
+	submodule = lookup_or_create_by_name(me->cache, me->gitmodules_sha1,
+			name.buf);
+
+	if (!strcmp(item.buf, "path")) {
+		struct strbuf path = STRBUF_INIT;
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto release_return;
+		}
+		if (!me->overwrite && submodule->path != NULL) {
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					"path");
+			goto release_return;
+		}
+
+		if (submodule->path)
+			cache_remove_path(me->cache, submodule);
+		free((void *) submodule->path);
+		strbuf_addstr(&path, value);
+		submodule->path = strbuf_detach(&path, NULL);
+		cache_put_path(me->cache, submodule);
+	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+		if (!me->overwrite &&
+		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE) {
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					"fetchrecursesubmodules");
+			goto release_return;
+		}
+
+		submodule->fetch_recurse = parse_fetch_recurse_submodules_arg(var, value);
+	} else if (!strcmp(item.buf, "ignore")) {
+		struct strbuf ignore = STRBUF_INIT;
+		if (!me->overwrite && submodule->ignore != NULL) {
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					"ignore");
+			goto release_return;
+		}
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto release_return;
+		}
+		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
+		    strcmp(value, "all") && strcmp(value, "none")) {
+			warning("Invalid parameter \"%s\" for config option "
+					"\"submodule.%s.ignore\"", value, var);
+			goto release_return;
+		}
+
+		free((void *) submodule->ignore);
+		strbuf_addstr(&ignore, value);
+		submodule->ignore = strbuf_detach(&ignore, NULL);
+	} else if (!strcmp(item.buf, "url")) {
+		struct strbuf url = STRBUF_INIT;
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto release_return;
+		}
+		if (!me->overwrite && submodule->url != NULL) {
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					"url");
+			goto release_return;
+		}
+
+		free((void *) submodule->url);
+		strbuf_addstr(&url, value);
+		submodule->url = strbuf_detach(&url, NULL);
+	}
+
+release_return:
+	strbuf_release(&name);
+	strbuf_release(&item);
+
+	return ret;
+}
+
+static const struct submodule *config_from_path(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	struct strbuf rev = STRBUF_INIT;
+	unsigned long config_size;
+	char *config;
+	unsigned char sha1[20];
+	enum object_type type;
+	const struct submodule *submodule = NULL;
+	struct parse_config_parameter parameter;
+
+	/*
+	 * If any parameter except the cache is a NULL pointer just
+	 * return the first submodule. Can be used to check whether
+	 * there are any submodules parsed.
+	 */
+	if (!commit_sha1 || !path) {
+		struct hashmap_iter iter;
+		struct submodule_entry *entry;
+
+		hashmap_iter_init(&cache->for_name, &iter);
+		entry = hashmap_iter_next(&iter);
+		if (!entry)
+			return NULL;
+		return entry->config;
+	}
+
+	if (is_null_sha1(commit_sha1))
+		return cache_lookup_path(cache, null_sha1, path);
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, sha1) < 0)
+		goto free_rev;
+
+	submodule = cache_lookup_path(cache, sha1, path);
+	if (submodule)
+		goto free_rev;
+
+	config = read_sha1_file(sha1, &type, &config_size);
+	if (!config)
+		goto free_rev;
+
+	if (type != OBJ_BLOB) {
+		free(config);
+		goto free_rev;
+	}
+
+	/* fill the submodule config into the cache */
+	parameter.cache = cache;
+	parameter.commit_sha1 = commit_sha1;
+	parameter.gitmodules_sha1 = sha1;
+	parameter.overwrite = 0;
+	git_config_from_buf(parse_config, rev.buf, config, config_size,
+			&parameter);
+	free(config);
+
+	submodule = cache_lookup_path(cache, sha1, path);
+
+free_rev:
+	strbuf_release(&rev);
+	return submodule;
+}
+
+static void ensure_cache_init()
+{
+	if (is_cache_init)
+		return;
+
+	cache_init(&cache);
+	is_cache_init = 1;
+}
+
+const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
+		const char *name)
+{
+	ensure_cache_init();
+	return cache_lookup_name(&cache, commit_sha1, name);
+}
+
+const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+		const char *path)
+{
+	ensure_cache_init();
+	return config_from_path(&cache, commit_sha1, path);
+}
+
+void submodule_free()
+{
+	cache_free(&cache);
+	is_cache_init = 0;
+}
diff --git a/submodule-config.h b/submodule-config.h
new file mode 100644
index 0000000..972496d
--- /dev/null
+++ b/submodule-config.h
@@ -0,0 +1,27 @@
+#ifndef SUBMODULE_CONFIG_CACHE_H
+#define SUBMODULE_CONFIG_CACHE_H
+
+#include "hashmap.h"
+#include "strbuf.h"
+
+/*
+ * Submodule entry containing the information about a certain submodule
+ * in a certain revision.
+ */
+struct submodule {
+	const char *path;
+	const char *name;
+	const char *url;
+	int fetch_recurse;
+	const char *ignore;
+	/* the sha1 blob id of the responsible .gitmodules file */
+	unsigned char gitmodules_sha1[20];
+};
+
+const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
+		const char *name);
+const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+		const char *path);
+void submodule_free();
+
+#endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index b80ecac..85e2b12 100644
--- a/submodule.c
+++ b/submodule.c
@@ -355,6 +355,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	default:
 		if (!strcmp(arg, "on-demand"))
 			return RECURSE_SUBMODULES_ON_DEMAND;
+		/* TODO: remove the die for history parsing here */
 		die("bad %s argument: %s", opt, arg);
 	}
 }
diff --git a/submodule.h b/submodule.h
index 7beec48..920fef3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;
 struct argv_array;
 
 enum {
+	RECURSE_SUBMODULES_NONE = -2,
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
 	RECURSE_SUBMODULES_OFF = 0,
 	RECURSE_SUBMODULES_DEFAULT = 1,
diff --git a/t/t7410-submodule-config.sh b/t/t7410-submodule-config.sh
new file mode 100755
index 0000000..ea453c5
--- /dev/null
+++ b/t/t7410-submodule-config.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Heiko Voigt
+#
+
+test_description='Test submodules config cache infrastructure
+
+This test verifies that parsing .gitmodules configuration directly
+from the database works.
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_expect_success 'submodule config cache setup' '
+	mkdir submodule &&
+	(cd submodule &&
+		git init
+		echo a >a &&
+		git add . &&
+		git commit -ma
+	) &&
+	mkdir super &&
+	(cd super &&
+		git init &&
+		git submodule add ../submodule &&
+		git submodule add ../submodule a &&
+		git commit -m "add as submodule and as a" &&
+		git mv a b &&
+		git commit -m "move a to b"
+	)
+'
+
+cat >super/expect <<EOF
+Submodule name: 'a' for path 'a'
+Submodule name: 'a' for path 'b'
+Submodule name: 'submodule' for path 'submodule'
+Submodule name: 'submodule' for path 'submodule'
+EOF
+
+test_expect_success 'test parsing of submodule config' '
+	(cd super &&
+		test-submodule-config \
+			HEAD^ a \
+			HEAD b \
+			HEAD^ submodule \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect actual
+	)
+'
+
+cat >super/expect_error <<EOF
+Submodule name: 'a' for path 'b'
+Submodule name: 'submodule' for path 'submodule'
+EOF
+
+test_expect_success 'error in one submodule config lets continue' '
+	(cd super &&
+		cp .gitmodules .gitmodules.bak &&
+		echo "	value = \"" >>.gitmodules &&
+		git add .gitmodules &&
+		mv .gitmodules.bak .gitmodules &&
+		git commit -m "add error" &&
+		test-submodule-config \
+			HEAD b \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect_error actual
+	)
+'
+
+test_done
diff --git a/test-submodule-config.c b/test-submodule-config.c
new file mode 100644
index 0000000..969d957
--- /dev/null
+++ b/test-submodule-config.c
@@ -0,0 +1,64 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "cache.h"
+#include "submodule-config.h"
+
+static void die_usage(int argc, char **argv, const char *msg)
+{
+	fprintf(stderr, "%s\n", msg);
+	fprintf(stderr, "Usage: %s [<commit> <submodulepath>] ...\n", argv[0]);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	char **arg = argv;
+	int my_argc = argc;
+	int output_url = 0;
+
+	arg++;
+	my_argc--;
+	while (starts_with(arg[0], "--")) {
+		if (!strcmp(arg[0], "--url"))
+			output_url = 1;
+		arg++;
+		my_argc--;
+	}
+
+	if (my_argc % 2 != 0)
+		die_usage(argc, argv, "Wrong number of arguments.");
+
+	while (*arg) {
+		unsigned char commit_sha1[20];
+		const struct submodule *submodule;
+		const char *commit;
+		const char *path;
+
+		commit = arg[0];
+		path = arg[1];
+
+		if (commit[0] == '\0')
+			hashcpy(commit_sha1, null_sha1);
+		else if (get_sha1(commit, commit_sha1) < 0)
+			die_usage(argc, argv, "Commit not found.");
+
+		submodule = submodule_from_path(commit_sha1, path);
+		if (!submodule)
+			die_usage(argc, argv, "Submodule not found.");
+
+		if (output_url)
+			printf("Submodule url: '%s' for path '%s'\n",
+					submodule->url, path);
+		else
+			printf("Submodule name: '%s' for path '%s'\n",
+					submodule->name, path);
+
+		arg += 2;
+	}
+
+	submodule_free();
+
+	return 0;
+}
-- 
2.0.0
