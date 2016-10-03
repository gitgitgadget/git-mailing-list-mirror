Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C585207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbcJCUgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:51463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbcJCUgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:36:07 -0400
Received: (qmail 17438 invoked by uid 109); 3 Oct 2016 20:36:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:36:07 +0000
Received: (qmail 29860 invoked by uid 111); 3 Oct 2016 20:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:36:04 -0400
Date:   Mon, 3 Oct 2016 16:36:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 14/18] alternates: store scratch buffer as strbuf
Message-ID: <20161003203604.6qwvc226nkgw44d2@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pre-size the scratch buffer to hold a loose object
filename of the form "xx/yyyy...", which leads to allocation
code that is hard to verify. We have to use some magic
numbers during the initial allocation, and then writers must
blindly assume that the buffer is big enough. Using a strbuf
makes it more clear that we cannot overflow.

Unfortunately, we do still need some magic numbers to grow
our strbuf before calling fill_sha1_path(), but the strbuf
growth is much closer to the point of use. This makes it
easier to see that it's correct, and opens the possibility
of pushing it even further down if fill_sha1_path() learns
to work on strbufs.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 13 +++++++++++--
 sha1_file.c | 28 ++++++++++++++++++----------
 sha1_name.c |  9 +++------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index e1996c5..9866e46 100644
--- a/cache.h
+++ b/cache.h
@@ -1383,8 +1383,9 @@ extern void remove_scheduled_dirs(void);
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 
-	char *name;
-	char *scratch;
+	/* see alt_scratch_buf() */
+	struct strbuf scratch;
+	size_t base_len;
 
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
@@ -1413,6 +1414,14 @@ extern void add_to_alternates_file(const char *dir);
  */
 extern void add_to_alternates_memory(const char *dir);
 
+/*
+ * Returns a scratch strbuf pre-filled with the alternate object directory,
+ * including a trailing slash, which can be used to access paths in the
+ * alternate. Always use this over direct access to alt->scratch, as it
+ * cleans up any previous use of the scratch buffer.
+ */
+extern struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/sha1_file.c b/sha1_file.c
index c6308c1..efc8cee 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -204,11 +204,24 @@ const char *sha1_file_name(const unsigned char *sha1)
 	return buf;
 }
 
+struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
+{
+	strbuf_setlen(&alt->scratch, alt->base_len);
+	return &alt->scratch;
+}
+
 static const char *alt_sha1_path(struct alternate_object_database *alt,
 				 const unsigned char *sha1)
 {
-	fill_sha1_path(alt->name, sha1);
-	return alt->scratch;
+	/* hex sha1 plus internal "/" */
+	size_t len = GIT_SHA1_HEXSZ + 1;
+	struct strbuf *buf = alt_scratch_buf(alt);
+
+	strbuf_grow(buf, len);
+	fill_sha1_path(buf->buf + buf->len, sha1);
+	strbuf_setlen(buf, buf->len + len);
+
+	return buf->buf;
 }
 
 /*
@@ -396,16 +409,11 @@ void read_info_alternates(const char * relative_base, int depth)
 struct alternate_object_database *alloc_alt_odb(const char *dir)
 {
 	struct alternate_object_database *ent;
-	size_t dirlen = strlen(dir);
-	size_t entlen;
 
-	entlen = st_add(dirlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
 	FLEX_ALLOC_STR(ent, path, dir);
-	ent->scratch = xmalloc(entlen);
-	xsnprintf(ent->scratch, entlen, "%s/", dir);
-
-	ent->name = ent->scratch + dirlen + 1;
-	ent->scratch[dirlen] = '/';
+	strbuf_init(&ent->scratch, 0);
+	strbuf_addf(&ent->scratch, "%s/", dir);
+	ent->base_len = ent->scratch.len;
 
 	return ent;
 }
diff --git a/sha1_name.c b/sha1_name.c
index 770ea4f..defbb3e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -92,15 +92,12 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 
 	xsnprintf(hex, sizeof(hex), "%.2s", hex_pfx);
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
+		struct strbuf *buf = alt_scratch_buf(alt);
 		struct dirent *de;
 		DIR *dir;
 
-		/*
-		 * every alt_odb struct has 42 extra bytes after the base
-		 * for exactly this purpose
-		 */
-		xsnprintf(alt->name, 42, "%.2s/", hex_pfx);
-		dir = opendir(alt->scratch);
+		strbuf_addf(buf, "%.2s/", hex_pfx);
+		dir = opendir(buf->buf);
 		if (!dir)
 			continue;
 
-- 
2.10.0.618.g82cc264

