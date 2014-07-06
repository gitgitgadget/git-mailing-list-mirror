From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 1/2] add `config_set` API for caching config-like files
Date: Sun,  6 Jul 2014 00:19:21 -0700
Message-ID: <1404631162-18556-2-git-send-email-tanayabh@gmail.com>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 09:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3glK-00051y-Be
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 09:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbaGFHVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 03:21:13 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:60171 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaGFHVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 03:21:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id hz1so3820699pad.10
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gaQKq2I3s7hn1HbePD9jKP+ddnDZWBdfshoGcKdHsu8=;
        b=mpn49tqrnAEzHgOvnMhJme0W6YkaczD50aVRtfKKY9IUnuvEyWRBdqpTkpK3XEbfZw
         /0QFVeK4sXxJnmPpzP94d9DjxrMaLrQuIfBG4aQx8FumYL95kB5oCd/mPhMDxPIkzsJG
         uE5YTkM+PsnKdQrwSbUFw2z3KT9xFU9aN8r+ZLe6xwi4LV9Q4psP+AS7b+h9wEx470Ay
         Cpg40sOb8PgNn14MQWLIsyNfl48V4ZJfCwR5i0bzY+chJzohCza3kvjDgUiNrl4ejSbX
         r1+zD0JF5O2anL5PZJewbFbPtCCQ6bg2o6brh7BrnZWW4p7ILmNdfQX4bslaXhqF+EcW
         dnaw==
X-Received: by 10.70.98.225 with SMTP id el1mr20836485pdb.63.1404631270019;
        Sun, 06 Jul 2014 00:21:10 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.206])
        by mx.google.com with ESMTPSA id ix7sm48970544pbd.36.2014.07.06.00.21.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Jul 2014 00:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252929>

Currently `git_config()` uses a callback mechanism and file rereads for
config values. Due to this approach, it is not uncommon for the config
files to be parsed several times during the run of a git program, with
different callbacks picking out different variables useful to themselves.

Add a `config_set`, that can be used to construct an in-memory cache for
config-like files that the caller specifies (i.e., files like `.gitmodules`,
`~/.gitconfig` etc.). Add two external functions `git_configset_get_value`
and `git_configset_get_value_multi` for querying from the config sets.
`git_configset_get_value` follows `last one wins` semantic (i.e. if there
are multiple matches for the queried key in the files of the configset the
value returned will be the last entry in `value_list`).
`git_configset_get_value_multi` returns a list of values sorted in order of
increasing priority (i.e. last match will be at the end of the list). Add
type specific query functions like `git_configset_get_bool` and similar.

