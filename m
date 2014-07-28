From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 3/6] rewrite git_config() to use the config-set API
Date: Mon, 28 Jul 2014 03:33:52 -0700
Message-ID: <1406543635-19281-4-git-send-email-tanayabh@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:34:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGZ-0008L7-8d
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbaG1Keq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:46 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58656 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1Kep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:45 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so10100735pad.41
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ru+FMNFoZpf1wFUWqW/KS7rpHvokq1GWVBIe2tSuXrA=;
        b=Tr0WZlvNBobaGEKjUUIDKotOF9jmQI+ZYp6uNWqsfsgGUgbmhXXdxmbPn25wdk0WCx
         Q1+ywtPpqrVfwsmVgnSxUuR8TYOZ6CrKP7ZWR5WxcUQimEG2kbxy64+TqikxyjsI9QJh
         +EjZbCNVG0dEABYljBFYoSWuy2ZATz2KF1sebKJW8OO7cVFV4ruY1ZtESq5raQFH8wKE
         NG98EvsJHMTCwGOAv10CgMvwsMurUsDcdvrEfniIQUOgCfA+eBgt9vSxfU630bgyFRz8
         J3Kc8nxllNu4LeftPG6UN32rGbDMdp+SqbQ3ThrE4Zk/wdE7xV5d6cEC3ZyLGV/wy7f/
         MKfg==
X-Received: by 10.68.193.193 with SMTP id hq1mr37141286pbc.107.1406543681978;
        Mon, 28 Jul 2014 03:34:41 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254293>

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
 cache.h  | 24 ++++++++++++++++++++++++
 config.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 8 deletions(-)

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
index 5499108..2ce3318 100644
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
@@ -1283,6 +1311,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -1306,6 +1340,9 @@ void git_configset_init(struct config_set *cs)
 {
 	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
 	cs->hash_initialized = 1;
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 void git_configset_clear(struct config_set *cs)
@@ -1322,6 +1359,10 @@ void git_configset_clear(struct config_set *cs)
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
+	free(cs->list.items);
+	cs->list.nr = 0;
+	cs->list.alloc = 0;
+	cs->list.items = NULL;
 }
 
 static int config_set_callback(const char *key, const char *value, void *cb)
@@ -1440,7 +1481,7 @@ static void git_config_check_init(void)
 	if (the_config_set.hash_initialized)
 		return;
 	git_configset_init(&the_config_set);
-	git_config(config_set_callback, &the_config_set);
+	git_config_raw(config_set_callback, &the_config_set);
 }
 
 void git_config_clear(void)
-- 
1.9.0.GIT
