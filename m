Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CB51F462
	for <e@80x24.org>; Thu, 23 May 2019 11:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfEWLag (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 07:30:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729430AbfEWLag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 07:30:36 -0400
Received: (qmail 11184 invoked by uid 109); 23 May 2019 11:30:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 May 2019 11:30:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30675 invoked by uid 111); 23 May 2019 11:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 May 2019 07:31:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 May 2019 07:30:31 -0400
Date:   Thu, 23 May 2019 07:30:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190523113031.GA17448@sigill.intra.peff.net>
References: <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410225721.GA32262@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 06:57:21PM -0400, Jeff King wrote:

>   2. The answer we get from a bitmap versus a regular traversal are not
>      apples-to-apples equivalent. The regular traversal walks down to
>      the UNINTERESTING commits, marks the boundaries trees and blobs as
>      UNINTERESTING, and then adds in all the interesting trees and blobs
>      minus the UNINTERESTING parts. So it can sometimes give the wrong
>      answer, claiming something is interesting when it is not.
> 
>      Whereas with bitmaps we fill in the trees and blobs as we walk, and
>      you get the true answer. But it means we may open up a lot more
>      trees than the equivalent traversal would.
> 
>      So one thing I've never really experimented with (and indeed, never
>      really thought about until writing this email) is that the bitmaps
>      could try to do that looser style of traversal, knowing that we
>      might err on the side of calling things interesting in a few cases.
>      But hopefully spending a lot less time opening trees.
> 
>      I'm not even 100% sure what that would look like in code, but just
>      thinking about it from a high level, I don't there's a particular
>      mathematical reason it couldn't work.

I spent a while thinking and experimenting with this tonight. The result
is the patch below. Ævar, do you still have a copy of the repo that
misbehaved? I'd be curious to see how it fares.

Finding the right trees to explore is a little tricky with bitmaps.  In
a normal traversal, we consider the "edges" to be worth exploring.
I.e., the places where an UNINTERESTING commit is the parent of an
interesting one.

But with bitmaps, we don't have that information in the same way,
because we're trying to avoid walking the commits in the first place. So
e.g., in a history like this:

  A--B--C
      \
       D

Let's imagine we're computing "C..D", and that D has a bitmap on disk
but C does not. When we visit D, we'll see that it has a bitmap, fill in
the results in our cumulative "want" bitmap, and then stop walking its
parents (because we know everything they could tell us already).

Then we visit C. It's not bitmapped, so we keep walking. Unlike a normal
traversal, we can't stop walking even though there are only
UNINTERESTING commits left, because we have to fill the complete bitmap,
including A and B (and you can imagine there might be thousands of
ancestors of A, too). The reason is that we skipped adding ancestors of
D when we saw its bitmap, so no still_interesting() cutoff will work
there.

But how do we know that it's worth looking into the tree of "B"? If we
assume we visit commits before their ancestors (because of the commit
timestamp ordering), then we'd see that "B" is in the "want" bitmap
already, which makes it worth visiting its tree.

Unfortunately we'd then continue on to "A", and it would _also_ look
interesting, because it's also in the "want" bitmap. We don't have an
easy way of knowing that "A" is basically already covered by "B", and is
therefore not worth pursuing. In this example, we could pass down a bit
from B to A as we traverse. But you can imagine another interesting
commit branched from A, which _would_ make A's tree worth considering.

Fundamentally, as soon as we load a bitmap and stop traversing, we lose
all information about the graph structure.

So the patch below just looks at every tree that might be worth
exploring (so both "A" and "B" here, but not "C"). That shouldn't be any
_worse_ than what the current code does (because it looks at all the
trees). It appears to behave correctly, at least so far as passing the
test suite. Running p5310 and p5311 against git.git and linux.git, it
seems to perform worse. I'm not quite sure why that is (i.e., if I
screwed up something in the implementation, or if the algorithm is
fundamentally worse).

There are a lot of rough edges in the patch; I was just trying to see if
the idea was even viable. So don't bother reviewing it as a real
proposal for inclusion. If you do read it, I'd recommend just looking at
the post-image, since it's essentially a rewrite and the diff is a bit
messy.

-Peff

---
 pack-bitmap.c | 398 ++++++++++++++++++++++++--------------------------
 1 file changed, 193 insertions(+), 205 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6069b2fe55..4a40f62a38 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -12,6 +12,8 @@
 #include "packfile.h"
 #include "repository.h"
 #include "object-store.h"
