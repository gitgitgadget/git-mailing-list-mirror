From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Tue, 03 Dec 2013 15:40:41 +0100
Message-ID: <529DED69.4080300@gmail.com>
References: <20131114124157.GA23784@sigill.intra.peff.net> <20131114124432.GJ10757@sigill.intra.peff.net> <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net> <5295B6A8.70303@gmail.com> <20131128103838.GB14615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	=?UTF-8?B?VmljZW4=?= =?UTF-8?B?dCBNYXJ0w60=?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 03 15:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnr9e-0004xu-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab3LCOkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 09:40:46 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:52743 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3LCOko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:40:44 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so5993650bkb.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/+3u20h5XBE6NylKBCqlD+WLhYDB1aZnR1KjDW9L+Do=;
        b=EdNP4WNz0LWUmMQ9Ne/BWUT8LfLrQV8rN/xCRUvx+eNOf4vW6w4QR74NI0IAPsSC3W
         8jEmmmKnavfK/8bJ+vQDTu1fEpToQpP/azFgeGAuOYlyqabbsjVN1sOwMrv3YT5LLqim
         kc9ReUVO4cm2+uCE16pjYrs3ofQbHuv+cNwEOYf2J3gJj+wqHXHOeKxwjdcSHwkR6HvO
         VjCHt/q+gzf7iwFXk/N5LL+BNHYpxWm0vhaOIVKJZcOnYensPwxNBjW/KH1/GACZSBhp
         7aE6jV+k4pjNDFCYrzk2O+DmQ2ICYfQzbz3JZXUAiYReo8fqHJAc29PMoHKP3Ki81kKg
         6myg==
X-Received: by 10.204.111.200 with SMTP id t8mr3549232bkp.43.1386081642910;
        Tue, 03 Dec 2013 06:40:42 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a4sm78671980bko.11.2013.12.03.06.40.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 06:40:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131128103838.GB14615@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238692>

Am 28.11.2013 11:38, schrieb Jeff King:
> On Wed, Nov 27, 2013 at 10:08:56AM +0100, Karsten Blees wrote:
> 
>> Khash is OK for sha1 keys, but I don't think it should be advertised
>> as a second general purpose hash table implementation. Its far too
>> easy to shoot yourself in the foot by using 'straightforward' hash-
>> and comparison functions. Khash doesn't store the hash codes of the
>> keys, so you have to take care of that yourself or live with the
>> performance penalties (see [1]).
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/237876
> 
> Yes. I wonder if we should improve it in that respect. I haven't looked
> carefully at the hash code you posted elsewhere, but I feel like many
> uses will want a macro implementation to let them store arbitrary types
> smaller or larger than a pointer.
> 
> -Peff
> 

IMO, trying to improve khash isn't worth the trouble.

With smaller-than-pointer types, khash _may_ actually save a few bytes compared to hash.[ch] or hashmap.[ch]. E.g. a set of 'int's would be a perfect use case for khash. However, you're using bitmaps for that, and khash's predefined macros for int sets and maps have been removed from the git version.

Using khash with pointers and larger-than-pointer types is just a waste of memory and performance, though. Hash tables are sparsely filled by design, and using large types means lots of large empty buckets. E.g. kh_resize requires almost four times the size or your data, and copies everything at least three times.

Additionally, there are the obvious problems with khash's macro design (hard to read, impossible to debug, and each named instance increases executable size by ~4k).


Below is a patch that converts pack-bitmap.c to hashmap. Its not even longer than the khash version, and the hashmap API forces you to think about no-brainer improvements such as specifying an expected size or skipping duplicates checks where they aren't needed. I could do the same for pack-bitmap-write.c if you like.

Karsten

-----------8<----------
Subject: [PATCH] pack-bitmap.c: convert to new hashmap implementation

Preallocates bitmap_index.bitmaps with the expected size to prevent
rehashing.

Combines the five arrays of ext_index ('objects', 'hashes' and khash's
'keys', 'flags' and 'vals') into a single structure for better locality.

