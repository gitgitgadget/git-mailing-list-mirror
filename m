Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A06C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCVRoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCVRoD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:44:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B7270B
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:43:36 -0700 (PDT)
Received: (qmail 10561 invoked by uid 109); 22 Mar 2023 17:42:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:42:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15917 invoked by uid 111); 22 Mar 2023 17:42:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:42:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:42:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] fast-export: drop data parameter from anonymous
 generators
Message-ID: <20230322174251.GC11424@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The anonymization code has a specific generator callback for each type
of data (e.g., one for paths, one for oids, and so on). These all take a
"data" parameter, but none of them use it for anything. Which is not
surprising, as the point is to generate a new name independent of any
input, and each function keeps its own static counter.

We added the extra pointer in d5bf91fde44 (fast-export: add a "data"
callback parameter to anonymize_str(), 2020-06-23) to handle
--anonymize-map parsing, but that turned out to be awkward itself, and
was recently dropped.

So let's get rid of this "data" parameter that nobody is using, both
from the generators and from anonymize_str() which plumbed it through.
This simplifies the code, and makes -Wunused-parameter happier.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1e7b26dc64..12adf75964c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -168,9 +168,8 @@ static struct anonymized_entry *add_anonymized_entry(struct hashmap *map,
  * is farmed out to the generate function.
  */
 static const char *anonymize_str(struct hashmap *map,
-				 char *(*generate)(void *),
-				 const char *orig, size_t len,
-				 void *data)
+				 char *(*generate)(void),
+				 const char *orig, size_t len)
 {
 	struct anonymized_entry_key key;
 	struct anonymized_entry *ret;
@@ -189,7 +188,7 @@ static const char *anonymize_str(struct hashmap *map,
 	/* ...and finally generate a new mapping if necessary */
 	if (!ret)
 		ret = add_anonymized_entry(map, key.hash.hash,
-					   orig, len, generate(data));
+					   orig, len, generate());
 
 	return ret->anon;
 }
@@ -202,12 +201,12 @@ static const char *anonymize_str(struct hashmap *map,
  */
 static void anonymize_path(struct strbuf *out, const char *path,
 			   struct hashmap *map,
-			   char *(*generate)(void *))
+			   char *(*generate)(void))
 {
 	while (*path) {
 		const char *end_of_component = strchrnul(path, '/');
 		size_t len = end_of_component - path;
-		const char *c = anonymize_str(map, generate, path, len, NULL);
+		const char *c = anonymize_str(map, generate, path, len);
 		strbuf_addstr(out, c);
 		path = end_of_component;
 		if (*path)
@@ -382,7 +381,7 @@ static void print_path_1(const char *path)
 		printf("%s", path);
 }
 
-static char *anonymize_path_component(void *data)
+static char *anonymize_path_component(void)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -404,7 +403,7 @@ static void print_path(const char *path)
 	}
 }
 
-static char *generate_fake_oid(void *data)
+static char *generate_fake_oid(void)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -420,7 +419,7 @@ static const char *anonymize_oid(const char *oid_hex)
 {
 	static struct hashmap objs;
 	size_t len = strlen(oid_hex);
-	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
+	return anonymize_str(&objs, generate_fake_oid, oid_hex, len);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -517,7 +516,7 @@ static const char *find_encoding(const char *begin, const char *end)
 	return bol;
 }
 
-static char *anonymize_ref_component(void *data)
+static char *anonymize_ref_component(void)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -563,7 +562,7 @@ static char *anonymize_commit_message(const char *old)
 	return xstrfmt("subject %d\n\nbody\n", counter++);
 }
 
-static char *anonymize_ident(void *data)
+static char *anonymize_ident(void)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -606,7 +605,7 @@ static void anonymize_ident_line(const char **beg, const char **end)
 
 		len = split.mail_end - split.name_begin;
 		ident = anonymize_str(&idents, anonymize_ident,
-				      split.name_begin, len, NULL);
+				      split.name_begin, len);
 		strbuf_addstr(out, ident);
 		strbuf_addch(out, ' ');
 		strbuf_add(out, split.date_begin, split.tz_end - split.date_begin);
@@ -747,7 +746,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	show_progress();
 }
 
-static char *anonymize_tag(void *data)
+static char *anonymize_tag(void)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -809,7 +808,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (message) {
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
-						message, message_size, NULL);
+						message, message_size);
 			message_size = strlen(message);
 		}
 	}
-- 
2.40.0.595.g9b96b494d8c

