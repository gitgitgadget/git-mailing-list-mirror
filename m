From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 04:28:19 -0700
Message-ID: <1406633302-23144-4-git-send-email-tanayabh@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:30:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5bX-0003Er-6l
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbaG2L3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:29:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53722 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbaG2L3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:29:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so12267638pad.11
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbIcCZdYnrIJDhwrAzJTtpVwAhZM9/bHKEgpYbE9uVk=;
        b=xcBirkzoZCe7GkOsU8mDpCstFhdAxQXQGhsHudAmKUh7ORdY81g7n7zZifzjx7VjM6
         tb94BLlVOPQFhDVFLBpOn5CN7PtaK0w0BlbtKox7XcySzLojuWniXTNQ9FGLJeybw9tW
         QLo5Y+61XJbAuhjhPLlm9HbTyB4RQ8yEatAtD/OXuYmQT0QJHhZuNtUyB1sJc2iG+fvZ
         nvyt2T1ZblE58+xx/X4fPKX8q/gcnO91aDglM+lw86atiYB5EmEHvPvz5AHZxBys9u9w
         Hvn0Gf28C91/UhjGAO/MKR44ZyJiIZ0ShTTiZc4/DakvPnNYJ212dI2bRQStpgyelGWK
         hOUA==
X-Received: by 10.70.44.2 with SMTP id a2mr1502162pdm.38.1406633393927;
        Tue, 29 Jul 2014 04:29:53 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.29.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:29:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254415>

Of all the functions in `git_config*()` family, `git_config()` has the
most invocations in the whole code base. Each `git_config()` invocation
causes config file rereads which can be avoided using the config-set API.

Use the config-set API to rewrite `git_config()` to use the config caching
layer to avoid config file rereads on each invocation during a git process
lifetime. First invocation constructs the cache, and after that for each
successive invocation, `git_config()` feeds values from the config cache
instead of rereading the configuration files.

Add configuration variable in addition to line number and file name to the
error message that is printed when `git_config()` dies.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h                 | 24 ++++++++++++++++++++
 config.c                | 58 ++++++++++++++++++++++++++++++++++++++++++-------
 t/t4055-diff-context.sh |  2 +-
 3 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 7292aef..93bdbab 100644
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
index 5499108..1134741 100644
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
@@ -1237,11 +1231,45 @@ struct key_value_info {
 	int linenr;
 };
 
-int git_config(config_fn_t fn, void *data)
+static int git_config_raw(config_fn_t fn, void *data)
 {
 	return git_config_with_options(fn, data, NULL, 1);
 }
 
+static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
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
+	return 0;
+}
+
+static void git_config_check_init(void);
+
+int git_config(config_fn_t fn, void *data)
+{
+	git_config_check_init();
+	return configset_iter(&the_config_set, fn, data);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
@@ -1268,6 +1296,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
+	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
 
 	e = configset_find_element(cs, key);
@@ -1283,6 +1312,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -1306,6 +1341,9 @@ void git_configset_init(struct config_set *cs)
 {
 	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
 	cs->hash_initialized = 1;
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 void git_configset_clear(struct config_set *cs)
@@ -1322,6 +1360,10 @@ void git_configset_clear(struct config_set *cs)
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
+	free(cs->list.items);
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 static int config_set_callback(const char *key, const char *value, void *cb)
@@ -1440,7 +1482,7 @@ static void git_config_check_init(void)
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
