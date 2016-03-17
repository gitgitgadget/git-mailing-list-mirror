From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] hashmap API: introduce for_each_hashmap_entry() helper macro
Date: Thu, 17 Mar 2016 16:38:47 +0600
Message-ID: <1458211127-26963-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:39:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agVKb-00011H-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 11:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934364AbcCQKi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 06:38:57 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35628 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbcCQKi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 06:38:56 -0400
Received: by mail-lb0-f175.google.com with SMTP id bc4so65592111lbc.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zAER2kwnwTVcTdurMs7Ox3WqYo4d1MmrYU3o3mwwspI=;
        b=sgb192AmBhpsuEIDuqz7oUn/ZOgCclKJh9E4uuTqVUFCWTfpWp39guIJ3510IQhiIX
         G0qTop/QgyBNrfUUfjOf+8iV+bfobh7L+ob7/loXsW/gCq9HDRjiZCkPlz1dy68TRCuJ
         9h/RQeIwbhbVxRCL7vqOVD6FFjhnAYleY6Qx9dZAFNmz0du4P83kkMb8c/jeI7ZQAtbL
         D+BeGDJgS7iCParSfb4goTna22E2A/Y5+CTPKuhE02F+a+bV1GvhLACkuEzBNOeyRUdQ
         xt/xewK8ROmYFPkjGjzaY7dU4nAuC/HfNs2AfvZS/wyqyaJcvIToQrb5tTSwkFo/8Nia
         zLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zAER2kwnwTVcTdurMs7Ox3WqYo4d1MmrYU3o3mwwspI=;
        b=VNGgfULKr6vHXw6iie5inoFqw/23/cQnOsRZ26B60S4D0CE+ELnOnGgYsL9NeeuxwH
         h2ma6Pdps48k/IR+8pSxOJzjP4511OBE/3gTwciqMf7/q0zkZnzxe8G0ch1Z+v20aoqV
         g5b0rBaXObyMH4MGnpl2qR82HM+lHtrrc6GQf/4JhRWgQt4hJ2mxecliJtk1UKtpn9SU
         opAn7dpjTZdbDPdFgsZFZciT+pfb9JvJUWzz+gSEKKHNpZUkcAx28hbSqxAeTFCk53Cd
         dbs7+57//HavkeQmZP7fR5R4VpgorXVxrhmWaQyDvyqQlFxBXIIabsPRFDo4ZHVvvS2I
         Xl6g==
X-Gm-Message-State: AD7BkJIztcTWVuGvAJ3o9FjpGcaZco4B/ztl8XehTmYni9J6K2Dl+GEMOku5yjQueqtXNA==
X-Received: by 10.112.198.132 with SMTP id jc4mr3442129lbc.120.1458211133686;
        Thu, 17 Mar 2016 03:38:53 -0700 (PDT)
Received: from localhost.localhost ([178.90.47.56])
        by smtp.gmail.com with ESMTPSA id um4sm1289943lbb.1.2016.03.17.03.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 03:38:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.212.g1f992f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289097>

There is common pattern to traverse a hashmap in git source code:

        hashmap_iter_init(map, &iter);
        while ((entry = hashmap_iter_next(&iter)))
             // do something with entry

This patch introduces the for_each_hashmap_entry() macro for more
simple and clean usage of this pattern. It encapsulates loop over
a hashmap and makes bypass of a hashmap more readable.

This patch has not functioal changes, so behaviour still the same
as before.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/technical/api-hashmap.txt | 5 +++++
 builtin/describe.c                      | 5 +++--
 config.c                                | 7 ++++---
 hashmap.c                               | 8 ++++----
 hashmap.h                               | 4 ++++
 submodule-config.c                      | 3 +--
 test-hashmap.c                          | 4 ++--
 7 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index ad7a5bd..7cb7d2a 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -193,6 +193,11 @@ more entries.
 `hashmap_iter_first` is a combination of both (i.e. initializes the iterator
 and returns the first entry, if any).
 
+`for_each_hashmap_entry`::
+
+	Allows iterate over entries of the given map with the given entry
+	and iterator.
+
 `const char *strintern(const char *string)`::
 `const void *memintern(const void *data, size_t len)`::
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..50e3377 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -274,8 +274,9 @@ static void describe(const char *arg, int last_one)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n = hashmap_iter_first(&names, &iter);
-		for (; n; n = hashmap_iter_next(&iter)) {
+		struct commit_name *n;
+
+		for_each_hashmap_entry(&names, n, &iter) {
 			c = lookup_commit_reference_gently(n->peeled, 1);
 			if (c)
 				c->util = n;
diff --git a/config.c b/config.c
index 7ddb287..392d5a2 100644
--- a/config.c
+++ b/config.c
@@ -1382,16 +1382,17 @@ void git_configset_init(struct config_set *cs)
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_set_element *entry;
 	struct hashmap_iter iter;
+	struct config_set_element *entry;
+
 	if (!cs->hash_initialized)
 		return;
 
-	hashmap_iter_init(&cs->config_hash, &iter);
-	while ((entry = hashmap_iter_next(&iter))) {
+	for_each_hashmap_entry(&cs->config_hash, entry, &iter) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
+
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
 	free(cs->list.items);
diff --git a/hashmap.c b/hashmap.c
index b10b642..c41c12b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -141,10 +141,10 @@ void hashmap_free(struct hashmap *map, int free_entries)
 		return;
 	if (free_entries) {
 		struct hashmap_iter iter;
-		struct hashmap_entry *e;
-		hashmap_iter_init(map, &iter);
-		while ((e = hashmap_iter_next(&iter)))
-			free(e);
+		struct hashmap_entry *entry;
+
+		for_each_hashmap_entry(map, entry, &iter)
+			free(entry);
 	}
 	free(map->table);
 	memset(map, 0, sizeof(*map));
diff --git a/hashmap.h b/hashmap.h
index ab7958a..772caf2 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -95,4 +95,8 @@ static inline const char *strintern(const char *string)
 	return memintern(string, strlen(string));
 }
 
+#define for_each_hashmap_entry(map, entry, iter)		\
+	for (entry = hashmap_iter_first(map, iter); entry;	\
+	     entry = hashmap_iter_next(iter))
+
 #endif
diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..5a8d7fa 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -73,8 +73,7 @@ static void cache_free(struct submodule_cache *cache)
 	 * allocation of struct submodule entries. Each is allocated by
 	 * their .gitmodule blob sha1 and submodule name.
 	 */
-	hashmap_iter_init(&cache->for_name, &iter);
-	while ((entry = hashmap_iter_next(&iter)))
+	for_each_hashmap_entry(&cache->for_name, entry, &iter)
 		free_one_config(entry);
 
 	hashmap_free(&cache->for_path, 1);
diff --git a/test-hashmap.c b/test-hashmap.c
index cc2891d..917d188 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -225,8 +225,8 @@ int main(int argc, char *argv[])
 		} else if (!strcmp("iterate", cmd)) {
 
 			struct hashmap_iter iter;
-			hashmap_iter_init(&map, &iter);
-			while ((entry = hashmap_iter_next(&iter)))
+
+			for_each_hashmap_entry(&map, entry, &iter)
 				printf("%s %s\n", entry->key, get_value(entry));
 
 		} else if (!strcmp("size", cmd)) {
-- 
2.8.0.rc3.212.g1f992f2.dirty
