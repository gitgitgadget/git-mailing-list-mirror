From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule: implement a config API for lookup of .gitmodules values
Date: Mon, 17 Aug 2015 17:21:57 -0700
Message-ID: <1439857323-21048-2-git-send-email-sbeller@google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 02:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUfU-0007oZ-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbHRAWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:22:15 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34878 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbHRAWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:22:13 -0400
Received: by pacgr6 with SMTP id gr6so118961731pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOz0Uf1XqeVdNOnZKa5VQflma26K0NSY7ZcoCHBZyuw=;
        b=cbbWFG3zICIxOLW+cOSg2eFQZoU1g8gIranVFjFp6sc/rIhRI83rdzIZ2bRVUj8hhU
         zGRlGXmbeC+mD3SojcKkL4cYxqgQpLwq6RGAF7ukT7jtlJS9Wxt8XXlx7JjTfVq6y8vz
         mG6va8hjJ6tBztbXarhZbroJmVGrNc4Rk1BZsfsVeVY6ydd8DNnWnPSPIkD7QeYEDrAV
         s8+yHo7qIvpO6tYdZKfyEjSf8dyPT+iN5eqgCkGGRSzURKfNhMxK2FTHQ0+BLNDdR0uA
         EbikaaO6HyBRMxW1tJHTT2/uJCboGg/Eg1ogbLx3sHC7vhINim1XzGECnaUe0lnXDyam
         gtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOz0Uf1XqeVdNOnZKa5VQflma26K0NSY7ZcoCHBZyuw=;
        b=OW21HJ45b2Gz5tFsNOGPV6cMfXo23YMf3FCNdMwgxRArEEmJsDVjJLyBRtBjRnOmUx
         hgiBpIBBvAEb38pTyZm3TH9ifpM/zlD1nQn0oGNDg7vSmr9JbBIjajq0glucxHWKFa8k
         o3a7x6rrmeM851cUFurK0sjx21icGQiw2jt31NXYOR+LDHFDWDiWwwXZ1L3rixsRUaje
         oeu4UY0B6GtPJZMHQju7kGEyN3/o3+iA/r32lIWA9Qy70AfYmokkx2wsiN/EAvHd2P8t
         y+Rwig086fZ8jGonYN8E55dg70bPH8sdaFoiQR4xVDQ6fI/iC8GlPf2RxXLRzA20MZxl
         OPIg==
X-Gm-Message-State: ALoCoQno7aDdvRgmRzYlIZYBmR1/OYw+jX+zABCTXDqBNpXD9UbosBIyY4WCmw033vFPpSxG1mIw
X-Received: by 10.66.102.71 with SMTP id fm7mr7424473pab.5.1439857333092;
        Mon, 17 Aug 2015 17:22:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bca6:6b6f:4dbb:30a3])
        by smtp.gmail.com with ESMTPSA id jt3sm15879132pbc.43.2015.08.17.17.22.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 17:22:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.330.g130be8e.dirty
In-Reply-To: <1439857323-21048-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276113>

From: Heiko Voigt <hvoigt@hvoigt.net>

In a superproject some commands need to interact with submodules. They
need to query values from the .gitmodules file either from the worktree
of from certain revisions. At the moment this is quite hard since a
caller would need to read the .gitmodules file from the history and then
parse the values. We want to provide an API for this so we have one
place to get values from .gitmodules from any revision (including the
worktree).

The API is realized as a cache which allows us to lazily read
.gitmodules configurations by commit into a runtime cache which can then
be used to easily lookup values from it. Currently only the values for
path or name are stored but it can be extended for any value needed.

It is expected that .gitmodules files do not change often between
commits. Thats why we lookup the .gitmodules sha1 from a commit and then
either lookup an already parsed configuration or parse and cache an
unknown one for each sha1. The cache is lazily build on demand for each
requested commit.

This cache can be used for all purposes which need knowledge about
submodule configurations. Example use cases are:

 * Recursive submodule checkout needs to lookup a submodule name from
   its path when a submodule first appears. This needs be done before
   this configuration exists in the worktree.

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
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  45 +++
 Makefile                                         |   2 +
 submodule-config.c                               | 443 +++++++++++++++++++++++
 submodule-config.h                               |  27 ++
 submodule.c                                      |   1 +
 submodule.h                                      |   1 +
 t/t7411-submodule-config.sh                      |  85 +++++
 test-submodule-config.c                          |  66 ++++
 9 files changed, 671 insertions(+)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

diff --git a/.gitignore b/.gitignore
index a685ec1..4fd81ba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -205,6 +205,7 @@
 /test-sha1-array
 /test-sigchain
 /test-string-list
