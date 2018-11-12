Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D08A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeKMAoe (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:44:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:35750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726443AbeKMAoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:44:34 -0500
Received: (qmail 29487 invoked by uid 109); 12 Nov 2018 14:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11321 invoked by uid 111); 12 Nov 2018 14:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:50:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:50:56 -0500
Date:   Mon, 12 Nov 2018 09:50:56 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 7/9] object-store: provide helpers for loose_objects_cache
Message-ID: <20181112145056.GG7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our object_directory struct has a loose objects cache that all users of
the struct can see. But the only one that knows how to load the cache is
find_short_object_filename(). Let's extract that logic in to a reusable
function.

While we're at it, let's also reset the cache when we re-read the object
directories. This shouldn't have an impact on performance, as re-reads
are meant to be rare (and are already expensive, so we avoid them with
things like OBJECT_INFO_QUICK).

Since the cache is already meant to be an approximation, it's tempting
to skip even this bit of safety. But it's necessary to allow more code
to use it. For instance, fetch-pack explicitly re-reads the object
directory after performing its fetch, and would be confused if we didn't
clear the cache.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-store.h | 18 +++++++++++++-----
 packfile.c     |  8 ++++++++
 sha1-file.c    | 26 ++++++++++++++++++++++++++
 sha1-name.c    | 21 +--------------------
 4 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/object-store.h b/object-store.h
index 30faf7b391..bf1e0cb761 100644
--- a/object-store.h
+++ b/object-store.h
@@ -11,11 +11,12 @@ struct object_directory {
 	struct object_directory *next;
 
 	/*
-	 * Used to store the results of readdir(3) calls when searching
-	 * for unique abbreviated hashes.  This cache is never
-	 * invalidated, thus it's racy and not necessarily accurate.
-	 * That's fine for its purpose; don't use it for tasks requiring
-	 * greater accuracy!
+	 * Used to store the results of readdir(3) calls when we are OK
+	 * sacrificing accuracy due to races for speed. That includes
+	 * our search for unique abbreviated hashes. Don't use it for tasks
+	 * requiring greater accuracy!
+	 *
+	 * Be sure to call odb_load_loose_cache() before using.
 	 */
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
@@ -45,6 +46,13 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
+/*
+ * Populate an odb's loose object cache for one particular subdirectory (i.e.,
+ * the one that corresponds to the first byte of objects you're interested in,
+ * from 0 to 255 inclusive).
+ */
+void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
+
 struct packed_git {
 	struct packed_git *next;
 	struct list_head mru;
diff --git a/packfile.c b/packfile.c
index 1eda33247f..91fd40efb0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -987,6 +987,14 @@ static void prepare_packed_git(struct repository *r)
 
 void reprepare_packed_git(struct repository *r)
 {
+	struct object_directory *odb;
+
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		oid_array_clear(&odb->loose_objects_cache);
+		memset(&odb->loose_objects_subdir_seen, 0,
+		       sizeof(odb->loose_objects_subdir_seen));
+	}
+
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
 	prepare_packed_git(r);
diff --git a/sha1-file.c b/sha1-file.c
index 503262edd2..4aae716a37 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2125,6 +2125,32 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
 	return 0;
 }
 
+static int append_loose_object(const struct object_id *oid, const char *path,
+			       void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
+void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (subdir_nr < 0 ||
+	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))
+		BUG("subdir_nr out of range");
+
+	if (odb->loose_objects_subdir_seen[subdir_nr])
+		return;
+
+	strbuf_addstr(&buf, odb->path);
+	for_each_file_in_obj_subdir(subdir_nr, &buf,
+				    append_loose_object,
+				    NULL, NULL,
+				    &odb->loose_objects_cache);
+	odb->loose_objects_subdir_seen[subdir_nr] = 1;
+}
+
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
 			     unsigned long size,
diff --git a/sha1-name.c b/sha1-name.c
index 358ca5e288..b24502811b 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -83,36 +83,19 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
-static int append_loose_object(const struct object_id *oid, const char *path,
-			       void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
 static int match_sha(unsigned, const unsigned char *, const unsigned char *);
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	int subdir_nr = ds->bin_pfx.hash[0];
 	struct object_directory *odb;
-	struct strbuf buf = STRBUF_INIT;
 
 	for (odb = the_repository->objects->odb;
 	     odb && !ds->ambiguous;
 	     odb = odb->next) {
 		int pos;
 
-		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
-			strbuf_reset(&buf);
-			strbuf_addstr(&buf, odb->path);
-			for_each_file_in_obj_subdir(subdir_nr, &buf,
-						    append_loose_object,
-						    NULL, NULL,
-						    &odb->loose_objects_cache);
-			odb->loose_objects_subdir_seen[subdir_nr] = 1;
-		}
-
+		odb_load_loose_cache(odb, subdir_nr);
 		pos = oid_array_lookup(&odb->loose_objects_cache, &ds->bin_pfx);
 		if (pos < 0)
 			pos = -1 - pos;
@@ -125,8 +108,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 			pos++;
 		}
 	}
-
-	strbuf_release(&buf);
 }
 
 static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
-- 
2.19.1.1577.g2c5b293d4f

