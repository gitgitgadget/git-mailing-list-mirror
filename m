Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA71ECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIFSit (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIFSiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 14:38:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B66B5327
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 11:38:43 -0700 (PDT)
Received: (qmail 19019 invoked by uid 109); 6 Sep 2022 18:38:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 18:38:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4621 invoked by uid 111); 6 Sep 2022 18:38:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 14:38:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 14:38:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [External Mail]Re: Partial-clone cause big performance impact on
 server
Message-ID: <YxeTsWrjpKo+JGfq@coredump.intra.peff.net>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
 <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
 <d5305274b7c24adbaf6ad9ab92ac3b6a@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5305274b7c24adbaf6ad9ab92ac3b6a@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2022 at 11:17:21AM +0000, 程洋 wrote:

> Sorry, I told you the wrong branch. It should be "android-t-preview-1"
> git clone --filter=blob:none --no-local -b android-t-preview-1 grade-plugin
> 
> Can you try this one?

Yes, I see more slow-down there. There are many more blobs there, but I
don't think it's really the number of them, but their sizes.

The problem is that both upload-pack and pack-objects are keen to call
parse_object() on their inputs. For commits, etc, that is usually
sensible; we have to parse the object to see what it points to. But for
blobs, the only thing we do is inflate a ton of bytes in order to check
the sha1. That's not really productive here; if there is a bit
corruption, the client will notice it on the receiving side.

So doing this:

diff --git a/object.c b/object.c
index 588b8156f1..6fbf6b2a7e 100644
--- a/object.c
+++ b/object.c
@@ -279,10 +279,6 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (stream_object_signature(r, repl) < 0) {
-			error(_("hash mismatch %s"), oid_to_hex(oid));
-			return NULL;
-		}
 		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
 		return lookup_object(r, oid);
 	}

makes the follow-up fetch very fast. But there are some parts of the
code that rely on this parsing to do the on-disk checks. So I think we'd
probably need to take a flag, and plumb it through from the appropriate
spots.

A sample patch is below, which makes things fast for the example I
showed (it might not for yours, because if you're using the v0 protocol
over ssh, I suspect a different parse_object() call might need to be
tweaked). I think it should be fairly safe, because in both callsites
we're already using the commit-graph to avoid checking the sha1 for
commits (actually, I think this may be an existing subtle breakage in
"rev-list --verify-objects", but that should be fixed separately).

---
diff --git a/object.c b/object.c
index 588b8156f1..97324bc406 100644
--- a/object.c
+++ b/object.c
@@ -263,7 +263,9 @@ struct object *parse_object_or_die(const struct object_id *oid,
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object(struct repository *r, const struct object_id *oid)
+struct object *parse_object_with_flags(struct repository *r,
+				       const struct object_id *oid,
+				       enum parse_object_flags flags)
 {
 	unsigned long size;
 	enum object_type type;
@@ -279,7 +281,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (stream_object_signature(r, repl) < 0) {
+		if (!(flags & PARSE_OBJECT_SKIP_HASH_CHECK) &&
+		    stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -289,7 +292,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(r, repl, buffer, size, type) < 0) {
+		if (!(flags & PARSE_OBJECT_SKIP_HASH_CHECK) &&
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
index 9caef89f1f..cd5b7d6306 100644
--- a/object.h
+++ b/object.h
@@ -137,6 +137,13 @@ struct object *parse_object(struct repository *r, const struct object_id *oid);
  */
 struct object *parse_object_or_die(const struct object_id *oid, const char *name);
 
+enum parse_object_flags {
+	PARSE_OBJECT_SKIP_HASH_CHECK = 1 << 0,
+};
+struct object *parse_object_with_flags(struct repository *r,
+				       const struct object_id *oid,
+				       enum parse_object_flags flags);
+
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
diff --git a/revision.c b/revision.c
index ee702e498a..8cbffc0325 100644
--- a/revision.c
+++ b/revision.c
@@ -384,7 +384,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (commit)
 		object = &commit->object;
 	else
-		object = parse_object(revs->repo, oid);
+		object = parse_object_with_flags(revs->repo, oid,
+						 PARSE_OBJECT_SKIP_HASH_CHECK);
 
 	if (!object) {
 		if (revs->ignore_missing)
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469..4bacdf087c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1420,7 +1420,8 @@ static int parse_want(struct packet_writer *writer, const char *line,
 		if (commit)
 			o = &commit->object;
 		else
-			o = parse_object(the_repository, &oid);
+			o = parse_object_with_flags(the_repository, &oid,
+						    PARSE_OBJECT_SKIP_HASH_CHECK);
 
 		if (!o) {
 			packet_writer_error(writer,
