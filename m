Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD07201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbdBUXsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:02 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39824 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753439AbdBUXrv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F1A92280B3;
        Tue, 21 Feb 2017 23:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720863;
        bh=M6Wj8OeRwLxg/WhhL9ZV9yKOp0D4go9aS2avjL8rEmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MS7Y6MxXLXFks85qKS/faB1DQrTRDz3QH89l3UoHcBHCXl2v1fONJf3FDf5xxTgik
         3C6qB1ufJ3+gYjihnScPq5LDWvl+P2e0Kgu661WPLCFgZ0qaanCMWb892rBESirFlf
         irbmaF98I5RlVP+HH3taCdiVBPQjKaP0VZE5mMvEcBgK9FamFGhFkzimwVDsX1wfiA
         lHtjQ2Xbo6OZ6eS3YZqildgY9oopB8IdbFNXkToZ+U47lcsLAm4dhSmIIv0JsisGkJ
         JCaKt1k5EnxXDSQCCyw6i9a/K9tJtQvWy0ys3UCnV36GkWSkQI3PGrHHUelLcX1B5F
         BBtunKcMacUX395h42+PEKsx8aeqR5n6pg79vvwHrPqVxkonvX3XnXNLP5HaXbDjAP
         VoG9CT6hKdesZqPsz1BgWhtjh88r6nmqF1yXXHKFyURfcHepKsvv5YyMz9YPaJPW3Q
         Qg8245Q6qLSfGPugX5fYVx8jdm8zfV8S9DRzxz+2lVFlqTrOaXA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 06/19] builtin/fmt-merge-message: convert to struct object_id
Date:   Tue, 21 Feb 2017 23:47:24 +0000
Message-Id: <20170221234737.894681-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert most of the code to use struct object_id, including struct
origin_data and struct merge_parents.  Convert several instances of
hardcoded numbers into references to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fmt-merge-msg.c | 70 ++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index efab62fd85..6faa3c0d24 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -41,7 +41,7 @@ struct src_data {
 };
 
 struct origin_data {
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned is_local_branch:1;
 };
 
@@ -59,8 +59,8 @@ static struct string_list origins = STRING_LIST_INIT_DUP;
 struct merge_parents {
 	int alloc, nr;
 	struct merge_parent {
-		unsigned char given[20];
-		unsigned char commit[20];
+		struct object_id given;
+		struct object_id commit;
 		unsigned char used;
 	} *item;
 };
@@ -70,14 +70,14 @@ struct merge_parents {
  * hundreds of heads at a time anyway.
  */
 static struct merge_parent *find_merge_parent(struct merge_parents *table,
-					      unsigned char *given,
-					      unsigned char *commit)
+					      struct object_id *given,
+					      struct object_id *commit)
 {
 	int i;
 	for (i = 0; i < table->nr; i++) {
-		if (given && hashcmp(table->item[i].given, given))
+		if (given && oidcmp(&table->item[i].given, given))
 			continue;
-		if (commit && hashcmp(table->item[i].commit, commit))
+		if (commit && oidcmp(&table->item[i].commit, commit))
 			continue;
 		return &table->item[i];
 	}
@@ -85,14 +85,14 @@ static struct merge_parent *find_merge_parent(struct merge_parents *table,
 }
 
 static void add_merge_parent(struct merge_parents *table,
-			     unsigned char *given,
-			     unsigned char *commit)
+			     struct object_id *given,
+			     struct object_id *commit)
 {
 	if (table->nr && find_merge_parent(table, given, commit))
 		return;
 	ALLOC_GROW(table->item, table->nr + 1, table->alloc);
-	hashcpy(table->item[table->nr].given, given);
-	hashcpy(table->item[table->nr].commit, commit);
+	oidcpy(&table->item[table->nr].given, given);
+	oidcpy(&table->item[table->nr].commit, commit);
 	table->item[table->nr].used = 0;
 	table->nr++;
 }
@@ -106,30 +106,30 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 
-	if (len < 43 || line[40] != '\t')
+	if (len < GIT_SHA1_HEXSZ + 3 || line[GIT_SHA1_HEXSZ] != '\t')
 		return 1;
 