+#include "blob.h"
+#include "prio-queue.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -422,180 +424,22 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 	return bitmap_pos + bitmap_git->pack->num_objects;
 }
 
-struct bitmap_show_data {
-	struct bitmap_index *bitmap_git;
-	struct bitmap *base;
-};
-
-static void show_object(struct object *object, const char *name, void *data_)
-{
-	struct bitmap_show_data *data = data_;
-	int bitmap_pos;
-
-	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
-
-	if (bitmap_pos < 0)
-		bitmap_pos = ext_index_add_object(data->bitmap_git, object,
-						  name);
-
-	bitmap_set(data->base, bitmap_pos);
-}
-
-static void show_commit(struct commit *commit, void *data)
-{
-}
-
-static int add_to_include_set(struct bitmap_index *bitmap_git,
-			      struct include_data *data,
-			      const struct object_id *oid,
-			      int bitmap_pos)
-{
-	khiter_t hash_pos;
-
-	if (data->seen && bitmap_get(data->seen, bitmap_pos))
-		return 0;
-
-	if (bitmap_get(data->base, bitmap_pos))
-		return 0;
-
-	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, *oid);
-	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
-		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
-		return 0;
-	}
-
-	bitmap_set(data->base, bitmap_pos);
-	return 1;
-}
-
-static int should_include(struct commit *commit, void *_data)
-{
-	struct include_data *data = _data;
-	int bitmap_pos;
-
-	bitmap_pos = bitmap_position(data->bitmap_git, &commit->object.oid);
-	if (bitmap_pos < 0)
-		bitmap_pos = ext_index_add_object(data->bitmap_git,
-						  (struct object *)commit,
-						  NULL);
-
-	if (!add_to_include_set(data->bitmap_git, data, &commit->object.oid,
-				bitmap_pos)) {
-		struct commit_list *parent = commit->parents;
-
-		while (parent) {
-			parent->item->object.flags |= SEEN;
-			parent = parent->next;
-		}
-
-		return 0;
-	}
-
-	return 1;
-}
-
-static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
-				   struct rev_info *revs,
-				   struct object_list *roots,
-				   struct bitmap *seen)
+static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
+				struct bitmap **base, struct commit *commit)
 {
-	struct bitmap *base = NULL;
-	int needs_walk = 0;
-
-	struct object_list *not_mapped = NULL;
-
-	/*
-	 * Go through all the roots for the walk. The ones that have bitmaps
-	 * on the bitmap index will be `or`ed together to form an initial
-	 * global reachability analysis.
-	 *
-	 * The ones without bitmaps in the index will be stored in the
-	 * `not_mapped_list` for further processing.
-	 */
-	while (roots) {
-		struct object *object = roots->item;
-		roots = roots->next;
-
-		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
-
-			if (pos < kh_end(bitmap_git->bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
-				if (base == NULL)
-					base = ewah_to_bitmap(or_with);
-				else
-					bitmap_or_ewah(base, or_with);
-
-				object->flags |= SEEN;
-				continue;
-			}
-		}
-
-		object_list_insert(object, &not_mapped);
-	}
-
-	/*
-	 * Best case scenario: We found bitmaps for all the roots,
-	 * so the resulting `or` bitmap has the full reachability analysis
-	 */
-	if (not_mapped == NULL)
-		return base;
-
-	roots = not_mapped;
-
-	/*
-	 * Let's iterate through all the roots that don't have bitmaps to
-	 * check if we can determine them to be reachable from the existing
-	 * global bitmap.
-	 *
-	 * If we cannot find them in the existing global bitmap, we'll need
-	 * to push them to an actual walk and run it until we can confirm
-	 * they are reachable
-	 */
-	while (roots) {
-		struct object *object = roots->item;
-		int pos;
-
-		roots = roots->next;
-		pos = bitmap_position(bitmap_git, &object->oid);
-
-		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
-			object->flags &= ~UNINTERESTING;
-			add_pending_object(revs, object, "");
-			needs_walk = 1;
-		} else {
-			object->flags |= SEEN;
-		}
-	}
-
-	if (needs_walk) {
-		struct include_data incdata;
-		struct bitmap_show_data show_data;
-
-		if (base == NULL)
-			base = bitmap_new();
-
-		incdata.bitmap_git = bitmap_git;
-		incdata.base = base;
-		incdata.seen = seen;
-
-		revs->include_check = should_include;
-		revs->include_check_data = &incdata;
-
-		if (prepare_revision_walk(revs))
-			die("revision walk setup failed");
+	khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
+	if (pos < kh_end(bitmap_git->bitmaps)) {
+		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
+		struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
 
-		show_data.bitmap_git = bitmap_git;
-		show_data.base = base;
+		if (*base == NULL)
+			*base = ewah_to_bitmap(or_with);
+		else
+			bitmap_or_ewah(*base, or_with);
 
-		traverse_commit_list(revs, show_commit, show_object,
-				     &show_data);
+		return 1;
 	}
-
-	return base;
+	return 0;
 }
 
 static void show_extended_objects(struct bitmap_index *bitmap_git,
@@ -665,24 +509,122 @@ static void show_objects_for_type(
 	}
 }
 