Removes two unnecessary duplicates checks:
 - we don't expect a pack index file to contain duplicate sha1's
 - ext_index_add_object is only called after bitmap_position returned -1,
   so it is impossible that the entry is already there

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 pack-bitmap.c | 166 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 81 insertions(+), 85 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 078f7c6..115caed 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -15,6 +15,7 @@
  * commit.
  */
 struct stored_bitmap {
+	struct hashmap_entry ent;
 	unsigned char sha1[20];
 	struct ewah_bitmap *root;
 	struct stored_bitmap *xor;
@@ -22,6 +23,16 @@ struct stored_bitmap {
 };
 
 /*
+ * An entry in the extended index.
+ */
+struct ext_entry {
+	struct hashmap_entry ent;
+	uint32_t name_hash;
+	struct object *object;
+	unsigned int nr;
+};
+
+/*
  * The currently active bitmap index. By design, repositories only have
  * a single bitmap index available (the index for the biggest packfile in
  * the repository), since bitmap indexes need full closure.
@@ -61,7 +72,7 @@ static struct bitmap_index {
 	struct ewah_bitmap *tags;
 
 	/* Map from SHA1 -> `stored_bitmap` for all the bitmapped comits */
-	khash_sha1 *bitmaps;
+	struct hashmap bitmaps;
 
 	/* Number of bitmapped commits */
 	uint32_t entry_count;
@@ -76,12 +87,7 @@ static struct bitmap_index {
 	 * packed in `pack`, these objects are added to this "fake index" and
 	 * are assumed to appear at the end of the packfile for all operations
 	 */
-	struct eindex {
-		struct object **objects;
-		uint32_t *hashes;
-		uint32_t count, alloc;
-		khash_sha1_pos *positions;
-	} ext_index;
+	struct hashmap ext_index;
 
 	/* Bitmap result of the last performed walk */
 	struct bitmap *result;
@@ -93,6 +99,21 @@ static struct bitmap_index {
 
 } bitmap_git;
 
+static int stored_bitmap_cmp(const struct stored_bitmap *entry,
+		const struct stored_bitmap *entry_or_key,
+		const unsigned char *sha1)
+{
+	return hashcmp(entry->sha1, sha1 ? sha1 : entry_or_key->sha1);
+}
+
+static int ext_entry_cmp(const struct ext_entry *entry,
+		const struct ext_entry *entry_or_key,
+		const unsigned char *sha1)
+{
+	return hashcmp(entry->object->sha1,
+		       sha1 ? sha1 : entry_or_key->object->sha1);
+}
+
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
 	struct ewah_bitmap *parent;
@@ -112,6 +133,16 @@ static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 	return composed;
 }
 
+static struct ewah_bitmap *lookup_stored_bitmap_sha1(const unsigned char *sha1)
+{
+	struct stored_bitmap key, *st;
+	hashmap_entry_init(&key, __kh_oid_hash(sha1));
+	st = hashmap_get(&bitmap_git.bitmaps, &key, sha1);
+	if (st)
+		return lookup_stored_bitmap(st);
+	return NULL;
+}
+
 /*
  * Read a bitmap from the current read position on the mmaped
  * index, and increase the read position accordingly
@@ -174,26 +205,15 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  int flags)
 {
 	struct stored_bitmap *stored;
-	khiter_t hash_pos;
-	int ret;
 
 	stored = xmalloc(sizeof(struct stored_bitmap));
+	hashmap_entry_init(stored, __kh_oid_hash(sha1));
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
 	hashcpy(stored->sha1, sha1);
 
-	hash_pos = kh_put_sha1(index->bitmaps, stored->sha1, &ret);
-
-	/* a 0 return code means the insertion succeeded with no changes,
-	 * because the SHA1 already existed on the map. this is bad, there
-	 * shouldn't be duplicated commits in the index */
-	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", sha1_to_hex(sha1));
-		return NULL;
-	}
-
-	kh_value(index->bitmaps, hash_pos) = stored;
+	hashmap_add(&index->bitmaps, stored);
 	return stored;
 }
 
