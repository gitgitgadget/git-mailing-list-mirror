Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F373C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 23:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIFXG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFXG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 19:06:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC4E9C
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 16:06:26 -0700 (PDT)
Received: (qmail 19929 invoked by uid 109); 6 Sep 2022 23:06:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 23:06:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6703 invoked by uid 111); 6 Sep 2022 23:06:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 19:06:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 19:06:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: [PATCH 3/3] parse_object(): check commit-graph when skip_hash set
Message-ID: <YxfScUATMQw9cB6m@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the caller told us that they don't care about us checking the object
hash, then we're free to implement any optimizations that get us the
parsed value more quickly. An obvious one is to check the commit graph
before loading an object from disk. And in fact, both of the callers who
pass in this flag are already doing so before they call parse_object()!

So we can simplify those callers, as well as any possible future ones,
by moving the logic into parse_object().

There are two subtle things to note in the diff, but neither has any
impact in practice:

  - it seems least-surprising here to do the graph lookup on the
    git-replace'd oid, rather than the original. This is in theory a
    change of behavior from the earlier code, as neither caller did a
    replace lookup itself. But in practice it doesn't matter, as we
    disable the commit graph entirely if there are any replace refs.

  - the caller in get_reference() passes the skip_hash flag only if
    revs->verify_objects isn't set, whereas it would look in the commit
    graph unconditionally. In practice this should not matter as we
    should disable the commit graph entirely when using verify_objects
    (and that was done recently in another patch).

So this should be a pure cleanup with no behavior change.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c      |  6 ++++++
 revision.c    | 16 +++-------------
 upload-pack.c |  9 ++-------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/object.c b/object.c
index 8f6de09078..2e4589bae5 100644
--- a/object.c
+++ b/object.c
@@ -279,6 +279,12 @@ struct object *parse_object_with_flags(struct repository *r,
 	if (obj && obj->parsed)
 		return obj;
 
+	if (skip_hash) {
+		struct commit *commit = lookup_commit_in_graph(r, repl);
+		if (commit)
+			return &commit->object;
+	}
+
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
diff --git a/revision.c b/revision.c
index 786e090785..a04ebd6139 100644
--- a/revision.c
+++ b/revision.c
@@ -373,20 +373,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 				    unsigned int flags)
 {
 	struct object *object;
-	struct commit *commit;
 
-	/*
-	 * If the repository has commit graphs, we try to opportunistically
-	 * look up the object ID in those graphs. Like this, we can avoid
-	 * parsing commit data from disk.
-	 */
-	commit = lookup_commit_in_graph(revs->repo, oid);
-	if (commit)
-		object = &commit->object;
-	else
-		object = parse_object_with_flags(revs->repo, oid,
-						 revs->verify_objects ? 0 :
-						 PARSE_OBJECT_SKIP_HASH_CHECK);
+	object = parse_object_with_flags(revs->repo, oid,
+					 revs->verify_objects ? 0 :
+					 PARSE_OBJECT_SKIP_HASH_CHECK);
 
 	if (!object) {
 		if (revs->ignore_missing)
diff --git a/upload-pack.c b/upload-pack.c
index 4bacdf087c..35fe1a3dbb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1409,19 +1409,14 @@ static int parse_want(struct packet_writer *writer, const char *line,
 	const char *arg;
 	if (skip_prefix(line, "want ", &arg)) {
 		struct object_id oid;
-		struct commit *commit;
 		struct object *o;
 
 		if (get_oid_hex(arg, &oid))
 			die("git upload-pack: protocol error, "
 			    "expected to get oid, not '%s'", line);
 
-		commit = lookup_commit_in_graph(the_repository, &oid);
-		if (commit)
-			o = &commit->object;
-		else
-			o = parse_object_with_flags(the_repository, &oid,
-						    PARSE_OBJECT_SKIP_HASH_CHECK);
+		o = parse_object_with_flags(the_repository, &oid,
+					    PARSE_OBJECT_SKIP_HASH_CHECK);
 
 		if (!o) {
 			packet_writer_error(writer,
-- 
2.37.3.1134.gfd534b3986