-static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
-			     struct object_list *roots)
+static void add_object_to_bitmap(struct bitmap_index *bitmap_git,
+				 struct object *obj,
+				 struct bitmap *bitmap,
+				 struct bitmap *seen,
+				 int ignore_missing);
+
+static void add_tag_to_bitmap(struct bitmap_index *bitmap_git,
+			      struct tag *tag,
+			      struct bitmap *bitmap,
+			      struct bitmap *seen,
+			      int ignore_missing)
+{
+	if (parse_tag(tag) < 0 || !tag->tagged) {
+		if (ignore_missing)
+			return;
+		die("unable to parse tag %s", oid_to_hex(&tag->object.oid));
+	}
+	add_object_to_bitmap(bitmap_git, tag->tagged, bitmap, seen,
+			     ignore_missing);
+}
+
+static void add_tree_to_bitmap(struct bitmap_index *bitmap_git,
+			       struct tree *tree,
+			       struct bitmap *bitmap,
+			       struct bitmap *seen,
+			       int ignore_missing)
 {
-	while (roots) {
-		struct object *object = roots->item;
-		roots = roots->next;
+	struct tree_desc desc;
+	struct name_entry entry;
 
-		if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
-			return 1;
+	if (parse_tree(tree) < 0) {
+		if (ignore_missing)
+			return;
+		die("unable to parse tree %s", oid_to_hex(&tree->object.oid));
 	}
 
-	return 0;
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode)) {
+			struct tree *t = lookup_tree(the_repository, &entry.oid);
+			if (!t) {
+				die(_("entry '%s' in tree %s has tree mode, "
+				      "but is not a tree"),
+				    entry.path, oid_to_hex(&tree->object.oid));
+			}
+			add_object_to_bitmap(bitmap_git, &t->object,
+					     bitmap, seen, ignore_missing);
+		} else if (!S_ISGITLINK(entry.mode)) {
+			struct blob *b = lookup_blob(the_repository, &entry.oid);
+			if (!b) {
+				die(_("entry '%s' in tree %s has blob mode, "
+				      "but is not a blob"),
+				    entry.path, oid_to_hex(&tree->object.oid));
+			}
+			add_object_to_bitmap(bitmap_git, &b->object,
+					     bitmap, seen, ignore_missing);
+		}
+	}
+
+	free_tree_buffer(tree);
+}
+
+static void add_object_to_bitmap(struct bitmap_index *bitmap_git,
+				 struct object *obj,
+				 struct bitmap *bitmap,
+				 struct bitmap *seen,
+				 int ignore_missing)
+{
+	int pos = bitmap_position(bitmap_git, &obj->oid);
+
+	if (pos < 0)
+		pos = ext_index_add_object(bitmap_git, obj, NULL);
+
+	if (bitmap_get(bitmap, pos))
+		return; /* already there */
+
+	if (seen && bitmap_get(seen, pos))
+		return; /* seen in other bitmap; not worth digging further */
+
+	bitmap_set(bitmap, pos);
+
+	if (obj->type == OBJ_BLOB)
+		return;
+	else if (obj->type == OBJ_TAG)
+		add_tag_to_bitmap(bitmap_git, (struct tag *)obj,
+				  bitmap, seen, ignore_missing);
+	else if (obj->type == OBJ_TREE)
+		add_tree_to_bitmap(bitmap_git, (struct tree *)obj,
+				   bitmap, seen, ignore_missing);
+	else
+		BUG("unexpected object type: %d", obj->type);
+}
+
+static void add_objects_to_bitmap(struct bitmap_index *bitmap_git,
+				  struct object_list **list,
+				  struct bitmap *bitmap,
+				  struct bitmap *seen,
+				  int ignore_missing)
+{
+	while (*list) {
+		struct object_list *cur = *list;
+
+		add_object_to_bitmap(bitmap_git, cur->item,
+				     bitmap, seen, ignore_missing);
+
+		*list = cur->next;
+		free(cur);
+	}
 }
 
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 {
 	unsigned int i;
 
+	struct prio_queue commits = { compare_commits_by_commit_date };
+
 	struct object_list *wants = NULL;
 	struct object_list *haves = NULL;
 
@@ -714,24 +656,16 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 			object = parse_object_or_die(&tag->tagged->oid, NULL);
 		}
 
