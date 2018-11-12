Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82631F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKMAmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:42:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:35706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:42:33 -0500
Received: (qmail 29352 invoked by uid 109); 12 Nov 2018 14:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:48:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11253 invoked by uid 111); 12 Nov 2018 14:48:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:48:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:48:56 -0500
Date:   Mon, 12 Nov 2018 09:48:56 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 4/9] sha1_file_name(): overwrite buffer instead of appending
Message-ID: <20181112144856.GD7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sha1_file_name() function is used to generate the path to a loose
object in the object directory. It doesn't make much sense for it to
append, since the the path we write may be absolute (i.e., you cannot
reliably build up a path with it). Because many callers use it with a
static buffer, they have to strbuf_reset() manually before each call
(and the other callers always use an empty buffer, so they don't care
either way). Let's handle this automatically.

Since we're changing the semantics, let's take the opportunity to give
it a more hash-neutral name (which will also catch any callers from
topics in flight).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c  |  2 +-
 http.c         |  4 ++--
 object-store.h |  2 +-
 sha1-file.c    | 18 ++++++++----------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b3334bf657..0a392c85b6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -547,7 +547,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		sha1_file_name(the_repository, &buf, req->sha1);
+		loose_object_path(the_repository, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 3dc8c560d6..46c2e7a275 100644
--- a/http.c
+++ b/http.c
@@ -2314,7 +2314,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(the_repository, &filename, sha1);
+	loose_object_path(the_repository, &filename, sha1);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2465,7 +2465,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	sha1_file_name(the_repository, &filename, freq->sha1);
+	loose_object_path(the_repository, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 122d5f75e2..fefa17e380 100644
--- a/object-store.h
+++ b/object-store.h
@@ -157,7 +157,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
+void loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
diff --git a/sha1-file.c b/sha1-file.c
index a3cc650a0a..478eac326b 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -346,8 +346,10 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
+void loose_object_path(struct repository *r, struct strbuf *buf,
+		       const unsigned char *sha1)
 {
+	strbuf_reset(buf);
 	strbuf_addstr(buf, r->objects->objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
@@ -735,8 +737,7 @@ static int check_and_freshen_local(const struct object_id *oid, int freshen)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
-	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, oid->hash);
+	loose_object_path(the_repository, &buf, oid->hash);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
@@ -888,7 +889,7 @@ int git_open_cloexec(const char *name, int flags)
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
- * call to sha1_file_name(), etc.
+ * call to loose_object_path(), etc.
  */
 static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 			  struct stat *st, const char **path)
@@ -896,8 +897,7 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
-	strbuf_reset(&buf);
-	sha1_file_name(r, &buf, sha1);
+	loose_object_path(r, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
@@ -926,8 +926,7 @@ static int open_sha1_file(struct repository *r,
 	int most_interesting_errno;
 	static struct strbuf buf = STRBUF_INIT;
 
-	strbuf_reset(&buf);
-	sha1_file_name(r, &buf, sha1);
+	loose_object_path(r, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -1626,8 +1625,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	strbuf_reset(&filename);
-	sha1_file_name(the_repository, &filename, oid->hash);
+	loose_object_path(the_repository, &filename, oid->hash);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-- 
2.19.1.1577.g2c5b293d4f

