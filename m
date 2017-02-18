Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341AA201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdBRAHo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:44 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60004 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750839AbdBRAHA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D3888280B0;
        Sat, 18 Feb 2017 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376418;
        bh=bEm7oYn7NHtJxPBdW6uIQJbRPNWA4cyVBhHIC3zOJSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igu8gKLw8qtU4RfRT3OVxjpPxVB2m9G6bPaAeFdHxlnCJETjkloa45H9+9FlOVBNW
         K9TxMkLaoVfc5fF/lOEVHwHoLaKVVm/4Z3Tsc41mFK9irswSd3mIgD32Hpz+COZilj
         JJDOfx++028twuD3gOSuac3bF4KSY/gHGHizW3kUt5/v8HwDauhGKqLrmHZ2EdkPBC
         ew7RT1xJaxSAV4pj+2Sa0nQ0wJKN30K1FbrXKyrrjaqiaqWmu6biYNr0ihg/J1iX55
         pHU5NQlN7E8BYHzo8ZOcm5e/5ZoBNbk+Z6x0c1Tk+nwzzsICPqD2NFNnd+BoCg3Zun
         Yw4Q3WE7xMM5w2dvSxzw4rnl6gwaBhjs46Fvh2tIQKEkf5EXRUM3lWibaBPpbeSLZb
         bDKM1jcbrkv2npk5IHiR/7APeQvehk+1K+0ozMiJb3Mz0sCgAMEOefsQs6y3ErbmVg
         68oBgAAAsbKQA2QGxKDr9dUa+1BIwbwUz3uzO1fSTvlMUWAv0f4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/19] builtin/describe: convert to struct object_id
Date:   Sat, 18 Feb 2017 00:06:36 +0000
Message-Id: <20170218000652.375129-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the functions in this file and struct commit_name  to struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/describe.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 01490a157e..738e68f95b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -39,11 +39,11 @@ static const char *diff_index_args[] = {
 
 struct commit_name {
 	struct hashmap_entry entry;
-	unsigned char peeled[20];
+	struct object_id peeled;
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *path;
 };
 
@@ -54,17 +54,17 @@ static const char *prio_names[] = {
 static int commit_name_cmp(const struct commit_name *cn1,
 		const struct commit_name *cn2, const void *peeled)
 {
-	return hashcmp(cn1->peeled, peeled ? peeled : cn2->peeled);
+	return oidcmp(&cn1->peeled, peeled ? peeled : &cn2->peeled);
 }
 
-static inline struct commit_name *find_commit_name(const unsigned char *peeled)
+static inline struct commit_name *find_commit_name(const struct object_id *peeled)
 {
-	return hashmap_get_from_hash(&names, sha1hash(peeled), peeled);
+	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled->hash);
 }
 
 static int replace_name(struct commit_name *e,
 			       int prio,
-			       const unsigned char *sha1,
+			       const struct object_id *oid,
 			       struct tag **tag)
 {
 	if (!e || e->prio < prio)
@@ -77,13 +77,13 @@ static int replace_name(struct commit_name *e,
 		struct tag *t;
 
 		if (!e->tag) {
-			t = lookup_tag(e->sha1);
+			t = lookup_tag(e->oid.hash);
 			if (!t || parse_tag(t))
 				return 1;
 			e->tag = t;
 		}
 
-		t = lookup_tag(sha1);
+		t = lookup_tag(oid->hash);
 		if (!t || parse_tag(t))
 			return 0;
 		*tag = t;
@@ -96,24 +96,24 @@ static int replace_name(struct commit_name *e,
 }
 
 static void add_to_known_names(const char *path,
-			       const unsigned char *peeled,
+			       const struct object_id *peeled,
 			       int prio,
-			       const unsigned char *sha1)
+			       const struct object_id *oid)
 {
 	struct commit_name *e = find_commit_name(peeled);
 	struct tag *tag = NULL;
-	if (replace_name(e, prio, sha1, &tag)) {
+	if (replace_name(e, prio, oid, &tag)) {
 		if (!e) {
 			e = xmalloc(sizeof(struct commit_name));
-			hashcpy(e->peeled, peeled);
-			hashmap_entry_init(e, sha1hash(peeled));
+			oidcpy(&e->peeled, peeled);
+			hashmap_entry_init(e, sha1hash(peeled->hash));
 			hashmap_add(&names, e);
 			e->path = NULL;
 		}
 		e->tag = tag;
 		e->prio = prio;
 		e->name_checked = 0;
-		hashcpy(e->sha1, sha1);
+		oidcpy(&e->oid, oid);
 		free(e->path);
 		e->path = xstrdup(path);
 	}
@@ -154,7 +154,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	else
 		prio = 0;
 
-	add_to_known_names(all ? path + 5 : path + 10, peeled.hash, prio, oid->hash);
+	add_to_known_names(all ? path + 5 : path + 10, &peeled, prio, oid);
 	return 0;
 }
 
@@ -212,7 +212,7 @@ static unsigned long finish_depth_computation(
 static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
-		n->tag = lookup_tag(n->sha1);
+		n->tag = lookup_tag(n->oid.hash);
 		if (!n->tag || parse_tag(n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
@@ -230,14 +230,14 @@ static void display_name(struct commit_name *n)
 		printf("%s", n->path);
 }
 
-static void show_suffix(int depth, const unsigned char *sha1)
+static void show_suffix(int depth, const struct object_id *oid)
 {
-	printf("-%d-g%s", depth, find_unique_abbrev(sha1, abbrev));
+	printf("-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
 }
 
 static void describe(const char *arg, int last_one)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
 	struct commit_name *n;
@@ -246,20 +246,20 @@ static void describe(const char *arg, int last_one)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	if (get_sha1(arg, sha1))
+	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(sha1);
+	cmit = lookup_commit_reference(oid.hash);
 	if (!cmit)
 		die(_("%s is not a valid '%s' object"), arg, commit_type);
 
-	n = find_commit_name(cmit->object.oid.hash);
+	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
 		display_name(n);
 		if (longformat)
-			show_suffix(0, n->tag ? n->tag->tagged->oid.hash : sha1);
+			show_suffix(0, n->tag ? &n->tag->tagged->oid : &oid);
 		if (dirty)
 			printf("%s", dirty);
 		printf("\n");
@@ -276,7 +276,7 @@ static void describe(const char *arg, int last_one)
 		struct commit *c;
 		struct commit_name *n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
-			c = lookup_commit_reference_gently(n->peeled, 1);
+			c = lookup_commit_reference_gently(n->peeled.hash, 1);
 			if (c)
 				c->util = n;
 		}
@@ -380,7 +380,7 @@ static void describe(const char *arg, int last_one)
 
 	display_name(all_matches[0].name);
 	if (abbrev)
-		show_suffix(all_matches[0].depth, cmit->object.oid.hash);
+		show_suffix(all_matches[0].depth, &cmit->object.oid);
 	if (dirty)
 		printf("%s", dirty);
 	printf("\n");
-- 
2.11.0