@@ -291,8 +311,9 @@ static int load_pack_bitmap(void)
 {
 	assert(bitmap_git.map && !bitmap_git.loaded);
 
-	bitmap_git.bitmaps = kh_init_sha1();
-	bitmap_git.ext_index.positions = kh_init_sha1_pos();
+	hashmap_init(&bitmap_git.bitmaps, (hashmap_cmp_fn) stored_bitmap_cmp,
+			bitmap_git.entry_count);
+	hashmap_init(&bitmap_git.ext_index, (hashmap_cmp_fn) ext_entry_cmp, 0);
 	bitmap_git.reverse_index = revindex_for_pack(bitmap_git.pack);
 
 	if (!(bitmap_git.commits = read_bitmap_1(&bitmap_git)) ||
@@ -362,13 +383,12 @@ struct include_data {
 
 static inline int bitmap_position_extended(const unsigned char *sha1)
 {
-	khash_sha1_pos *positions = bitmap_git.ext_index.positions;
-	khiter_t pos = kh_get_sha1_pos(positions, sha1);
+	struct ext_entry key, *e;
+	hashmap_entry_init(&key, __kh_oid_hash(sha1));
+	e = hashmap_get(&bitmap_git.bitmaps, &key, sha1);
 
-	if (pos < kh_end(positions)) {
-		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_git.pack->num_objects;
-	}
+	if (e)
+		return e->nr + bitmap_git.pack->num_objects;
 
 	return -1;
 }
@@ -390,32 +410,13 @@ static int bitmap_position(const unsigned char *sha1)
 
 static int ext_index_add_object(struct object *object, const char *name)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
-
-	khiter_t hash_pos;
-	int hash_ret;
-	int bitmap_pos;
-
-	hash_pos = kh_put_sha1_pos(eindex->positions, object->sha1, &hash_ret);
-	if (hash_ret > 0) {
-		if (eindex->count >= eindex->alloc) {
-			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
-			eindex->objects = xrealloc(eindex->objects,
-				eindex->alloc * sizeof(struct object *));
-			eindex->hashes = xrealloc(eindex->hashes,
-				eindex->alloc * sizeof(uint32_t));
-		}
-
-		bitmap_pos = eindex->count;
-		eindex->objects[eindex->count] = object;
-		eindex->hashes[eindex->count] = pack_name_hash(name);
-		kh_value(eindex->positions, hash_pos) = bitmap_pos;
-		eindex->count++;
-	} else {
-		bitmap_pos = kh_value(eindex->positions, hash_pos);
-	}
-
-	return bitmap_pos + bitmap_git.pack->num_objects;
+	struct ext_entry *e = xmalloc(sizeof(struct ext_entry));
+	hashmap_entry_init(e, __kh_oid_hash(object->sha1));
+	e->object = object;
+	e->name_hash = pack_name_hash(name);
+	e->nr = bitmap_git.ext_index.size;
+	hashmap_add(&bitmap_git.ext_index, e);
+	return e->nr + bitmap_git.pack->num_objects;
 }
 
 static void show_object(struct object *object, const struct name_path *path,
@@ -443,7 +444,7 @@ static int add_to_include_set(struct include_data *data,
 			      const unsigned char *sha1,
 			      int bitmap_pos)
 {
-	khiter_t hash_pos;
+	struct ewah_bitmap *bm;
 
 	if (data->seen && bitmap_get(data->seen, bitmap_pos))
 		return 0;
@@ -451,10 +452,9 @@ static int add_to_include_set(struct include_data *data,
 	if (bitmap_get(data->base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_sha1(bitmap_git.bitmaps, sha1);
-	if (hash_pos < kh_end(bitmap_git.bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, hash_pos);
-		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
+	bm = lookup_stored_bitmap_sha1(sha1);
+	if (bm) {
+		bitmap_or_ewah(data->base, bm);
 		return 0;
 	}
 
@@ -507,12 +507,9 @@ static struct bitmap *find_objects(struct rev_info *revs,
 		roots = roots->next;
 
 		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_sha1(bitmap_git.bitmaps, object->sha1);
-
-			if (pos < kh_end(bitmap_git.bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
+			struct ewah_bitmap *or_with =
+				lookup_stored_bitmap_sha1(object->sha1);
+			if (or_with) {
 				if (base == NULL)
 					base = ewah_to_bitmap(or_with);
 				else
@@ -584,17 +581,15 @@ static struct bitmap *find_objects(struct rev_info *revs,
 static void show_extended_objects(struct bitmap *objects,
 				  show_reachable_fn show_reach)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
-	uint32_t i;
-
-	for (i = 0; i < eindex->count; ++i) {
-		struct object *obj;
+	struct ext_entry *e;
+	struct hashmap_iter iter;
 
-		if (!bitmap_get(objects, bitmap_git.pack->num_objects + i))
+	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
+	     e = hashmap_iter_next(&iter)) {
+		if (!bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
 			continue;
 
-		obj = eindex->objects[i];
-		show_reach(obj->sha1, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(e->object->sha1, e->object->type, 0, e->name_hash, NULL, 0);
 	}
 }
 
@@ -831,7 +826,8 @@ void traverse_bitmap_commit_list(show_reachable_fn show_reachable)
 static uint32_t count_object_type(struct bitmap *objects,
 				  enum object_type type)
 {
-	struct eindex *eindex = &bitmap_git.ext_index;
+	struct ext_entry *e;
+	struct hashmap_iter iter;
 
 	uint32_t i = 0, count = 0;
 	struct ewah_iterator it;
@@ -863,9 +859,10 @@ static uint32_t count_object_type(struct bitmap *objects,
 		count += ewah_bit_popcount64(word);
 	}
 
-	for (i = 0; i < eindex->count; ++i) {
-		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git.pack->num_objects + i))
+	for (e = hashmap_iter_first(&bitmap_git.ext_index, &iter); e;
+	     e = hashmap_iter_next(&iter)) {
+		if (e->object->type == type &&
+			bitmap_get(objects, bitmap_git.pack->num_objects + e->nr))
 			count++;
 	}
 
@@ -928,7 +925,7 @@ void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
 	struct bitmap *result = NULL;
-	khiter_t pos;
+	struct ewah_bitmap *bm;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
 
@@ -942,12 +939,9 @@ void test_bitmap_walk(struct rev_info *revs)
 		bitmap_git.version, bitmap_git.entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_sha1(bitmap_git.bitmaps, root->sha1);
-
-	if (pos < kh_end(bitmap_git.bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git.bitmaps, pos);
-		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
 
+	bm = lookup_stored_bitmap_sha1(root->sha1);
+	if (bm) {
 		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
 			sha1_to_hex(root->sha1), (int)bm->bit_size, ewah_checksum(bm));
 
@@ -1020,6 +1014,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	struct bitmap *rebuild;
 	struct stored_bitmap *stored;
 	struct progress *progress = NULL;
+	struct hashmap_iter iter;
 
 	khiter_t hash_pos;
 	int hash_ret;
@@ -1049,7 +1044,8 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 	if (show_progress)
 		progress = start_progress("Reusing bitmaps", 0);
 
-	kh_foreach_value(bitmap_git.bitmaps, stored, {
+	for (stored = hashmap_iter_first(&bitmap_git.bitmaps, &iter); stored;
+	     stored = hashmap_iter_next(&iter)) {
 		if (stored->flags & BITMAP_FLAG_REUSE) {
 			if (!rebuild_bitmap(reposition,
 					    lookup_stored_bitmap(stored),
@@ -1063,7 +1059,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 			bitmap_reset(rebuild);
 			display_progress(progress, ++i);
 		}
-	});
+	}
 
 	stop_progress(&progress);
 
-- 
