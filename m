Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA7C2070F
	for <e@80x24.org>; Mon,  5 Sep 2016 20:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbcIEUKB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:10:01 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42990 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964896AbcIEUI3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CD740280B2;
        Mon,  5 Sep 2016 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106108;
        bh=J1wr6a+S2zH7JeYUYsAGcX2GOMGlLfHwie+hqpkD49I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlVhg0OKEuwAOeuHf2KJjSn3P+qj703k+HscWdnObK7fq+RWIAvJ81rDM8dfs0ei6
         3AyJrOaL6dkLb8b0it7chuiIhA0WEHij3QDThG2uTiW/gozLby6dcKW9KP40F5xV9d
         NLEoQ3s2B3aVO4MTAh6t8+30k/z6yk2uR15+flHt2pLXIiN1OQ/YMW/Qr2TH+PFbEd
         /mlU5fz7ez2E6p56RdmXrOSZiP2ukzJ67USQjgmkVB7VxitJYdp+1FG9d+cmG07buH
         jpI9Yutjro8+hsJBlfHS0wmIn3/uJLmJlBxJpjkuLmjkcJT1MYPR2oJYmHpDXirtAV
         HxVJ9s5m4y/mckh87PykNQ35Pl94sPrhv3wPsGW5ZSLQx/Hq7ms1SLAgdT2ct9uJXI
         tBJUgk2ffyUIF+pPJrvPoDmgZYT4CfMx7ssXeXT2+xFjY1rmoiakviq+ZX7BUz2NZO
         hA6FFNbT9p/4+vC7WOegI2LBqeDhLoZ7r9jDJJQ1vFXIw+1G+7b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 12/20] builtin/blame: convert file to use struct object_id
Date:   Mon,  5 Sep 2016 20:08:03 +0000
Message-Id: <20160905200811.697889-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
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
index 0e10e302..ccaf8be5 100644
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
 
@@ -2251,13 +2251,13 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
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
 
@@ -2274,10 +2274,10 @@ static void append_merge_parents(struct commit_list **tail)
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
@@ -2306,7 +2306,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	struct commit *commit;
 	struct origin *origin;
 	struct commit_list **parent_tail, *parent;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
 	time_t now;
@@ -2322,10 +2322,10 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->date = now;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		die("no such ref: HEAD");
 
-	parent_tail = append_parent(parent_tail, head_sha1);
+	parent_tail = append_parent(parent_tail, &head_oid);
 	append_merge_parents(parent_tail);
 	verify_working_tree_path(commit, path);
 
