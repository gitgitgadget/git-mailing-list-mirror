Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFD8201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdBUXr5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:47:57 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39778 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753447AbdBUXrp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 22F25280B0;
        Tue, 21 Feb 2017 23:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720862;
        bh=3TlFX+FGJy8RwubPQyzYJuV3IRrFtkAg5QiFsdNns7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkH0cjdzxEhfq1ETDqtVqPeyb4UkdDT14ddzQJqTwRHDoxciZarP4iSzR5Hw7MjgQ
         nWweK5qjYrSp5RWzjb2JcU5KoFd44tuiVkMYGDbYw84nv/3995KX57tqMPZgXwCj7y
         AsIzauLgruQaqg6e+DzDQjkphEGoTmiKkKjdI/j/gwKXj0jzQLGeouwzUd05jnz8IP
         F4sh62awhcAj22I1FcuYLPJXZ6glMI0c3FZvG09M4SaMxqb6Zk7DiEbAzDCcm4VguR
         onLUeeO/voeRPtXwBFz7MiuihpsHEb2Te0MhUvFeCYEkAh5HVh7Enwc4e1+RnqpFg6
         64Cjan5b+sIUnhpBN4qTE9YgFo36hf03xl2tXNO5FDV1eINLyHxWNY/LAnYWRpShHE
         JFjVaKXFJMf9JpneiESTE2Ne3lOv8oRcFytooCfTW4daSjgojvC9ERr0pBxwLbFb8I
         9cw9UhqE10kbJjJctvQPlr37DK9x7KqauNIaGmJmFqYpLSrWoJz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 03/19] builtin/diff-tree: convert to struct object_id
Date:   Tue, 21 Feb 2017 23:47:21 +0000
Message-Id: <20170221234737.894681-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert most leaf functions to struct object_id.  Change several
hardcoded numbers to uses of parse_oid_hex.  In doing so, verify that we
when we want two trees, we have exactly two trees.

Finally, in stdin_diff_commit, avoid accessing the byte after the NUL.
This will be a NUL as well, since the first NUL was a newline we
overwrote.  However, with parse_oid_hex, we no longer need to increment
the pointer directly, and can simply increment it as part of our check
for the space character.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff-tree.c | 61 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8ce00480cd..326f88b657 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -7,46 +7,44 @@
 
 static struct rev_info log_tree_opt;
 
-static int diff_tree_commit_sha1(const unsigned char *sha1)
+static int diff_tree_commit_sha1(const struct object_id *oid)
 {
-	struct commit *commit = lookup_commit_reference(sha1);
+	struct commit *commit = lookup_commit_reference(oid->hash);
 	if (!commit)
 		return -1;
 	return log_tree_commit(&log_tree_opt, commit);
 }
 
 /* Diff one or more commits. */
-static int stdin_diff_commit(struct commit *commit, char *line, int len)
+static int stdin_diff_commit(struct commit *commit, const char *p)
 {
-	unsigned char sha1[20];
-	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
-		/* Graft the fake parents locally to the commit */
-		int pos = 41;
-		struct commit_list **pptr;
+	struct object_id oid;
+	struct commit_list **pptr = NULL;
 
-		/* Free the real parent list */
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
-		pptr = &(commit->parents);
-		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
-			struct commit *parent = lookup_commit(sha1);
-			if (parent) {
-				pptr = &commit_list_insert(parent, pptr)->next;
-			}
-			pos += 41;
+	/* Graft the fake parents locally to the commit */
+	while (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
+		struct commit *parent = lookup_commit(oid.hash);
+		if (!pptr) {
+			/* Free the real parent list */
+			free_commit_list(commit->parents);
+			commit->parents = NULL;
+			pptr = &(commit->parents);
+		}
+		if (parent) {
+			pptr = &commit_list_insert(parent, pptr)->next;
 		}
 	}
 	return log_tree_commit(&log_tree_opt, commit);
 }
 
 /* Diff two trees. */
-static int stdin_diff_trees(struct tree *tree1, char *line, int len)
+static int stdin_diff_trees(struct tree *tree1, const char *p)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct tree *tree2;
-	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
+	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
-	tree2 = lookup_tree(sha1);
+	tree2 = lookup_tree(oid.hash);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
@@ -60,23 +58,24 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 static int diff_tree_stdin(char *line)
 {
 	int len = strlen(line);
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object *obj;
+	const char *p;
 
 	if (!len || line[len-1] != '\n')
 		return -1;
 	line[len-1] = 0;
-	if (get_sha1_hex(line, sha1))
+	if (parse_oid_hex(line, &oid, &p))
 		return -1;
-	obj = parse_object(sha1);
+	obj = parse_object(oid.hash);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
-		return stdin_diff_commit((struct commit *)obj, line, len);
+		return stdin_diff_commit((struct commit *)obj, p);
 	if (obj->type == OBJ_TREE)
-		return stdin_diff_trees((struct tree *)obj, line, len);
+		return stdin_diff_trees((struct tree *)obj, p);
 	error("Object %s is a %s, not a commit or tree",
-	      sha1_to_hex(sha1), typename(obj->type));
+	      oid_to_hex(&oid), typename(obj->type));
 	return -1;
 }
 
@@ -141,7 +140,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
-		diff_tree_commit_sha1(tree1->oid.hash);
+		diff_tree_commit_sha1(&tree1->oid);
 		break;
 	case 2:
 		tree1 = opt->pending.objects[0].item;
@@ -164,9 +163,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
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

