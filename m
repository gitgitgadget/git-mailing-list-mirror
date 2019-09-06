Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9D61F461
	for <e@80x24.org>; Fri,  6 Sep 2019 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfIFBgI (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 21:36:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:41632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726829AbfIFBgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 21:36:08 -0400
Received: (qmail 12127 invoked by uid 109); 6 Sep 2019 01:36:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 01:36:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 833 invoked by uid 111); 6 Sep 2019 01:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 21:37:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 21:36:05 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH v2 6/6] pack-objects: drop packlist index_pos optimization
Message-ID: <20190906013604.GA32054@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <20190905224859.GA28660@sigill.intra.peff.net>
 <963e5249-82ca-8961-917a-f45c20b1affe@gmx.net>
 <20190905225802.GA19526@sigill.intra.peff.net>
 <6894a758-d4ee-92e8-1aab-fc44c9ddcdc3@gmx.net>
 <20190906012430.GA29104@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906012430.GA29104@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 09:24:30PM -0400, Jeff King wrote:

> Running on linux.git, I got:
> 
>   [before]
>   Benchmark #1: git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1
>     Time (mean ± σ):     26.225 s ±  0.233 s    [User: 24.089 s, System: 4.867 s]
>     Range (min … max):   25.915 s … 26.555 s    10 runs
> 
>   [after]
>   Benchmark #1: git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1
>     Time (mean ± σ):     26.129 s ±  0.170 s    [User: 24.003 s, System: 4.958 s]
>     Range (min … max):   25.974 s … 26.570 s    10 runs
> 
> So actually faster after, though not statistically significant. ;)

By the way, I wondered if LTO actually helped here. Those are both
compiled with -O2. Here's the same measurement with "-flto -O2":

  Benchmark #1: git pack-objects --stdout --delta-base-offset <input >/dev/null 2>&1
  Time (mean ± σ):     26.276 s ±  0.131 s    [User: 24.153 s, System: 4.900 s]
  Range (min … max):   26.111 s … 26.469 s    10 runs

Slightly slower, but still within the noise.

> The BUG() on "found==1" might be worth doing.

And here's a revised version of patch 6 with that (it matches the
duplicate check that rehash_objects does, too, which is a nice
symmetry).

-- >8 --
Subject: [PATCH v2] pack-objects: drop packlist index_pos optimization

Once upon a time, the code to add an object to our packing list in
pack-objects all lived in a single function. It computed the position
within the hash table once, then used it to check if the object was
already present, and if not, to add it.

Later, in 2834bc27c1 (pack-objects: refactor the packing list,
2013-10-24), this was split into two functions: packlist_find() and
packlist_alloc(). We ended up with an "index_pos" variable that gets
passed through several functions to make it from one to the other.

The resulting code is rather confusing to follow. The "index_pos"
variable is sometimes undefined, if we don't yet have a hash table. This
works out in practice because in that case packlist_alloc() won't use it
at all, since it will have to create/grow the hash table. But it's hard
to verify that, and it does cause gcc 9.2.1's -Wmaybe-uninitialized to
complain when compiled with "-flto -O3" (rightfully, since we do pass
the uninitialized value as a function parameter, even if nobody ends up
using it).

All of this is to save computing the hash index again when we're
inserting into the hash table, which I found doesn't make a measurable
difference in the program runtime (which is not surprising, since we're
doing all kinds of other heavyweight things for each object).

Let's just drop this index_pos variable entirely, simplifying the code
(and pleasing the compiler).

We might be better still refactoring this custom hash table to use one
of our existing implementations (an oidmap, or a kh_oid_map). I stopped
short of that here, but this would be the likely first step towards that
anyway.

Reported-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 33 ++++++++++++++-------------------
 pack-bitmap-write.c    |  2 +-
 pack-bitmap.c          |  2 +-
 pack-objects.c         | 20 +++++++++++---------
 pack-objects.h         |  6 ++----
 5 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dc2a7e9ac0..9a8d935700 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -610,12 +610,12 @@ static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 		       void *cb_data)
 {
 	struct object_id peeled;
-	struct object_entry *entry = packlist_find(&to_pack, oid, NULL);
+	struct object_entry *entry = packlist_find(&to_pack, oid);
 
 	if (entry)
 		entry->tagged = 1;
 	if (!peel_ref(path, &peeled)) {
-		entry = packlist_find(&to_pack, &peeled, NULL);
+		entry = packlist_find(&to_pack, &peeled);
 		if (entry)
 			entry->tagged = 1;
 	}
@@ -996,12 +996,11 @@ static int no_try_delta(const char *path)
  * few lines later when we want to add the new entry.
  */
 static int have_duplicate_entry(const struct object_id *oid,
-				int exclude,
-				uint32_t *index_pos)
+				int exclude)
 {
 	struct object_entry *entry;
 
-	entry = packlist_find(&to_pack, oid, index_pos);
+	entry = packlist_find(&to_pack, oid);
 	if (!entry)
 		return 0;
 
@@ -1141,13 +1140,12 @@ static void create_object_entry(const struct object_id *oid,
 				uint32_t hash,
 				int exclude,
 				int no_try_delta,
-				uint32_t index_pos,
 				struct packed_git *found_pack,
 				off_t found_offset)
 {
 	struct object_entry *entry;
 
-	entry = packlist_alloc(&to_pack, oid, index_pos);
+	entry = packlist_alloc(&to_pack, oid);
 	entry->hash = hash;
 	oe_set_type(entry, type);
 	if (exclude)
@@ -1171,11 +1169,10 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
-	uint32_t index_pos;
 
 	display_progress(progress_state, ++nr_seen);
 
-	if (have_duplicate_entry(oid, exclude, &index_pos))
+	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
 	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
@@ -1190,7 +1187,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
-			    index_pos, found_pack, found_offset);
+			    found_pack, found_offset);
 	return 1;
 }
 
