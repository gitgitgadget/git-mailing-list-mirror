Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740B11F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfJRFBt (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:01:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726139AbfJRFBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:01:49 -0400
Received: (qmail 9531 invoked by uid 109); 18 Oct 2019 05:01:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:01:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14526 invoked by uid 111); 18 Oct 2019 05:04:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:04:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:01:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 22/23] fsck: accept an oid instead of a "struct commit" for
 fsck_commit()
Message-ID: <20191018050148.GV17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually look at the commit struct in fsck_commit() beyond its
oid and type (which is obviously OBJ_COMMIT). Just taking an oid gives
our callers more flexibility to avoid creating or parsing a struct, and
makes it clear that we are fscking just what is in the buffer, not any
pre-parsed bits from the struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fsck.c b/fsck.c
index 38be501278..f8c5bbe891 100644
--- a/fsck.c
+++ b/fsck.c
@@ -764,8 +764,9 @@ static int fsck_ident(const char **ident,
 	return 0;
 }
 
-static int fsck_commit(struct commit *commit, const char *buffer,
-		       unsigned long size, struct fsck_options *options)
+static int fsck_commit(const struct object_id *oid,
+		       const char *buffer, unsigned long size,
+		       struct fsck_options *options)
 {
 	struct object_id tree_oid, parent_oid;
 	unsigned author_count;
@@ -773,21 +774,20 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	const char *buffer_begin = buffer;
 	const char *p;
 
-	if (verify_headers(buffer, size, &commit->object.oid,
-			   commit->object.type, options))
+	if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
-		return report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
+		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
-		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
-			err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
@@ -796,23 +796,23 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	author_count = 0;
 	while (skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
-		err = fsck_ident(&buffer, &commit->object.oid, commit->object.type, options);
+		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 		if (err)
 			return err;
 	}
 	if (author_count < 1)
-		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
 	else if (author_count > 1)
-		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-		return report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, &commit->object.oid, commit->object.type, options);
+		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
+	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
-		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_NUL_IN_COMMIT,
+		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
 			     "NUL byte in the commit object body");
 		if (err)
 			return err;
@@ -984,8 +984,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	if (obj->type == OBJ_TREE)
 		return fsck_tree((struct tree *) obj, data, size, options);
 	if (obj->type == OBJ_COMMIT)
-		return fsck_commit((struct commit *) obj, (const char *) data,
-			size, options);
+		return fsck_commit(&obj->oid, data, size, options);
 	if (obj->type == OBJ_TAG)
 		return fsck_tag(&obj->oid, data, size, options);
 
-- 
2.23.0.1228.gee29b05929

