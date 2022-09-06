Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CE7ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIFXBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIFXBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 19:01:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1A832C0
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 16:01:35 -0700 (PDT)
Received: (qmail 19869 invoked by uid 109); 6 Sep 2022 23:01:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 23:01:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6645 invoked by uid 111); 6 Sep 2022 23:01:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 19:01:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 19:01:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: [PATCH 1/3] parse_object(): allow skipping hash check
Message-ID: <YxfRTubqh7aFvNJs@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse_object() function checks the object hash of any object it
parses. This is a nice feature, as it means we may catch bit corruption
during normal use, rather than waiting for specific fsck operations.

But it also can be slow. It's particularly noticeable for blobs, where
except for the hash check, we could return without loading the object
contents at all. Now one may wonder what is the point of calling
parse_object() on a blob in the first place then, but usually it's not
intentional: we were fed an oid from somewhere, don't know the type, and
want an object struct. For commits and trees, the parsing is usually
helpful; we're about to look at the contents anyway. But this is less
true for blobs, where we may be collecting them as part of a
reachability traversal, etc, and don't actually care what's in them. And
blobs, of course, tend to be larger.

We don't want to just throw out the hash-checks for blobs, though. We do
depend on them in some circumstances (e.g., rev-list --verify-objects
uses parse_object() to check them). It's only the callers that know
how they're going to use the result. And so we can help them by
providing a special flag to skip the hash check.

We could just apply this to blobs, as they're going to be the main
source of performance improvement. But if a caller doesn't care about
checking the hash, we might as well skip it for other object types, too.
Even though we can't avoid reading the object contents, we can still
skip the actual hash computation.

If this seems like it is making Git a little bit less safe against
corruption, it may be. But it's part of a series of tradeoffs we're
already making. For instance, "rev-list --objects" does not open the
contents of blobs it prints. And when a commit graph is present, we skip
opening most commits entirely. The important thing will be to use this
flag in cases where it's safe to skip the check. For instance, when
serving a pack for a fetch, we know the client will fully index the
objects and do a connectivity check itself. There's little to be gained
from the server side re-hashing a blob itself. And indeed, most of the
time we don't! The revision machinery won't open up a blob reached by
traversal, but only one requested directly with a "want" line. So
applied properly, this new feature shouldn't make anything less safe in
practice.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm sorry, I know the argument here is really hand-wavy. But I really
think this isn't making anything much less safe.

I was actually tempted to rip out the blob hash-check entirely by
default!  Anybody who really cares about checking the bits can do so
with read_object_file(). That's what fsck does, and we could pretty
easily convert "rev-list --verify-objects" to do so, too. So this is the
less extreme version of the patch. ;)

 object.c | 15 ++++++++++++---
 object.h |  6 ++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index 588b8156f1..8f6de09078 100644
--- a/object.c
+++ b/object.c
@@ -263,8 +263,11 @@ struct object *parse_object_or_die(const struct object_id *oid,
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object(struct repository *r, const struct object_id *oid)
+struct object *parse_object_with_flags(struct repository *r,
+				       const struct object_id *oid,
+				       enum parse_object_flags flags)
 {
+	int skip_hash = !!(flags & PARSE_OBJECT_SKIP_HASH_CHECK);
 	unsigned long size;
 	enum object_type type;
 	int eaten;
@@ -279,7 +282,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (stream_object_signature(r, repl) < 0) {
+		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -289,7 +292,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(r, repl, buffer, size, type) < 0) {
+		if (!skip_hash &&
+		    check_object_signature(r, repl, buffer, size, type) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
@@ -304,6 +308,11 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	return NULL;
 }
 
+struct object *parse_object(struct repository *r, const struct object_id *oid)
+{
+	return parse_object_with_flags(r, oid, 0);
+}
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p)
 {
diff --git a/object.h b/object.h
index 9caef89f1f..31ebe11458 100644
--- a/object.h
+++ b/object.h
@@ -128,7 +128,13 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
  *
  * Returns NULL if the object is missing or corrupt.
  */
+enum parse_object_flags {
+	PARSE_OBJECT_SKIP_HASH_CHECK = 1 << 0,
+};
 struct object *parse_object(struct repository *r, const struct object_id *oid);
+struct object *parse_object_with_flags(struct repository *r,
+				       const struct object_id *oid,
+				       enum parse_object_flags flags);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
-- 
2.37.3.1134.gfd534b3986

