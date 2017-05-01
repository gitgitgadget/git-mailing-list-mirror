Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EAB1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999502AbdEACbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35796 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642346AbdEACaY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6837A280C2;
        Mon,  1 May 2017 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605807;
        bh=LN8wkSzE1wZmdGdw+SRTDnx2DORuPoqICeG0SDni2UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwhVaQcjSGwHJY72a8r+P6Tnb0WIrdUHywY1yBCPstKl9khvXIXsNgAeBRp0pNvzT
         LaXZ3uL4U3r9mjcVjcy3b4KvsRf+owXtKy3PBGSTIDvw+mu7q03izCgepQYLEMbKWa
         eKTKxNUVJJ/1ItJVRXhioUYEM3JHFtiNG0ss4eJrItEUFn8Djxhl659pS/ytemVh4Y
         dOXgAHlts56YjMdpl8S8BoC3HFiIw3lcv/+1PLolZNOY9NxqrLh6Ho7StIWUPgPtBn
         Z1j3chVLZsKKjcZ5KqhpLTEPWWPoRMVj1rwFiqpHfR6F9TLrnJEgGyEKA4RXTA22vg
         H2zY2NpFexNe+QTG0G54BPwSBZNl7or6U26NJCNsl4+irPqiKB5aKBC0jtAT/lesz3
         Her3DtVdP07lIExG72tOe23rE+uWLAQj+ZGsi0sE1ctQZ909IvxtHrnBNEnSw1w+eO
         ww01o+jFHU4n0PK+eKBdht+smWcq/hpGM3YzyRFOzR6pUC0hEYX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 19/53] notes-utils: convert internals to struct object_id
Date:   Mon,  1 May 2017 02:29:12 +0000
Message-Id: <20170501022946.258735-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the internals of create_notes_comit and commit_notes to use
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes-utils.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index 24a33616a..36c1490aa 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -7,18 +7,18 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 unsigned char *result_sha1)
 {
-	unsigned char tree_sha1[20];
+	struct object_id tree_oid;
 
 	assert(t->initialized);
 
-	if (write_notes_tree(t, tree_sha1))
+	if (write_notes_tree(t, tree_oid.hash))
 		die("Failed to write notes tree to database");
 
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
-		unsigned char parent_sha1[20];
-		if (!read_ref(t->ref, parent_sha1)) {
-			struct commit *parent = lookup_commit(parent_sha1);
+		struct object_id parent_oid;
+		if (!read_ref(t->ref, parent_oid.hash)) {
+			struct commit *parent = lookup_commit(parent_oid.hash);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
@@ -26,14 +26,14 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
 
-	if (commit_tree(msg, msg_len, tree_sha1, parents, result_sha1, NULL, NULL))
+	if (commit_tree(msg, msg_len, tree_oid.hash, parents, result_sha1, NULL, NULL))
 		die("Failed to commit notes tree to database");
 }
 
 void commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char commit_sha1[20];
+	struct object_id commit_oid;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -46,9 +46,9 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_addstr(&buf, msg);
 	strbuf_complete_line(&buf);
 
-	create_notes_commit(t, NULL, buf.buf, buf.len, commit_sha1);
+	create_notes_commit(t, NULL, buf.buf, buf.len, commit_oid.hash);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->update_ref, commit_sha1, NULL, 0,
+	update_ref(buf.buf, t->update_ref, commit_oid.hash, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_release(&buf);