Add a default `config_set`, `the_config_set` to cache all key-value pairs
read from usual config files (repo specific .git/config, user wide
~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
single hashmap populated using `git_config()`.

Add two external functions `git_config_get_value` and 
`git_config_get_value_multi` for querying in a non-callback manner from
`the_config_set`. Also, add type specific query functions that are
implemented as a thin wrapper around the `config_set` API.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 134 +++++++++++++++
 Makefile                               |   1 +
 cache.h                                |  34 ++++
 config-hash.c                          | 297 +++++++++++++++++++++++++++++++++
 config.c                               |   3 +
 5 files changed, 469 insertions(+)
 create mode 100644 config-hash.c

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..bdf86d0 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,81 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying For Specific Variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non-callback
+manner, the config API provides two functions `git_config_get_value`
+and `git_config_get_value_multi`. They both read values from an internal
+cache generated previously from reading the config files.
+
+`int git_config_get_value(const char *key, const char **value)`::
+
+	Finds the highest-priority value for the configuration variable `key`,
+	stores the pointer to it in `value` and returns 0. When the
+	configuration variable `key` is not found, returns 1 without touching
+	`value`. The caller should not free or modify `value`, as it is owned
+	by the cache.
+
+`const struct string_list *git_config_get_value_multi(const char *key)`::
+
+	Finds and returns the value list, sorted in order of increasing priority
+	for the configuration variable `key`. When the configuration variable
+	`key` is not found, returns NULL. The caller should not free or modify
+	the returned pointer, as it is owned by the cache.
+
+`void git_config_clear(void)`::
+
+	Resets and invalidate the config cache. 
+
+The config API also provides type specific API functions which do conversion
+as well as retrieval for the queried variable, including:
+
+`int git_config_get_int(const char *key, int *dest)`::
+
+	Finds and parses the value to an integer for the configuration variable
+	`key`. Dies on error; otherwise, stores pointer to the parsed integer in
+	`dest` and returns 0. When the configuration variable `key` is not found,
+	returns 1 without touching `dest`.
+
+`int git_config_get_ulong(const char *key, unsigned long *dest)`::
+
+	Similar to `git_config_get_int` but for unsigned longs.
+
+`int git_config_get_int(const char *key, int *dest)`::
+
+	Finds and parses the value into a boolean value, for the configuration
+	variable `key`respecting keywords like "true" and "false". Integer
+	values are converted into true/false values (when they are non-zero or
+	zero, respectively). Other values cause a die(). If parsing is successful,
+	stores the pointer to the parsed result in `dest` and returns 0. When the
+	configuration variable `key` is not found, returns 1 without touching
+	`dest`.
+
+`int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)`::
+
+	Similar to `git_config_get_bool`, except that integers are copied as-is,
+	and `is_bool` flag is unset.
+
+`int git_config_get_maybe_bool(const char *key, int *dest)`::
+
+	Similar to `git_config_get_bool`, except that it returns -1 on error
+	rather than dying.
+
+`int git_config_get_string(const char *key, const char **dest)`::
+
+	Allocates and copies the retrieved string into the `dest` parameter for
+	the configuration variable `key`; if NULL string is given, prints an
+	error message and returns -1. When the configuration variable `key` is
+	not found, returns 1 without touching `dest`.
+
+`int git_config_get_pathname(const char *key, const char **dest)`::
+
+	Similar to `git_config_get_string`, but expands `~` or `~user` into
+	the user's home directory when found at the beginning of the path.
+
+See test-config.c for usage examples.
+
 Value Parsing Helpers
 ---------------------
 
@@ -134,6 +209,65 @@ int read_file_with_include(const char *file, config_fn_t fn, void *data)
 `git_config` respects includes automatically. The lower-level
 `git_config_from_file` does not.
 
+Custom Configsets
+-----------------
+
+A `config_set` can be used to construct an in-memory cache for config-like
+files that the caller specifies (i.e., files like `.gitmodules`,
+`~/.gitconfig` etc.). For example,
+
+---------------------------------------
+struct config_set gm_config;
+git_configset_init(&gm_config);
+int b;
+/* we add config files to the config_set */
+git_configset_add_file(&gm_config, ".gitmodules");
+git_configset_add_file(&gm_config, ".gitmodules_alt");
+
+if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
+	/* hack hack hack */
+}
+
+/* when we are done with the configset */
+git_configset_clear(&gm_config);
+----------------------------------------
+
+Configset API provides functions for the above mentioned work flow, including:
+
+`void git_configset_init(struct config_set *cs)`::
+
+	Initializes the member variables of config_set `cs`.
+
+`int git_configset_add_file(struct config_set *cs, const char *filename)`::
+
+	Parses the file and adds the variable-value pairs to the `config_set`,
+	dies if there is an error in parsing the file.
+
+`int git_configset_get_value(struct config_set *cs, const char *key, const char **value)`::
+
+	Finds the highest-priority value for the configuration variable `key`
+	and config set `cs`, stores the pointer to it in `value` and returns 0.
+	When the configuration variable `key` is not found, returns 1 without
+	touching `value`. The caller should not free or modify `value`, as it
+	is owned by the cache.
+
+`const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)`::
+
+	Finds and returns the value list, sorted in order of increasing priority
+	for the configuration variable `key` and config set `cs`. When the
+	configuration variable `key` is not found, returns NULL. The caller
+	should not free or modify the returned pointer, as it is owned by the cache.
+
+`void git_configset_clear(struct config_set *cs)`::
+
+	Clears `config_set` structure, removes all saved variable-value pairs.
+
+In addition to above functions, the `config_set` API provides type specific
+functions in the vein of `git_config_get_int` and family but with an extra
+parameter, pointer to struct `config_set`.
+They all behave similarly to the `git_config_get*()` family described in
+"Querying For Specific Variables" above.
+
 Writing Config Files
 --------------------
 
diff --git a/Makefile b/Makefile
index 07ea105..d503f78 100644
--- a/Makefile
+++ b/Makefile
@@ -777,6 +777,7 @@ LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
+LIB_OBJS += config-hash.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
 LIB_OBJS += convert.o
diff --git a/cache.h b/cache.h
index df65231..35bd71e 100644
--- a/cache.h
+++ b/cache.h
@@ -1325,6 +1325,40 @@ extern int parse_config_key(const char *var,
 			    const char **subsection, int *subsection_len,
 			    const char **key);
 
