Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B68C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2BF61C6C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGGXNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:13:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54098 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhGGXND (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:13:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 52BB31F8C7;
        Wed,  7 Jul 2021 23:10:20 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] speed up alt_odb_usable() with many alternates
Date:   Wed,  7 Jul 2021 23:10:15 +0000
Message-Id: <20210707231019.14738-2-e@80x24.org>
In-Reply-To: <20210629205305.7100-1-e@80x24.org>
References: <20210629205305.7100-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With many alternates, the duplicate check in alt_odb_usable()
wastes many cycles doing repeated fspathcmp() on every existing
alternate.  Use a khash to speed up lookups by odb->path.

Since the kh_put_* API uses the supplied key without
duplicating it, we also take advantage of it to replace both
xstrdup() and strbuf_release() in link_alt_odb_entry() with
strbuf_detach() to avoid the allocation and copy.

In a test repository with 50K alternates and each of those 50K
alternates having one alternate each (for a total of 100K total
alternates); this speeds up lookup of a non-existent blob from
over 16 minutes to roughly 2.7 seconds on my busy workstation.

Note: all underlying git object directories were small and
unpacked with only loose objects and no packs.  Having to load
packs increases times significantly.

v3: Introduce and use fspatheq and fspathhash functions;
    avoid unnecessary checks for allocation failures already
    handled by our own *alloc wrappers.

Signed-off-by: Eric Wong <e@80x24.org>
---
 dir.c          | 10 ++++++++++
 dir.h          |  2 ++
 object-file.c  | 33 +++++++++++++++++++++------------
 object-store.h |  7 +++++++
 object.c       |  2 ++
 5 files changed, 42 insertions(+), 12 deletions(-)

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
index f233b440b2..a13f49b192 100644
--- a/object-file.c
+++ b/object-file.c
@@ -517,9 +517,9 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
  */
 static int alt_odb_usable(struct raw_object_store *o,
 			  struct strbuf *path,
-			  const char *normalized_objdir)
+			  const char *normalized_objdir, khiter_t *pos)
 {
-	struct object_directory *odb;
+	int r;
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
@@ -533,14 +533,20 @@ static int alt_odb_usable(struct raw_object_store *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (odb = o->odb; odb; odb = odb->next) {
-		if (!fspathcmp(path->buf, odb->path))
-			return 0;
+	if (!o->odb_by_path) {
+		khiter_t p;
+
+		o->odb_by_path = kh_init_odb_path_map();
+		assert(!o->odb->next);
+		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
+		assert(r == 1); /* never used */
+		kh_value(o->odb_by_path, p) = o->odb;
 	}
-	if (!fspathcmp(path->buf, normalized_objdir))
+	if (fspatheq(path->buf, normalized_objdir))
 		return 0;
-
-	return 1;
+	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
+	/* r: 0 = exists, 1 = never used, 2 = deleted */
+	return r == 0 ? 0 : 1;
 }
 
 /*
@@ -566,6 +572,7 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 {
 	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
+	khiter_t pos;
 
 	if (!is_absolute_path(entry) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -587,23 +594,25 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
 
 	CALLOC_ARRAY(ent, 1);
-	ent->path = xstrdup(pathbuf.buf);
+	/* pathbuf.buf is already in r->objects->odb_by_path */
+	ent->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
 	*r->objects->odb_tail = ent;
 	r->objects->odb_tail = &(ent->next);
 	ent->next = NULL;
+	assert(r->objects->odb_by_path);
+	kh_value(r->objects->odb_by_path, pos) = ent;
 
 	/* recursively add alternates */
-	read_info_alternates(r, pathbuf.buf, depth + 1);
+	read_info_alternates(r, ent->path, depth + 1);
 
-	strbuf_release(&pathbuf);
 	return 0;
 }
 
diff --git a/object-store.h b/object-store.h
index ec32c23dcb..6077065d90 100644
--- a/object-store.h
+++ b/object-store.h
@@ -7,6 +7,8 @@
 #include "oid-array.h"
 #include "strbuf.h"
 #include "thread-utils.h"
+#include "khash.h"
+#include "dir.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -30,6 +32,9 @@ struct object_directory {
 	char *path;
 };
 
+KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
+	struct object_directory *, 1, fspathhash, fspatheq);
+
 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct object_directory *, void *);
@@ -116,6 +121,8 @@ struct raw_object_store {
 	 */
 	struct object_directory *odb;
 	struct object_directory **odb_tail;
+	kh_odb_path_map_t *odb_by_path;
+
 	int loaded_alternates;
 
 	/*
diff --git a/object.c b/object.c
index 14188453c5..2b3c075a15 100644
--- a/object.c
+++ b/object.c
@@ -511,6 +511,8 @@ static void free_object_directories(struct raw_object_store *o)
 		free_object_directory(o->odb);
 		o->odb = next;
 	}
+	kh_destroy_odb_path_map(o->odb_by_path);
+	o->odb_by_path = NULL;
 }
 
 void raw_object_store_clear(struct raw_object_store *o)
