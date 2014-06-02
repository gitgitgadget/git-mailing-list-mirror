From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH v2 1/2] config: Add hashtable for config parsing & retrieval
Date: Mon,  2 Jun 2014 07:47:39 -0700
Message-ID: <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 16:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrTY6-0007jX-D2
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 16:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbaFBOtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 10:49:10 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:44900 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbaFBOtI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 10:49:08 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so4310877pbb.11
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ux2LDmOHLPEpQ5NBncyi5XmQULSRrFPA8UF83dS413Q=;
        b=DLE/RIXMn0E04c1krqQSM8x5mCK4pT5D6meVzWpvnYNyObITf7k1ZYMzSM1e4YqJTZ
         /HEHahjZ9Dw2BPIpMSYtYkV+285UbiEV+/srYLIGreys/uZSVvaXPc5OkjbaemqNzdm7
         uZyLdasSm/AY68+OpsyauMeoBO1T5eEvOGWuTnS833mtGIwdeGyj3Bii3JBgXKr4bjIR
         E5aHKMvfpoONqelWTqCNNwGadiC1ufF58/XUQPRK+zGo8bR0jJfjHkmqDdv8NvW+VfMj
         ZohyEudaNqNwNS8nV5YUrDh9+mcWWMWfvzsE6Doqz38/q3PVzrYbz57v5l1QtfNGT6ye
         JixQ==
X-Received: by 10.68.164.4 with SMTP id ym4mr40804953pbb.53.1401720547704;
        Mon, 02 Jun 2014 07:49:07 -0700 (PDT)
Received: from localhost.localdomain ([117.254.216.65])
        by mx.google.com with ESMTPSA id ja8sm20927802pbd.3.2014.06.02.07.48.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 07:49:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250567>

Add a hash table to cache all key-value pairs read from config files
(repo specific .git/config, user wide ~/.gitconfig and the global
/etc/gitconfig). Add two external functions `git_config_get_string` and
`git_config_get_string_multi` for querying in a non-callback manner from the
hash table.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h  |   2 ++
 config.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/cache.h b/cache.h
index 107ac61..2038150 100644
--- a/cache.h
+++ b/cache.h
@@ -1271,6 +1271,8 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
+extern const char *git_config_get_string(const char *);
+extern const struct string_list *git_config_get_string_multi(const char *);
 #if defined(__GNUC__) && ! defined(__clang__)
 #define config_error_nonbool(s) (config_error_nonbool(s), -1)
 #endif
diff --git a/config.c b/config.c
index a30cb5c..23c9403 100644
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
@@ -37,6 +39,112 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+static struct hashmap config_cache;
+
+struct config_cache_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list *value_list;
+};
+
+static int hashmap_is_init = 0;
+
+static int config_cache_entry_cmp_icase(const struct config_cache_entry *e1,
+				 const struct config_cache_entry *e2, const char* key)
+{
+	return strcasecmp(e1->key, key ? key : e2->key);
+}
+
+static void config_cache_init(void)
+{
+	hashmap_init(&config_cache, (hashmap_cmp_fn)config_cache_entry_cmp_icase, 0);
+}
+
+static void config_cache_free(void)
+{
+	struct config_cache_entry* entry;
+	struct hashmap_iter iter;
+	hashmap_iter_init(&config_cache, &iter);
+	while (entry = hashmap_iter_next(&iter)) {
+		free(entry->key);
+		string_list_clear(entry->value_list, 0);
+	}
+	hashmap_free(&config_cache, 1);
+}
+
+static struct config_cache_entry *config_cache_find_entry(const char *key)
+{
+	struct hashmap_entry k;
+	hashmap_entry_init(&k, strihash(key));
+	return hashmap_get(&config_cache, &k, key);
+}
+
+static struct string_list *config_cache_get_value(const char *key)
+{
+	struct config_cache_entry *e = config_cache_find_entry(key);
+	return e ? e->value_list : NULL;
+}
+
+
+static void config_cache_set_value(const char *key, const char *value)
+{
+	struct config_cache_entry *e;
+
+	e = config_cache_find_entry(key);
+	if (!e) {
+		e = malloc(sizeof(*e));
+		hashmap_entry_init(e, strihash(key));
+		e->key=xstrdup(key);
+		e->value_list = xcalloc(sizeof(struct string_list), 1);
+		e->value_list->strdup_strings = 1;
+		string_list_append(e->value_list, value);
+		hashmap_add(&config_cache, e);
+	} else {
+		if (!unsorted_string_list_has_string(e->value_list, value))
+			string_list_append(e->value_list, value);
+	}
+}
+
+static void config_cache_remove_value(const char *key, const char *value)
+{
+	struct config_cache_entry *e;
+	int i;
+
+	e = config_cache_find_entry(key);
+	if(!e)
+		return;
+	/* If value == NULL then remove all the entries for the key */
+	if(!value) {
+		string_list_clear(e->value_list, 0);
+		free(e->value_list);
+		hashmap_remove(&config_cache, e, NULL);
+		return;
+	}
+	/* All the occurances of "value" will be deleted */
+	for (i = 0; i < e->value_list->nr; i++)
+		if (!strcmp(value, e->value_list->items[i].string))
+			unsorted_string_list_delete_item(e->value_list, i, 0);
+	if(e->value_list->nr == 0) {
+		string_list_clear(e->value_list, 0);
+		free(e->value_list);
+		hashmap_remove(&config_cache, e, NULL);
+	}
+}
+
+extern const char *git_config_get_string(const char *name)
+{
+	struct string_list *values;
+	values = config_cache_get_value(name);
+	if (!values)
+		return NULL;
+	return values->items[values->nr - 1].string;
+}
+
+extern const struct string_list *git_config_get_string_multi(const char *key)
+{
+	return config_cache_get_value(key);
+}
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -333,6 +441,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 		if (!value)
 			return -1;
 	}
+	config_cache_set_value(name->buf, value);
 	return fn(name->buf, value, data);
 }
 
@@ -1135,6 +1244,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 
+	if (!hashmap_is_init) {
+		config_cache_init();
+		hashmap_is_init = 1;
+	}
+
 	home_config_paths(&user_config, &xdg_config, "config");
 
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
@@ -1570,6 +1684,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		if (!store_write_section(fd, key) ||
 		    !store_write_pair(fd, key, value))
 			goto write_err_out;
+		else config_cache_set_value(key, value);
 	} else {
 		struct stat st;
 		char *contents;
@@ -1673,6 +1788,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			}
 			if (!store_write_pair(fd, key, value))
 				goto write_err_out;
+			else config_cache_set_value(key, value);
+		} else {
+			config_cache_remove_value(key, NULL);
 		}
 
 		/* write the rest of the config */
-- 
1.9.0.GIT
