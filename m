Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407531F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKMAnO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:43:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:35724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:43:14 -0500
Received: (qmail 29405 invoked by uid 109); 12 Nov 2018 14:49:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:49:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11274 invoked by uid 111); 12 Nov 2018 14:48:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:48:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:49:35 -0500
Date:   Mon, 12 Nov 2018 09:49:35 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 5/9] handle alternates paths the same as the main object dir
Message-ID: <20181112144935.GE7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we generate loose file paths for the main object directory, the
caller provides a buffer to loose_object_path (formerly sha1_file_name).
The callers generally keep their own static buffer to avoid excessive
reallocations.

But for alternate directories, each struct carries its own scratch
buffer. This is needlessly different; let's unify them.

We could go either direction here, but this patch moves the alternates
struct over to the main directory style (rather than vice-versa).
Technically the alternates style is more efficient, as it avoids
rewriting the object directory name on each call. But this is unlikely
to matter in practice, as we avoid reallocations either way (and nobody
has ever noticed or complained that the main object directory is copying
a few extra bytes before making a much more expensive system call).

And this has the advantage that the reusable buffers are tied to
particular calls, which makes the invalidation rules simpler (for
example, the return value from stat_sha1_file() used to be invalidated
by basically any other object call, but now it is affected only by other
calls to stat_sha1_file()).

We do steal the trick from alt_sha1_path() of returning a pointer to the
filled buffer, which makes a few conversions more convenient.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-store.h | 14 +-------------
 object.c       |  1 -
 sha1-file.c    | 44 ++++++++++++++++----------------------------
 sha1-name.c    |  8 ++++++--
 4 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/object-store.h b/object-store.h
index fefa17e380..b2fa0d0df0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -10,10 +10,6 @@
 struct object_directory {
 	struct object_directory *next;
 
-	/* see alt_scratch_buf() */
-	struct strbuf scratch;
-	size_t base_len;
-
 	/*
 	 * Used to store the results of readdir(3) calls when searching
 	 * for unique abbreviated hashes.  This cache is never
@@ -54,14 +50,6 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
-/*
- * Returns a scratch strbuf pre-filled with the alternate object directory,
- * including a trailing slash, which can be used to access paths in the
- * alternate. Always use this over direct access to alt->scratch, as it
- * cleans up any previous use of the scratch buffer.
- */
-struct strbuf *alt_scratch_buf(struct object_directory *odb);
-
 struct packed_git {
 	struct packed_git *next;
 	struct list_head mru;
@@ -157,7 +145,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-void loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
+const char *loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
diff --git a/object.c b/object.c
index 6af8e908bb..dd485ac629 100644
--- a/object.c
+++ b/object.c
@@ -484,7 +484,6 @@ struct raw_object_store *raw_object_store_new(void)
 
 static void free_alt_odb(struct object_directory *odb)
 {
-	strbuf_release(&odb->scratch);
 	oid_array_clear(&odb->loose_objects_cache);
 	free(odb);
 }
diff --git a/sha1-file.c b/sha1-file.c
index 478eac326b..15db6b61a9 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -346,27 +346,20 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void loose_object_path(struct repository *r, struct strbuf *buf,
-		       const unsigned char *sha1)
+static const char *odb_loose_path(const char *path, struct strbuf *buf,
+				  const unsigned char *sha1)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, r->objects->objectdir);
+	strbuf_addstr(buf, path);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
+	return buf->buf;
 }
 
-struct strbuf *alt_scratch_buf(struct object_directory *odb)
+const char *loose_object_path(struct repository *r, struct strbuf *buf,
+			      const unsigned char *sha1)
 {
-	strbuf_setlen(&odb->scratch, odb->base_len);
-	return &odb->scratch;
-}
-
-static const char *alt_sha1_path(struct object_directory *odb,
-				 const unsigned char *sha1)
-{
-	struct strbuf *buf = alt_scratch_buf(odb);
-	fill_sha1_path(buf, sha1);
-	return buf->buf;
+	return odb_loose_path(r->objects->objectdir, buf, sha1);
 }
 
 /*
@@ -547,9 +540,6 @@ struct object_directory *alloc_alt_odb(const char *dir)
 	struct object_directory *ent;
 
 	FLEX_ALLOC_STR(ent, path, dir);
-	strbuf_init(&ent->scratch, 0);
-	strbuf_addf(&ent->scratch, "%s/", dir);
-	ent->base_len = ent->scratch.len;
 
 	return ent;
 }
@@ -745,10 +735,12 @@ static int check_and_freshen_local(const struct object_id *oid, int freshen)
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
 	struct object_directory *odb;
+	static struct strbuf path = STRBUF_INIT;
+
 	prepare_alt_odb(the_repository);
 	for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
-		const char *path = alt_sha1_path(odb, oid->hash);
-		if (check_and_freshen_file(path, freshen))
+		odb_loose_path(odb->path, &path, oid->hash);
+		if (check_and_freshen_file(path.buf, freshen))
 			return 1;
 	}
 	return 0;
@@ -889,7 +881,7 @@ int git_open_cloexec(const char *name, int flags)
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
- * call to loose_object_path(), etc.
+ * call to stat_sha1_file().
  */
 static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 			  struct stat *st, const char **path)
@@ -897,16 +889,14 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
-	loose_object_path(r, &buf, sha1);
-	*path = buf.buf;
-
+	*path = loose_object_path(r, &buf, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
 	prepare_alt_odb(r);
 	errno = ENOENT;
 	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
-		*path = alt_sha1_path(odb, sha1);
+		*path = odb_loose_path(odb->path, &buf, sha1);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -926,9 +916,7 @@ static int open_sha1_file(struct repository *r,
 	int most_interesting_errno;
 	static struct strbuf buf = STRBUF_INIT;
 
-	loose_object_path(r, &buf, sha1);
-	*path = buf.buf;
-
+	*path = loose_object_path(r, &buf, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -936,7 +924,7 @@ static int open_sha1_file(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
-		*path = alt_sha1_path(odb, sha1);
+		*path = odb_loose_path(odb->path, &buf, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
diff --git a/sha1-name.c b/sha1-name.c
index 2594aa79f8..96a8e71482 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -97,6 +97,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	int subdir_nr = ds->bin_pfx.hash[0];
 	struct object_directory *odb;
 	static struct object_directory *fakeent;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!fakeent) {
 		/*
@@ -114,8 +115,9 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		int pos;
 
 		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
-			struct strbuf *buf = alt_scratch_buf(odb);
-			for_each_file_in_obj_subdir(subdir_nr, buf,
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, odb->path);
+			for_each_file_in_obj_subdir(subdir_nr, &buf,
 						    append_loose_object,
 						    NULL, NULL,
 						    &odb->loose_objects_cache);
@@ -134,6 +136,8 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 			pos++;
 		}
 	}
+
+	strbuf_release(&buf);
 }
 
 static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
-- 
2.19.1.1577.g2c5b293d4f

