Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDDB1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdALXzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:35 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34067 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id 127so20408677pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VoR464G4U9JeRGoL1UiSI4aErsK07TP5RVqM1RQwGck=;
        b=Q1lW2QYA+wR2jF0bniLqWjRWI5D9Zrgz3yb6R0le51rbJqsrCsb3hu9lHhV8is4A3c
         AOLYfBOsjOyk9QPoUF13lMFziIntBX1CiInC2f25aWlm5aK+hsPf65X2USr/Zp3GnlF3
         qn41NN2wsjr8OhV5qyMHeR/0Uigf6f24CZVLRuqHD3DPR81n+qXyvuLmAwBEa2O8bEaR
         54Bl7+Eju3WwTU/lHuh5htqUS1Zwl1WHS/YgctspMcgN2BQ9d7EO9QwqmoMRujyeO4lF
         0fAVID2DRZ5Ghse2gIvl6db/g07WH+hboF9ERgwjQceCOQsOPdqcjErXmQ6rFnjYSw+J
         WdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VoR464G4U9JeRGoL1UiSI4aErsK07TP5RVqM1RQwGck=;
        b=KKLA08t7djci4Vq0jr/roAlWG0511BUK2M44JkVBYbUDtVNTHJaTSuIuTRX38AfaIK
         CUIVSCc7YeJAtQvywCKon3fas1YUFs1+RJ4BGyzbo+D8Vea2JIka7FZcKNzSy4kbNBt+
         fg1/a3Nm0BCpQrVSbonf49KqRdkGm7xruzxxcjcdziHKOWj13LCmdrstZrpp12gpTke/
         A5D5xS/6BAVXTnBfTg4hOatDiX4Ms2IEVaSHV0GlbWYOy6nCXGcsspvUFFD4D1OcCq7V
         IyEEFGyS1WO3dd8NT4qE3NhMYsmItkA5ZGcPiawGSf1IVRqssJJhsF5006LF05dqrjX6
         x+wg==
X-Gm-Message-State: AIkVDXK2p14aRZ+hrzI0iFvYWGI+bU7bcZC99NT7Lx/iQDU0yi4k0UeXlyGjKQSA5P3xXR3q
X-Received: by 10.99.217.81 with SMTP id e17mr20487737pgj.127.1484265274880;
        Thu, 12 Jan 2017 15:54:34 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:33 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 21/27] attr: use hashmap for attribute dictionary
Date:   Thu, 12 Jan 2017 15:53:48 -0800
Message-Id: <20170112235354.153403-22-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current implementation of the attribute dictionary uses a custom
hashtable.  This modernizes the dictionary by converting it to the builtin
'hashmap' structure.

Also, in order to enable a threaded API in the future add an
accompanying mutex which must be acquired prior to accessing the
dictionary of interned attributes.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c        | 171 ++++++++++++++++++++++++++++++++++++++++++----------------
 attr.h        |   2 +
 common-main.c |   3 ++
 3 files changed, 131 insertions(+), 45 deletions(-)

diff --git a/attr.c b/attr.c
index 5399e1cb3..8cf2ea901 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "utf8.h"
 #include "quote.h"
+#include "thread-utils.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -23,28 +24,17 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define ATTR__UNSET NULL
 #define ATTR__UNKNOWN git_attr__unknown
 
-/* This is a randomly chosen prime. */
-#define HASHSIZE 257
-
 #ifndef DEBUG_ATTR
 #define DEBUG_ATTR 0
 #endif
 
-/*
- * NEEDSWORK: the global dictionary of the interned attributes
- * must stay a singleton even after we become thread-ready.
- * Access to these must be surrounded with mutex when it happens.
- */
 struct git_attr {
-	struct git_attr *next;
-	unsigned h;
-	int attr_nr;
+	int attr_nr; /* unique attribute number */
 	int maybe_macro;
 	int maybe_real;
-	char name[FLEX_ARRAY];
+	char name[FLEX_ARRAY]; /* attribute name */
 };
 static int attr_nr;
