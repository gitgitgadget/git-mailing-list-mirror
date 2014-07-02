From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Tue,  1 Jul 2014 23:01:44 -0700
Message-ID: <1404280905-26763-2-git-send-email-tanayabh@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 08:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2DdB-0003NL-Go
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 08:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbaGBGCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 02:02:53 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47890 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaGBGCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 02:02:52 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so11922725pad.37
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SV+0V/ICnSQ5pUpV+TmWA0OtQY2unsaJA28xUymQFlQ=;
        b=rwi3AAkC1Wql9CVlkBputca6ifeEv0/Ek7ZXQXrjVJsdrTwDmVx4pE1GiwtHhnEdyP
         cxRME7DOM7FuE9XQ/g7CBzBOg4z8Nm7mJsEP9a3L2AxynVkMwQKfU9XMbTRY0hVI17c1
         4a+/IVK3Hu5Bb7P7iE/nC2fq7f9P1dtO2o0OqLqxIYIpaedHodBUHdAkCpqfMxTRW9Kr
         MDuWGXuVV70cDt8b/Z1zLDfZNjin252udaJGzLKtbThB5Ha9c5mFlzFVoHDt7c7ZJKAu
         of9w7iunPqp+mL/suRduAMyFLAv0+qOUWGsNO/kzQrCsXJtMGyuVAleJ77EQQJcLXdJ7
         BlBA==
X-Received: by 10.68.190.231 with SMTP id gt7mr39903372pbc.148.1404280971806;
        Tue, 01 Jul 2014 23:02:51 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.26])
        by mx.google.com with ESMTPSA id ek2sm35417795pbd.30.2014.07.01.23.02.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 23:02:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252768>

Currently `git_config()` uses a callback mechanism and file rereads for
config values. Due to this approach, it is not uncommon for the config
files to be parsed several times during the run of a git program, with
different callbacks picking out different variables useful to themselves.

Add a `config_set` construct that points to an ordered set of config files
specified by the user, each of which represents what was read and cached
in core as hashmaps. Add two external functions `git_configset_get_value`
and `git_configset_get_value_multi` for querying from the config sets,
which follow `last one wins` semantic(i.e. if there are multiple matches
for the queried key in the files of the configset the value returned will
the last value in the last matching file of the configset) Add type
specific query functions like `git_configset_get_bool` and similar.

