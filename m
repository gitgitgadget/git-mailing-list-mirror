From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] implement submodule config cache for lookup of submodule
 names
Date: Mon, 10 Mar 2014 22:24:12 +0100
Message-ID: <20140310212412.GA8693@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7gW-0002fh-Ek
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbaCJVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:24:27 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:44025 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbaCJVY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 17:24:26 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WN7gH-0006FF-GR; Mon, 10 Mar 2014 22:24:18 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243818>

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

This was originally part of my submodule fetch series[1] of moved or new
submodules. There has been an RFC patch separating this[2] to use it
independently for git-archive. This updated patch now uses the new
hashmap implementation from Karsten Blees.

I have also moved all functions into the new submodule-config-cache
module. I am not completely satisfied with the naming since it is quite
long. If someone comes up with some different naming I am open for it.
Maybe simply submodule-config (submodule_config prefix for functions)?

Next I am planning to extend this so configuration cache so it will
return the local configuration (with the usual .gitmodules,
/etc/gitconfig, .git/config, ... overlay of variables) when you pass it
null_sha1 for gitmodule or commit sha1. That way we can give this
configuration cache some use and implement its usage for the current
configuration variables in submodule.c. There we could get rid of the
global string_lists and only have one global submodule_config_cache
structure from which values can be read.

Let me know what you think.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/217018
[2] http://article.gmane.org/gmane.comp.version-control.git/239094

 .gitignore                                         |   1 +
 .../technical/api-submodule-config-cache.txt       |  39 ++++
 Makefile                                           |   2 +
 submodule-config-cache.c                           | 256 +++++++++++++++++++++
 submodule-config-cache.h                           |  26 +++
 t/t7410-submodule-config-cache.sh                  |  74 ++++++
 test-submodule-config-cache.c                      |  50 ++++
 7 files changed, 448 insertions(+)
 create mode 100644 Documentation/technical/api-submodule-config-cache.txt
 create mode 100644 submodule-config-cache.c
 create mode 100644 submodule-config-cache.h
 create mode 100755 t/t7410-submodule-config-cache.sh
 create mode 100644 test-submodule-config-cache.c

diff --git a/.gitignore b/.gitignore
index dc600f9..ed286e4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,6 +198,7 @@
 /test-sha1
 /test-sigchain
 /test-string-list
+/test-submodule-config-cache
 /test-subprocess
 /test-svn-fe
 /test-urlmatch-normalization
