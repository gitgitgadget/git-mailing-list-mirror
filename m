From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 4/7] rewrite git_config() to use the config-set API
Date: Thu, 31 Jul 2014 08:47:39 -0700
Message-ID: <1406821662-1570-5-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsbC-0008KP-8R
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaGaPst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:49 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62243 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaGaPsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so3869411pad.38
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2sjxVgQI40IU7/91XB00Ft+54BWUyWke3WVyl4eCP6c=;
        b=ExVUqDeqfbA+dudtqD4bkihUAgPe8KQwph737B+cS3A8FiapLYRwxKNw+WZIyNc3vD
         sJT6HQFLiRmfPmc5sPwgBZ1nc1leG7Pjwf6F/KCCc4vgNdtXmOxxJfz2kBwmEnzXB4qh
         thyqZPif45FWkM42wgGfZfQUgBmuSE1Tl2lrr4GNW/FyhwvbRdTRE04BfRCXbrnEHIfe
         sflcNnbWHBbRTnUQCzihLHcjquaXsEyQVMe1/0hZ1VsnXJ+NHrJmoCbg7Ivnr81El2GD
         w5CmRXoexmq3emZntvTVYS+yrDsTCVrZYo/GOlkw9WOzxBbA2tALyFbvHy0uJzJynrAI
         mX5g==
X-Received: by 10.68.201.134 with SMTP id ka6mr4265117pbc.157.1406821726747;
        Thu, 31 Jul 2014 08:48:46 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254581>

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
index ecbe14f..6b4dd65 100644
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
 		die(_("unknown error occured while reading the configuration files"));
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
+				die(_("unable to parse '%s' from command-line config"), entry->key);
+			else
+				die(_("bad config variable '%s' at file line %d in %s"),
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