-	if (starts_with(line + 41, "not-for-merge"))
+	if (starts_with(line + GIT_SHA1_HEXSZ + 1, "not-for-merge"))
 		return 0;
 
-	if (line[41] != '\t')
+	if (line[GIT_SHA1_HEXSZ + 1] != '\t')
 		return 2;
 
-	i = get_sha1_hex(line, sha1);
+	i = get_oid_hex(line, &oid);
 	if (i)
 		return 3;
 
-	if (!find_merge_parent(merge_parents, sha1, NULL))
+	if (!find_merge_parent(merge_parents, &oid, NULL))
 		return 0; /* subsumed by other parents */
 
 	origin_data = xcalloc(1, sizeof(struct origin_data));
-	hashcpy(origin_data->sha1, sha1);
+	oidcpy(&origin_data->oid, &oid);
 
 	if (line[len - 1] == '\n')
 		line[len - 1] = 0;
-	line += 42;
+	line += GIT_SHA1_HEXSZ + 2;
 
 	/*
 	 * At this point, line points at the beginning of comment e.g.
@@ -338,10 +338,10 @@ static void shortlog(const char *name,
 	struct string_list committers = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
-	const unsigned char *sha1 = origin_data->sha1;
+	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
+	branch = deref_tag(parse_object(oid->hash), oid_to_hex(oid), GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
@@ -531,7 +531,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 }
 
 static void find_merge_parents(struct merge_parents *result,
-			       struct strbuf *in, unsigned char *head)
+			       struct strbuf *in, struct object_id *head)
 {
 	struct commit_list *parents;
 	struct commit *head_commit;
@@ -542,31 +542,31 @@ static void find_merge_parents(struct merge_parents *result,
 		int len;
 		char *p = in->buf + pos;
 		char *newline = strchr(p, '\n');
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct commit *parent;
 		struct object *obj;
 
 		len = newline ? newline - p : strlen(p);
 		pos += len + !!newline;
 
-		if (len < 43 ||
-		    get_sha1_hex(p, sha1) ||
-		    p[40] != '\t' ||
-		    p[41] != '\t')
+		if (len < GIT_SHA1_HEXSZ + 3 ||
+		    get_oid_hex(p, &oid) ||
+		    p[GIT_SHA1_HEXSZ] != '\t' ||
+		    p[GIT_SHA1_HEXSZ + 1] != '\t')
 			continue; /* skip not-for-merge */
 		/*
 		 * Do not use get_merge_parent() here; we do not have
 		 * "name" here and we do not want to contaminate its
 		 * util field yet.
 		 */
-		obj = parse_object(sha1);
+		obj = parse_object(oid.hash);
 		parent = (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
 		if (!parent)
 			continue;
 		commit_list_insert(parent, &parents);
-		add_merge_parent(result, obj->oid.hash, parent->object.oid.hash);
+		add_merge_parent(result, &obj->oid, &parent->object.oid);
 	}
-	head_commit = lookup_commit(head);
+	head_commit = lookup_commit(head->hash);
 	if (head_commit)
 		commit_list_insert(head_commit, &parents);
 	parents = reduce_heads(parents);
@@ -574,7 +574,7 @@ static void find_merge_parents(struct merge_parents *result,
 	while (parents) {
 		struct commit *cmit = pop_commit(&parents);
 		for (i = 0; i < result->nr; i++)
-			if (!hashcmp(result->item[i].commit, cmit->object.oid.hash))
+			if (!oidcmp(&result->item[i].commit, &cmit->object.oid))
 				result->item[i].used = 1;
 	}
 
@@ -592,7 +592,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
 {
 	int i = 0, pos = 0;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	const char *current_branch;
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
@@ -601,13 +601,13 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
+		resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
 		current_branch += 11;
 
-	find_merge_parents(&merge_parents, in, head_sha1);
+	find_merge_parents(&merge_parents, in, &head_oid);
 
 	/* get a line */
 	while (pos < in->len) {
@@ -633,7 +633,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct commit *head;
 		struct rev_info rev;
 
-		head = lookup_commit_or_die(head_sha1, "HEAD");
+		head = lookup_commit_or_die(head_oid.hash, "HEAD");
 		init_revisions(&rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
-- 
2.11.0

