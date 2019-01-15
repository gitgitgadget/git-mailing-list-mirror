Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A9A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 00:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfAOAkM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 19:40:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59218 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbfAOAkL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Jan 2019 19:40:11 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5304C60FE1;
        Tue, 15 Jan 2019 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547512809;
        bh=TQeCgCykJvByYpNrZs9d3N2zBVorZCLG2qJtGq+g+B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g418QHAmwdHNd+OjzfOGnMCiWSJPtCCSYZ26Arq/SlEFBWswUJ6SWWUYthk1RPl6s
         Mlet8UkcGZ9vevb6TeT9DNxfdNGgpwdKN89/a36bCjl4PeOS+bnTPQIyQ72Bjm9/9c
         KljJb1m8Ky65fvS28V4RrJnmixfiNV2gvceBWPu2ifcuuQ5EwCibKc/fuk4rruKsbK
         vQX2shqIC3mhXuUZEt+1giKyLwNTru6Ony4nMO3Sil1iXZtLPOW1vIivirU9a+aVql
         3HjoyzPEyAWtJkfaW5hXMQwwYf0e5tKoVLCj5wtqFtcyEBjlPu3IsshlKwYynbT6K/
         KYCmlVmRrn/GqviFwig/i3my2KbVIAbDcM1vIoqUtlUI/zHX2B4K2rcxaHM513dvMB
         3ZqyiiEwFPJOufA+4/rZs3mT1tyrZSm3lvEKbKxwH3NtPoot/wpahYEtUQpLcurWNc
         s3QoPv4xlaFKYQIJPJnFgx4wrIqXuSL8PTNnEawpsDSr+pHAjkv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] match-trees: use hashcpy to splice trees
Date:   Tue, 15 Jan 2019 00:39:43 +0000
Message-Id: <20190115003946.932078-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce
In-Reply-To: <20190115003946.932078-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190115003946.932078-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we splice trees together, we operate in place on the tree buffer.
If we're using SHA-1 for the hash algorithm, we may not have a full
GIT_MAX_RAWSZ (32) bytes to copy. Consequently, it doesn't logically
make sense for us to use a struct object_id to represent this type,
since it isn't a complete object.

Represent this value as a unsigned char pointer instead and copy it when
necessary.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 match-trees.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index feca48a5fd..c2b7329e09 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -179,7 +179,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	char *buf;
 	unsigned long sz;
 	struct tree_desc desc;
-	struct object_id *rewrite_here;
+	unsigned char *rewrite_here;
 	const struct object_id *rewrite_with;
 	struct object_id subtree;
 	enum object_type type;
@@ -206,9 +206,19 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree", name,
 				    oid_to_hex(oid1));
-			rewrite_here = (struct object_id *)(desc.entry.path +
-							    strlen(desc.entry.path) +
-							    1);
+
+			/*
+			 * We cast here for two reasons:
+			 *
+			 *   - to flip the "char *" (for the path) to "unsigned
+			 *     char *" (for the hash stored after it)
+			 *
+			 *   - to discard the "const"; this is OK because we
+			 *     know it points into our non-const "buf"
+			 */
+			rewrite_here = (unsigned char *)(desc.entry.path +
+							 strlen(desc.entry.path) +
+							 1);
 			break;
 		}
 		update_tree_entry(&desc);
@@ -217,14 +227,16 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		die("entry %.*s not found in tree %s", toplen, prefix,
 		    oid_to_hex(oid1));
 	if (*subpath) {
-		status = splice_tree(rewrite_here, subpath, oid2, &subtree);
+		struct object_id tree_oid;
+		hashcpy(tree_oid.hash, rewrite_here);
+		status = splice_tree(&tree_oid, subpath, oid2, &subtree);
 		if (status)
 			return status;
 		rewrite_with = &subtree;
 	} else {
 		rewrite_with = oid2;
 	}
-	oidcpy(rewrite_here, rewrite_with);
+	hashcpy(rewrite_here, rewrite_with->hash);
 	status = write_object_file(buf, sz, tree_type, result);
 	free(buf);
 	return status;
