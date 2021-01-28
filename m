Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB52C433E9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AC764DD1
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhA1GO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:14:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhA1GO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:14:56 -0500
Received: (qmail 9627 invoked by uid 109); 28 Jan 2021 06:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:14:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25272 invoked by uid 111); 28 Jan 2021 06:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:14:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:14:11 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] rerere: check dirname format while iterating rr_cache
 directory
Message-ID: <YBJWM0v/D6afqBLI@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJVuckmbGriVa//@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rerere_gc(), we walk over the .git/rr_cache directory and create a
struct for each entry we find. We feed any name we get from readdir() to
find_rerere_dir(), which then calls get_sha1_hex() on it (since we use
the binary hash as a lookup key). If that fails (i.e., the directory
name is not what we expected), it returns NULL. But the comment in
find_rerere_dir() says "BUG".

It _would_ be a bug for the call from new_rerere_id_hex(), the only
other code path, to fail here; it's generating the hex internally. But
the call in rerere_gc() is using it say "is this a plausible directory
name".

Let's instead have rerere_gc() do its own "is this plausible" check.
That has two benefits:

  - we can now reliably BUG() inside find_rerere_dir(), which would
    catch bugs in the other code path (and we now will never return NULL
    from the function, which makes it easier to see that a rerere_id
    struct will always have a non-NULL "collection" field).

  - it makes the use of the binary hash an implementation detail of
    find_rerere_dir(), not known by callers. That will free us up to
    change it in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously I have an ulterior motive here, but mostly this just seemed
to make the code clearer to me. The separation of concerns might also
help if we did something more exotic with rerere conflict hashes (which
just use the_hash_algo now, but really don't have to).

 rerere.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index d6928c1b5c..7b0c262ac6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -146,7 +146,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 	int pos;
 
 	if (get_sha1_hex(hex, hash))
-		return NULL; /* BUG */
+		BUG("cannot parse rerere dir hex?");
 	pos = hash_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash);
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
@@ -1178,6 +1178,13 @@ static void prune_one(struct rerere_id *id,
 		unlink_rr_item(id);
 }
 
+/* Does the basename in "path" look plausibly like an rr-cache entry? */
+static int is_rr_cache_dirname(const char *path)
+{
+	unsigned char hash[GIT_MAX_RAWSZ];
+	return !get_sha1_hex(path, hash);
+}
+
 void rerere_gc(struct repository *r, struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
@@ -1205,10 +1212,11 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		rr_dir = find_rerere_dir(e->d_name);
-		if (!rr_dir)
+		if (!is_rr_cache_dirname(e->d_name))
 			continue; /* or should we remove e->d_name? */
 
+		rr_dir = find_rerere_dir(e->d_name);
+
 		now_empty = 1;
 		for (id.variant = 0, id.collection = rr_dir;
 		     id.variant < id.collection->status_nr;
-- 
2.30.0.758.gfe500d6872