+/test-submodule-config
 /test-subprocess
 /test-svn-fe
 /test-urlmatch-normalization
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
new file mode 100644
index 0000000..1fbde41
--- /dev/null
+++ b/Documentation/technical/api-submodule-config.txt
@@ -0,0 +1,45 @@
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
+	Lookup values for one submodule by its commit_sha1 and path.
+
+`const struct submodule *submodule_from_name(const unsigned char *commit_sha1, const char *name)`::
+
+	The same as above but lookup by name.
+
+For an example usage see test-submodule-config.c.
diff --git a/Makefile b/Makefile
index 7efedbe..24b636d 100644
--- a/Makefile
+++ b/Makefile
@@ -594,6 +594,7 @@ TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
+TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
@@ -785,6 +786,7 @@ LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
+LIB_OBJS += submodule-config.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/submodule-config.c b/submodule-config.c
new file mode 100644
index 0000000..ea82edb
--- /dev/null
+++ b/submodule-config.c
@@ -0,0 +1,443 @@
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
+enum lookup_type {
+	lookup_name,
+	lookup_path
+};
+
+static struct submodule_cache cache;
+static int is_cache_init;
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
+	hashmap_free(&cache->for_path, 1);
+	hashmap_free(&cache->for_name, 1);
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
+			"'submodule.%s.%s'. Skipping second one!",
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
+			warning("Invalid parameter '%s' for config option "
+					"'submodule.%s.ignore'", value, var);
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
+static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+				      unsigned char *gitmodules_sha1)
+{
+	struct strbuf rev = STRBUF_INIT;
+	int ret = 0;
+
+	if (is_null_sha1(commit_sha1)) {
+		hashcpy(gitmodules_sha1, null_sha1);
+		return 1;
+	}
+
+	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev.buf, gitmodules_sha1) >= 0)
+		ret = 1;
+
+	strbuf_release(&rev);
+	return ret;
+}
+
+/* This does a lookup of a submodule configuration by name or by path
+ * (key) with on-demand reading of the appropriate .gitmodules from
+ * revisions.
+ */
+static const struct submodule *config_from(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *key,
+		enum lookup_type lookup_type)
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
+	if (!commit_sha1 || !key) {
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
+	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
+		return NULL;
+
+	switch (lookup_type) {
+	case lookup_name:
+		submodule = cache_lookup_name(cache, sha1, key);
+		break;
+	case lookup_path:
+		submodule = cache_lookup_path(cache, sha1, key);
+		break;
+	}
+	if (submodule)
+		return submodule;
+
+	config = read_sha1_file(sha1, &type, &config_size);
+	if (!config)
+		return NULL;
+
+	if (type != OBJ_BLOB) {
+		free(config);
+		return NULL;
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
+	switch (lookup_type) {
+	case lookup_name:
+		return cache_lookup_name(cache, sha1, key);
+	case lookup_path:
+		return cache_lookup_path(cache, sha1, key);
+	default:
+		return NULL;
+	}
+}
+
+static const struct submodule *config_from_path(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *path)
+{
+	return config_from(cache, commit_sha1, path, lookup_path);
+}
+
+static const struct submodule *config_from_name(struct submodule_cache *cache,
+		const unsigned char *commit_sha1, const char *name)
+{
+	return config_from(cache, commit_sha1, name, lookup_name);
+}
+
+static void ensure_cache_init(void)
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
+	return config_from_name(&cache, commit_sha1, name);
+}
+
+const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
+		const char *path)
+{
+	ensure_cache_init();
+	return config_from_path(&cache, commit_sha1, path);
+}
+
+void submodule_free(void)
+{
+	cache_free(&cache);
+	is_cache_init = 0;
+}
diff --git a/submodule-config.h b/submodule-config.h
new file mode 100644
index 0000000..cd68030
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
+void submodule_free(void);
+
+#endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index 700bbf4..17b54e4 100644
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
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
new file mode 100755
index 0000000..2602bc5
--- /dev/null
+++ b/t/t7411-submodule-config.sh
@@ -0,0 +1,85 @@
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
+		git init &&
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
+test_expect_success 'test parsing and lookup of submodule config by path' '
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
+test_expect_success 'test parsing and lookup of submodule config by name' '
+	(cd super &&
+		test-submodule-config --name \
+			HEAD^ a \
+			HEAD a \
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
index 0000000..f3c3918
--- /dev/null
+++ b/test-submodule-config.c
@@ -0,0 +1,66 @@
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
+	int lookup_name = 0;
+
+	arg++;
+	my_argc--;
+	while (starts_with(arg[0], "--")) {
+		if (!strcmp(arg[0], "--url"))
+			output_url = 1;
+		if (!strcmp(arg[0], "--name"))
+			lookup_name = 1;
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
+		const char *path_or_name;
+
+		commit = arg[0];
+		path_or_name = arg[1];
+
+		if (commit[0] == '\0')
+			hashcpy(commit_sha1, null_sha1);
+		else if (get_sha1(commit, commit_sha1) < 0)
+			die_usage(argc, argv, "Commit not found.");
+
+		if (lookup_name) {
+			submodule = submodule_from_name(commit_sha1, path_or_name);
+		} else
+			submodule = submodule_from_path(commit_sha1, path_or_name);
+		if (!submodule)
+			die_usage(argc, argv, "Submodule not found.");
+
+		if (output_url)
+			printf("Submodule url: '%s' for path '%s'\n",
+					submodule->url, submodule->path);
+		else
+			printf("Submodule name: '%s' for path '%s'\n",
+					submodule->name, submodule->path);
+
+		arg += 2;
+	}
+
+	submodule_free();
+
+	return 0;
+}
-- 
2.5.0.330.g130be8e.dirty
