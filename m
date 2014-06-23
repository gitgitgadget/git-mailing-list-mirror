From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 03:11:39 -0700
Message-ID: <1403518300-23053-3-git-send-email-tanayabh@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1Fa-0001uH-P8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbaFWKNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:13:18 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39378 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaFWKNR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:13:17 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so5440571pdj.8
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Axxw3tbPkDnOajsV1yezhjZMkiBGCHW5k6GInVy7CeQ=;
        b=FSll02jpk9UWUmw5oMsayJDSMENzudSe5fpNnWTa5P8XcwNUxVN0BxFGWvCAicRLR6
         iwxeNQOfT4kpKwsBJ7JpmpouGW8QraY3ZYDEYBJz7LkaZjhAVYG15jeBoKhr8hubFoCa
         JPww2GXyazn2JYfBS3U0K713tXaKAi/yY6s5lhQ9ovRdEXJdzFRCdS2OXwQFeIuQJR40
         QjoL+gSV26eUCHwL0P4HKefYMFaFLFkk1+oKRnC4pqpcGVj5twONmhEm902tWT3x8UYw
         m2NxG5jWctv+NHLcwBRuCFMPJdLQ5QBgEb93fzTEsL1BhewO27KmRwp0HAhd5QOsHanY
         FYiw==
X-Received: by 10.68.225.74 with SMTP id ri10mr27699103pbc.116.1403518397330;
        Mon, 23 Jun 2014 03:13:17 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id io8sm26085321pbc.96.2014.06.23.03.13.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:13:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252330>

Currently `git_config()` uses a callback mechanism and file rereads for
config values. Due to this approach, it is not uncommon for the config
files to be parsed several times during the run of a git program, with
different callbacks picking out different variables useful to themselves.

Add a hash table to cache all key-value pairs read from config files
(repo specific .git/config, user wide ~/.gitconfig and the global
/etc/gitconfig). Add two external functions `git_config_get_string` and
`git_config_get_string_multi` for querying in a non-callback manner from the
hash table. They support O(1) lookups once the hash table is constructed.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt |  26 ++++++
 cache.h                                |   2 +
 config.c                               | 144 +++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..13f3f40 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,32 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying For Specific Variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non-callback
+manner, the config API provides two functions `git_config_get_string`
+and `git_config_get_string_multi`.They both read values from an internal
+cache generated previously from reading the config files.
+
+`git_config_get_string` takes two parameters,
+
+- a key string in canonical flat form for which the corresponding value
+  with the highest priority (i.e. value in the repo config will be
+  preferred over value in user wide config for the same variable) will
+  be retrieved.
+
+- a pointer to a string which will point to the retrieved value.
+
+`git_config_get_string` returns 0 for success, or -1 for no value found.
+
+`git_config_get_string_multi` returns a `string_list` containing all the
+values for the key passed as parameter, sorted in order of increasing
+priority (Note: NULL values are flagged as 1, check `util` for each
+'string_list_item` for flag value).
+
+See test-config.c for usage examples.
+
 Value Parsing Helpers
 ---------------------
 
diff --git a/cache.h b/cache.h
index cbe1935..fec0a63 100644
--- a/cache.h
+++ b/cache.h
@@ -1294,6 +1294,8 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
+extern int git_config_get_string(const char *, const char **);
+extern const struct string_list *git_config_get_string_multi(const char *);
 #if defined(__GNUC__)
 #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
 #endif
diff --git a/config.c b/config.c
index a1aef1c..6200f36 100644
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
@@ -37,6 +39,141 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+struct config_cache_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+static int hashmap_initialized;
+
+static int config_cache_add_value(const char *key, const char *value);
+
+static int config_cache_entry_cmp(const struct config_cache_entry *e1,
+				 const struct config_cache_entry *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+static void config_cache_init(struct hashmap *config_cache)
+{
+	hashmap_init(config_cache, (hashmap_cmp_fn)config_cache_entry_cmp, 0);
+}
+
+static int config_cache_callback(const char *key, const char *value, void *unused)
+{
+	config_cache_add_value(key, value);
+	return 0;
+}
+
+static struct hashmap *get_config_cache(void)
+{
+	static struct hashmap config_cache;
+	if (!hashmap_initialized) {
+		config_cache_init(&config_cache);
+		hashmap_initialized = 1;
+		git_config(config_cache_callback, NULL);
+	}
+	return &config_cache;
+}
+
+static void config_cache_free(void)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry *entry;
+	struct hashmap_iter iter;
+	config_cache = get_config_cache();
+	hashmap_iter_init(config_cache, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		free(entry->key);
+		string_list_clear(&entry->value_list, 1);
+	}
+	hashmap_free(config_cache, 1);
+	hashmap_initialized = 0;
+}
+
+static struct config_cache_entry *config_cache_find_entry(const char *key)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry k;
+	struct config_cache_entry *found_entry;
+	char *normalized_key;
+	int ret;
+	config_cache = get_config_cache();
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = normalized_key;
+	found_entry = hashmap_get(config_cache, &k, NULL);
+	free(normalized_key);
+	return found_entry;
+}
+
+static struct string_list *config_cache_get_value(const char *key)
+{
+	struct config_cache_entry *e = config_cache_find_entry(key);
+	return e ? &e->value_list : NULL;
+}
+
+static int config_cache_add_value(const char *key, const char *value)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry *e;
+	struct string_list_item *item;
+	int *boolean_null_flag;
+
+	config_cache = get_config_cache();
+	e = config_cache_find_entry(key);
+
+	boolean_null_flag = xcalloc(1, sizeof(*boolean_null_flag));
+
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		string_list_init_dup(&e->value_list);
+		hashmap_add(config_cache, e);
+	}
+	/*
+	 * If the variable had no value specified, the value will be NULL
+	 * (typically this means it should be interpreted as boolean true).
+	 * For such values, silently convert them to "BOOLEAN_NULL" to
+	 * store in hashmap and flag that string_list_item as 1.
+	 */
+	if (value == NULL) {
+		value = "BOOLEAN_NULL";
+		*boolean_null_flag = 1;
+	}
+	item = string_list_append(&e->value_list, value);
+	item->util = boolean_null_flag;
+
+	return 0;
+}
+
+int git_config_get_string(const char *key, const char **value)
+{
+	struct string_list *values;
+	int *flag;
+	values = config_cache_get_value(key);
+	if (!values)
+		return -1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	flag = values->items[values->nr - 1].util;
+	if (*flag)
+		*value = NULL;
+	return 0;
+}
+
+/* for NULL values, 'util' for each `string_list_item` is flagged as 1 */
+const struct string_list *git_config_get_string_multi(const char *key)
+{
+	return config_cache_get_value(key);
+}
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -1708,6 +1845,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;
 
+	/*
+	 * content of config file has changed, so invalidate the
+	 * config cache used by non-callback based query functions.
+	 */
+	if (hashmap_initialized)
+		config_cache_free();
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 
1.9.0.GIT
