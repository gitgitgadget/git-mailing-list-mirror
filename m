From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC] config: Add config sets for config parsing & retrieval
Date: Fri, 27 Jun 2014 11:04:45 -0700
Message-ID: <1403892285-9878-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 20:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0aXW-0002ap-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 20:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaF0SGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 14:06:18 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45535 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbaF0SGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 14:06:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so4889781pac.11
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=483fQIRTPTeZmH4GuO51kiXg+TdsHgt7ahAaARZ1/sg=;
        b=Kb78YrkHJJSvHo9E54lXZiVav7+h2ViUddinwg7h2ol4kt9Q52Z7heNmvS8l+eoSmm
         wGl47XCelcpj3b8LIYKiNBmldx8k0dkBi+8LIwHceR9p3gUoFxkSKB0MbfTGJBdG/Plk
         xhY0053+NRupKTY6Z4ZCMIoyWBLsv8lAcnG1HT7OE2Na6yr5RzWXg3j41Tolif7UjFu9
         UigpU+Y/2eKWENyPO7dO2DNZrdKszFklu3YgDCoq7569ZN8rzpX8MRjKc9P2alk1Tvi7
         wwXWeaIed00yMF6kNTrq9eaYl/ANVITCOZafwKRfW5Wx1Ocp3YcfRsgEPdkXCObbuIyv
         1UBQ==
X-Received: by 10.66.175.166 with SMTP id cb6mr32165916pac.128.1403892375487;
        Fri, 27 Jun 2014 11:06:15 -0700 (PDT)
Received: from localhost.localdomain ([117.254.219.18])
        by mx.google.com with ESMTPSA id su8sm15761736pbc.72.2014.06.27.11.06.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 11:06:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252567>

Add a hash table to cache all key-value pairs read from config files
(repo specific .git/config, user wide ~/.gitconfig and the global
/etc/gitconfig). Add two external functions `git_config_get_string` and
`git_config_get_string_multi` for querying in a non-callback manner from the
hash table.

Add a way to construct custom config sets which contain multiple config
files cached as hashmaps for value retrieval.
---

*NOTE*

Please ignore the commit message and the documentation. This is a WIP. This patch
implements the user facing API which was discussed thoroughly in discussion thread[1].
A more polished patch will land next week, this patch is just to give a feel for what
I inferred from the discussion.

API functions:

1. int git_config_get_value(char *k, char **v): The most generic function, traverses
the usual config functions for values. (internally uses the the_config_set struct)

2. int git_configset_get_value_from(const char *key, const char **value,
			 	const char *filename, struct config_set *cs)
For usage of this function, see the example given below.

Most of the extra API functions will be constructed on the top of this patch.
Workflow for custom config_set works like this,

	char *value;
	struct config_set gm_config = {NULL, 0 ,0};
	git_configset_add_file(".gitmodule", &gm_config);
	/* Add other files similarly */
	git_configset_get_value_from(key, &value, ".gitmodule", &gm_config);
	/* Work on config values free the set when done */
	git_configset_clear(&gm_config);

I have tested the workflow and it works fine. :)

Now, about helper functions, if I add new helper functions for get_ family like
git_config_get_string, git_config_get_int and similar, won't the helper functions
in config.c would become redundant. Is it really necessary to write new
helper functions for the non-callback code, instead of reusing the older ones?

[1]: http://marc.info/?t=140351850200001&r=1&w=2

Cheers,
Tanay Abhra.

 Documentation/technical/api-config.txt |  26 +++++
 cache.h                                |   2 +
 config.c                               | 182 +++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

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
index a1aef1c..332d92e 100644
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
@@ -37,6 +39,180 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+struct config_hash_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+struct config_set {
+	struct config_set_item *item;
+	unsigned int nr, alloc;
+};
+
+struct config_set_item {
+	struct hashmap config_hash;
+	char *filename;
+	int hashmap_initialized;
+};
+
+static struct config_set_cb {
+	struct config_set *cs;
+	struct config_set_item *ct;
+};
+
+static struct config_set the_config_set;
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
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set_cb *c = cb;
+	config_hash_add_value(key, value, c->ct, c->cs);
+	return 0;
+}
+
+static struct hashmap *get_config_hash(const char *filename, struct config_set *cs)
+{
+	int i;
+	struct config_set_item *ct;
+	struct config_set_cb cb;
+	for(i = 0; i < cs->nr; i++) {
+		if (!strcmp(cs->item[i].filename, filename))
+			return &cs->item[i].config_hash;
+	}
+
+	ALLOC_GROW(cs->item, cs->nr + 1, cs->alloc);
+	ct = &cs->item[cs->nr++];
+	ct->filename = xstrdup(filename);
+	config_hash_init(&ct->config_hash);
+	ct->hashmap_initialized = 1;
+	cb.cs = cs;
+	cb.ct = ct;
+	/*
+	 * When filename is "default", hashmap is constructed from the usual set of
+	 * config files (i.e repo specific .git/config, user wide ~/.gitconfig and the
+	 * global /etc/gitconfig)
+	 */
+	if (!strcmp(filename, "default"))
+		git_config(config_hash_callback, &cb);
+	else
+		git_config_from_file(config_hash_callback, filename, &cb);
+
+	return &ct->config_hash;
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
+		string_list_init_dup(&e->value_list);
+		hashmap_add(config_hash, e);
+	}
+	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	return 0;
+}
+
+int git_configset_get_value_from(const char *key, const char **value,
+				 const char *filename, struct config_set *cs)
+{
+	struct string_list *values;
+	values = config_hash_get_value(key, filename, cs);
+	if (!values)
+		return -1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	return 0;
+}
+
+int git_config_get_value(const char *key, const char **value)
+{
+	return git_configset_get_value_from(key, value, "default", &the_config_set);
+}
+
+const struct string_list *git_config_get_value_multi(const char *key)
+{
+	return config_hash_get_value(key, "default", &the_config_set);
+}
+
+const struct string_list *git_configset_get_value_multi_from(const char *key, const char* filename,
+							struct config_set *cs)
+{
+	return config_hash_get_value(key, filename, cs);
+}
+
+void git_configset_add_file(char *filename, struct config_set *cs)
+{
+	get_config_hash(filename, cs);
+}
+
+void git_configset_clear(struct config_set *cs)
+{
+	int i;
+	struct hashmap *config_hash;
+	struct config_hash_entry *entry;
+	struct hashmap_iter iter;
+	for (i = 0; i < cs->nr; i++) {
+		config_hash = &cs->item[i].config_hash;
+		free(cs->item[i].filename);
+		cs->item[i].hashmap_initialized = 0;
+		hashmap_iter_init(config_hash, &iter);
+		while ((entry = hashmap_iter_next(&iter))) {
+			free(entry->key);
+			string_list_clear(&entry->value_list, 0);
+		}
+		hashmap_free(config_hash, 1);
+	}
+}
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -1708,6 +1884,12 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;
 
+	/*
+	 * content of config file has changed, so invalidate the
+	 * config cache used by non-callback based query functions.
+	 */
+	git_configset_clear(&the_config_set);
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 
1.9.0.GIT
