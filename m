Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222FCC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052C92076E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406872AbgFYTs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406836AbgFYTsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:23 -0400
Received: (qmail 31372 invoked by uid 109); 25 Jun 2020 19:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jun 2020 19:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19595 invoked by uid 111); 25 Jun 2020 19:48:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jun 2020 15:48:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Jun 2020 15:48:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/11] fast-export: tighten anonymize_mem() interface to
 handle only strings
Message-ID: <20200625194821.GD4029374@coredump.intra.peff.net>
References: <20200625194802.GA4028913@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625194802.GA4028913@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the anonymize_mem() interface _can_ store arbitrary byte
sequences, none of the callers uses this feature (as of the previous
commit). We'd like to keep it that way, as we'll be exposing the
string-like nature of the anonymization routines to the user. So let's
tighten up the interface a bit:

  - don't treat "len" as an out-parameter from anonymize_mem(); this
    ensures callers treat the pointer result as a NUL-terminated string

  - likewise, don't treat "len" as an out-parameter from generator
    functions

  - swap out "void *" for "char *" as appropriate to signal that we
    don't handle arbitrary memory

  - rename the function to anonymize_str()

This will also open up some optimization opportunities in a future
patch.

Note that we can't drop the "len" parameter entirely. Some callers do
pass in partial strings (e.g., "foo/bar", len=3) to avoid copying, and
we need to handle those still.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 53 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4a3a4c933e..d8ea067630 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -145,31 +145,30 @@ static int anonymized_entry_cmp(const void *unused_cmp_data,
  * the same anonymized string with another. The actual generation
  * is farmed out to the generate function.
  */
-static const void *anonymize_mem(struct hashmap *map,
-				 void *(*generate)(const void *, size_t *),
-				 const void *orig, size_t *len)
+static const char *anonymize_str(struct hashmap *map,
+				 char *(*generate)(const char *, size_t),
+				 const char *orig, size_t len)
 {
 	struct anonymized_entry key, *ret;
 
 	if (!map->cmpfn)
 		hashmap_init(map, anonymized_entry_cmp, NULL, 0);
 
-	hashmap_entry_init(&key.hash, memhash(orig, *len));
+	hashmap_entry_init(&key.hash, memhash(orig, len));
 	key.orig = orig;
-	key.orig_len = *len;
+	key.orig_len = len;
 	ret = hashmap_get_entry(map, &key, hash, NULL);
 
 	if (!ret) {
 		ret = xmalloc(sizeof(*ret));
 		hashmap_entry_init(&ret->hash, key.hash.hash);
-		ret->orig = xmemdupz(orig, *len);
-		ret->orig_len = *len;
+		ret->orig = xmemdupz(orig, len);
+		ret->orig_len = len;
 		ret->anon = generate(orig, len);
-		ret->anon_len = *len;
+		ret->anon_len = strlen(ret->anon);
 		hashmap_put(map, &ret->hash);
 	}
 
-	*len = ret->anon_len;
 	return ret->anon;
 }
 
@@ -181,13 +180,13 @@ static const void *anonymize_mem(struct hashmap *map,
  */
 static void anonymize_path(struct strbuf *out, const char *path,
 			   struct hashmap *map,
-			   void *(*generate)(const void *, size_t *))
+			   char *(*generate)(const char *, size_t))
 {
 	while (*path) {
 		const char *end_of_component = strchrnul(path, '/');
 		size_t len = end_of_component - path;
-		const char *c = anonymize_mem(map, generate, path, &len);
-		strbuf_add(out, c, len);
+		const char *c = anonymize_str(map, generate, path, len);
+		strbuf_addstr(out, c);
 		path = end_of_component;
 		if (*path)
 			strbuf_addch(out, *path++);
@@ -361,12 +360,12 @@ static void print_path_1(const char *path)
 		printf("%s", path);
 }
 
-static void *anonymize_path_component(const void *path, size_t *len)
+static char *anonymize_path_component(const char *path, size_t len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
 	strbuf_addf(&out, "path%d", counter++);
-	return strbuf_detach(&out, len);
+	return strbuf_detach(&out, NULL);
 }
 
 static void print_path(const char *path)
@@ -383,7 +382,7 @@ static void print_path(const char *path)
 	}
 }
 
-static void *generate_fake_oid(const void *old, size_t *len)
+static char *generate_fake_oid(const char *old, size_t len)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -399,7 +398,7 @@ static const char *anonymize_oid(const char *oid_hex)
 {
 	static struct hashmap objs;
 	size_t len = strlen(oid_hex);
-	return anonymize_mem(&objs, generate_fake_oid, oid_hex, &len);
+	return anonymize_str(&objs, generate_fake_oid, oid_hex, len);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -496,12 +495,12 @@ static const char *find_encoding(const char *begin, const char *end)
 	return bol;
 }
 
-static void *anonymize_ref_component(const void *old, size_t *len)
+static char *anonymize_ref_component(const char *old, size_t len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
 	strbuf_addf(&out, "ref%d", counter++);
-	return strbuf_detach(&out, len);
+	return strbuf_detach(&out, NULL);
 }
 
 static const char *anonymize_refname(const char *refname)
@@ -550,13 +549,13 @@ static char *anonymize_commit_message(const char *old)
 }
 
 static struct hashmap idents;
-static void *anonymize_ident(const void *old, size_t *len)
+static char *anonymize_ident(const char *old, size_t len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
 	strbuf_addf(&out, "User %d <user%d@example.com>", counter, counter);
 	counter++;
-	return strbuf_detach(&out, len);
+	return strbuf_detach(&out, NULL);
 }
 
 /*
@@ -591,9 +590,9 @@ static void anonymize_ident_line(const char **beg, const char **end)
 		size_t len;
 
 		len = split.mail_end - split.name_begin;
-		ident = anonymize_mem(&idents, anonymize_ident,
-				      split.name_begin, &len);
-		strbuf_add(out, ident, len);
+		ident = anonymize_str(&idents, anonymize_ident,
+				      split.name_begin, len);
+		strbuf_addstr(out, ident);
 		strbuf_addch(out, ' ');
 		strbuf_add(out, split.date_begin, split.tz_end - split.date_begin);
 	} else {
@@ -733,12 +732,12 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	show_progress();
 }
 
-static void *anonymize_tag(const void *old, size_t *len)
+static char *anonymize_tag(const char *old, size_t len)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
 	strbuf_addf(&out, "tag message %d", counter++);
-	return strbuf_detach(&out, len);
+	return strbuf_detach(&out, NULL);
 }
 
 static void handle_tail(struct object_array *commits, struct rev_info *revs,
@@ -808,8 +807,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		name = anonymize_refname(name);
 		if (message) {
 			static struct hashmap tags;
-			message = anonymize_mem(&tags, anonymize_tag,
-						message, &message_size);
+			message = anonymize_str(&tags, anonymize_tag,
+						message, message_size);
 		}
 	}
 
-- 
2.27.0.593.gb3082a2aaf