Add a default `config_set`, `the_config_set` to cache all key-value pairs
read from usual config files(repo specific .git/config, user wide
~/.gitconfig and the global /etc/gitconfig). `the_config_set` uses a
single hashmap populated using git_config(). The reason for doing so is
twofold, one is to honour include directives, another is to guarantee O(1)
lookups for usual config values, as values are queried for hundred of
times during a run of a git program.
Add two external functions `git_config_get_value` and 
`git_config_get_value_multi` for querying in a non-callback manner from
`the_config_set`. Also, add type specific query functions that are
implemented as a thin wrapper around the `config_set` API.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 144 ++++++++++++
 Makefile                               |   1 +
 cache.h                                |  41 ++++
 config-hash.c                          | 405 +++++++++++++++++++++++++++++++++
 config.c                               |   3 +
 5 files changed, 594 insertions(+)
 create mode 100644 config-hash.c

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..2c02fee 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,75 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying For Specific Variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non-callback
+manner, the config API provides two functions `git_config_get_value`
+and `git_config_get_value_multi`.They both read values from an internal
+cache generated previously from reading the config files.
+
+`git_config_get_value` takes two parameters,
+
+- a key string in canonical flat form for which the corresponding value
+  with the highest priority (i.e. value in the repo config will be
+  preferred over value in user wide config for the same variable) will
+  be retrieved.
+
+- a pointer to a string which will point to the retrieved value. The caller
+  should not free or modify the value returned as it is owned by the cache.
+
+`git_config_get_value` returns 0 on success, or -1 for no value found.
+
+`git_config_get_value_multi` allocates and returns a `string_list`
+containing all the values for the key passed as parameter, sorted in order
+of increasing priority (Note: caller has to call `string_list_clear` on
+the returned pointer and then free it).
+
+`git_config_get_value_multi` returns NULL for no value found.
+
+`git_config_clear` is provided for resetting and invalidating the cache.
+
+`git_config_iter` gives a way to iterate over the keys in cache. Existing
+`git_config` callback function signature is used for iterating.
+
+The config API also provides type specific API functions which do conversion
+as well as retrieval for the queried variable, including:
+
+`git_config_get_int`::
+Parse the retrieved value to an integer, including unit factors. Dies on
+error; otherwise, allocates and copies the integer into the dest parameter.
+Returns 0 on success, or 1 if no value was found.
+
+`git_config_get_ulong`::
+Identical to `git_config_get_int` but for unsigned longs.
+
+`git_config_bool`::
+Parse the retrieved value into a boolean value, respecting keywords like
+"true" and "false". Integer values are converted into true/false values
+(when they are non-zero or zero, respectively). Other values cause a die().
+If parsing is successful, allocates and copies the result into the dest
+parameter. Returns 0 on success, or 1 if no value is found.
+
+`git_config_get_bool_or_int`::
+Same as `git_config_get_bool`, except that integers are copied as-is, and
+an `is_bool` flag is unset.
+
+`git_config_get_maybe_bool`::
+Same as `git_config_get_bool`, except that it returns -1 on error rather
+than dying.
+
+`git_config_get_string`::
+Allocates and copies the retrieved value string into the `dest` parameter;
+if NULL string is given, prints an error message and returns -1. Returns 1,
+if no value is found for the queried variable .
+
+`git_config_get_pathname`::
+Similar to `git_config_get_string`, but expands `~` or `~user` into the
+user's home directory when found at the beginning of the path.
+
+See test-config.c for usage examples.
+
 Value Parsing Helpers
 ---------------------
 
@@ -134,6 +203,81 @@ int read_file_with_include(const char *file, config_fn_t fn, void *data)
 `git_config` respects includes automatically. The lower-level
 `git_config_from_file` does not.
 
+Custom Configsets
+-----------------
+
+A `config_set` points at an ordered set of config files, each of
+which represents what was read and cached in-core from a file.
+It can be used to construct an in-memory cache for config files that
+the caller specifies. For example,
+
+---------------------------------------
+struct config_set gm_config = CONFIG_SET_INIT;
+int b;
+/* we add config files to the config_set */
+git_configset_add_file(&gm_config, ".gitmodules");
+git_configset_add_file(&gm_config, ".gitmodules_alt");
+
+if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
+/* hack hack hack */
+}
+
+/* when we are done with the configset */
+git_configset_clear(&gm_config);
+----------------------------------------
+
+Configset API provides functions for the above mentioned work flow, including:
+
+`git_configset_init`::
+
+Returns an allocated and initialized struct `config_set` pointer.
+
+`git_configset_add_file`::
+
+Parses the file and constructs an in core cache which is appended at the end of
+the config_set, dies if there is an error in parsing the file.
+
+`git_configset_get_value`::
+
+Follows "last one wins" semantic, i.e., if there are multiple matches for the
+queried key in the files of the configset the value returned will the last value
+in the last matching file of the configset.
+
+It takes three parameters,
+
+- the `config_set` from which the value will be queried.
+
+- a key string in canonical flat form
+
+- a pointer to a string which will point to the retrieved value. The caller
+  should not free or modify the value returned as it is owned by the cache.
+
+`git_configset_get_value` returns 0 on success, or -1 for no value found.
+
+`git_configset_get_value_multi`::
+
+`git_configset_get_value_multi` allocates and returns a `string_list`
+containing all the values for the key passed as parameter, sorted in order
+of increasing priority (Note: caller has to call `string_list_clear` on
+the returned pointer and then free it).
+
+`git_configset_get_value_multi` returns NULL for no value found.
+
+'git_configset_iter'::
+
+It gives a way to iterate over the keys in config_set.
+Existing `git_config` callback function signature is used for iterating.
+
+`git_configset_clear`::
+It is used to clear the config_set after use. If the `config_set` was dynamically
+allocated using `git_configset_init`, the caller has to free the `config_set`
+after calling `git_configset_clear`.
+
+In addition to above the config_set API provides type specific functions in the
+vein of `git_config_get_int` but with an extra parameter, `config_set`. They
+all behave similarly to the `git_config_get*()` family described in
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
index df65231..005e945 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "string-list.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1325,6 +1326,46 @@ extern int parse_config_key(const char *var,
 			    const char **subsection, int *subsection_len,
 			    const char **key);
 
