Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522DC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4C32070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgFWPZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:25:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPZF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:05 -0400
Received: (qmail 11884 invoked by uid 109); 23 Jun 2020 15:25:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:25:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17008 invoked by uid 111); 23 Jun 2020 15:25:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:25:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:25:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 08/10] fast-export: add a "data" callback parameter to
 anonymize_str()
Message-ID: <20200623152503.GH1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The anonymize_str() function takes a generator callback, but there's no
way to pass extra context to it. Let's add the usual "void *data"
parameter to the generator interface and pass it along.

This is mildly annoying for existing callers, all of which pass NULL,
but is necessary to avoid extra globals in some cases we'll add in a
subsequent patch.

While we're touching each of these callbacks, we can further observe
that none of them use the existing orig/len parameters at all. This
makes sense, since the point is for their output to have no discernable
basis in the original (my original version had some notion that we might
use a one-way function to obfuscate the names, but it was never
implemented). So let's drop those extra parameters. If a caller really
wants to do something with them, it can pass a struct through the new
data parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 16a1563e49..1cbca5b4b4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -155,8 +155,9 @@ static int anonymized_entry_cmp(const void *unused_cmp_data,
  * is farmed out to the generate function.
  */
 static const char *anonymize_str(struct hashmap *map,
-				 char *(*generate)(const char *, size_t),
-				 const char *orig, size_t len)
+				 char *(*generate)(void *),
+				 const char *orig, size_t len,
+				 void *data)
 {
 	struct anonymized_entry_key key;
 	struct anonymized_entry *ret;
@@ -172,7 +173,7 @@ static const char *anonymize_str(struct hashmap *map,
 	if (!ret) {
 		FLEX_ALLOC_MEM(ret, orig, orig, len);
 		hashmap_entry_init(&ret->hash, key.hash.hash);
-		ret->anon = generate(orig, len);
+		ret->anon = generate(data);
 		hashmap_put(map, &ret->hash);
 	}
 
@@ -187,12 +188,12 @@ static const char *anonymize_str(struct hashmap *map,
  */
 static void anonymize_path(struct strbuf *out, const char *path,
 			   struct hashmap *map,
-			   char *(*generate)(const char *, size_t))
+			   char *(*generate)(void *))
 {
 	while (*path) {
 		const char *end_of_component = strchrnul(path, '/');
 		size_t len = end_of_component - path;
-		const char *c = anonymize_str(map, generate, path, len);
+		const char *c = anonymize_str(map, generate, path, len, NULL);
 		strbuf_addstr(out, c);
 		path = end_of_component;
 		if (*path)
@@ -367,7 +368,7 @@ static void print_path_1(const char *path)
 		printf("%s", path);
 }
 
-static char *anonymize_path_component(const char *path, size_t len)
+static char *anonymize_path_component(void *data)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -389,7 +390,7 @@ static void print_path(const char *path)
 	}
 }
 
-static char *generate_fake_oid(const char *old, size_t len)
+static char *generate_fake_oid(void *data)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -405,7 +406,7 @@ static const char *anonymize_oid(const char *oid_hex)
 {
 	static struct hashmap objs;
 	size_t len = strlen(oid_hex);
-	return anonymize_str(&objs, generate_fake_oid, oid_hex, len);
+	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -502,7 +503,7 @@ static const char *find_encoding(const char *begin, const char *end)
 	return bol;
 }
 
-static char *anonymize_ref_component(const char *old, size_t len)
+static char *anonymize_ref_component(void *data)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -555,7 +556,7 @@ static char *anonymize_commit_message(const char *old)
 	return xstrfmt("subject %d\n\nbody\n", counter++);
 }
 
-static char *anonymize_ident(const char *old, size_t len)
+static char *anonymize_ident(void *data)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -598,7 +599,7 @@ static void anonymize_ident_line(const char **beg, const char **end)
 
 		len = split.mail_end - split.name_begin;
 		ident = anonymize_str(&idents, anonymize_ident,
-				      split.name_begin, len);
+				      split.name_begin, len, NULL);
 		strbuf_addstr(out, ident);
 		strbuf_addch(out, ' ');
 		strbuf_add(out, split.date_begin, split.tz_end - split.date_begin);
@@ -739,7 +740,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	show_progress();
 }
 
-static char *anonymize_tag(const char *old, size_t len)
+static char *anonymize_tag(void *data)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -815,7 +816,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (message) {
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
-						message, message_size);
+						message, message_size, NULL);
 		}
 	}
 
-- 
2.27.0.517.gbc32778fa3

