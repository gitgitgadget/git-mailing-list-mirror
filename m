Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8EEE1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756250AbcH1X2l (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:41 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41058 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756196AbcH1X2H (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43ADE280B3;
        Sun, 28 Aug 2016 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426885;
        bh=PUNlfIckrXoIdHx4BaaMMh6BmS0GYcYJoozya/Gkdjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXRuOABB1fS84Ot8lyWQ/bANztLp7KI8waxNlEfzZpMdNmzfxVOqfLE9pWCb8H1aC
         WXJqOwxeaj9A2qqWKsq8yrlLeYBTx1eKkgbkPvXfqPD3wakVjduxZpT1+Ug1/VoDyV
         9HGYmzop+7Iu7KKcdEz2dXLgUIKSizL9PrRjTXqj8evPniJnVQeIXq9qCYVjXvo3XF
         fgYb1WOdImkKPrWqt1cDUUnStXxqcx1p9HFoDn17YYtCRfS5nTQT2BU4H5BUnS+u4+
         nSAf1gU/sDX4g5gEzgeFiW9tbeZgK+JI+8yuP8m1S3Se7S0X6CmMcVgDku4VYXF9/T
         V4MzVDeEYjhxc8HVEi0sUQLz4G2J08QWcHYqw7DhEmENRIlbzvvFEt2xgQ7yIWP+oO
         OHbrumkiS/v8vBIEeLecsICBnlObseGcO1Xj02i5z7dzKpuEjN6oKsIS+Fl2yGh5Qr
         QaBkxV4Cq1l+sE5phAi7LZNf3+oqOOVb+/dcbq0SpQi0MetS8A3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 12/20] builtin/blame: convert file to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:49 +0000
Message-Id: <20160828232757.373278-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this file to use struct object_id, and additionally convert some
uses of the constant 40 to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 527b66a4..6650e7dd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1941,7 +1941,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : abbrev;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -2232,12 +2232,12 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 	int pos;
 
 	for (parents = work_tree->parents; parents; parents = parents->next) {
-		const unsigned char *commit_sha1 = parents->item->object.oid.hash;
-		unsigned char blob_sha1[20];
+		const struct object_id *commit_oid = &parents->item->object.oid;
+		struct object_id blob_oid;
 		unsigned mode;
 
-		if (!get_tree_entry(commit_sha1, path, blob_sha1, &mode) &&
-		    sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
+		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
+		    sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
 			return;
 	}
 
@@ -2250,13 +2250,13 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		die("no such path '%s' in HEAD", path);
 }
 
-static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
+static struct commit_list **append_parent(struct commit_list **tail, const struct object_id *oid)
 {
 	struct commit *parent;
 
-	parent = lookup_commit_reference(sha1);
+	parent = lookup_commit_reference(oid->hash);
 	if (!parent)
-		die("no such commit %s", sha1_to_hex(sha1));
+		die("no such commit %s", oid_to_hex(oid));
 	return &commit_list_insert(parent, tail)->next;
 }
 
@@ -2273,10 +2273,10 @@ static void append_merge_parents(struct commit_list **tail)
 	}
 
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
-		unsigned char sha1[20];
-		if (line.len < 40 || get_sha1_hex(line.buf, sha1))
+		struct object_id oid;
+		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
 			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
-		tail = append_parent(tail, sha1);
+		tail = append_parent(tail, &oid);
 	}
 	close(merge_head);
 	strbuf_release(&line);
@@ -2305,7 +2305,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	struct commit *commit;
 	struct origin *origin;
 	struct commit_list **parent_tail, *parent;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
 	time_t now;
@@ -2321,10 +2321,10 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->date = now;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		die("no such ref: HEAD");
 
-	parent_tail = append_parent(parent_tail, head_sha1);
+	parent_tail = append_parent(parent_tail, &head_oid);
 	append_merge_parents(parent_tail);
 	verify_working_tree_path(commit, path);
 
