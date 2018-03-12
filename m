Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9A21F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeCLC2y (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34444 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932608AbeCLC2q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0640E610E3;
        Mon, 12 Mar 2018 02:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821725;
        bh=RB2+klP5q+eEhWkzupmDk9E3ja7P+Ysku0SkKsxF8bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ia6cfCp06iBTJDmSLvPdNXq/jmZhxnLRd7H6vxW0CTYCKPu449c4Klh5cL7u8Rwqs
         hKjbz9MAiTaKHErjM3RkYOa8MPlI8/UMNWcfm6bw09m36y1BMWQCi2VfEaZs1Ixsfe
         JLs7VQ1Mj2SxZ4IFqY6O6FudxJ1BQZ9mg+ZVJX+VlVKPvjICshcjQIpjrei2OndrV2
         2V5JmzvduVSXrKSdtmHvegSwPIshVqf2JIEJqH+JBJjFvyCDXW28LcMEnRlyS5M/OD
         mXnopoXtIkLYrxA2BG+f00q/5XIkLE55ZUfw95PZQxGU4Y2IniQMAD4vbkgSlUIiAY
         TzNQcU6KL89UuLX5MEVdGlKWZx1+/jCX2PNqFq8efhCbqOG2Vj5D1wljs2MDhq37E3
         GKsvTPUgG29Uldyajr3EmVQ7nXw3aozB64+2DZcUNK+FKmrAPCSpwms/a+TLVnQZkI
         oQKpemIg0PviFF+G+Ilq8Ef5/wtS/GpyEKGCbzO67qkt5lI6GVW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 29/36] tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
Date:   Mon, 12 Mar 2018 02:27:49 +0000
Message-Id: <20180312022756.483934-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the internals of this function to use struct object_id.  This is
one of the last remaining callers of read_sha1_file_extended that has
not been converted yet.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree-walk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 63a87ed666..521defdaa2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -583,14 +583,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 	struct dir_state *parents = NULL;
 	size_t parents_alloc = 0;
 	size_t i, parents_nr = 0;
-	unsigned char current_tree_sha1[20];
+	struct object_id current_tree_oid;
 	struct strbuf namebuf = STRBUF_INIT;
 	struct tree_desc t;
 	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
 
 	init_tree_desc(&t, NULL, 0UL);
 	strbuf_addstr(&namebuf, name);
-	hashcpy(current_tree_sha1, tree_sha1);
+	hashcpy(current_tree_oid.hash, tree_sha1);
 
 	while (1) {
 		int find_result;
@@ -599,22 +599,22 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 		if (!t.buffer) {
 			void *tree;
-			unsigned char root[20];
+			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(current_tree_sha1,
+			tree = read_object_with_reference(current_tree_oid.hash,
 							  tree_type, &size,
-							  root);
+							  root.hash);
 			if (!tree)
 				goto done;
 
 			ALLOC_GROW(parents, parents_nr + 1, parents_alloc);
 			parents[parents_nr].tree = tree;
 			parents[parents_nr].size = size;
-			hashcpy(parents[parents_nr].sha1, root);
+			hashcpy(parents[parents_nr].sha1, root.hash);
 			parents_nr++;
 
 			if (namebuf.buf[0] == '\0') {
-				hashcpy(result, root);
+				hashcpy(result, root.hash);
 				retval = FOUND;
 				goto done;
 			}
@@ -671,14 +671,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(&t, namebuf.buf,
-					      current_tree_sha1, mode);
+					      current_tree_oid.hash, mode);
 		if (find_result) {
 			goto done;
 		}
 
 		if (S_ISDIR(*mode)) {
 			if (!remainder) {
-				hashcpy(result, current_tree_sha1);
+				hashcpy(result, current_tree_oid.hash);
 				retval = FOUND;
 				goto done;
 			}
@@ -688,7 +688,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 				      1 + first_slash - namebuf.buf);
 		} else if (S_ISREG(*mode)) {
 			if (!remainder) {
-				hashcpy(result, current_tree_sha1);
+				hashcpy(result, current_tree_oid.hash);
 				retval = FOUND;
 			} else {
 				retval = NOT_DIR;
@@ -714,7 +714,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_sha1_file(current_tree_sha1, &type,
+			contents = read_sha1_file(current_tree_oid.hash, &type,
 						  &link_len);
 
 			if (!contents)
