Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37331FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbdALXzd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:33 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33185 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f169.google.com with SMTP id y143so20697826pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GCAFkJxuyjcAxiCDqvX+76LFveI3n3PqBFismeuDiQ=;
        b=wLt3SRpNt1GCg80GsbCbUw3DDyq5Ne9zTcduephJQl/+van3h5sDAPTo7IUOUrt38C
         CMdxZMR7/kFiZy19O3hJYigxBI8SzFKekT+GmOAUIDPgXeebOHVVY31YPOWEaDS7f/qN
         UtT5RjaWQxtYOBsCw2fhuaLZeJlw7R54dZE3wXHzQLKCEVaK6/Yiyy/l+QclTfqj5ld8
         R6jnAs9PBPu4wkU0IUkikWCPZB48v4raHw8aSsLxUiBd1jlIKbEIrHjvIqQ/DHVolAwi
         /n1qdScPBG6yVmb6+G1p21D6eZYoUBPJNU0CPNjgyHvX1fPOBQagkr80egA+0lY920wu
         f0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GCAFkJxuyjcAxiCDqvX+76LFveI3n3PqBFismeuDiQ=;
        b=soR3z4Jzy9RXUM5k8OJh/pTY0YeCkoI8lsNx7t5b0fyv33n4hZ0KfaE6dBshJ8OGy0
         DwVOC0KNUm6BbBHAGrRpA2YfQYm6aVA6gfHG4AmLBuHKIeYQtkAHSfxH0nkDrhm67Y1p
         Ty6u0Y6KeZ6paJAbYBYKCkhnTFIBjiAxs16/4mdDhWbO23LeljDRaPDSTL1KGEhll3qk
         J6xmcClWoWgOdIl4QXmTuwRkRqomGMYJb96ZzRlk7RWJE68X0u+nmc/1C/bEEZDyPrD/
         ojdG3sZLf7VOSKvM2LKSr8u4WygC6/0Q+VbjIsbBWIief5/u5adyxj1WAdf1sjXFPU8W
         m68g==
X-Gm-Message-State: AIkVDXI1oaC7jeDWgaF+Jfwn0BYzLMMxe2xcSwLa49nf5JpqsdW2M1sZbft93tcDX5AsJCo+
X-Received: by 10.99.202.73 with SMTP id o9mr20785093pgi.47.1484265276471;
        Thu, 12 Jan 2017 15:54:36 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 22/27] attr: eliminate global check_all_attr array
Date:   Thu, 12 Jan 2017 15:53:49 -0800
Message-Id: <20170112235354.153403-23-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is a reliance on 'check_all_attr' which is a global
array of 'attr_check_item' items which is used to store the value of
each attribute during the collection process.

This patch eliminates this global and instead creates an array per
'attr_check' instance which is then used in the attribute collection
process.  This brings the attribute system one step closer to being
thread-safe.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 114 +++++++++++++++++++++++++++++++++++++++++++----------------------
 attr.h |   2 ++
 2 files changed, 78 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 8cf2ea901..38b0d4347 100644
--- a/attr.c
+++ b/attr.c
@@ -34,7 +34,6 @@ struct git_attr {
 	int maybe_real;
 	char name[FLEX_ARRAY]; /* attribute name */
 };
-static int attr_nr;
 
 /*
  * NEEDSWORK: maybe-real, maybe-macro are not property of
@@ -45,9 +44,6 @@ static int attr_nr;
  */
 static int cannot_trust_maybe_real;
 
-/* NEEDSWORK: This will become per git_attr_check */
-static struct attr_check_item *check_all_attr;
-
 const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
@@ -143,6 +139,52 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 	hashmap_add(&map->map, e);
 }
 
+/*
+ * Reallocate and reinitialize the array of all attributes (which is used in
+ * the attribute collection process) in 'check' based on the global dictionary
+ * of attributes.
+ */
+static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
+{
+	int i;
+
+	hashmap_lock(map);
+
+	if (map->map.size < check->all_attrs_nr)
+		die("BUG: interned attributes shouldn't be deleted");
+
+	/*
+	 * If the number of attributes in the global dictionary has increased
+	 * (or this attr_check instance doesn't have an initialized all_attrs
+	 * field), reallocate the provided attr_check instance's all_attrs
+	 * field and fill each entry with its corresponding git_attr.
+	 */
+	if (map->map.size != check->all_attrs_nr) {
+		struct attr_hash_entry *e;
+		struct hashmap_iter iter;
+		hashmap_iter_init(&map->map, &iter);
+
+		REALLOC_ARRAY(check->all_attrs, map->map.size);
+		check->all_attrs_nr = map->map.size;
+
+		while ((e = hashmap_iter_next(&iter))) {
+			const struct git_attr *a = e->value;
+			check->all_attrs[a->attr_nr].attr = a;
+		}
+	}
+
+	hashmap_unlock(map);
+
+	/*
+	 * Re-initialize every entry in check->all_attrs.
+	 * This re-initialization can live outside of the locked region since
+	 * the attribute dictionary is no longer being accessed.
+	 */
+	for (i = 0; i < check->all_attrs_nr; i++) {
+		check->all_attrs[i].value = ATTR__UNKNOWN;
+	}
+}
+
 static int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
@@ -196,16 +238,6 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 
 		attr_hashmap_add(&g_attr_hashmap, a->name, namelen, a);
 		assert(a->attr_nr == (g_attr_hashmap.map.size - 1));
