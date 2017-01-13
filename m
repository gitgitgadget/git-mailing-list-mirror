Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FF320756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdAMR7t (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:59:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:38944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdAMR7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:59:47 -0500
Received: (qmail 6262 invoked by uid 109); 13 Jan 2017 17:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:59:47 +0000
Received: (qmail 7453 invoked by uid 111); 13 Jan 2017 18:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 13:00:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:59:44 -0500
Date:   Fri, 13 Jan 2017 12:59:44 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 5/6] fsck: parse loose object paths directly
Message-ID: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we iterate over the list of loose objects to check, we
get the actual path of each object. But we then throw it
away and pass just the sha1 to fsck_sha1(), which will do a
fresh lookup. Usually it would find the same object, but it
may not if an object exists both as a loose and a packed
object. We may end up checking the packed object twice, and
never look at the loose one.

In practice this isn't too terrible, because if fsck doesn't
complain, it means you have at least one good copy. But
since the point of fsck is to look for corruption, we should
be thorough.

The new read_loose_object() interface can help us get the
data from disk, and then we replace parse_object() with
parse_object_buffer(). As a bonus, our error messages now
mention the path to a corrupted object, which should make it
easier to track down errors when they do happen.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 46 +++++++++++++++++++++++++++++++++-------------
 t/t1450-fsck.sh | 16 ++++++++++++++++
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f01b81eeb..4b91ee95e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -362,18 +362,6 @@ static int fsck_obj(struct object *obj)
 	return 0;
 }
 
-static int fsck_sha1(const unsigned char *sha1)
-{
-	struct object *obj = parse_object(sha1);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error("%s: object corrupt or missing",
-			     sha1_to_hex(sha1));
-	}
-	obj->flags |= HAS_OBJ;
-	return fsck_obj(obj);
-}
-
 static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 			   unsigned long size, void *buffer, int *eaten)
 {
@@ -488,9 +476,41 @@ static void get_default_heads(void)
 	}
 }
 
+static struct object *parse_loose_object(const unsigned char *sha1,
+					 const char *path)
+{
+	struct object *obj;
+	void *contents;
+	enum object_type type;
+	unsigned long size;
+	int eaten;
+
+	if (read_loose_object(path, sha1, &type, &size, &contents) < 0)
+		return NULL;
+
+	if (!contents && type != OBJ_BLOB)
+		die("BUG: read_loose_object streamed a non-blob");
+
+	obj = parse_object_buffer(sha1, type, size, contents, &eaten);
+
+	if (!eaten)
+		free(contents);
+	return obj;
+}
+
 static int fsck_loose(const unsigned char *sha1, const char *path, void *data)
 {
-	if (fsck_sha1(sha1))
+	struct object *obj = parse_loose_object(sha1, path);
+
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		error("%s: object corrupt or missing: %s",
+		      sha1_to_hex(sha1), path);
+		return 0; /* keep checking other objects */
+	}
+
+	obj->flags = HAS_OBJ;
+	if (fsck_obj(obj))
 		errors_found |= ERROR_OBJECT;
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index c39d42120..455c186fe 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -581,4 +581,20 @@ test_expect_success 'fsck errors in packed objects' '
 	! grep corrupt out
 '
 
+test_expect_success 'fsck finds problems in duplicate loose objects' '
+	rm -rf broken-duplicate &&
+	git init broken-duplicate &&
+	(
+		cd broken-duplicate &&
+		test_commit duplicate &&
+		# no "-d" here, so we end up with duplicates
+		git repack &&
+		# now corrupt the loose copy
+		file=$(sha1_file "$(git rev-parse HEAD)") &&
+		rm "$file" &&
+		echo broken >"$file" &&
+		test_must_fail git fsck
+	)
+'
+
 test_done
-- 
2.11.0.629.g10075098c

