Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEF721847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeEBA0s (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeEBA0f (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADA8A60B1A;
        Wed,  2 May 2018 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220794;
        bh=//bmgidpS5Jo/vbie374hc8MdFjC3RUZzhN270p+SzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UQrxF2g6gzTTvfPGVNNN2ngOu0A5CuaxtxGPlJtjvkr+W7nEntlIS9gEoIkN/SskN
         1xgKAwzy/fzVfXGhNG7T4pCjAZghI9EQ7goRUnsLjZtESk+TkeqgZ47ueFdLja+ecW
         WNYJ38+WGZYrj3Fj52envKZ4TKIcm5WEa7LP+W9+Q9GjGtxQiqMbLqlK70aIN1vQZG
         G8QvYiAoKtCcLg2iM/iA6LzJHucaOYKGnOT7XJ0s/Y/1Du79TiGlI2DVxiD5bWmXvx
         xmjlgS2mzB8Ii+1rylFLTBdzcdR/+xXvV51fWYzdUY2WW+syW4HsAf2kuqg8forKIW
         6GdAoDL4X0rzgAVj4+0b/4PrsCDuO5iEzO6ZAOPfDgnRyKvbEoA2sRcE+H77OHxFlQ
         X9gAtGyll3k0YLXV4XDpfhZtBm54sU/ddZdpYbgO29T1xa95cD90JsnbqYkl5hTdVE
         uAvTRpDWMr+10gZhpF/4mavItR7KiM9ud+jqt4CXGRNwBnOU43Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 14/42] submodule-config: convert structures to object_id
Date:   Wed,  2 May 2018 00:25:42 +0000
Message-Id: <20180502002610.915892-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct submodule and struct parse_config_parameter to use struct
object_id.  Adjust the functions which take members of these structures
as arguments to also use struct object_id.  Include cache.h into
submodule-config.h to make struct object_id visible.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 submodule-config.c | 66 +++++++++++++++++++++++-----------------------
 submodule-config.h |  7 ++---
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 3f2075764f..5537c88727 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -44,7 +44,7 @@ static int config_path_cmp(const void *unused_cmp_data,
 	const struct submodule_entry *b = entry_or_key;
 
 	return strcmp(a->config->path, b->config->path) ||
-	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
+	       oidcmp(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
 static int config_name_cmp(const void *unused_cmp_data,
@@ -56,7 +56,7 @@ static int config_name_cmp(const void *unused_cmp_data,
 	const struct submodule_entry *b = entry_or_key;
 
 	return strcmp(a->config->name, b->config->name) ||
-	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
+	       oidcmp(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
 static struct submodule_cache *submodule_cache_alloc(void)
@@ -109,17 +109,17 @@ void submodule_cache_free(struct submodule_cache *cache)
 	free(cache);
 }
 
-static unsigned int hash_sha1_string(const unsigned char *sha1,
-				     const char *string)
+static unsigned int hash_oid_string(const struct object_id *oid,
+				    const char *string)
 {
-	return memhash(sha1, 20) + strhash(string);
+	return memhash(oid->hash, the_hash_algo->rawsz) + strhash(string);
 }
 
 static void cache_put_path(struct submodule_cache *cache,
 			   struct submodule *submodule)
 {
-	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
-					     submodule->path);
+	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
+					    submodule->path);
 	struct submodule_entry *e = xmalloc(sizeof(*e));
 	hashmap_entry_init(e, hash);
 	e->config = submodule;
@@ -129,8 +129,8 @@ static void cache_put_path(struct submodule_cache *cache,
 static void cache_remove_path(struct submodule_cache *cache,
 			      struct submodule *submodule)
 {
-	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
-					     submodule->path);
+	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
+					    submodule->path);
 	struct submodule_entry e;
 	struct submodule_entry *removed;
 	hashmap_entry_init(&e, hash);
@@ -142,8 +142,8 @@ static void cache_remove_path(struct submodule_cache *cache,
 static void cache_add(struct submodule_cache *cache,
 		      struct submodule *submodule)
 {
-	unsigned int hash = hash_sha1_string(submodule->gitmodules_sha1,
-					     submodule->name);
+	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
+					    submodule->name);
 	struct submodule_entry *e = xmalloc(sizeof(*e));
 	hashmap_entry_init(e, hash);
 	e->config = submodule;
@@ -151,14 +151,14 @@ static void cache_add(struct submodule_cache *cache,
 }
 
 static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
-		const unsigned char *gitmodules_sha1, const char *path)
+		const struct object_id *gitmodules_oid, const char *path)
 {
 	struct submodule_entry *entry;
-	unsigned int hash = hash_sha1_string(gitmodules_sha1, path);
+	unsigned int hash = hash_oid_string(gitmodules_oid, path);
 	struct submodule_entry key;
 	struct submodule key_config;
 
-	hashcpy(key_config.gitmodules_sha1, gitmodules_sha1);
+	oidcpy(&key_config.gitmodules_oid, gitmodules_oid);
 	key_config.path = path;
 
 	hashmap_entry_init(&key, hash);
@@ -171,14 +171,14 @@ static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
 }
 
 static struct submodule *cache_lookup_name(struct submodule_cache *cache,
-		const unsigned char *gitmodules_sha1, const char *name)
+		const struct object_id *gitmodules_oid, const char *name)
 {
 	struct submodule_entry *entry;
-	unsigned int hash = hash_sha1_string(gitmodules_sha1, name);
+	unsigned int hash = hash_oid_string(gitmodules_oid, name);
 	struct submodule_entry key;
 	struct submodule key_config;
 
-	hashcpy(key_config.gitmodules_sha1, gitmodules_sha1);
+	oidcpy(&key_config.gitmodules_oid, gitmodules_oid);
 	key_config.name = name;
 
 	hashmap_entry_init(&key, hash);
@@ -207,12 +207,12 @@ static int name_and_item_from_var(const char *var, struct strbuf *name,
 }
 
 static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
-		const unsigned char *gitmodules_sha1, const char *name)
+		const struct object_id *gitmodules_oid, const char *name)
 {
 	struct submodule *submodule;
 	struct strbuf name_buf = STRBUF_INIT;
 
-	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
+	submodule = cache_lookup_name(cache, gitmodules_oid, name);
 	if (submodule)
 		return submodule;
 
@@ -230,7 +230,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->branch = NULL;
 	submodule->recommend_shallow = -1;
 
-	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
+	oidcpy(&submodule->gitmodules_oid, gitmodules_oid);
 
 	cache_add(cache, submodule);
 
@@ -341,12 +341,12 @@ int parse_push_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_push_recurse(opt, arg, 1);
 }
 
-static void warn_multiple_config(const unsigned char *treeish_name,
+static void warn_multiple_config(const struct object_id *treeish_name,
 				 const char *name, const char *option)
 {
 	const char *commit_string = "WORKTREE";
 	if (treeish_name)
-		commit_string = sha1_to_hex(treeish_name);
+		commit_string = oid_to_hex(treeish_name);
 	warning("%s:.gitmodules, multiple configurations found for "
 			"'submodule.%s.%s'. Skipping second one!",
 			commit_string, name, option);
@@ -354,8 +354,8 @@ static void warn_multiple_config(const unsigned char *treeish_name,
 
 struct parse_config_parameter {
 	struct submodule_cache *cache;
-	const unsigned char *treeish_name;
-	const unsigned char *gitmodules_sha1;
+	const struct object_id *treeish_name;
+	const struct object_id *gitmodules_oid;
 	int overwrite;
 };
 
@@ -371,7 +371,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		return 0;
 
 	submodule = lookup_or_create_by_name(me->cache,
-					     me->gitmodules_sha1,
+					     me->gitmodules_oid,
 					     name.buf);
 
 	if (!strcmp(item.buf, "path")) {
@@ -389,7 +389,7 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
-		int die_on_error = is_null_sha1(me->gitmodules_sha1);
+		int die_on_error = is_null_oid(me->gitmodules_oid);
 		if (!me->overwrite &&
 		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
 			warn_multiple_config(me->treeish_name, submodule->name,
@@ -511,10 +511,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	switch (lookup_type) {
 	case lookup_name:
-		submodule = cache_lookup_name(cache, oid.hash, key);
+		submodule = cache_lookup_name(cache, &oid, key);
 		break;
 	case lookup_path:
-		submodule = cache_lookup_path(cache, oid.hash, key);
+		submodule = cache_lookup_path(cache, &oid, key);
 		break;
 	}
 	if (submodule)
@@ -526,8 +526,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	parameter.treeish_name = treeish_name->hash;
-	parameter.gitmodules_sha1 = oid.hash;
+	parameter.treeish_name = treeish_name;
+	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
@@ -536,9 +536,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	switch (lookup_type) {
 	case lookup_name:
-		return cache_lookup_name(cache, oid.hash, key);
+		return cache_lookup_name(cache, &oid, key);
 	case lookup_path:
-		return cache_lookup_path(cache, oid.hash, key);
+		return cache_lookup_path(cache, &oid, key);
 	default:
 		return NULL;
 	}
@@ -567,7 +567,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
-	parameter.gitmodules_sha1 = null_sha1;
+	parameter.gitmodules_oid = &null_oid;
 	parameter.overwrite = 1;
 
 	return parse_config(var, value, &parameter);
diff --git a/submodule-config.h b/submodule-config.h
index a5503a5d17..11729fbc74 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -1,6 +1,7 @@
 #ifndef SUBMODULE_CONFIG_CACHE_H
 #define SUBMODULE_CONFIG_CACHE_H
 
+#include "cache.h"
 #include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
@@ -17,13 +18,13 @@ struct submodule {
 	const char *ignore;
 	const char *branch;
 	struct submodule_update_strategy update_strategy;
-	/* the sha1 blob id of the responsible .gitmodules file */
-	unsigned char gitmodules_sha1[20];
+	/* the object id of the responsible .gitmodules file */
+	struct object_id gitmodules_oid;
 	int recommend_shallow;
 };
 
 #define SUBMODULE_INIT { NULL, NULL, NULL, RECURSE_SUBMODULES_NONE, \
-	NULL, NULL, SUBMODULE_UPDATE_STRATEGY_INIT, {0}, -1 };
+	NULL, NULL, SUBMODULE_UPDATE_STRATEGY_INIT, { { 0 } }, -1 };
 
 struct submodule_cache;
 struct repository;
