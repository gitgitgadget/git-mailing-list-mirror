From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Mon,  9 Jun 2014 05:49:06 -0700
Message-ID: <1402318146-5062-2-git-send-email-tanayabh@gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 14:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtz3M-0000z4-T4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 14:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbaFIMvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 08:51:54 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54243 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbaFIMvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 08:51:48 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so717495pad.37
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RV+vaydIlpFUQQPqQc4y5tDukGZ1flZzeUL9A8/pwN4=;
        b=NGPghp65J1LipGjqh3qJx7qsrBB9ZhVhsObySdGaBqVs/bVUVzBdCeCP1bag4jsPAO
         ILjCzatbvKtTQ9/M86+xv7CLlKVOTNWeLip8D9E26PuHtij49YuADAsADJCOlY8mqN0N
         lZ1/cyGrX3E89TWzMD2HZKUY1/cH1G9e+5WdZr1mtCDFfCHZXlX0YpdjfEVgiH3irBIa
         hI1awieqDSq45zpKyokdevVZ+olTUgYhaNEE+khCxraw0d9J/hYW/uUSB79MqRsDshvM
         VQVxjS8qoH4slbD8HSevgL4CoslNRpFSc+7bnLZUwL03UVeYbhvnVd4ok38jy/ruLWAJ
         WOmg==
X-Received: by 10.66.148.230 with SMTP id tv6mr3309623pab.155.1402318308396;
        Mon, 09 Jun 2014 05:51:48 -0700 (PDT)
Received: from localhost.localdomain ([117.254.220.136])
        by mx.google.com with ESMTPSA id qw8sm63962212pbb.27.2014.06.09.05.51.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 05:51:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251074>

Add a hash table to cache all key-value pairs read from config files
(repo specific .git/config, user wide ~/.gitconfig and the global
/etc/gitconfig). Add two external functions `git_config_get_string` and
`git_config_get_string_multi` for querying in a non-callback manner from the
hash table.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt |  18 +++++
 cache.h                                |   2 +
 config.c                               | 122 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..5b6e376 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,24 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying For Specific Variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non-callback
+manner, the config API provides two functions `git_config_get_string`
+and `git_config_get_string_multi`. They both take a single parameter,
+
+- a key string in canonical flat form for which the corresponding values
+  will be retrieved and returned.
+
+They both read values from an internal cache generated previously from
+reading the config files. `git_config_get_string` returns the value with
+the highest priority(i.e. for the same variable value in the repo config
+will be preferred over value in user wide config).
+
+`git_config_get_string_multi` returns a `string_list` containing all the
+values for that particular key, sorted in order of increasing priority.
+
 Value Parsing Helpers
 ---------------------
 
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
index a30cb5c..6f6b04e 100644
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
@@ -37,6 +39,120 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+struct config_cache_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list *value_list;
+};
+
+static int hashmap_is_init;
+
+static int config_cache_set_value(const char *key, const char *value);
+
+static int config_cache_entry_cmp_case(const struct config_cache_entry *e1,
+				 const struct config_cache_entry *e2, const void *unused)
+{
+	return strcmp(e1->key, e2->key);
+}
+
+static void config_cache_init(struct hashmap *config_cache)
+{
+	hashmap_init(config_cache, (hashmap_cmp_fn) config_cache_entry_cmp_case, 0);
+}
+
+static int config_cache_callback(const char *key, const char *value, void *unused)
+{
+	config_cache_set_value(key, value);
+	return 0;
+}
+
+static struct hashmap *get_config_cache(void)
+{
+	static struct hashmap config_cache;
+	if (!hashmap_is_init) {
+		config_cache_init(&config_cache);
+		hashmap_is_init = 1;
+		git_config(config_cache_callback, NULL);
+		return &config_cache;
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
+		string_list_clear(entry->value_list, 0);
+	}
+	hashmap_free(config_cache, 1);
+	hashmap_is_init = 0;
+}
+
+static struct config_cache_entry *config_cache_find_entry(const char *key)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry k;
+	char *normalized_key;
+	int baselength = 0, ret;
+	config_cache = get_config_cache();
+	ret = git_config_parse_key(key, &normalized_key, &baselength);
+
+	if (ret)
+		return NULL;
+
+	hashmap_entry_init(&k, strhash(normalized_key));
+	k.key = (char*) key;
+	return hashmap_get(config_cache, &k, NULL);
+}
+
+static struct string_list *config_cache_get_value(const char *key)
+{
+	struct config_cache_entry *e = config_cache_find_entry(key);
+	return e ? e->value_list : NULL;
+}
+
+
+static int config_cache_set_value(const char *key, const char *value)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry *e;
+
+	config_cache = get_config_cache();
+	e = config_cache_find_entry(key);
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		e->value_list = xcalloc(sizeof(struct string_list), 1);
+		e->value_list->strdup_strings = 1;
+		string_list_append(e->value_list, value);
+		hashmap_add(config_cache, e);
+	} else {
+		string_list_append(e->value_list, value);
+	}
+	return 0;
+}
+
+extern const char *git_config_get_string(const char *key)
+{
+	struct string_list *values;
+	values = config_cache_get_value(key);
+	if (!values)
+		return NULL;
+	assert(values->nr > 0);
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
@@ -1700,6 +1816,12 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	lock = NULL;
 	ret = 0;
 
+	/* contents of config file has changed, so invalidate the
+	 * config cache used by non-callback based query functions.
+	 */
+	if (hashmap_is_init)
+		config_cache_free();
+
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-- 
1.9.0.GIT
