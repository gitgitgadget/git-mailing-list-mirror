From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 4/7] rewrite git_config() to use the config-set API
Date: Thu, 31 Jul 2014 02:44:14 -0700
Message-ID: <1406799857-28048-5-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:46:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvv-0004va-LB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbaGaJpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:50 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43587 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3300711pab.16
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sIbpgtam2x7q+U5SuqOCYEVK6YSfLh8URUUlIgcbVQ=;
        b=ftiyw2fu9wFglUDECAN8sS5Wg3qj01Bb4NOR6wlxd5BQ4rK6SwM26yOWSesQkvmFrJ
         pTYFGoGCJyPdp67BZePfTPvao6pYpsiH9bradqJlgtHa9Kjc5uPTkxAxqeeexcDGL5BZ
         gYRrQ7Un1+7/PhHwHRbsIsR1g8BWz/I3c9tl590ahaG4lMJfqvIKxN0nOKg+p+gvAefd
         xossO4z+DHwnoMJuTWTWRxE/TYtezm8A2IFY9nluJNdaC9ypuMvAYieeFEAYCAF2fQrP
         GDyocdhpauZiXZ9ZSA8NUvWo+enyLCswaFHYwjUsm9XVcYiUi1rhSk2+7utDjP0oTH9v
         g6Qw==
X-Received: by 10.70.65.100 with SMTP id w4mr10775165pds.128.1406799948761;
        Thu, 31 Jul 2014 02:45:48 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254546>

Of all the functions in `git_config*()` family, `git_config()` has the
most invocations in the whole code base. Each `git_config()` invocation
causes config file rereads which can be avoided using the config-set API.

Use the config-set API to rewrite `git_config()` to use the config caching
layer to avoid config file rereads on each invocation during a git process
lifetime. First invocation constructs the cache, and after that for each
successive invocation, `git_config()` feeds values from the config cache
instead of rereading the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h                 | 24 +++++++++++++++++++++
 config.c                | 57 ++++++++++++++++++++++++++++++++++++++++++-------
 t/t4055-diff-context.sh |  2 +-
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index c61919d..4d3c6bd 100644
--- a/cache.h
+++ b/cache.h
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "convert.h"
 #include "trace.h"
+#include "string-list.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1351,9 +1352,32 @@ extern int parse_config_key(const char *var,
 			    const char **subsection, int *subsection_len,
 			    const char **key);
 
+struct config_set_element {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+struct configset_list_item {
+	struct config_set_element *e;
+	int value_index;
+};
+
+/*
+ * the contents of the list are ordered according to their
+ * position in the config files and order of parsing the files.
+ * (i.e. key-value pair at the last position of .git/config will
+ * be at the last item of the list)
+ */
+struct configset_list {
+	struct configset_list_item *items;
+	unsigned int nr, alloc;
+};
+
 struct config_set {
 	struct hashmap config_hash;
 	int hash_initialized;
+	struct configset_list list;
 };
 
 extern void git_configset_init(struct config_set *cs);
diff --git a/config.c b/config.c
index c0faaca..4937515 100644
--- a/config.c
+++ b/config.c
@@ -35,12 +35,6 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };
 
-struct config_set_element {
-	struct hashmap_entry ent;
-	char *key;
-	struct string_list value_list;
-};
-
 static struct config_source *cf;
 
 static int zlib_compression_seen;
@@ -1235,7 +1229,7 @@ struct key_value_info {
 	int linenr;
 };
 
-void git_config(config_fn_t fn, void *data)
+static void git_config_raw(config_fn_t fn, void *data)
 {
 	if (git_config_with_options(fn, data, NULL, 1) < 0)
 		/*
@@ -1252,6 +1246,39 @@ void git_config(config_fn_t fn, void *data)
 		die("Unknown error occured while reading the configuration files");
 }
 
+static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i, value_index;
+	struct string_list *values;
+	struct config_set_element *entry;
+	struct configset_list *list = &cs->list;
+	struct key_value_info *kv_info;
+
+	for (i = 0; i < list->nr; i++) {
+		entry = list->items[i].e;
+		value_index = list->items[i].value_index;
+		values = &entry->value_list;
+		if (fn(entry->key, values->items[value_index].string, data) < 0) {
+			kv_info = values->items[value_index].util;
+			if (!kv_info->linenr)
+				die("unable to parse '%s' from command-line config", entry->key);
+			else
+				die("bad config variable '%s' at file line %d in %s",
+					entry->key,
+					kv_info->linenr,
+					kv_info->filename);
+		}
+	}
+}
+
+static void git_config_check_init(void);
+
+void git_config(config_fn_t fn, void *data)
+{
+	git_config_check_init();
+	configset_iter(&the_config_set, fn, data);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
@@ -1278,6 +1305,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
+	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
 
 	e = configset_find_element(cs, key);
@@ -1293,6 +1321,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		hashmap_add(&cs->config_hash, e);
 	}
 	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
+	l_item = &cs->list.items[cs->list.nr++];
+	l_item->e = e;
+	l_item->value_index = e->value_list.nr - 1;
+
 	if (cf) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
@@ -1316,6 +1350,9 @@ void git_configset_init(struct config_set *cs)
 {
 	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
 	cs->hash_initialized = 1;
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 void git_configset_clear(struct config_set *cs)
@@ -1332,6 +1369,10 @@ void git_configset_clear(struct config_set *cs)
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
+	free(cs->list.items);
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 static int config_set_callback(const char *key, const char *value, void *cb)
@@ -1450,7 +1491,7 @@ static void git_config_check_init(void)
 	if (the_config_set.hash_initialized)
 		return;
 	git_configset_init(&the_config_set);
-	git_config(config_set_callback, &the_config_set);
+	git_config_raw(config_set_callback, &the_config_set);
 }
 
 void git_config_clear(void)
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index cd04543..741e080 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -79,7 +79,7 @@ test_expect_success 'non-integer config parsing' '
 test_expect_success 'negative integer config parsing' '
 	git config diff.context -1 &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad config file" output
+	test_i18ngrep "bad config variable" output
 '
 
 test_expect_success '-U0 is valid, so is diff.context=0' '
-- 
1.9.0.GIT
