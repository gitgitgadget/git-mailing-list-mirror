From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 3/6] rewrite git_config() to use the config-set API
Date: Fri, 25 Jul 2014 05:58:12 -0700
Message-ID: <1406293095-15920-4-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf5s-0003BB-8j
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760419AbaGYM7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:24 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56115 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaGYM7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:23 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so6054136pab.20
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P6PURFeC0OGbEhkkXuSw17isfptTQBwPMtQtjb+G3Wo=;
        b=vxoBUwU9yFDlzy595jD/vgRYF+BPEmQI7OmHCVDhx7gjQ/x4xYCZUOG/2g+SJ8yWmo
         IXdty58UoICF3iT+EDkImN7LbiHezJxZG7sYHm0DszVKhttTbwXTDHeNuQ7SKmjCwcRr
         qGkibxN+OaEIfmX9XTxBroLQGzUokX34JkZTxctM4C8l5P3YMfUrOOvtVVUIPnPSbc9Y
         EbkN+EJ1EnByZ5HNLwl0tbJ43hFOZmc1PKtyWICzMU5McazkUaODdDSLfan1WrRfFCpH
         OtaWO8/kSfQ3vhwochYY7IsJgP5RPXAoIAeBwMauXs0WHh+7Dya7wz6GrTMMvUwNWIW6
         ThOA==
X-Received: by 10.68.227.4 with SMTP id rw4mr18449173pbc.3.1406293162840;
        Fri, 25 Jul 2014 05:59:22 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.59.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:59:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254214>

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
 cache.h  | 25 +++++++++++++++++++++++++
 config.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 7292aef..11ded5a 100644
--- a/cache.h
+++ b/cache.h
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "convert.h"
 #include "trace.h"
+#include "string-list.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1351,9 +1352,33 @@ extern int parse_config_key(const char *var,
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
+
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
index 110f9a5..aa5c0ad 100644
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
@@ -1237,11 +1231,44 @@ struct key_value_info {
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
+				die("unable to parse command-line config");
+			else
+				die("bad config file line %d in %s",
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
@@ -1268,6 +1295,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
+	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
 
 	e = configset_find_element(cs, key);
@@ -1283,6 +1311,13 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		hashmap_add(&cs->config_hash, e);
 	}
 	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+
+	if (cs->list.nr + 1 > cs->list.alloc)
+		ALLOC_GROW(cs->list.items, cs->list.nr + 20, cs->list.alloc);
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
@@ -1318,10 +1356,14 @@ void git_configset_clear(struct config_set *cs)
 	hashmap_iter_init(&cs->config_hash, &iter);
 	while ((entry = hashmap_iter_next(&iter))) {
 		free(entry->key);
-		string_list_clear(&entry->value_list, 0);
+		string_list_clear(&entry->value_list, 1);
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
+	free(cs->list.items);
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 static int config_set_callback(const char *key, const char *value, void *cb)
@@ -1448,7 +1490,7 @@ static void git_config_check_init(void)
 	if (the_config_set.hash_initialized)
 		return;
 	git_configset_init(&the_config_set);
-	git_config(config_set_callback, &the_config_set);
+	git_config_raw(config_set_callback, &the_config_set);
 }
 
 void git_config_clear(void)
-- 
1.9.0.GIT