@@ -1199,17 +1196,15 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 					int flags, uint32_t name_hash,
 					struct packed_git *pack, off_t offset)
 {
-	uint32_t index_pos;
-
 	display_progress(progress_state, ++nr_seen);
 
-	if (have_duplicate_entry(oid, 0, &index_pos))
+	if (have_duplicate_entry(oid, 0))
 		return 0;
 
 	if (!want_object_in_pack(oid, 0, &pack, &offset))
 		return 0;
 
-	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
+	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
 	return 1;
 }
 
@@ -1507,7 +1502,7 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 	 * First see if we're already sending the base (or it's explicitly in
 	 * our "excluded" list).
 	 */
-	base = packlist_find(&to_pack, &base_oid, NULL);
+	base = packlist_find(&to_pack, &base_oid);
 	if (base) {
 		if (!in_same_island(&delta->idx.oid, &base->idx.oid))
 			return 0;
@@ -2579,7 +2574,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid, NULL))
+	if (packlist_find(&to_pack, oid))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2603,7 +2598,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, &peeled, NULL))      /* object packed? */
+	    packlist_find(&to_pack, &peeled))      /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
@@ -2803,7 +2798,7 @@ static void show_object(struct object *obj, const char *name, void *data)
 		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
 			depth++;
 
-		ent = packlist_find(&to_pack, &obj->oid, NULL);
+		ent = packlist_find(&to_pack, &obj->oid);
 		if (ent && depth > oe_tree_depth(&to_pack, ent))
 			oe_set_tree_depth(&to_pack, ent, depth);
 	}
@@ -3034,7 +3029,7 @@ static void loosen_unused_packed_objects(void)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
-			if (!packlist_find(&to_pack, &oid, NULL) &&
+			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
 				if (force_object_loose(&oid, p->mtime))
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index fa78a460c9..a7a4964b50 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -144,7 +144,7 @@ static inline void reset_all_seen(void)
 
 static uint32_t find_object_pos(const struct object_id *oid)
 {
-	struct object_entry *entry = packlist_find(writer.to_pack, oid, NULL);
+	struct object_entry *entry = packlist_find(writer.to_pack, oid);
 
 	if (!entry) {
 		die("Failed to write bitmap index. Packfile doesn't have full closure "
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ed2befaac6..84cd1bed4a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1063,7 +1063,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 
 		entry = &bitmap_git->pack->revindex[i];
 		nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
-		oe = packlist_find(mapping, &oid, NULL);
+		oe = packlist_find(mapping, &oid);
 
 		if (oe)
 			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
diff --git a/pack-objects.c b/pack-objects.c
index c1df08df1a..c6250d77f4 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -68,8 +68,7 @@ static void rehash_objects(struct packing_data *pdata)
 }
 
 struct object_entry *packlist_find(struct packing_data *pdata,
-				   const struct object_id *oid,
-				   uint32_t *index_pos)
+				   const struct object_id *oid)
 {
 	uint32_t i;
 	int found;
@@ -79,9 +78,6 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 
 	i = locate_object_entry_hash(pdata, oid, &found);
 
-	if (index_pos)
-		*index_pos = i;
-
 	if (!found)
 		return NULL;
 
@@ -153,8 +149,7 @@ void prepare_packing_data(struct repository *r, struct packing_data *pdata)
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-				    const struct object_id *oid,
-				    uint32_t index_pos)
+				    const struct object_id *oid)
 {
 	struct object_entry *new_entry;
 
@@ -181,8 +176,15 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 	if (pdata->index_size * 3 <= pdata->nr_objects * 4)
 		rehash_objects(pdata);
-	else
-		pdata->index[index_pos] = pdata->nr_objects;
+	else {
+		int found;
+		uint32_t pos = locate_object_entry_hash(pdata,
+							&new_entry->idx.oid,
+							&found);
+		if (found)
+			BUG("duplicate object inserted into hash");
+		pdata->index[pos] = pdata->nr_objects;
+	}
 
 	if (pdata->in_pack)
 		pdata->in_pack[pdata->nr_objects - 1] = NULL;
diff --git a/pack-objects.h b/pack-objects.h
index 47bf7ebf86..6fe6ae5ee8 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -183,12 +183,10 @@ static inline void packing_data_unlock(struct packing_data *pdata)
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-				    const struct object_id *oid,
-				    uint32_t index_pos);
+				    const struct object_id *oid);
 
 struct object_entry *packlist_find(struct packing_data *pdata,
-				   const struct object_id *oid,
-				   uint32_t *index_pos);
+				   const struct object_id *oid);
 
 static inline uint32_t pack_name_hash(const char *name)
 {
-- 
2.23.0.463.g883b23b1c5

