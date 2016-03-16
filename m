From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [RFC PATCH] hashmap API: introduce for_each_hashmap_entry() helper macro
Date: Wed, 16 Mar 2016 22:39:06 +0600
Message-ID: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:41:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEVN-0008AS-JL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbcCPQjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:39:18 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35283 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbcCPQjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:39:15 -0400
Received: by mail-lf0-f44.google.com with SMTP id l202so23586997lfl.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BmZrucV8TgJiVsfBYpGQJOaqP0wThCf24NKDO/L81Hg=;
        b=UKmoaoTiXhnkmOPk9nymuAkHm8LiOpTqkR8JinsvNS95kdIpIqaOkH6Z11b5M62gLx
         7XaoJdhZuDWXvfVm+7obFN+vYU1oVJyu3IfXYyvlceMPlpg5n1Gupv07wzcLWwBZkQbi
         BJh8JZc0u7SSkiXzqJZ8GsjvAgPIL424Bnzha1lGYtwACjGOQ2Qtkob2bJnEuocZkrqC
         QvJK1cylQMqPsR4q/kP+WNr3e3g0eQZKqwPJjF0de8nqp/luiVcCF1gVl1kd+OqCUiLL
         eWmjpJE5gDrQIdkMC1fwUL6lxFdboeLuJk1QKeqRtiClUXIWZ8IY4seQ/A81tCVSWgwK
         6/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BmZrucV8TgJiVsfBYpGQJOaqP0wThCf24NKDO/L81Hg=;
        b=ALds/RZf592NohsToJzxja/tjOfJmQ/T0oIqlj6CEKv0miiInivgFl3SqpWv6VVIzY
         13dsi01qhilbhUDRZU5doCvF/GIy4N44xYUbHF+1hYcjhgxBwyrmiLYXFaNBFN8E/Xzh
         F6Hu1pmXWbSnBa7v/w6jaMzl0niNWDmfADGYSVlm1ZjuAqkHiRFCmhODpmig8sSYGctj
         H4hu6GQ6NSQEaRMdhDm8qRiZ3bVH2T+ketVlvsEF6chFqHEqKbETZBRBmSHoBC5Xw+dc
         UV1fIwslJZGztbBRknNxf/oMks+WEwPFbeIg9LAibQri5wROIiz/wLzCqH0ntjnjMVi7
         ET5w==
X-Gm-Message-State: AD7BkJJG9j7D4lxKTcESBHPVvqC9j6sPH10kMUyx2NpsD39wDfFJdI3cfzfa8iBMy6+Eng==
X-Received: by 10.25.85.204 with SMTP id j195mr1894730lfb.49.1458146353775;
        Wed, 16 Mar 2016 09:39:13 -0700 (PDT)
Received: from localhost.localhost ([37.150.78.168])
        by smtp.gmail.com with ESMTPSA id jb5sm670994lbc.8.2016.03.16.09.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2016 09:39:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.216.g1477fb2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288989>

There is common pattern to traverse a hashmap in git source code:

        hashmap_iter_init(map, &iter);
        while ((entry = hashmap_iter_next(&iter)))
             // do something with entry

This patch introduces the for_each_hashmap_entry() macro for more
simple and clean usage of this pattern. It encapsulates loop over
a hashmap, some related variables and makes bypass of a hashmap
more readable.

This patch has not functioal changes, so behaviour still the same
as before.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/technical/api-hashmap.txt | 5 +++++
 builtin/describe.c                      | 9 ++++-----
 config.c                                | 6 ++----
 hashmap.c                               | 7 ++-----
 hashmap.h                               | 7 +++++++
 submodule-config.c                      | 6 +-----
 test-hashmap.c                          | 4 +---
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index ad7a5bd..4c49aaf 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -193,6 +193,11 @@ more entries.
 `hashmap_iter_first` is a combination of both (i.e. initializes the iterator
 and returns the first entry, if any).
 
+`for_each_hashmap_entry`::
+
+	Allows iterate over entries of the given hashmap with the certain
+	type of entry.
+
 `const char *strintern(const char *string)`::
 `const void *memintern(const void *data, size_t len)`::
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..c678bbb 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -272,13 +272,12 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, _("searching to describe %s\n"), arg);
 
 	if (!have_util) {
-		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n = hashmap_iter_first(&names, &iter);
-		for (; n; n = hashmap_iter_next(&iter)) {
-			c = lookup_commit_reference_gently(n->peeled, 1);
+
+		for_each_hashmap_entry(&names, commit_name) {
+			c = lookup_commit_reference_gently(entry->peeled, 1);
 			if (c)
-				c->util = n;
+				c->util = entry;
 		}
 		have_util = 1;
 	}
diff --git a/config.c b/config.c
index 7ddb287..c4b09ad 100644
--- a/config.c
+++ b/config.c
@@ -1382,16 +1382,14 @@ void git_configset_init(struct config_set *cs)
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_set_element *entry;
-	struct hashmap_iter iter;
 	if (!cs->hash_initialized)
 		return;
 
-	hashmap_iter_init(&cs->config_hash, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	for_each_hashmap_entry(&cs->config_hash, config_set_element) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
+
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
 	free(cs->list.items);
diff --git a/hashmap.c b/hashmap.c
index b10b642..0574326 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -140,11 +140,8 @@ void hashmap_free(struct hashmap *map, int free_entries)
 	if (!map || !map->table)
 		return;
 	if (free_entries) {
-		struct hashmap_iter iter;
-		struct hashmap_entry *e;
-		hashmap_iter_init(map, &iter);
-		while ((e = hashmap_iter_next(&iter)))
-			free(e);
+		for_each_hashmap_entry(map, hashmap_entry)
+			free(entry);
 	}
 	free(map->table);
 	memset(map, 0, sizeof(*map));
diff --git a/hashmap.h b/hashmap.h
index ab7958a..b8b158c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -95,4 +95,11 @@ static inline const char *strintern(const char *string)
 	return memintern(string, strlen(string));
 }
 
+#define for_each_hashmap_entry(map, type)		\
+	struct type *entry;				\
+	struct hashmap_iter iter;			\
+							\
+	hashmap_iter_init(map, &iter);			\
+	while ((entry = hashmap_iter_next(&iter)))
+
 #endif
diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..4be2812 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -65,16 +65,12 @@ static void free_one_config(struct submodule_entry *entry)
 
 static void cache_free(struct submodule_cache *cache)
 {
-	struct hashmap_iter iter;
-	struct submodule_entry *entry;
-
 	/*
 	 * We iterate over the name hash here to be symmetric with the
 	 * allocation of struct submodule entries. Each is allocated by
 	 * their .gitmodule blob sha1 and submodule name.
 	 */
-	hashmap_iter_init(&cache->for_name, &iter);
-	while ((entry = hashmap_iter_next(&iter)))
+	for_each_hashmap_entry(&cache->for_name, submodule_entry)
 		free_one_config(entry);
 
 	hashmap_free(&cache->for_path, 1);
diff --git a/test-hashmap.c b/test-hashmap.c
index cc2891d..44758eb 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -224,9 +224,7 @@ int main(int argc, char *argv[])
 
 		} else if (!strcmp("iterate", cmd)) {
 
-			struct hashmap_iter iter;
-			hashmap_iter_init(&map, &iter);
-			while ((entry = hashmap_iter_next(&iter)))
+			for_each_hashmap_entry(&map, test_entry)
 				printf("%s %s\n", entry->key, get_value(entry));
 
 		} else if (!strcmp("size", cmd)) {
-- 
2.8.0.rc2.216.g1477fb2.dirty