+/* config-hash.c */
+#define CONFIG_SET_INIT { NULL, 0, 0 }
+
+struct config_set {
+	struct config_set_item *item;
+	unsigned int nr, alloc;
+};
+
+struct config_set_item {
+	struct hashmap config_hash;
+	char *filename;
+};
+
+extern struct config_set *git_configset_init(void);
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
index 0000000..3e45d03
--- /dev/null
+++ b/config-hash.c
@@ -0,0 +1,405 @@
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
+static int the_config_set_initialised = 0;
+
+struct config_hash_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+static int config_hash_add_value(const char *, const char *,
+				  struct config_set_item *, struct config_set *);
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
+struct config_set_cb {
+	struct config_set *cs;
+	struct config_set_item *ct;
+};
+
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set_cb *c = cb;
+	config_hash_add_value(key, value, c->ct, c->cs);
+	return 0;
+}
+
+static struct hashmap *add_config_hash(const char *filename, struct config_set *cs)
+{
+	int ret = 0;
+	struct config_set_item *ct;
+	struct config_set_cb cb;
+	ALLOC_GROW(cs->item, cs->nr + 1, cs->alloc);
+	ct = &cs->item[cs->nr++];
+	ct->filename = xstrdup(filename);
+	config_hash_init(&ct->config_hash);
+	cb.cs = cs;
+	cb.ct = ct;
+	/*
+	 * When filename is "default", hashmap is constructed from the usual set of
+	 * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
+	 * global /etc/gitconfig), used in `the_config_set`
+	 */
+	if (!strcmp(filename, "default"))
+		git_config(config_hash_callback, &cb);
+	else
+		ret = git_config_from_file(config_hash_callback, filename, &cb);
+	if (!ret)
+		return &ct->config_hash;
+	else {
+		free(ct->filename);
+		hashmap_free(&ct->config_hash, 1);
+		cs->nr--;
+		return NULL;
+	}
+}
+
+static struct hashmap *get_config_hash(const char *filename, struct config_set *cs)
+{
+	int i;
+	for(i = 0; i < cs->nr; i++) {
+		if (!strcmp(cs->item[i].filename, filename))
+			return &cs->item[i].config_hash;
+	}
+	return add_config_hash(filename, cs);
+}
+
+static struct config_hash_entry *config_hash_find_entry(const char *key, const char* filename,
+							struct config_set *cs)
+{
+	struct hashmap *config_hash;
+	struct config_hash_entry k;
+	struct config_hash_entry *found_entry;
+	char *normalized_key;
+	int ret;
+	config_hash = get_config_hash(filename, cs);
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
+static struct string_list *config_hash_get_value(const char *key, const char* filename, 
+						 struct config_set *cs)
+{
+	struct config_hash_entry *e = config_hash_find_entry(key, filename, cs);
+	return e ? &e->value_list : NULL;
+}
+
+static int config_hash_add_value(const char *key, const char *value,
+				 struct config_set_item *ct, struct config_set *cs)
+{
+	struct hashmap *config_hash = &ct->config_hash;
+	struct config_hash_entry *e;
+	e = config_hash_find_entry(key, ct->filename, cs);
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
+	 * are already normalised. So simply add them without any further munging.
+	 */
+	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	return 0;
+}
+
+struct config_set *git_configset_init(void)
+{
+	struct config_set *cs = xcalloc(1, sizeof(*cs));
+	return cs;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return get_config_hash(filename, cs) ? 0 : -1;
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	int i;
+	struct string_list *values = NULL;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset the value returned will the last value
+	 * in the last matching file of the configset
+	 */
+	assert(cs->nr > 0);
+	for (i = cs->nr-1; i >= 0; i--) {
+		values = config_hash_get_value(key, cs->item[i].filename, cs);
+		if (values)
+			break;
+	}
+	if (!values)
+		return -1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	return 0;
+}
+
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+{
+	int i, j;
+	struct string_list *values = NULL;
+	struct string_list *retval = xcalloc(1, sizeof(*retval));
+	for (i = 0; i < cs->nr; i++) {
+		values = config_hash_get_value(key, cs->item[i].filename, cs);
+		if (values)
+			for(j = 0; j < values->nr; j++)
+				string_list_append_nodup(retval, values->items[j].string);
+	}
+	if (!retval->nr) {
+		free(retval);
+		return NULL;
+	}
+	return retval;
+}
+
+/*
+ * Uses the existing git_config() callback function signature to iterate over
+ * keys in the configset.
+ */
+void git_configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i;
+	char *value;
+	struct string_list *strptr;
+	struct config_hash_entry *entry;
+	struct hashmap *config_hash;
+	struct hashmap_iter iter;
+	for (i = 0; i < cs->nr; i++) {
+		config_hash = &cs->item[i].config_hash;
+		hashmap_iter_init(config_hash, &iter);
+		while ((entry = hashmap_iter_next(&iter))) {
+			strptr = &entry->value_list;
+			for (i = 0; i < strptr->nr; i++) {
+				value = strptr->items[i].string;
+				fn(entry->key, value, data);
+			}
+		}
+	}
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	int i;
+	struct hashmap *config_hash;
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	/* No files in config_set so return */
+	if (!cs->nr)
+		return;
+	for (i = 0; i < cs->nr; i++) {
+		config_hash = &cs->item[i].config_hash;
+		free(cs->item[i].filename);
+		hashmap_iter_init(config_hash, &iter);
+		while ((entry = hashmap_iter_next(&iter))) {
+			free(entry->key);
+			string_list_clear(&entry->value_list, 0);
+		}
+		hashmap_free(config_hash, 1);
+	}
+	free(cs->item);
+	cs->item = NULL;
+	cs->nr = cs->alloc = 0;
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
+int git_config_get_value(const char *key, const char **value)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_value(&the_config_set, key, value);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_value_multi(&the_config_set, key);
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set_initialised)
+		return;
+	git_configset_clear(&the_config_set);
+	the_config_set_initialised = 0;
+}
+
+void git_config_iter(config_fn_t fn, void *data)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	git_configset_iter(&the_config_set, fn, data);
+}
+
+int git_config_get_string(const char *key, const char **dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_string(&the_config_set, key, dest);
+}
+
+int git_config_get_int(const char *key, int *dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_int(&the_config_set, key, dest);
+}
+
+int git_config_get_ulong(const char *key, unsigned long *dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_ulong(&the_config_set, key, dest);
+}
+
+int git_config_get_bool(const char *key, int *dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_bool_or_int(&the_config_set, key, is_bool, dest);
+}
+
+int git_config_get_maybe_bool(const char *key, int *dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
+	return git_configset_get_maybe_bool(&the_config_set, key, dest);
+}
+
+int git_config_get_pathname(const char *key, const char **dest)
+{
+	if (!the_config_set_initialised) {
+		git_configset_add_file(&the_config_set, "default");
+		the_config_set_initialised = 1;
+	}
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
