Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14FE1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfFTHlY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:45360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:23 -0400
Received: (qmail 16604 invoked by uid 109); 20 Jun 2019 07:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12867 invoked by uid 111); 20 Jun 2019 07:42:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:21 -0400
Date:   Thu, 20 Jun 2019 03:41:21 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/17] object: convert create_object() to use object_id
Message-ID: <20190620074121.GI3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left of lookup_object() that aren't just passing us
the "hash" member of a "struct object_id". Let's take the whole struct,
which gets us closer to removing all raw sha1 variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 blob.c         | 3 +--
 commit-graph.c | 2 +-
 commit.c       | 3 +--
 object.c       | 6 +++---
 object.h       | 2 +-
 tag.c          | 3 +--
 tree.c         | 3 +--
 7 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/blob.c b/blob.c
index b9c7180b7c..36f9abda19 100644
--- a/blob.c
+++ b/blob.c
@@ -9,8 +9,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid->hash,
-				     alloc_blob_node(r));
+		return create_object(r, oid, alloc_blob_node(r));
 	return object_as_type(r, obj, OBJ_BLOB, 0);
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 7c5e54875f..5a62131d68 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1214,7 +1214,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		odb_commit = (struct commit *)create_object(r, cur_oid.hash, alloc_commit_node(r));
+		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
diff --git a/commit.c b/commit.c
index f47c75afae..b71ac195d4 100644
--- a/commit.c
+++ b/commit.c
@@ -59,8 +59,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid->hash,
-				     alloc_commit_node(r));
+		return create_object(r, oid, alloc_commit_node(r));
 	return object_as_type(r, obj, OBJ_COMMIT, 0);
 }
 
diff --git a/object.c b/object.c
index dbfdbe504d..317647da3e 100644
--- a/object.c
+++ b/object.c
@@ -141,13 +141,13 @@ static void grow_object_hash(struct repository *r)
 	r->parsed_objects->obj_hash_size = new_hash_size;
 }
 
-void *create_object(struct repository *r, const unsigned char *sha1, void *o)
+void *create_object(struct repository *r, const struct object_id *oid, void *o)
 {
 	struct object *obj = o;
 
 	obj->parsed = 0;
 	obj->flags = 0;
-	hashcpy(obj->oid.hash, sha1);
+	oidcpy(&obj->oid, oid);
 
 	if (r->parsed_objects->obj_hash_size - 1 <= r->parsed_objects->nr_objs * 2)
 		grow_object_hash(r);
@@ -182,7 +182,7 @@ struct object *lookup_unknown_object(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid);
 	if (!obj)
-		obj = create_object(the_repository, oid->hash,
+		obj = create_object(the_repository, oid,
 				    alloc_object_node(the_repository));
 	return obj;
 }
diff --git a/object.h b/object.h
index 47301186a4..0120892bbd 100644
--- a/object.h
+++ b/object.h
@@ -118,7 +118,7 @@ struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(struct repository *r, const struct object_id *oid);
 
-void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
+void *create_object(struct repository *r, const struct object_id *oid, void *obj);
 
 void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
diff --git a/tag.c b/tag.c
index 3ae00ba1ab..5db870edb9 100644
--- a/tag.c
+++ b/tag.c
@@ -102,8 +102,7 @@ struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid->hash,
-				     alloc_tag_node(r));
+		return create_object(r, oid, alloc_tag_node(r));
 	return object_as_type(r, obj, OBJ_TAG, 0);
 }
 
diff --git a/tree.c b/tree.c
index 0ebb8c5b02..4720945e6a 100644
--- a/tree.c
+++ b/tree.c
@@ -199,8 +199,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid->hash,
-				     alloc_tree_node(r));
+		return create_object(r, oid, alloc_tree_node(r));
 	return object_as_type(r, obj, OBJ_TREE, 0);
 }
 
-- 
2.22.0.732.g5402924b4b

