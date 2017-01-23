Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FB720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdAWUgP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:15 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35983 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdAWUgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:36:09 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so43794538pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYbxwuaVVxveNW4jsId5+SZQwFpo1LZFK7DE9W9uIXA=;
        b=qZaFsJKLihM3nxTj+ynMP68XYuUiFUKaoc6epYxs0fq1BvkdaZG0hY/chnsX36fMI2
         DOaujPQEa2vUn23SBRy7M8LkO8ZW85cKodsKDzA6eIq+yVbF+8vdARx0HaAtElR+JTlF
         NGgbXPHyRnku/PC7yqhxHTvdYA2H5yxCU7x5Wkliz/94bbO40IQPEXb3qbSVNUK4pyLM
         /UCU8XyPEqocQaESeyeH22PB/KNX0cr/6AyBnBFjVHX0W7VmsQrdvBfTKCYyo1Vlkbkj
         S4WcfKRl85giDYWI/WhNSwJv/jJmXqYEYiXosZMBJRez+2yjjGScR8QpsMHoSRwk0+5g
         5/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYbxwuaVVxveNW4jsId5+SZQwFpo1LZFK7DE9W9uIXA=;
        b=m8U35HsOOpAecZXDDDuhZT0m2QfBhL2upqwGRbIE5p8Q0nkI9vZv+4MURW5xBy5OB7
         nhI0njNriHAqiGz9cOE9auAaeFiwrckNBkySYiQctnb36n48SnSDcJuguUK4VQhQ4nh4
         2VXq9/rSWEAkvJwojYlRrQeVXdLUi53RcmLXUscTxlhz11xzDKE9WfpGjfivyWMFv3R+
         GDe2YcnGfEzpAeCF5LBX+qCTMxqWZ8JLrF/wNdRc4jufYbTfOITi933ceJn7AbnLJGaS
         9w/N75pNePvL4YjzYnI7ERRL4DVtgKdywc35VTMnPPUII/lLNntKt371VsU2iayd965Y
         4J/Q==
X-Gm-Message-State: AIkVDXJ9XEWnr6EERIX4+7jSSUCPWla2DnbcRt74Uwgk+fh9ezgDwKUjC49wqN9H5uNZqSDO
X-Received: by 10.98.149.93 with SMTP id p90mr34536957pfd.72.1485203768481;
        Mon, 23 Jan 2017 12:36:08 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 21/27] attr: use hashmap for attribute dictionary
Date:   Mon, 23 Jan 2017 12:35:19 -0800
Message-Id: <20170123203525.185058-22-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
 attr.c        | 173 +++++++++++++++++++++++++++++++++++++++++++---------------
 attr.h        |   2 +
 common-main.c |   3 +
 3 files changed, 133 insertions(+), 45 deletions(-)

diff --git a/attr.c b/attr.c
index 5399e1cb3..d2ece4eba 100644
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
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_lock(&map->mutex);
+#endif
+}
+
+static inline void hashmap_unlock(struct attr_hashmap *map)
 {
-	unsigned val = 0, c;
+#ifndef NO_PTHREADS
+	pthread_mutex_unlock(&map->mutex);
+#endif
+}
 
-	while (namelen--) {
-		c = *name++;
-		val = ((val << 7) | (val >> 22)) ^ c;
-	}
-	return val;
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
+static void attr_hashmap_init(struct attr_hashmap *map)
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
 
@@ -941,3 +1017,10 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 		drop_attr_stack();
 	use_index = istate;
 }
+
+void attr_start(void)
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
+#endif
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
2.11.0.483.g087da7b7c-goog

