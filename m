Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC6AC4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF302070E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392170AbhALPxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:53:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:53564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391882AbhALPxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:53:15 -0500
Received: (qmail 11476 invoked by uid 109); 12 Jan 2021 15:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 15:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15870 invoked by uid 111); 12 Jan 2021 15:52:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 10:52:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 10:52:32 -0500
From:   Jeff King <peff@peff.net>
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH] patch-ids: handle duplicate hashmap entries
Message-ID: <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
 <X/28IXBpse2dNZQH@coredump.intra.peff.net>
 <20210112153438.GC32482@sync>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112153438.GC32482@sync>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:34:38PM +0000, Arnaud Morin wrote:

> So instead of:
> id = has_commit_patch_id(commit, &ids);
> 
> We should use some sort of iterator, in order to call:
> id->commit->object.flags |= cherry_flag;
> 
> for all commits which are related to this patch?

Yep, exactly.

Here it is as a patch. :)

-- >8 --
Subject: [PATCH] patch-ids: handle duplicate hashmap entries

This fixes a bug introduced in dfb7a1b4d0 (patch-ids: stop using a
hand-rolled hashmap implementation, 2016-07-29) in which

  git rev-list --cherry-pick A...B

will fail to suppress commits reachable from A even if a commit with
matching patch-id appears in B.

Around the time of that commit, the algorithm for "--cherry-pick" looked
something like this:

  0. Traverse all of the commits, marking them as being on the left or
     right side of the symmetric difference.

  1. Iterate over the left-hand commits, inserting a patch-id struct for
     each into a hashmap, and pointing commit->util to the patch-id
     struct.

  2. Iterate over the right-hand commits, checking which are present in
     the hashmap. If so, we exclude the commit from the output _and_ we
     mark the patch-id as "seen".

  3. Iterate again over the left-hand commits, checking whether
     commit->util->seen is set; if so, exclude them from the output.

At the end, we'll have eliminated commits from both sides that have a
matching patch-id on the other side. But there's a subtle assumption
here: for any given patch-id, we must have exactly one struct
representing it. If two commits from A both have the same patch-id and
we allow duplicates in the hashmap, then we run into a problem:

  a. In step 1, we insert two patch-id structs into the hashmap.

  b. In step 2, our lookups will find only one of these structs, so only
     one "seen" flag is marked.

  c. In step 3, one of the commits in A will have its commit->util->seen
     set, but the other will not. We'll erroneously output the latter.

Prior to dfb7a1b4d0, our hashmap did not allow duplicates. Afterwards,
it used hashmap_add(), which explicitly does allow duplicates.

At that point, the solution would have been easy: when we are about to
add a duplicate, skip doing so and return the existing entry which
matches. But it gets more complicated.

In 683f17ec44 (patch-ids: replace the seen indicator with a commit
pointer, 2016-07-29), our step 3 goes away entirely. Instead, in step 2,
when the right-hand side finds a matching patch_id from the left-hand
side, we can directly mark the left-hand patch_id->commit to be omitted.
Solving that would be easy, too; there's a one-to-many relationship of
patch-ids to commits, so we just need to keep a list.

But there's more. Commit b3dfeebb92 (rebase: avoid computing unnecessary
patch IDs, 2016-07-29) built on that by lazily computing the full
patch-ids. So we don't even know when adding to the hashmap whether two
commits truly have the same id. We'd have to tentatively assign them a
list, and then possibly split them apart (possibly into N new structs)
at the moment we compute the real patch-ids. This could work, but it's
complicated and error-prone.

Instead, let's accept that we may store duplicates, and teach the lookup
side to be more clever. Rather than asking for a single matching
patch-id, it will need to iterate over all matching patch-ids. This does
mean examining every entry in a single hash bucket, but the worst-case
for a hash lookup was already doing that.

We'll keep the hashmap details out of the caller by providing a simple
iteration interface. We can retain the simple has_commit_patch_id()
interface for the other callers, but we'll simplify its return value
into an integer, rather than returning the patch_id struct. That way
they won't be tempted to look at the "commit" field of the return value
without iterating.

Reported-by: Arnaud Morin <arnaud.morin@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 patch-ids.c                          | 14 +++++++++++++-
 patch-ids.h                          | 20 +++++++++++++++++++-
 revision.c                           |  6 ++++--
 t/t6007-rev-list-cherry-pick-file.sh | 12 ++++++++++++
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 21973e4933..f51021a0cb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -89,7 +89,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	return 0;
 }
 
-struct patch_id *has_commit_patch_id(struct commit *commit,
+struct patch_id *patch_id_iter_first(struct commit *commit,
 				     struct patch_ids *ids)
 {
 	struct patch_id patch;
@@ -104,6 +104,18 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	return hashmap_get_entry(&ids->patches, &patch, ent, NULL);
 }
 
+struct patch_id *patch_id_iter_next(struct patch_id *cur,
+				    struct patch_ids *ids)
+{
+	return hashmap_get_next_entry(&ids->patches, cur, ent);
+}
+
+int has_commit_patch_id(struct commit *commit,
+			struct patch_ids *ids)
+{
+	return !!patch_id_iter_first(commit, ids);
+}
+
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
diff --git a/patch-ids.h b/patch-ids.h
index 03bb04e707..ab6c6a6804 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -23,7 +23,25 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int, int);
 int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
+
+/* Add a patch_id for a single commit to the set. */
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
-struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
+
+/* Returns true if the patch-id of "commit" is present in the set. */
+int has_commit_patch_id(struct commit *commit, struct patch_ids *);
+
+/*
+ * Iterate over all commits in the set whose patch id matches that of
+ * "commit", like:
+ *
+ *   struct patch_id *cur;
+ *   for (cur = patch_id_iter_first(commit, ids);
+ *        cur;
+ *        cur = patch_id_iter_next(cur, ids) {
+ *           ... look at cur->commit
+ *   }
+ */
+struct patch_id *patch_id_iter_first(struct commit *commit, struct patch_ids *);
+struct patch_id *patch_id_iter_next(struct patch_id *cur, struct patch_ids *);
 
 #endif /* PATCH_IDS_H */
diff --git a/revision.c b/revision.c
index 9dff845bed..7ec9b634e3 100644
--- a/revision.c
+++ b/revision.c
@@ -1241,12 +1241,14 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		/*
 		 * Have we seen the same patch id?
 		 */
-		id = has_commit_patch_id(commit, &ids);
+		id = patch_id_iter_first(commit, &ids);
 		if (!id)
 			continue;
 
 		commit->object.flags |= cherry_flag;
-		id->commit->object.flags |= cherry_flag;
+		do {
+			id->commit->object.flags |= cherry_flag;
+		} while ((id = patch_id_iter_next(id, &ids)));
 	}
 
 	free_patch_ids(&ids);
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index f0268372d2..8bf5ae23c2 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -245,6 +245,18 @@ test_expect_success '--count --left-right' '
 	test_cmp expect actual
 '
 
+test_expect_success '--cherry-pick with duplicates on each side' '
+	git checkout -b dup-orig &&
+	test_commit dup-base &&
+	git revert dup-base &&
+	git cherry-pick dup-base &&
+	git checkout -b dup-side HEAD~3 &&
+	test_tick &&
+	git cherry-pick -3 dup-orig &&
+	git rev-list --cherry-pick dup-orig...dup-side >actual &&
+	test_must_be_empty actual
+'
+
 # Corrupt the object store deliberately to make sure
 # the object is not even checked for its existence.
 remove_loose_object () {
-- 
2.30.0.455.gdab6b73766

