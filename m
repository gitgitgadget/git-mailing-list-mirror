From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v10 3/4] add `config_set` API for caching config-like files
Date: Fri, 18 Jul 2014 02:19:01 -0700
Message-ID: <1405675142-20300-4-git-send-email-tanayabh@gmail.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84Kt-0006HM-B6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761112AbaGRJUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:20:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59857 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761100AbaGRJT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:19:57 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so5077423pac.4
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mOcTDOUcFWesZg9YyGrhUkAitG3Wu/spBfItMD6fbAA=;
        b=Hw6ozyMf8Gi2xLj8rKxqlh4ED7GYXUDdvmxK1k8NrOB9OmZF7ZVrAVXUPN/TwNfUkj
         naFPYScYTx9AxxYaNBPzqyw7FXBxRgCiyV4Y2+laSs9UIFrZKDZK4uZnG5NZS6TijJBD
         ikplxjz4mDqcEZYvG5wbix8KwPnxl1l4c2RcccZX3YjM8NH4GyrY++yIabYuVJi34F4c
         PVYstCyXQzMAMU/N7r/o1Sfa1NmhY94DIRtrBNWbhih8hbeevCcKrS0L3thdRj/K8LlH
         x7LZYKYmrMpTb7izqZ6fZlbtkNqC1Gc7mo21zRPOvyY9I5+0xYWEwEB3nZeOFXGTdcxS
         0zHg==
X-Received: by 10.67.15.40 with SMTP id fl8mr3278045pad.69.1405675197462;
        Fri, 18 Jul 2014 02:19:57 -0700 (PDT)
Received: from localhost.localdomain ([106.203.84.80])
        by mx.google.com with ESMTPSA id wn7sm20813928pab.18.2014.07.18.02.19.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:19:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253802>

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
~/.gitconfig, XDG config and the global /etc/gitconfig). `the_config_set`
is populated using `git_config()`.

Add two external functions `git_config_get_value` and 
`git_config_get_value_multi` for querying in a non-callback manner from
`the_config_set`. Also, add type specific query functions that are
implemented as a thin wrapper around the `config_set` API.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 137 +++++++++++++++++
 cache.h                                |  30 ++++
 config.c                               | 263 +++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..8a86e45 100644
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
+	Resets and invalidates the config cache.
+
+The config API also provides type specific API functions which do conversion
+as well as retrieval for the queried variable, including:
+
+`int git_config_get_int(const char *key, int *dest)`::
+
+	Finds and parses the value to an integer for the configuration variable
+	`key`. Dies on error; otherwise, stores the value of the parsed integer in
+	`dest` and returns 0. When the configuration variable `key` is not found,
+	returns 1 without touching `dest`.
+
+`int git_config_get_ulong(const char *key, unsigned long *dest)`::
+
+	Similar to `git_config_get_int` but for unsigned longs.
+
+`int git_config_get_bool(const char *key, int *dest)`::
+
+	Finds and parses the value into a boolean value, for the configuration
+	variable `key` respecting keywords like "true" and "false". Integer
+	values are converted into true/false values (when they are non-zero or
+	zero, respectively). Other values cause a die(). If parsing is successful,
+	stores the value of the parsed result in `dest` and returns 0. When the
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
 
@@ -134,6 +209,68 @@ int read_file_with_include(const char *file, config_fn_t fn, void *data)
 `git_config` respects includes automatically. The lower-level
 `git_config_from_file` does not.
 
+Custom Configsets
+-----------------
+
+A `config_set` can be used to construct an in-memory cache for
+config-like files that the caller specifies (i.e., files like `.gitmodules`,
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
+	Initializes the config_set `cs`.
+
+`int git_configset_add_file(struct config_set *cs, const char *filename)`::
+
+	Parses the file and adds the variable-value pairs to the `config_set`,
+	dies if there is an error in parsing the file. Returns 0 on success, or
+	-1 if the file does not exist or is inaccessible. The user has to decide
+	if he wants to free the incomplete configset or continue using it when
+	the function returns -1.
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
 
diff --git a/cache.h b/cache.h
index 92fc9f1..e53651c 100644
--- a/cache.h
+++ b/cache.h
@@ -1348,6 +1348,36 @@ extern int parse_config_key(const char *var,
 			    const char **subsection, int *subsection_len,
 			    const char **key);
 
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
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.c b/config.c
index ba882a1..fe9f399 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "hashmap.h"
+#include "string-list.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -33,10 +35,23 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };
 
+struct config_set_element {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
 static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+/*
+ * Default config_set that contains key-value pairs from the usual set of config
+ * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
+ * config file and the global /etc/gitconfig)
+ */
+static struct config_set the_config_set;
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -1212,6 +1227,251 @@ int git_config(config_fn_t fn, void *data)
 	return git_config_with_options(fn, data, NULL, 1);
 }
 
+static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+{
+	struct config_set_element k;
+	struct config_set_element *found_entry;
+	char *normalized_key;
+	int ret;
+	/*
+	 * `key` may come from the user, so normalize it before using it
+	 * for querying entries from the hashmap.
+	 */
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = normalized_key;
+	found_entry = hashmap_get(&cs->config_hash, &k, NULL);
+	free(normalized_key);
+	return found_entry;
+}
+
+static int configset_add_value(struct config_set *cs, const char *key, const char *value)
+{
+	struct config_set_element *e;
+	e = configset_find_element(cs, key);
+	/*
+	 * Since the keys are being fed by git_config*() callback mechanism, they
+	 * are already normalized. So simply add them without any further munging.
+	 */
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		string_list_init(&e->value_list, 1);
+		hashmap_add(&cs->config_hash, e);
+	}
+	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	return 0;
+}
+
+static int config_set_element_cmp(const struct config_set_element *e1,
+				 const struct config_set_element *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+void git_configset_init(struct config_set *cs)
+{
+	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
+	cs->hash_initialized = 1;
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	struct config_set_element *entry;
+	struct hashmap_iter iter;
+	if (!cs->hash_initialized)
+		return;
+
+	hashmap_iter_init(&cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 0);
+	}
+	hashmap_free(&cs->config_hash, 1);
+	cs->hash_initialized = 0;
+}
+
+static int config_set_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set *cs = cb;
+	configset_add_value(cs, key, value);
+	return 0;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return git_config_from_file(config_set_callback, filename, cs);
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	const struct string_list *values = NULL;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset, the value returned will be the last
+	 * value in the value list for that key.
+	 */
+	values = git_configset_get_value_multi(cs, key);
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
+	struct config_set_element *e = configset_find_element(cs, key);
+	return e ? &e->value_list : NULL;
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
+static void git_config_check_init(void)
+{
+	if (the_config_set.hash_initialized)
+		return;
+	git_configset_init(&the_config_set);
+	git_config(config_set_callback, &the_config_set);
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set.hash_initialized)
+		return;
+	git_configset_clear(&the_config_set);
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
+
 /*
  * Find all the stuff for git_config_set() below.
  */
@@ -1707,6 +1967,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
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
