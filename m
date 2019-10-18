Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C471F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfJRFCJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:02:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:51784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726139AbfJRFCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:02:09 -0400
Received: (qmail 9542 invoked by uid 109); 18 Oct 2019 05:02:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:02:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14542 invoked by uid 111); 18 Oct 2019 05:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:05:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:02:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 23/23] fsck: accept an oid instead of a "struct tree" for
 fsck_tree()
Message-ID: <20191018050208.GW17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually look at the tree struct in fsck_tree() beyond its oid
and type (which is obviously OBJ_TREE). Just taking an oid gives our
callers more flexibility to avoid creating a struct, and makes it clear
that we are fscking just what is in the buffer, not any pre-parsed bits
from the struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fsck.c b/fsck.c
index f8c5bbe891..ac4ba4c8e8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -566,7 +566,7 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(struct tree *item,
+static int fsck_tree(const struct object_id *oid,
 		     const char *buffer, unsigned long size,
 		     struct fsck_options *options)
 {
@@ -586,7 +586,7 @@ static int fsck_tree(struct tree *item,
 	const char *o_name;
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -613,13 +613,13 @@ static int fsck_tree(struct tree *item,
 				oidset_insert(&gitmodules_found, oid);
 			else
 				retval += report(options,
-						 &item->object.oid, item->object.type,
+						 oid, OBJ_TREE,
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 			break;
 		}
 
@@ -664,25 +664,25 @@ static int fsck_tree(struct tree *item,
 	}
 
 	if (has_null_sha1)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
 	if (has_dot)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOT, "contains '.'");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOT, "contains '.'");
 	if (has_dotdot)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOTDOT, "contains '..'");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTDOT, "contains '..'");
 	if (has_dotgit)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
+		retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
@@ -982,7 +982,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	if (obj->type == OBJ_BLOB)
 		return fsck_blob(&obj->oid, data, size, options);
 	if (obj->type == OBJ_TREE)
-		return fsck_tree((struct tree *) obj, data, size, options);
+		return fsck_tree(&obj->oid, data, size, options);
 	if (obj->type == OBJ_COMMIT)
 		return fsck_commit(&obj->oid, data, size, options);
 	if (obj->type == OBJ_TAG)
-- 
2.23.0.1228.gee29b05929