-		if (object->flags & UNINTERESTING)
-			object_list_insert(object, &haves);
-		else
-			object_list_insert(object, &wants);
+		if (object->type == OBJ_COMMIT)
+			prio_queue_put(&commits, object);
+		else {
+			if (object->flags & UNINTERESTING)
+				object_list_insert(object, &haves);
+			else
+				object_list_insert(object, &wants);
+		}
 	}
 
-	/*
-	 * if we have a HAVES list, but none of those haves is contained
-	 * in the packfile that has a bitmap, we don't have anything to
-	 * optimize here
-	 */
-	if (haves && !in_bitmapped_pack(bitmap_git, haves))
-		goto cleanup;
-
-	/* if we don't want anything, we're done here */
-	if (!wants)
-		goto cleanup;
-
 	/*
 	 * now we're going to use bitmaps, so load the actual bitmap entries
 	 * from disk. this is the point of no return; after this the rev_list
@@ -742,20 +676,74 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 
 	object_array_clear(&revs->pending);
 
-	if (haves) {
-		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
-		reset_revision_walk();
-		revs->ignore_missing_links = 0;
+	haves_bitmap = bitmap_new();
+	wants_bitmap = bitmap_new();
 
-		if (haves_bitmap == NULL)
-			BUG("failed to perform bitmap walk");
-	}
+	/*
+	 * First traverse the relevant commits as we would for a normal
+	 * traversal.
+	 */
+	while (commits.nr) {
+		struct commit *commit = prio_queue_get(&commits);
+		struct bitmap **dst_bitmap;
+		int pos;
+		struct commit_list *parent;
+
+		if (commit->object.flags & UNINTERESTING)
+			dst_bitmap = &haves_bitmap;
+		else
+			dst_bitmap = &wants_bitmap;
 
-	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
+		pos = bitmap_position(bitmap_git, &commit->object.oid);
+		if (pos >= 0 && *dst_bitmap && bitmap_get(*dst_bitmap, pos))
+			continue; /* already covered */
 
-	if (!wants_bitmap)
-		BUG("failed to perform bitmap walk");
+		if (add_commit_to_bitmap(bitmap_git, dst_bitmap, commit))
+			continue; /* skip adding parents, they're covered */
+
+
+		/* otherwise mark ourselves and queue dependent objects */
+		if (pos < 0)
+			pos = ext_index_add_object(bitmap_git, &commit->object, NULL);
+		bitmap_set(*dst_bitmap, pos);
+		if (parse_commit(commit)) {
+			if (commit->object.flags & UNINTERESTING)
+				continue;
+			die("unable to parse commit %s",
+			    oid_to_hex(&commit->object.oid));
+		}
+		if (commit->object.flags & UNINTERESTING) {
+			/*
+			 * If an uninteresting commit is in the "wants" bitmap,
+			 * then our tree is worth exploring. This means we may
+			 * miss some trees in the "haves" that are not
+			 * ancestors of "wants" (or that are, but we missed
+			 * because of out-of-order timestamps).
+			 */
+			if (wants_bitmap && bitmap_get(wants_bitmap, pos))
+				object_list_insert(&get_commit_tree(commit)->object,
+						   &haves);
+		} else {
+			/*
+			 * "wants" must always be explored
+			 */
+			object_list_insert(&get_commit_tree(commit)->object,
+					   &wants);
+		}
+
+		for (parent = commit->parents; parent; parent = parent->next) {
+			if (commit->object.flags & UNINTERESTING)
+				parent->item->object.flags |= UNINTERESTING;
+			prio_queue_put(&commits, parent->item);
+		}
+	}
+
+	/*
+	 * At this point we've processed all of the commits, and queued items
+	 * in "haves" and "wants" that need to be marked.
+	 */
+	add_objects_to_bitmap(bitmap_git, &haves, haves_bitmap, NULL, 1);
+	add_objects_to_bitmap(bitmap_git, &wants, wants_bitmap, haves_bitmap, 0);
 
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
-- 
2.22.0.rc1.549.gadb183c4cb

