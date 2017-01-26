Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6168B1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 04:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbdAZEMK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 23:12:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:45106 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdAZEMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 23:12:09 -0500
Received: (qmail 31199 invoked by uid 109); 26 Jan 2017 04:12:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 04:12:09 +0000
Received: (qmail 20107 invoked by uid 111); 26 Jan 2017 04:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:12:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 23:12:07 -0500
Date:   Wed, 25 Jan 2017 23:12:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] fsck: lazily load types under --connectivity-only
Message-ID: <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net>
References: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent fixes to "fsck --connectivity-only" load all of
the objects with their correct types. This keeps the
connectivity-only code path close to the regular one, but it
also introduces some unnecessary inefficiency. While getting
the type of an object is cheap compared to actually opening
and parsing the object (as the non-connectivity-only case
would do), it's still not free.

For reachable non-blob objects, we end up having to parse
them later anyway (to see what they point to), making our
type lookup here redundant.

For unreachable objects, we might never hit them at all in
the reachability traversal, making the lookup completely
wasted. And in some cases, we might have quite a few
unreachable objects (e.g., when alternates are used for
shared object storage between repositories, it's normal for
there to be objects reachable from other repositories but
not the one running fsck).

The comment in mark_object_for_connectivity() claims two
benefits to getting the type up front:

  1. We need to know the types during fsck_walk(). (And not
     explicitly mentioned, but we also need them when
     printing the types of broken or dangling commits).

     We can address this by lazy-loading the types as
     necessary. Most objects never need this lazy-load at
     all, because they fall into one of these categories:

       a. Reachable from our tips, and are coerced into the
	  correct type as we traverse (e.g., a parent link
	  will call lookup_commit(), which converts OBJ_NONE
	  to OBJ_COMMIT).

       b. Unreachable, but not at the tip of a chunk of
          unreachable history. We only mention the tips as
	  "dangling", so an unreachable commit which links
	  to hundreds of other objects needs only report the
	  type of the tip commit.

  2. It serves as a cross-check that the coercion in (1a) is
     correct (i.e., we'll complain about a parent link that
     points to a blob). But we get most of this for free
     already, because right after coercing, we'll parse any
     non-blob objects. So we'd notice then if we expected a
     commit and got a blob.

     The one exception is when we expect a blob, in which
     case we never actually read the object contents.

     So this is a slight weakening, but given that the whole
     point of --connectivity-only is to sacrifice some data
     integrity checks for speed, this seems like an
     acceptable tradeoff.

Here are before and after timings for an extreme case with
~5M reachable objects and another ~12M unreachable (it's the
torvalds/linux repository on GitHub, connected to shared
storage for all of the other kernel forks):

  [before]
  $ time git fsck --no-dangling --connectivity-only
  real	3m4.323s
  user	1m25.121s
  sys	1m38.710s

  [after]
  $ time git fsck --no-dangling --connectivity-only
  real	0m51.497s
  user	0m49.575s
  sys	0m1.776s

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 58 +++++++---------------------------------------------------
 fsck.c         |  4 ++++
 2 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3d5ced2d3..140357b6f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -60,6 +60,12 @@ static const char *printable_type(struct object *obj)
 {
 	const char *ret;
 
+	if (obj->type == OBJ_NONE) {
+		enum object_type type = sha1_object_info(obj->oid.hash, NULL);
+		if (type > 0)
+			object_as_type(obj, type, 0);
+	}
+
 	ret = typename(obj->type);
 	if (!ret)
 		ret = "unknown";
@@ -595,57 +601,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static void mark_object_for_connectivity(const unsigned char *sha1)
 {
-	struct object *obj = lookup_object(sha1);
-
-	/*
-	 * Setting the object type here isn't strictly necessary for a
-	 * connectivity check. In most cases, our walk will expect a certain
-	 * type (e.g., a tree referencing a blob) and will use lookup_blob() to
-	 * assign the type. But doing it here has two advantages:
-	 *
-	 *   1. When the fsck_walk code looks at objects that _don't_ come from
-	 *      links (e.g., the tip of a ref), it may complain about the
-	 *      "unknown object type".
-	 *
-	 *   2. This serves as a nice cross-check that the graph links are
-	 *      sane. So --connectivity-only does not check that the bits of
-	 *      blobs are not corrupted, but it _does_ check that 100644 tree
-	 *      entries point to blobs, and so forth.
-	 *
-	 * Unfortunately we can't just use parse_object() here, because the
-	 * whole point of --connectivity-only is to avoid reading the object
-	 * data more than necessary.
-	 */
-	if (!obj || obj->type == OBJ_NONE) {
-		enum object_type type = sha1_object_info(sha1, NULL);
-		switch (type) {
-		case OBJ_BAD:
-			error("%s: unable to read object type",
-			      sha1_to_hex(sha1));
-			break;
-		case OBJ_COMMIT:
-			obj = (struct object *)lookup_commit(sha1);
-			break;
-		case OBJ_TREE:
-			obj = (struct object *)lookup_tree(sha1);
-			break;
-		case OBJ_BLOB:
-			obj = (struct object *)lookup_blob(sha1);
-			break;
-		case OBJ_TAG:
-			obj = (struct object *)lookup_tag(sha1);
-			break;
-		default:
-			error("%s: unknown object type %d",
-			      sha1_to_hex(sha1), type);
-		}
-
-		if (!obj || obj->type == OBJ_NONE) {
-			errors_found |= ERROR_OBJECT;
-			return;
-		}
-	}
-
+	struct object *obj = lookup_unknown_object(sha1);
 	obj->flags |= HAS_OBJ;
 }
 
diff --git a/fsck.c b/fsck.c
index 4a3069e20..939792752 100644
--- a/fsck.c
+++ b/fsck.c
@@ -458,6 +458,10 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return -1;
+
+	if (obj->type == OBJ_NONE)
+		parse_object(obj->oid.hash);
+
 	switch (obj->type) {
 	case OBJ_BLOB:
 		return 0;
-- 
2.11.0.840.gd37c5973a