+/* config-hash.c */
+
+struct config_set {
+	struct hashmap config_hash;
+	int hash_initialized;
+};
+
+extern void git_configset_init(struct config_set *cs);
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+extern void git_configset_clear(struct config_set *cs);
+extern void git_configset_iter(struct config_set *cs, config_fn_t fn, void *data);
+extern int git_configset_get_string(struct config_set *cs, const char *key, const char **dest);
+extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
+extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
+extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+
+extern int git_config_get_value(const char *key, const char **value);
+extern const struct string_list *git_config_get_value_multi(const char *key);
+extern void git_config_clear(void);
+extern void git_config_iter(config_fn_t fn, void *data);
+extern int git_config_get_string(const char *key, const char **dest);
+extern int git_config_get_int(const char *key, int *dest);
+extern int git_config_get_ulong(const char *key, unsigned long *dest);
+extern int git_config_get_bool(const char *key, int *dest);
+extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+extern int git_config_get_maybe_bool(const char *key, int *dest);
+extern int git_config_get_pathname(const char *key, const char **dest);
+
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config-hash.c b/config-hash.c
new file mode 100644
index 0000000..4c56bd9
--- /dev/null
+++ b/config-hash.c
@@ -0,0 +1,297 @@
+#include "cache.h"
+#include "hashmap.h"
+#include "string-list.h"
+
+
+/*
+ * Default config_set that contains key-value pairs from the usual set of config
+ * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
+ * global /etc/gitconfig)
+ */
+static struct config_set the_config_set;
+
+struct config_hash_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+static int config_hash_add_value(const char *, const char *, struct hashmap *);
+
+static int config_hash_entry_cmp(const struct config_hash_entry *e1,
+				 const struct config_hash_entry *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+static void config_hash_init(struct hashmap *config_hash)
+{
+	hashmap_init(config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
+}
+
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set *cs = cb;
+	config_hash_add_value(key, value, &cs->config_hash);
+	return 0;
+}
+
+static int add_configset_hash(const char *filename, struct config_set *cs)
+{
+	int ret = 0;
+	if (!cs->hash_initialized)
+		config_hash_init(&cs->config_hash);
+	cs->hash_initialized = 1;
+	ret = git_config_from_file(config_hash_callback, filename, cs);
+	if (!ret)
+		return 0;
+	else {
+		hashmap_free(&cs->config_hash, 1);
+		cs->hash_initialized = 0;
+		return -1;
+	}
+}
+
+static struct config_hash_entry *config_hash_find_entry(const char *key,
+							struct hashmap *config_hash)
+{
+	struct config_hash_entry k;
+	struct config_hash_entry *found_entry;
+	char *normalized_key;
+	int ret;
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = normalized_key;
+	found_entry = hashmap_get(config_hash, &k, NULL);
+	free(normalized_key);
+	return found_entry;
+}
+
+static struct string_list *configset_get_list(const char *key, struct config_set *cs)
+{
+	struct config_hash_entry *e = config_hash_find_entry(key, &cs->config_hash);
+	return e ? &e->value_list : NULL;
+}
+
+static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
+{
+	struct config_hash_entry *e;
+	e = config_hash_find_entry(key, config_hash);
+
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		memset(&e->value_list, 0, sizeof(e->value_list));
+		e->value_list.strdup_strings = 1;
+		hashmap_add(config_hash, e);
+	}
+	/*
+	 * Since the values are being fed by git_config*() callback mechanism, they
+	 * are already normalized. So simply add them without any further munging.
+	 */
+	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	return 0;
+}
+
+void git_configset_init(struct config_set *cs)
+{
+	cs->hash_initialized = 0;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return add_configset_hash(filename, cs);
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	struct string_list *values = NULL;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset, the value returned will be the last
+	 * value in the value list for that key.
+	 */
+	values = configset_get_list(key, cs);
+
+	if (!values)
+		return 1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	return 0;
+}
+
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+{
+	return configset_get_list(key, cs);
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	if (!cs->hash_initialized)
+		return;
+
+	hashmap_iter_init( &cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 0);
+	}
+	hashmap_free(&cs->config_hash, 1);
+}
+
+int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_string(dest, key, value);
+	else
+		return 1;
+}
+
+int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_int(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_ulong(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
+				int *is_bool, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_bool_or_int(key, value, is_bool);
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_maybe_bool(key, value);
+		if (*dest == -1)
+			return -1;
+		return 0;
+	} else
+		return 1;
+}
+
+int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value))
+		return git_config_pathname(dest, key, value);
+	else
+		return 1;
+}
+
+static int git_config_check_init(void)
+{
+	int ret = 0;
+	if (the_config_set.hash_initialized)
+		return 0;
+	config_hash_init(&the_config_set.config_hash);
+	the_config_set.hash_initialized = 1;
+	ret = git_config(config_hash_callback, &the_config_set);
+	if (ret >= 0)
+		return 0;
+	else {
+		hashmap_free(&the_config_set.config_hash, 1);
+		the_config_set.hash_initialized = 0;
+		return -1;
+	}
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	git_config_check_init();
+	return git_configset_get_value(&the_config_set, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	git_config_check_init();
+	return git_configset_get_value_multi(&the_config_set, key);
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set.hash_initialized)
+		return;
+	git_configset_clear(&the_config_set);
+	the_config_set.hash_initialized = 0;
+}
+
+int git_config_get_string(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_string(&the_config_set, key, dest);
+}
+
+int git_config_get_int(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_int(&the_config_set, key, dest);
+}
+
+int git_config_get_ulong(const char *key, unsigned long *dest)
+{
+	git_config_check_init();
+	return git_configset_get_ulong(&the_config_set, key, dest);
+}
+
+int git_config_get_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+}
+
+int git_config_get_maybe_bool(const char *key, int *dest)
+{
+	git_config_check_init();
+	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_pathname(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_pathname(&the_config_set, key, dest);
+}
diff --git a/config.c b/config.c
index a1aef1c..6cffec7 100644
--- a/config.c
+++ b/config.c
@@ -1708,6 +1708,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;
 
+	/* Invalidate the config cache */
+	git_config_clear();
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 
1.9.0.GIT