-static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 /*
  * NEEDSWORK: maybe-real, maybe-macro are not property of
@@ -63,15 +53,94 @@ const char *git_attr_name(const struct git_attr *attr)
 	return attr->name;
 }
 
-static unsigned hash_name(const char *name, int namelen)
+struct attr_hashmap {
+	struct hashmap map;
+#ifndef NO_PTHREADS
+	pthread_mutex_t mutex;
+#endif
+};
+
+static inline void hashmap_lock(struct attr_hashmap *map)
 {
-	unsigned val = 0, c;
+#ifndef NO_PTHREADS
+	pthread_mutex_lock(&map->mutex);
+#endif
+}
 
-	while (namelen--) {
-		c = *name++;
-		val = ((val << 7) | (val >> 22)) ^ c;
-	}
-	return val;
+static inline void hashmap_unlock(struct attr_hashmap *map)
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_unlock(&map->mutex);
+#endif
+}
+
+/*
+ * The global dictionary of all interned attributes.  This
+ * is a singleton object which is shared between threads.
+ * Access to this dictionary must be surrounded with a mutex.
+ */
+static struct attr_hashmap g_attr_hashmap;
+
+/* The container for objects stored in "struct attr_hashmap" */
+struct attr_hash_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *key; /* the key; memory should be owned by value */
+	size_t keylen; /* length of the key */
+	void *value; /* the stored value */
+};
+
+/* attr_hashmap comparison function */
+static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
+			       const struct attr_hash_entry *b,
+			       void *unused)
+{
+	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
+}
+
+/* Initialize an 'attr_hashmap' object */
+void attr_hashmap_init(struct attr_hashmap *map)
+{
+	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, 0);
+}
+
+/*
+ * Retrieve the 'value' stored in a hashmap given the provided 'key'.
+ * If there is no matching entry, return NULL.
+ */
+static void *attr_hashmap_get(struct attr_hashmap *map,
+			      const char *key, size_t keylen)
+{
+	struct attr_hash_entry k;
+	struct attr_hash_entry *e;
+
+	if (!map->map.tablesize)
+		attr_hashmap_init(map);
+
+	hashmap_entry_init(&k, memhash(key, keylen));
+	k.key = key;
+	k.keylen = keylen;
+	e = hashmap_get(&map->map, &k, NULL);
+
+	return e ? e->value : NULL;
+}
+
+/* Add 'value' to a hashmap based on the provided 'key'. */
+static void attr_hashmap_add(struct attr_hashmap *map,
+			     const char *key, size_t keylen,
+			     void *value)
+{
+	struct attr_hash_entry *e;
+
+	if (!map->map.tablesize)
+		attr_hashmap_init(map);
+
+	e = xmalloc(sizeof(struct attr_hash_entry));
+	hashmap_entry_init(e, memhash(key, keylen));
+	e->key = key;
+	e->keylen = keylen;
+	e->value = value;
+
+	hashmap_add(&map->map, e);
 }
 
 static int attr_name_valid(const char *name, size_t namelen)
@@ -103,37 +172,44 @@ static void report_invalid_attr(const char *name, size_t len,
 	strbuf_release(&err);
 }
 
-static struct git_attr *git_attr_internal(const char *name, int len)
+/*
+ * Given a 'name', lookup and return the corresponding attribute in the global
+ * dictionary.  If no entry is found, create a new attribute and store it in
+ * the dictionary.
+ */
+static struct git_attr *git_attr_internal(const char *name, int namelen)
 {
-	unsigned hval = hash_name(name, len);
-	unsigned pos = hval % HASHSIZE;
 	struct git_attr *a;
 
-	for (a = git_attr_hash[pos]; a; a = a->next) {
-		if (a->h == hval &&
-		    !memcmp(a->name, name, len) && !a->name[len])
-			return a;
-	}
-
-	if (!attr_name_valid(name, len))
+	if (!attr_name_valid(name, namelen))
 		return NULL;
 
-	FLEX_ALLOC_MEM(a, name, name, len);
-	a->h = hval;
-	a->next = git_attr_hash[pos];
-	a->attr_nr = attr_nr++;
-	a->maybe_macro = 0;
-	a->maybe_real = 0;
-	git_attr_hash[pos] = a;
+	hashmap_lock(&g_attr_hashmap);
+
+	a = attr_hashmap_get(&g_attr_hashmap, name, namelen);
+
+	if (!a) {
+		FLEX_ALLOC_MEM(a, name, name, namelen);
+		a->attr_nr = g_attr_hashmap.map.size;
+		a->maybe_real = 0;
+		a->maybe_macro = 0;
+
+		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
+		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
+
+		/*
+		 * NEEDSWORK: per git_attr_check check_all_attr
+		 * will be initialized a lot more lazily, not
+		 * like this, and not here.
+		 */
+		REALLOC_ARRAY(check_all_attr, ++attr_nr);
+		check_all_attr[a->attr_nr].attr = a;
+		check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
+		assert(a->attr_nr == (attr_nr - 1));
+	}
+
+	hashmap_unlock(&g_attr_hashmap);
 
-	/*
-	 * NEEDSWORK: per git_attr_check check_all_attr
-	 * will be initialized a lot more lazily, not
-	 * like this, and not here.
-	 */
-	REALLOC_ARRAY(check_all_attr, attr_nr);
-	check_all_attr[a->attr_nr].attr = a;
-	check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
 	return a;
 }
 
@@ -941,3 +1017,8 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 		drop_attr_stack();
 	use_index = istate;
 }
+
+void attr_start(void)
+{
+	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
+}
diff --git a/attr.h b/attr.h
index 3db9893ef..8505bca79 100644
--- a/attr.h
+++ b/attr.h
@@ -67,4 +67,6 @@ enum git_attr_direction {
 };
 void git_attr_set_direction(enum git_attr_direction, struct index_state *);
 
+extern void attr_start(void);
+
 #endif /* ATTR_H */
diff --git a/common-main.c b/common-main.c
index c654f9555..6a689007e 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "attr.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -33,6 +34,8 @@ int main(int argc, const char **argv)
 
 	git_setup_gettext();
 
+	attr_start();
+
 	git_extract_argv0_path(argv[0]);
 
 	restore_sigpipe_to_default();
-- 
2.11.0.390.gc69c2f50cf-goog