diff --git a/Documentation/technical/api-submodule-config-cache.txt b/Documentation/technical/api-submodule-config-cache.txt
new file mode 100644
index 0000000..e3c80e8
--- /dev/null
+++ b/Documentation/technical/api-submodule-config-cache.txt
@@ -0,0 +1,39 @@
+submodule config cache API
+==========================
+
+The submodule config cache API allows to lazily read submodule
+configurations from multiple revisions into a cache that can then be
+used for subsequent lookups of submodule configurations either by its
+path or name.
+
+Data Structures
+---------------
+
+`struct submodule_config_cache`::
+
+	The configuration cache which stores everything needed for
+	lookup. All functions for lookup or insertion operate
+	on this structure.
+
+`struct submodule_config`::
+
+	This structure stores the configuration for one submodule for a
+	certain revision. It is returned by the lookup functions.
+
+Functions
+---------
+
+`void submodule_config_cache_init(struct submodule_config_cache *cache)`::
+`void submodule_config_cache_free(struct submodule_config_cache *cache)`::
+
+	Use these to initialize before and free a cache after your
+	lookups.
+
+`struct submodule_config *get_submodule_config_from_path(
+			struct submodule_config_cache *cache,
+			const unsigned char *commit_sha1,
+			const char *path)::
+
+	Lookup a submodules configuration by its commit_sha1 and path.
+
+For an example usage see test-submodule-config-cache.c.
diff --git a/Makefile b/Makefile
index d4ce53a..d2459bd 100644
--- a/Makefile
+++ b/Makefile
@@ -572,6 +572,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
+TEST_PROGRAMS_NEED_X += test-submodule-config-cache
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
@@ -880,6 +881,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
+LIB_OBJS += submodule-config-cache.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule-config-cache.c b/submodule-config-cache.c
new file mode 100644
index 0000000..5a7ffea
--- /dev/null
+++ b/submodule-config-cache.c
@@ -0,0 +1,256 @@
+#include "cache.h"
+#include "submodule-config-cache.h"
+#include "strbuf.h"
+
+struct submodule_config_entry {
+	struct hashmap_entry ent;
+	struct submodule_config *config;
+};
+
+static int submodule_config_path_cmp(const struct submodule_config_entry *a,
+				     const struct submodule_config_entry *b,
+				     const void *unused)
+{
+	int ret;
+	if ((ret = strcmp(a->config->path.buf, b->config->path.buf)))
+		return ret;
+	if ((ret = hashcmp(a->config->gitmodule_sha1, b->config->gitmodule_sha1)))
+		return ret;
+
+	return 0;
+}
+
+static int submodule_config_name_cmp(const struct submodule_config_entry *a,
+				     const struct submodule_config_entry *b,
+				     const void *unused)
+{
+	int ret;
+	if ((ret = strcmp(a->config->name.buf, b->config->name.buf)))
+		return ret;
+	if ((ret = hashcmp(a->config->gitmodule_sha1, b->config->gitmodule_sha1)))
+		return ret;
+
+	return 0;
+}
+
+void submodule_config_cache_init(struct submodule_config_cache *cache)
+{
+	hashmap_init(&cache->for_path, (hashmap_cmp_fn) submodule_config_path_cmp, 0);
+	hashmap_init(&cache->for_name, (hashmap_cmp_fn) submodule_config_name_cmp, 0);
+}
+
+static int free_one_submodule_config(struct submodule_config_entry *entry)
+{
+	strbuf_release(&entry->config->path);
+	strbuf_release(&entry->config->name);
+	free(entry->config);
+
+	return 0;
+}
+
+void submodule_config_cache_free(struct submodule_config_cache *cache)
+{
+	struct hashmap_iter iter;
+	struct submodule_config_entry *entry;
+
+	/*
+	 * NOTE: we iterate over the name hash here since
+	 * submodule_config entries are allocated by their gitmodule
+	 * sha1 and submodule name.
+	 */
+	hashmap_iter_init(&cache->for_name, &iter);
+	while ((entry = hashmap_iter_next(&iter)))
+		free_one_submodule_config(entry);
+
+	hashmap_free(&cache->for_path, 1);
+	hashmap_free(&cache->for_name, 1);
+}
+
+static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
+{
+	return memhash(sha1, 20) + strhash(string);
+}
+
+static void submodule_config_cache_update_path(struct submodule_config_cache *cache,
+		struct submodule_config *config)
+{
+	unsigned int hash = hash_sha1_string(config->gitmodule_sha1,
+					     config->path.buf);
+	struct submodule_config_entry *e = xmalloc(sizeof(*e));
+	hashmap_entry_init(e, hash);
+	e->config = config;
+	hashmap_put(&cache->for_path, e);
+}
+
+static void submodule_config_cache_insert(struct submodule_config_cache *cache, struct submodule_config *config)
+{
+	unsigned int hash = hash_sha1_string(config->gitmodule_sha1,
+					     config->name.buf);
+	struct submodule_config_entry *e = xmalloc(sizeof(*e));
+	hashmap_entry_init(e, hash);
+	e->config = config;
+	hashmap_add(&cache->for_name, e);
+}
+
+static struct submodule_config *submodule_config_cache_lookup_path(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *path)
+{
+	struct submodule_config_entry *entry;
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, path);
+	struct submodule_config_entry key;
+	struct submodule_config key_config;
+
+	hashcpy(key_config.gitmodule_sha1, gitmodule_sha1);
+	key_config.path.buf = (char *) path;
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
+static struct submodule_config *submodule_config_cache_lookup_name(struct submodule_config_cache *cache,
+	const unsigned char *gitmodule_sha1, const char *name)
+{
+	struct submodule_config_entry *entry;
+	unsigned int hash = hash_sha1_string(gitmodule_sha1, name);
+	struct submodule_config_entry key;
+	struct submodule_config key_config;
+
+	hashcpy(key_config.gitmodule_sha1, gitmodule_sha1);
+	key_config.name.buf = (char *) name;
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
+	strbuf_init(&config->name, 0);
+	strbuf_addstr(&config->name, name);
+
+	strbuf_init(&config->path, 0);
+
+	hashcpy(config->gitmodule_sha1, gitmodule_sha1);
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
+	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
+
+	/* We only read submodule.<name> entries */
+	if (prefixcmp(var, "submodule."))
+		return 0;
+
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
+	strbuf_release(&name);
+	strbuf_release(&item);
+
+	return 0;
+}
+
+struct submodule_config *submodule_config_from_path(struct submodule_config_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	struct strbuf rev = STRBUF_INIT;
+	unsigned long config_size;
+	char *config;
+	unsigned char sha1[20];
+	enum object_type type;
+	struct submodule_config *submodule_config = NULL;
+	struct parse_submodule_config_parameter parameter;
+
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, sha1) < 0)
+		goto free_rev;
+
+	submodule_config = submodule_config_cache_lookup_path(cache, sha1, path);
+	if (submodule_config)
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
+	parameter.gitmodule_sha1 = sha1;
+	git_config_from_buf(parse_submodule_config_into_cache, rev.buf,
+			config, config_size, &parameter);
+	free(config);
+
+	submodule_config = submodule_config_cache_lookup_path(cache, sha1, path);
+
+free_rev:
+	strbuf_release(&rev);
+	return submodule_config;
+}
diff --git a/submodule-config-cache.h b/submodule-config-cache.h
new file mode 100644
index 0000000..18524b0
--- /dev/null
+++ b/submodule-config-cache.h
@@ -0,0 +1,26 @@
+#ifndef SUBMODULE_CONFIG_CACHE_H
+#define SUBMODULE_CONFIG_CACHE_H
+
+#include "hashmap.h"
+#include "strbuf.h"
+
+struct submodule_config_cache {
+	struct hashmap for_path;
+	struct hashmap for_name;
+};
+
+/* one submodule_config_cache entry */
+struct submodule_config {
+	struct strbuf path;
+	struct strbuf name;
+	unsigned char gitmodule_sha1[20];
+};
+
+void submodule_config_cache_init(struct submodule_config_cache *cache);
+void submodule_config_cache_free(struct submodule_config_cache *cache);
+
+struct submodule_config *submodule_config_from_path(
+		struct submodule_config_cache *cache,
+		const unsigned char *commit_sha1, const char *path);
+
+#endif /* SUBMODULE_CONFIG_CACHE_H */
diff --git a/t/t7410-submodule-config-cache.sh b/t/t7410-submodule-config-cache.sh
new file mode 100755
index 0000000..9193e9d
--- /dev/null
+++ b/t/t7410-submodule-config-cache.sh
@@ -0,0 +1,74 @@
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
+		test-submodule-config-cache \
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
+		test-submodule-config-cache \
+			HEAD b \
+			HEAD submodule \
+				>actual &&
+		test_cmp expect_error actual &&
+		git checkout .gitmodules
+	)
+'
+
+test_done
diff --git a/test-submodule-config-cache.c b/test-submodule-config-cache.c
new file mode 100644
index 0000000..b893d94
--- /dev/null
+++ b/test-submodule-config-cache.c
@@ -0,0 +1,50 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "cache.h"
+#include "submodule-config-cache.h"
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
+	struct submodule_config_cache submodule_config_cache;
+
+	if ((argc - 1) % 2 != 0)
+		die_usage(argc, argv, "Wrong number of arguments.");
+
+	submodule_config_cache_init(&submodule_config_cache);
+
+	arg++;
+	while (*arg) {
+		unsigned char commit_sha1[20];
+		struct submodule_config *submodule_config;
+		const char *commit;
+		const char *path;
+
+		commit = arg[0];
+		path = arg[1];
+
+		if (get_sha1(commit, commit_sha1) < 0)
+			die_usage(argc, argv, "Commit not found.");
+
+		submodule_config = submodule_config_from_path(&submodule_config_cache,
+				commit_sha1, path);
+		if (!submodule_config)
+			die_usage(argc, argv, "Submodule config not found.");
+
+		printf("Submodule name: '%s' for path '%s'\n", submodule_config->name.buf, path);
+		arg += 2;
+	}
+
+	submodule_config_cache_free(&submodule_config_cache);
+
+	return 0;
+}
-- 
1.9.0.158.gd3fc797
