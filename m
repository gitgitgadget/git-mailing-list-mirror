Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DF920705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964931AbcIEUJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964900AbcIEUIa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 35120280B4;
        Mon,  5 Sep 2016 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106109;
        bh=BSAFEuJh527+RfR8bv2nYNXBREkR79mQu8m3pljdE4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A07jbIOJyyL8BS/H9RYAoD6zMICNcNyE7CK7UxbzyYxpo6Sx1QmtpOeA2yIW8eSOE
         y+T6d6uzCJPOpxUm+VfS3QB8fBx1ovg1Lq5ppLX6KqFNBua71bWzsm+HPj28tngT0H
         DmcEUcr68vgXgD6+j8/Gt4WI+zb+iGQlKivRWdNOIqYSW14wY9yWnHcIICMNf5x8+T
         OM9i4yFxG5f0poqqp2IU7O1kjVEdRraqlukbrdljmgR4d2kmeFXov7pCwgxHHSsC/D
         QOIukhCmn2r+KLeKlh/rtuVQ6f/IyTaMGrFWGCqzFuedWNagQPtL6HM8NseEcd+Z1G
         hY7jOpEQsHZmQSiwB4AW7B8bgQYrdi6A+6TA72E/hzykJArh4nR/JtXg9DbaI89MW4
         qLcmS2MaG4PfXjwRoDHutVAYUkM1bFhq9kPC4FUyK3Z0ap2spq8DJIa44IvbC7qq21
         M7nF7M54d2TI1RNO4pu0OruWXmahL86MLkN+ClbbYLPo+oTWzZY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 14/20] notes: convert init_notes to use struct object_id
Date:   Mon,  5 Sep 2016 20:08:05 +0000
Message-Id: <20160905200811.697889-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index df4660fe..2bab961a 100644
--- a/notes.c
+++ b/notes.c
@@ -993,7 +993,7 @@ const char *default_notes_ref(void)
 void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
-	unsigned char sha1[20], object_sha1[20];
+	struct object_id oid, object_oid;
 	unsigned mode;
 	struct leaf_node root_tree;
 
@@ -1017,16 +1017,16 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    get_sha1_treeish(notes_ref, object_sha1))
+	    get_sha1_treeish(notes_ref, object_oid.hash))
 		return;
-	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_sha1))
+	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_oid.hash))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry(object_sha1, "", sha1, &mode))
+	if (get_tree_entry(object_oid.hash, "", oid.hash, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
-		    notes_ref, sha1_to_hex(object_sha1));
+		    notes_ref, oid_to_hex(&object_oid));
 
 	hashclr(root_tree.key_sha1);
-	hashcpy(root_tree.val_sha1, sha1);
+	hashcpy(root_tree.val_sha1, oid.hash);
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