-
-		/*
-		 * NEEDSWORK: per git_attr_check check_all_attr
-		 * will be initialized a lot more lazily, not
-		 * like this, and not here.
-		 */
-		REALLOC_ARRAY(check_all_attr, ++attr_nr);
-		check_all_attr[a->attr_nr].attr = a;
-		check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
-		assert(a->attr_nr == (attr_nr - 1));
 	}
 
 	hashmap_unlock(&g_attr_hashmap);
@@ -791,16 +823,16 @@ static int path_matches(const char *pathname, int pathlen,
 			      pattern, prefix, pat->patternlen, pat->flags);
 }
 
-static int macroexpand_one(int attr_nr, int rem);
+static int macroexpand_one(struct attr_check_item *all_attrs, int nr, int rem);
 
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static int fill_one(const char *what, struct attr_check_item *all_attrs,
+		    struct match_attr *a, int rem)
 {
-	struct attr_check_item *check = check_all_attr;
 	int i;
 
-	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
+	for (i = a->num_attr - 1; rem > 0 && i >= 0; i--) {
 		struct git_attr *attr = a->state[i].attr;
-		const char **n = &(check[attr->attr_nr].value);
+		const char **n = &(all_attrs[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
@@ -809,14 +841,15 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 				  attr, v);
 			*n = v;
 			rem--;
-			rem = macroexpand_one(attr->attr_nr, rem);
+			rem = macroexpand_one(all_attrs, attr->attr_nr, rem);
 		}
 	}
 	return rem;
 }
 
 static int fill(const char *path, int pathlen, int basename_offset,
-		struct attr_stack *stk, int rem)
+		struct attr_stack *stk, struct attr_check_item *all_attrs,
+		int rem)
 {
 	int i;
 	const char *base = stk->origin ? stk->origin : "";
@@ -827,18 +860,18 @@ static int fill(const char *path, int pathlen, int basename_offset,
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
 				 &a->u.pat, base, stk->originlen))
-			rem = fill_one("fill", a, rem);
+			rem = fill_one("fill", all_attrs, a, rem);
 	}
 	return rem;
 }
 
-static int macroexpand_one(int nr, int rem)
+static int macroexpand_one(struct attr_check_item *all_attrs, int nr, int rem)
 {
 	struct attr_stack *stk;
 	int i;
 
-	if (check_all_attr[nr].value != ATTR__TRUE ||
-	    !check_all_attr[nr].attr->maybe_macro)
+	if (all_attrs[nr].value != ATTR__TRUE ||
+	    !all_attrs[nr].attr->maybe_macro)
 		return rem;
 
 	for (stk = attr_stack; stk; stk = stk->prev) {
@@ -847,7 +880,7 @@ static int macroexpand_one(int nr, int rem)
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				return fill_one("expand", ma, rem);
+				return fill_one("expand", all_attrs, ma, rem);
 		}
 	}
 
@@ -855,9 +888,9 @@ static int macroexpand_one(int nr, int rem)
 }
 
 /*
- * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * Collect attributes for path into the array pointed to by check->all_attrs.
+ * If check->check_nr is non-zero, only attributes in check[] are collected.
+ * Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, struct attr_check *check)
 {
@@ -880,15 +913,15 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 	}
 
 	prepare_attr_stack(path, dirlen);
-	for (i = 0; i < attr_nr; i++)
-		check_all_attr[i].value = ATTR__UNKNOWN;
+	all_attrs_init(&g_attr_hashmap, check);
+
 	if (check->check_nr && !cannot_trust_maybe_real) {
 		rem = 0;
 		for (i = 0; i < check->check_nr; i++) {
 			const struct git_attr *a = check->check[i].attr;
 			if (!a->maybe_real) {
 				struct attr_check_item *c;
-				c = check_all_attr + a->attr_nr;
+				c = check->all_attrs + a->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -897,9 +930,9 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
 			return;
 	}
 
-	rem = attr_nr;
+	rem = check->all_attrs_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, basename_offset, stk, rem);
+		rem = fill(path, pathlen, basename_offset, stk, check->all_attrs, rem);
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
@@ -909,7 +942,8 @@ int git_check_attr(const char *path, struct attr_check *check)
 	collect_some_attrs(path, check);
 
 	for (i = 0; i < check->check_nr; i++) {
-		const char *value = check_all_attr[check->check[i].attr->attr_nr].value;
+		size_t index = check->check[i].attr->attr_nr;
+		const char *value = check->all_attrs[index].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
 		check->check[i].value = value;
@@ -925,9 +959,9 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	attr_check_reset(check);
 	collect_some_attrs(path, check);
 
-	for (i = 0; i < attr_nr; i++) {
-		const char *name = check_all_attr[i].attr->name;
-		const char *value = check_all_attr[i].value;
+	for (i = 0; i < check->all_attrs_nr; i++) {
+		const char *name = check->all_attrs[i].attr->name;
+		const char *value = check->all_attrs[i].value;
 		struct attr_check_item *item;
 		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
 			continue;
@@ -997,6 +1031,10 @@ void attr_check_clear(struct attr_check *check)
 	check->check = NULL;
 	check->check_alloc = 0;
 	check->check_nr = 0;
+
+	free(check->all_attrs);
+	check->all_attrs = NULL;
+	check->all_attrs_nr = 0;
 }
 
 void attr_check_free(struct attr_check *check)
diff --git a/attr.h b/attr.h
index 8505bca79..44b21d82c 100644
--- a/attr.h
+++ b/attr.h
@@ -33,6 +33,8 @@ struct attr_check {
 	int check_nr;
 	int check_alloc;
 	struct attr_check_item *check;
+	int all_attrs_nr;
+	struct attr_check_item *all_attrs;
 };
 
 extern struct attr_check *attr_check_alloc(void);
-- 
2.11.0.390.gc69c2f50cf-goog

