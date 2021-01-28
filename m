Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E11C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E4F64DD6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhA1GfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:35:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhA1GfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:35:13 -0500
Received: (qmail 9923 invoked by uid 109); 28 Jan 2021 06:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:34:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25580 invoked by uid 111); 28 Jan 2021 06:34:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:34:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:34:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] rerere: use strmap to store rerere directories
Message-ID: <YBJa98B1a6mP/Bsx@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
 <YBJXYMFu8dhOabDv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJXYMFu8dhOabDv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 01:19:12AM -0500, Jeff King wrote:

> On Thu, Dec 03, 2020 at 11:28:14AM -0500, Jeff King wrote:
> 
> > We store a struct for each directory we access under .git/rr-cache. The
> > structs are kept in an array sorted by the binary hash associated with
> > their name (and we do lookups with a binary search).

Hmph. Apparently I accidentally sent this as a reply instead of sending
the original format-patch output. Oops.

Here it is minus the quoting, which should make it easier to apply. :)

-- >8 --
Subject: [PATCH] rerere: use strmap to store rerere directories

We store a struct for each directory we access under .git/rr-cache. The
structs are kept in an array sorted by the binary hash associated with
their name (and we do lookups with a binary search).

This works OK, but there are a few small downsides:

 - the amount of code isn't huge, but it's more than we'd need using one
   of our other stock data structures

 - the insertion into a sorted array is quadratic (though in practice
   it's unlikely anybody has enough conflicts for this to matter)

 - it's intimately tied to the representation of an object hash. This
   isn't a big deal, as the conflict ids we generate use the same hash,
   but it produces a few awkward bits (e.g., we are the only user of
   hash_pos() that is not using object_id).

Let's instead just treat the directory names as strings, and store them
in a strmap. This is less code, and removes the use of hash_pos().

Insertion is now non-quadratic, though we probably use a bit more
memory. Besides the hash table overhead, and storing hex bytes instead
of a binary hash, we actually store each name twice. Other code expects
to access the name of a rerere_dir struct from the struct itself, so we
need a copy there. But strmap keeps its own copy of the name, as well.

Using a bare hashmap instead of strmap means we could use the name for
both, but at the cost of extra code (e.g., our own comparison function).
Likewise, strmap has a feature to use a pointer to the in-struct name at
the cost of a little extra code. I didn't do either here, as simple code
seemed more important than squeezing out a few bytes of efficiency.

Signed-off-by: Jeff King <peff@peff.net>
---
This one might be controversial, or at least considered unnecessary
churn. Because the benefits I listed above are pretty negligible, and
really my ulterior motive is getting rid of the call to hash_pos().

Still, it was nice to try out strmap a bit more, and the resulting code
is shorter. It also abstracts things more, if we were to do something
more exotic with hashes (right now I think a sha256 repo just has sha256
conflict hashes, and everything would just work. I don't have any plans
to change that, but this would be a better base if somebody wanted to do
so later).

 rerere.c | 62 +++++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/rerere.c b/rerere.c
index e92e305f96..dee60dc6df 100644
--- a/rerere.c
+++ b/rerere.c
@@ -11,6 +11,7 @@
 #include "pathspec.h"
 #include "object-store.h"
 #include "hash-lookup.h"
+#include "strmap.h"
 
 #define RESOLVED 0
 #define PUNTED 1
@@ -23,26 +24,27 @@ static int rerere_enabled = -1;
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
 
-static int rerere_dir_nr;
-static int rerere_dir_alloc;
-
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
-static struct rerere_dir {
-	unsigned char hash[GIT_MAX_HEXSZ];
+struct rerere_dir {
 	int status_alloc, status_nr;
 	unsigned char *status;
-} **rerere_dir;
+	char name[FLEX_ARRAY];
+};
+
+static struct strmap rerere_dirs = STRMAP_INIT;
 
 static void free_rerere_dirs(void)
 {
-	int i;
-	for (i = 0; i < rerere_dir_nr; i++) {
-		free(rerere_dir[i]->status);
-		free(rerere_dir[i]);
+	struct hashmap_iter iter;
+	struct strmap_entry *ent;
+
+	strmap_for_each_entry(&rerere_dirs, &iter, ent) {
+		struct rerere_dir *rr_dir = ent->value;
+		free(rr_dir->status);
+		free(rr_dir);
 	}
-	FREE_AND_NULL(rerere_dir);
-	rerere_dir_nr = rerere_dir_alloc = 0;
+	strmap_clear(&rerere_dirs, 0);
 }
 
 static void free_rerere_id(struct string_list_item *item)
@@ -52,7 +54,7 @@ static void free_rerere_id(struct string_list_item *item)
 
 static const char *rerere_id_hex(const struct rerere_id *id)
 {
-	return hash_to_hex(id->collection->hash);
+	return id->collection->name;
 }
 
 static void fit_variant(struct rerere_dir *rr_dir, int variant)
@@ -115,7 +117,7 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 static void scan_rerere_dir(struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
-	DIR *dir = opendir(git_path("rr-cache/%s", hash_to_hex(rr_dir->hash)));
+	DIR *dir = opendir(git_path("rr-cache/%s", rr_dir->name));
 
 	if (!dir)
 		return;
@@ -133,39 +135,21 @@ static void scan_rerere_dir(struct rerere_dir *rr_dir)
 	closedir(dir);
 }
 
-static const unsigned char *rerere_dir_hash(size_t i, void *table)
-{
-	struct rerere_dir **rr_dir = table;
-	return rr_dir[i]->hash;
-}
-
 static struct rerere_dir *find_rerere_dir(const char *hex)
 {
-	unsigned char hash[GIT_MAX_RAWSZ];
 	struct rerere_dir *rr_dir;
-	int pos;
-
-	if (get_sha1_hex(hex, hash))
-		BUG("cannot parse rerere dir hex?");
-	pos = hash_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash);
-	if (pos < 0) {
-		rr_dir = xmalloc(sizeof(*rr_dir));
-		hashcpy(rr_dir->hash, hash);
+
+	rr_dir = strmap_get(&rerere_dirs, hex);
+	if (!rr_dir) {
+		FLEX_ALLOC_STR(rr_dir, name, hex);
 		rr_dir->status = NULL;
 		rr_dir->status_nr = 0;
 		rr_dir->status_alloc = 0;
-		pos = -1 - pos;
-
-		/* Make sure the array is big enough ... */
-		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
-		/* ... and add it in. */
-		rerere_dir_nr++;
-		MOVE_ARRAY(rerere_dir + pos + 1, rerere_dir + pos,
-			   rerere_dir_nr - pos - 1);
-		rerere_dir[pos] = rr_dir;
+		strmap_put(&rerere_dirs, hex, rr_dir);
+
 		scan_rerere_dir(rr_dir);
 	}
-	return rerere_dir[pos];
+	return rr_dir;
 }
 
 static int has_rerere_resolution(const struct rerere_id *id)
-- 
2.30.0.758.gfe500d6872

