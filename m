From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH 1/2] config: Add cache for config value querying
Date: Mon, 26 May 2014 10:33:20 -0700
Message-ID: <1401125601-18249-2-git-send-email-tanayabh@gmail.com>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 19:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoyoW-0004QN-2c
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 19:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaEZRfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 13:35:51 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40773 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaEZRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 13:35:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so7866916pad.32
        for <git@vger.kernel.org>; Mon, 26 May 2014 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ox0HC7m/chdLAdNIOJ4OvIx05CMGamWqgo36nmyoi6U=;
        b=FQl1gUN36RbUi5cqrpTawiLWilQSsf1nNPE6rjhH3259vrVWjfYjN6tY2EXZoYdXnp
         tFTn4dHO1dIYcWEIknAlooHELX0+98upubtzQoFOvYfo2DtEmS0YlRuInAR2MKC6Wkfk
         Rl5ENMuRLE1sSF8HwGKOHXGHK4T+vBa1RDGEFZBq6x77PvbfmgVY51lUCe/jLkb8YNFa
         t58m7QjRf6ouD8bFAu/A2OIA13eK28XGEsOONeitr59s822h7v5QXcXb561leL2+NfdU
         31t7C7bMzfKRc7p/dFcsWv1oEgNzs0/HkFVxdxCQECvBxo0/bu/N3InpESqecoXEmAEH
         bqPQ==
X-Received: by 10.68.253.73 with SMTP id zy9mr29859403pbc.114.1401125750772;
        Mon, 26 May 2014 10:35:50 -0700 (PDT)
Received: from localhost.localdomain ([117.254.217.73])
        by mx.google.com with ESMTPSA id sh5sm19261135pbc.21.2014.05.26.10.35.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 10:35:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250109>

Add an internal cache with the all variable value pairs read from the usual
config files(repo specific .git/config, user wide ~/.gitconfig and the global
/etc/gitconfig). Also, add two external functions `git_config_get_string` and
`git_config_get_string_multi` for querying in an non callback manner from the
cache.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h  |   2 ++
 config.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

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
index a30cb5c..f6515c2 100644
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
@@ -37,6 +39,102 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+struct hashmap config_cache;
+
+struct config_cache_node {
+	struct hashmap_entry ent;
+	struct strbuf key;
+	struct string_list *value_list ;
+};
+
+static int hashmap_init_v = 0;
+
+static int config_cache_node_cmp(const struct config_cache_node *e1,
+			   const struct config_cache_node *e2, const char *key)
+{
+	return strcmp(e1->key.buf, key ? key : e2->key.buf);
+}
+
+static int config_cache_node_cmp_icase(const struct config_cache_node *e1,
+				 const struct config_cache_node *e2, const char* key)
+{
+	return strcasecmp(e1->key.buf, key ? key : e2->key.buf);
+}
+
+static void config_cache_init(const int icase)
+{
+	hashmap_init(&config_cache, (hashmap_cmp_fn) (icase ? config_cache_node_cmp_icase
+			: config_cache_node_cmp), 0);
+}
+
+static void config_cache_free(void)
+{
+	hashmap_free(&config_cache, 1);
+}
+
+static struct config_cache_node *config_cache_find_entry(const char *key)
+{
+	struct hashmap_entry k;
+	hashmap_entry_init(&k, strihash(key));
+	return hashmap_get(&config_cache, &k, key);
+}
+
+static struct string_list *config_cache_get_value(const char *key)
+{
+	struct config_cache_node *e = config_cache_find_entry(key);
+	if (e == NULL)
+		return NULL;
+	else
+		return (e->value_list);
+}
+
+
+static void config_cache_set_value(const char *key, const char *value)
+{
+	struct config_cache_node *e;
+
+	if (!value)
+		return;
+
+	e = config_cache_find_entry(key);
+	if (!e) {
+		e = malloc(sizeof(*e));
+		hashmap_entry_init(e, strihash(key));
+		strbuf_init(&(e->key), 1024);
+		strbuf_addstr(&(e->key),key);
+		e->value_list = malloc(sizeof(struct string_list));
+		e->value_list->strdup_strings = 1;
+		e->value_list->nr = 0;
+		e->value_list->alloc = 0;
+		e->value_list->items = NULL;
+		e->value_list->cmp = NULL;
+		string_list_append(e->value_list, value);
+		hashmap_add(&config_cache, e);
+	}
+	else {
+		if (!unsorted_string_list_has_string((e->value_list), value))
+			string_list_append((e->value_list), value);
+	}
+}
+
+extern const char *git_config_get_string(const char *name)
+{
+	struct string_list *values;
+	int num_values;
+	char *result;
+	values = config_cache_get_value(name);
+	if (!values)
+		return NULL;
+	num_values = values->nr;
+	result = values->items[num_values-1].string ;
+	return result;
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
@@ -333,6 +431,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 		if (!value)
 			return -1;
 	}
+	config_cache_set_value(name->buf, value);
 	return fn(name->buf, value, data);
 }
 
@@ -1135,6 +1234,12 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 
+	int icase = 1;
+	if (!hashmap_init_v) {
+		config_cache_init(icase);
+		hashmap_init_v = 1;
+	}
+
 	home_config_paths(&user_config, &xdg_config, "config");
 
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
-- 
1.9.0.GIT
