Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9481C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8721E61C69
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGGXNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:13:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53980 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhGGXNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:13:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 177181F8C6;
        Wed,  7 Jul 2021 23:10:20 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] optimizations for many alternates
Date:   Wed,  7 Jul 2021 23:10:14 +0000
Message-Id: <20210707231019.14738-1-e@80x24.org>
In-Reply-To: <20210629205305.7100-1-e@80x24.org>
References: <20210629205305.7100-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implemented suggestions from Ævar and René, noticed a few more
things that's probably worth exploring at some point...

TODO items unrelated to this series (probably for somebody else):

* try fspatheq and fspathhash in more places in hopes it can
  reduce binary + icache size

* favor ${#var} (instead of "wc -c" as as suggested by Ævar)
  to reduce fork+execve overhead in tests.  We already use ${#var}
  in t/test-lib-functions.sh, and it works in shells I've tried
  (dash, posh, ksh93, bash --posix)

* reduce internal redundancies (hash functions,
  hash table and memory pool implementations, etc.)

Eric Wong (5):
  speed up alt_odb_usable() with many alternates
  avoid strlen via strbuf_addstr in link_alt_odb_entry
  make object_directory.loose_objects_subdir_seen a bitmap
  oidcpy_with_padding: constify `src' arg
  oidtree: a crit-bit tree for odb_loose_cache

 Makefile                |   3 +
 cbtree.c                | 167 ++++++++++++++++++++++++++++++++++++++++
 cbtree.h                |  56 ++++++++++++++
 dir.c                   |  10 +++
 dir.h                   |   2 +
 hash.h                  |   2 +-
 object-file.c           |  75 ++++++++++--------
 object-name.c           |  28 +++----
 object-store.h          |  14 +++-
 object.c                |   2 +
 oidtree.c               | 104 +++++++++++++++++++++++++
 oidtree.h               |  22 ++++++
 t/helper/test-oidtree.c |  49 ++++++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t0069-oidtree.sh      |  49 ++++++++++++
 16 files changed, 534 insertions(+), 51 deletions(-)
 create mode 100644 cbtree.c
 create mode 100644 cbtree.h
 create mode 100644 oidtree.c
 create mode 100644 oidtree.h
 create mode 100644 t/helper/test-oidtree.c
 create mode 100755 t/t0069-oidtree.sh

Interdiff against v2:
diff --git a/alloc.c b/alloc.c
index ca1e178c5a..957a0af362 100644
--- a/alloc.c
+++ b/alloc.c
@@ -14,7 +14,6 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
-#include "oidtree.h"
 #include "alloc.h"
 
 #define BLOCKING 1024
@@ -124,11 +123,6 @@ void *alloc_commit_node(struct repository *r)
 	return c;
 }
 
-void *alloc_from_state(struct alloc_state *alloc_state, size_t n)
-{
-	return alloc_node(alloc_state, n);
-}
-
 static void report(const char *name, unsigned int count, size_t size)
 {
 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
diff --git a/alloc.h b/alloc.h
index 4032375aa1..371d388b55 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
-void *alloc_from_state(struct alloc_state *, size_t n);
 void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
diff --git a/dir.c b/dir.c
index ebe5ec046e..20b942d161 100644
--- a/dir.c
+++ b/dir.c
@@ -84,11 +84,21 @@ int fspathcmp(const char *a, const char *b)
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
 
+int fspatheq(const char *a, const char *b)
+{
+	return !fspathcmp(a, b);
+}
+
 int fspathncmp(const char *a, const char *b, size_t count)
 {
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
 
+unsigned int fspathhash(const char *str)
+{
+	return ignore_case ? strihash(str) : strhash(str);
+}
+
 int git_fnmatch(const struct pathspec_item *item,
 		const char *pattern, const char *string,
 		int prefix)
diff --git a/dir.h b/dir.h
index e3db9b9ec6..2af7bcd7e5 100644
--- a/dir.h
+++ b/dir.h
@@ -489,7 +489,9 @@ int remove_dir_recursively(struct strbuf *path, int flag);
 int remove_path(const char *path);
 
 int fspathcmp(const char *a, const char *b);
+int fspatheq(const char *a, const char *b);
 int fspathncmp(const char *a, const char *b, size_t count);
+unsigned int fspathhash(const char *str);
 
 /*
  * The prefix part of pattern must not contains wildcards.
diff --git a/object-file.c b/object-file.c
index 6c397fb4f1..35f3e7e9bb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -539,14 +539,12 @@ static int alt_odb_usable(struct raw_object_store *o,
 		o->odb_by_path = kh_init_odb_path_map();
 		assert(!o->odb->next);
 		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
-		if (r < 0) die_errno(_("kh_put_odb_path_map"));
 		assert(r == 1); /* never used */
 		kh_value(o->odb_by_path, p) = o->odb;
 	}
-	if (!fspathcmp(path->buf, normalized_objdir))
+	if (fspatheq(path->buf, normalized_objdir))
 		return 0;
 	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
-	if (r < 0) die_errno(_("kh_put_odb_path_map"));
 	/* r: 0 = exists, 1 = never used, 2 = deleted */
 	return r == 0 ? 0 : 1;
 }
@@ -2474,21 +2472,25 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 
 	bitmap = &odb->loose_objects_subdir_seen[word_index];
 	if (*bitmap & mask)
-		return &odb->loose_objects_cache;
-
+		return odb->loose_objects_cache;
+	if (!odb->loose_objects_cache) {
+		ALLOC_ARRAY(odb->loose_objects_cache, 1);
+		oidtree_init(odb->loose_objects_cache);
+	}
 	strbuf_addstr(&buf, odb->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    &odb->loose_objects_cache);
+				    odb->loose_objects_cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return &odb->loose_objects_cache;
+	return odb->loose_objects_cache;
 }
 
 void odb_clear_loose_cache(struct object_directory *odb)
 {
-	oidtree_destroy(&odb->loose_objects_cache);
+	oidtree_clear(odb->loose_objects_cache);
+	FREE_AND_NULL(odb->loose_objects_cache);
 	memset(&odb->loose_objects_subdir_seen, 0,
 	       sizeof(odb->loose_objects_subdir_seen));
 }
diff --git a/object-store.h b/object-store.h
index b507108d18..e679acc4c3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -24,7 +24,7 @@ struct object_directory {
 	 * Be sure to call odb_load_loose_cache() before using.
 	 */
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oidtree loose_objects_cache;
+	struct oidtree *loose_objects_cache;
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
@@ -33,18 +33,8 @@ struct object_directory {
 	char *path;
 };
 
-static inline int odb_path_eq(const char *a, const char *b)
-{
-	return !fspathcmp(a, b);
-}
-
-static inline int odb_path_hash(const char *str)
-{
-	return ignore_case ? strihash(str) : __ac_X31_hash_string(str);
-}
-
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, odb_path_hash, odb_path_eq);
+	struct object_directory *, 1, fspathhash, fspatheq);
 
 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
diff --git a/oidtree.c b/oidtree.c
index c1188d8f48..7eb0e9ba05 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -19,46 +19,55 @@ struct oidtree_iter_data {
 	uint8_t last_byte;
 };
 
-void oidtree_destroy(struct oidtree *ot)
+void oidtree_init(struct oidtree *ot)
 {
-	if (ot->mempool) {
-		clear_alloc_state(ot->mempool);
-		FREE_AND_NULL(ot->mempool);
+	cb_init(&ot->tree);
+	mem_pool_init(&ot->mem_pool, 0);
+}
+
+void oidtree_clear(struct oidtree *ot)
+{
+	if (ot) {
+		mem_pool_discard(&ot->mem_pool, 0);
+		oidtree_init(ot);
 	}
-	oidtree_init(ot);
 }
 
 void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 {
 	struct oidtree_node *on;
 
-	if (!ot->mempool)
-		ot->mempool = allocate_alloc_state();
 	if (!oid->algo)
 		BUG("oidtree_insert requires oid->algo");
 
-	on = alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
+	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
 	oidcpy_with_padding((struct object_id *)on->n.k, oid);
 
 	/*
-	 * n.b. we shouldn't get duplicates, here, but we'll have
-	 * a small leak that won't be freed until oidtree_destroy
+	 * n.b. Current callers won't get us duplicates, here.  If a
+	 * future caller causes duplicates, there'll be a a small leak
+	 * that won't be freed until oidtree_clear.  Currently it's not
+	 * worth maintaining a free list
 	 */
-	cb_insert(&ot->t, &on->n, sizeof(*oid));
+	cb_insert(&ot->tree, &on->n, sizeof(*oid));
 }
 
+
 int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
 {
-	struct object_id k = { 0 };
+	struct object_id k;
 	size_t klen = sizeof(k);
+
 	oidcpy_with_padding(&k, oid);
 
-	if (oid->algo == GIT_HASH_UNKNOWN) {
-		k.algo = hash_algo_by_ptr(the_hash_algo);
+	if (oid->algo == GIT_HASH_UNKNOWN)
 		klen -= sizeof(oid->algo);
-	}
 
-	return cb_lookup(&ot->t, (const uint8_t *)&k, klen) ? 1 : 0;
+	/* cb_lookup relies on memcmp on the struct, so order matters: */
+	klen += BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, hash) <
+				offsetof(struct object_id, algo));
+
+	return cb_lookup(&ot->tree, (const uint8_t *)&k, klen) ? 1 : 0;
 }
 
 static enum cb_next iter(struct cb_node *n, void *arg)
@@ -78,17 +87,18 @@ static enum cb_next iter(struct cb_node *n, void *arg)
 }
 
 void oidtree_each(struct oidtree *ot, const struct object_id *oid,
-			size_t oidhexlen, oidtree_iter fn, void *arg)
+			size_t oidhexsz, oidtree_iter fn, void *arg)
 {
-	size_t klen = oidhexlen / 2;
+	size_t klen = oidhexsz / 2;
 	struct oidtree_iter_data x = { 0 };
+	assert(oidhexsz <= GIT_MAX_HEXSZ);
 
 	x.fn = fn;
 	x.arg = arg;
 	x.algo = oid->algo;
-	if (oidhexlen & 1) {
+	if (oidhexsz & 1) {
 		x.last_byte = oid->hash[klen];
 		x.last_nibble_at = &klen;
 	}
-	cb_each(&ot->t, (const uint8_t *)oid, klen, iter, &x);
+	cb_each(&ot->tree, (const uint8_t *)oid, klen, iter, &x);
 }
diff --git a/oidtree.h b/oidtree.h
index 73399bb978..77898f510a 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -3,27 +3,20 @@
 
 #include "cbtree.h"
 #include "hash.h"
+#include "mem-pool.h"
 
-struct alloc_state;
 struct oidtree {
-	struct cb_tree t;
-	struct alloc_state *mempool;
+	struct cb_tree tree;
+	struct mem_pool mem_pool;
 };
 
-#define OIDTREE_INIT { .t = CBTREE_INIT, .mempool = NULL }
-
-static inline void oidtree_init(struct oidtree *ot)
-{
-	cb_init(&ot->t);
-	ot->mempool = NULL;
-}
-
-void oidtree_destroy(struct oidtree *);
+void oidtree_init(struct oidtree *);
+void oidtree_clear(struct oidtree *);
 void oidtree_insert(struct oidtree *, const struct object_id *);
 int oidtree_contains(struct oidtree *, const struct object_id *);
 
-typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *arg);
+typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *data);
 void oidtree_each(struct oidtree *, const struct object_id *,
-			size_t oidhexlen, oidtree_iter, void *arg);
+			size_t oidhexsz, oidtree_iter, void *data);
 
 #endif /* OIDTREE_H */
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index e0da13eea3..180ee28dd9 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -10,11 +10,12 @@ static enum cb_next print_oid(const struct object_id *oid, void *data)
 
 int cmd__oidtree(int argc, const char **argv)
 {
-	struct oidtree ot = OIDTREE_INIT;
+	struct oidtree ot;
 	struct strbuf line = STRBUF_INIT;
 	int nongit_ok;
 	int algo = GIT_HASH_UNKNOWN;
 
+	oidtree_init(&ot);
 	setup_git_directory_gently(&nongit_ok);
 
 	while (strbuf_getline(&line, stdin) != EOF) {
@@ -34,14 +35,15 @@ int cmd__oidtree(int argc, const char **argv)
 			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
 			memset(&oid, 0, sizeof(oid));
 			memcpy(buf, arg, strlen(arg));
-			buf[hash_algos[algo].hexsz] = 0;
+			buf[hash_algos[algo].hexsz] = '\0';
 			get_oid_hex_any(buf, &oid);
 			oid.algo = algo;
 			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
-		} else if (!strcmp(line.buf, "destroy"))
-			oidtree_destroy(&ot);
-		else
+		} else if (!strcmp(line.buf, "clear")) {
+			oidtree_clear(&ot);
+		} else {
 			die("unknown command: %s", line.buf);
+		}
 	}
 	return 0;
 }
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index 0594f57c81..bfb1397d7b 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -3,35 +3,32 @@
 test_description='basic tests for the oidtree implementation'
 . ./test-lib.sh
 
+maxhexsz=$(test_oid hexsz)
 echoid () {
 	prefix="${1:+$1 }"
 	shift
 	while test $# -gt 0
 	do
-		echo "$1"
+		shortoid="$1"
 		shift
-	done | awk -v prefix="$prefix" -v ZERO_OID=$ZERO_OID '{
-		printf("%s%s", prefix, $0);
-		need = length(ZERO_OID) - length($0);
-		for (i = 0; i < need; i++)
-			printf("0");
-		printf "\n";
-	}'
+		difference=$(($maxhexsz - ${#shortoid}))
+		printf "%s%s%0${difference}d\\n" "$prefix" "$shortoid" "0"
+	done
 }
 
 test_expect_success 'oidtree insert and contains' '
-	cat >expect <<EOF &&
-0
-0
-0
-1
-1
-0
-EOF
+	cat >expect <<-\EOF &&
+		0
+		0
+		0
+		1
+		1
+		0
+	EOF
 	{
 		echoid insert 444 1 2 3 4 5 a b c d e &&
 		echoid contains 44 441 440 444 4440 4444
-		echo destroy
+		echo clear
 	} | test-tool oidtree >actual &&
 	test_cmp expect actual
 '
@@ -44,7 +41,7 @@ test_expect_success 'oidtree each' '
 		echo each 3211
 		echo each 3210
 		echo each 32100
-		echo destroy
+		echo clear
 	} | test-tool oidtree >actual &&
 	test_cmp expect actual
 '
