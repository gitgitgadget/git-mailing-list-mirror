Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E79720705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964909AbcIEUJr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:47 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43028 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964905AbcIEUIb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A7420280B8;
        Mon,  5 Sep 2016 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106110;
        bh=UHeZum9QKOMBcTRjICG2SnQ/csx+90xN8TtgPZXLTLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdsqUdhg+CzbkyBZQUsjp/M8u8RRc3bj0UbAZ8gbjqzYKQ1qU3FVppijH82w3bPUm
         bx7v+AZlaKLjSyx75DIg36GJRkzxGl5YocMiuqp0CVxe7LoSump6ik9mQFkHzk+5m5
         3XT5vE0UH6GsPF8bk3AuraG8cSDmN9bph6o77Ya8psAbENzd7rSjldnzTalfkZOGh6
         zbqwbSw3wps78WVZnZ7Swxh5pnf6ubQOaU/v9q5UWMJjWHZji7Luf1PIZeHWCHuc5s
         MRx7NGvn9iMnldXY8/WkJg5eMzrGXYQ9lYjxrDBtB04d0eF1EfnMR5Wpq/OYKvwe3t
         +5FIZ0bEcvbgOPS/7EMUQ2TdsX68mcBZ6Y5qIDzPlblOKGTxmiAf52eqnCsz5rS6T8
         H9UU3ErEZ6W1eId0v8K22GDvVs/TrGHxIDYPJqfvzfb9voH4SZV88258BGDardm4l1
         s3UKFeE3QCQEUWCUcfzKElq5DOj/7/fXFwF2OcxiDK7EGucNVer
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 19/20] builtin/commit-tree: convert to struct object_id
Date:   Mon,  5 Sep 2016 20:08:10 +0000
Message-Id: <20160905200811.697889-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit-tree.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 8a674bc9..60501726 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -40,8 +40,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i, got_tree = 0;
 	struct commit_list *parents = NULL;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
+	struct object_id tree_oid;
+	struct object_id commit_oid;
 	struct strbuf buffer = STRBUF_INIT;
 
 	git_config(commit_tree_config, NULL);
@@ -52,13 +52,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "-p")) {
-			unsigned char sha1[20];
+			struct object_id oid;
 			if (argc <= ++i)
 				usage(commit_tree_usage);
-			if (get_sha1_commit(argv[i], sha1))
+			if (get_sha1_commit(argv[i], oid.hash))
 				die("Not a valid object name %s", argv[i]);
-			assert_sha1_type(sha1, OBJ_COMMIT);
-			new_parent(lookup_commit(sha1), &parents);
+			assert_sha1_type(oid.hash, OBJ_COMMIT);
+			new_parent(lookup_commit(oid.hash), &parents);
 			continue;
 		}
 
@@ -105,7 +105,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (get_sha1_tree(arg, tree_sha1))
+		if (get_sha1_tree(arg, tree_oid.hash))
 			die("Not a valid object name %s", arg);
 		if (got_tree)
 			die("Cannot give more than one trees");
@@ -117,13 +117,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die_errno("git commit-tree: failed to read");
 	}
 
-	if (commit_tree(buffer.buf, buffer.len, tree_sha1, parents,
-			commit_sha1, NULL, sign_commit)) {
+	if (commit_tree(buffer.buf, buffer.len, tree_oid.hash, parents,
+			commit_oid.hash, NULL, sign_commit)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
 
-	printf("%s\n", sha1_to_hex(commit_sha1));
+	printf("%s\n", oid_to_hex(&commit_oid));
 	strbuf_release(&buffer);
 	return 0;
 }
