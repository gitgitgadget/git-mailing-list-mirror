Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B921D201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdBRAHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:02 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750788AbdBRAHA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A9BA3280AF;
        Sat, 18 Feb 2017 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376418;
        bh=kMHhi8wEwX8KTal1Bz0WEqvRD7ABzyfgEe+0i+0XRBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpFOhv975H3WFQ9bNUywHIQqfKesjSkbPu9KywRvFTz0RXtQ2TPemPVevhXlsJa3I
         QjUqZyUfdKtpYFgrQz9Rkir24NYQcXqtcGe2WWsqxT0Wv69uEfZ5nAwYCrTxiRAPv+
         5nGVEKYGdQY6qYcYEgKQUvtl05olLc491lugJvPCVcf0ennQ1z2FTLW1ozVl1tozRY
         VyCFf6V53pXy/GXCJJ2srbCAEFiFHAJHR4q7sbBLb8Fyh344F0bkds3c81YNSYcAZb
         SKGHa8IyJu8LlFHolrTcjzfr4EEk4FwiVxU6fbf7B0xzrqyDdxyH6uG6TOw61W1SKn
         yd33bfmP2BOCiowgO2S+0UUNcxF5iECnrnWfo2Ftqo+YOhIc6Bo2ngjsjPfxS50os6
         bvlxdtpawXv7q+gZhTiHuw/aHJ9mzTbul6CsoUggyvflu3LZUg1gcnfiw2Y4lVmnOe
         d2eRjGCt0WQAUU/VyHvcp9YiC0Z0OWFGyAAvkFje9HpFpjHrRcu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Date:   Sat, 18 Feb 2017 00:06:35 +0000
Message-Id: <20170218000652.375129-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert most leaf functions to struct object_id.  Rewrite several
hardcoded numbers in terms of GIT_SHA1_HEXSZ, using an intermediate
variable where that makes sense.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/diff-tree.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8ce00480cd..1f1573bb2a 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -7,9 +7,9 @@
 
 static struct rev_info log_tree_opt;
 
-static int diff_tree_commit_sha1(const unsigned char *sha1)
+static int diff_tree_commit_sha1(const struct object_id *oid)
 {
-	struct commit *commit = lookup_commit_reference(sha1);
+	struct commit *commit = lookup_commit_reference(oid->hash);
 	if (!commit)
 		return -1;
 	return log_tree_commit(&log_tree_opt, commit);
@@ -18,22 +18,22 @@ static int diff_tree_commit_sha1(const unsigned char *sha1)
 /* Diff one or more commits. */
 static int stdin_diff_commit(struct commit *commit, char *line, int len)
 {
-	unsigned char sha1[20];
-	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
+	struct object_id oid;
+	if (isspace(line[GIT_SHA1_HEXSZ]) && !get_oid_hex(line+GIT_SHA1_HEXSZ+1, &oid)) {
 		/* Graft the fake parents locally to the commit */
-		int pos = 41;
+		int pos = GIT_SHA1_HEXSZ + 1;
 		struct commit_list **pptr;
 
 		/* Free the real parent list */
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 		pptr = &(commit->parents);
-		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
-			struct commit *parent = lookup_commit(sha1);
+		while (line[pos] && !get_oid_hex(line + pos, &oid)) {
+			struct commit *parent = lookup_commit(oid.hash);
 			if (parent) {
 				pptr = &commit_list_insert(parent, pptr)->next;
 			}
-			pos += 41;
+			pos += GIT_SHA1_HEXSZ + 1;
 		}
 	}
 	return log_tree_commit(&log_tree_opt, commit);
@@ -42,11 +42,13 @@ static int stdin_diff_commit(struct commit *commit, char *line, int len)
 /* Diff two trees. */
 static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct tree *tree2;
-	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
+	const int chunksz = GIT_SHA1_HEXSZ + 1;
+	if (len != 2 * chunksz || !isspace(line[chunksz-1]) ||
+		get_sha1_hex(line + chunksz, oid.hash))
 		return error("Need exactly two trees, separated by a space");
-	tree2 = lookup_tree(sha1);
+	tree2 = lookup_tree(oid.hash);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
@@ -60,15 +62,15 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 static int diff_tree_stdin(char *line)
 {
 	int len = strlen(line);
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object *obj;
 
 	if (!len || line[len-1] != '\n')
 		return -1;
 	line[len-1] = 0;
-	if (get_sha1_hex(line, sha1))
+	if (get_oid_hex(line, &oid))
 		return -1;
-	obj = parse_object(sha1);
+	obj = parse_object(oid.hash);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
@@ -76,7 +78,7 @@ static int diff_tree_stdin(char *line)
 	if (obj->type == OBJ_TREE)
 		return stdin_diff_trees((struct tree *)obj, line, len);
 	error("Object %s is a %s, not a commit or tree",
-	      sha1_to_hex(sha1), typename(obj->type));
+	      oid_to_hex(&oid), typename(obj->type));
 	return -1;
 }
 
@@ -141,7 +143,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
-		diff_tree_commit_sha1(tree1->oid.hash);
+		diff_tree_commit_sha1(&tree1->oid);
 		break;
 	case 2:
 		tree1 = opt->pending.objects[0].item;
@@ -164,9 +166,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 					       DIFF_SETUP_USE_CACHE);
 		while (fgets(line, sizeof(line), stdin)) {
-			unsigned char sha1[20];
+			struct object_id oid;
 
-			if (get_sha1_hex(line, sha1)) {
+			if (get_oid_hex(line, &oid)) {
 				fputs(line, stdout);
 				fflush(stdout);
 			}
-- 
2.11.0

