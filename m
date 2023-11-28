Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ipwbJoUW"
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B58D1733
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:10 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a31b64a9aso18686186d6.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198489; x=1701803289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQrr3leSKb3XekPDx8zb8zAgnsSrKl75AYfTDMuWnS4=;
        b=ipwbJoUWzEwrOrW9ntwohoIosDg3g5kPQSd+7ytOVzOpidg7ujN4GcdCn2pWhviI1a
         DZ/ViKExk3D3jCZtts44rpLoYR+OV2U7Sicaxe7wvA1lFsBN+D1CDKewlMNixkr8asBz
         Zcwc2gybwEsU5OkADv3YJAIg2KKVKaVNteFh6OPXAfoSEguzVr1e5Vov03gORzqHg5LV
         2q6FZr8mXz/7MY5hRbMPXz7z8iT0Yscdsnb8hlS4VmJ6bUrBNuRXQb3tX9WjBouVwNPj
         yd8Axq0pfW9bd5i8ISLhbueD+zpMwOvw+Lc0gqn/fluWrHfFfGrPCrEceLYIKc0vdzgW
         BrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198489; x=1701803289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQrr3leSKb3XekPDx8zb8zAgnsSrKl75AYfTDMuWnS4=;
        b=onKBTarpDXfJKOw5N/wvChXZeT+stMDaAmKxHtLYL6Ret9V2YUfrmOuF0stU0ry4w2
         6bvwl/a2uyU5h+7j7FKZ2Zk7sNewZxevk8SqoyPXYr2YWi1OMyB5T1ygBMUqtpAOCJXu
         YBybdmZBRiEFHnSCKHtdJsRx88/xTaEz0fSTgttPO3NsbeBj7gN4xTMxwJLgbStPUUcu
         ItQ95OYDshOUGQmqnKWDfT+ezojP9O05jDkIK5f2ayJEwV8ps6wApkcycSTzCJAVdJAd
         4JgrNqN7+746pOVoYj+IfYdtyFpzYrwjKNdAY1U2axYzph21nLStCZpWTyEsJZheleGh
         VRRg==
X-Gm-Message-State: AOJu0YxMp7/ojrMAX0009TqGJ3IARNSpp5p9Bo+HsBy6uuPPBPY9KCjo
	QBzgvZOmimEIlXos95D2shTR99LPZQX6+elk/14=
X-Google-Smtp-Source: AGHT+IHk1G9co26ZDkBXbg9V9CRi5iWY7HM4cymzGVOJNw8+X39/z/MP3MUEIXm7gJtHpznZnqECbw==
X-Received: by 2002:a05:6214:86:b0:67a:2b0b:c591 with SMTP id n6-20020a056214008600b0067a2b0bc591mr13129514qvr.25.1701198489111;
        Tue, 28 Nov 2023 11:08:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e3-20020ad44183000000b0067a2637e3e9sm3655739qvp.121.2023.11.28.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:08 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

When a multi-pack bitmap is used to implement verbatim pack reuse (that
is, when verbatim chunks from an on-disk packfile are copied
directly[^1]), it does so by using its "preferred pack" as the source
for pack-reuse.

This allows repositories to pack the majority of their objects into a
single (often large) pack, and then use it as the single source for
verbatim pack reuse. This increases the amount of objects that are
reused verbatim (and consequently, decrease the amount of time it takes
to generate many packs). But this performance comes at a cost, which is
that the preferred packfile must pace its growth with that of the entire
repository in order to maintain the utility of verbatim pack reuse.

As repositories grow beyond what we can reasonably store in a single
packfile, the utility of verbatim pack reuse diminishes. Or, at the very
least, it becomes increasingly more expensive to maintain as the pack
grows larger and larger.

It would be beneficial to be able to perform this same optimization over
multiple packs, provided some modest constraints (most importantly, that
the set of packs eligible for verbatim reuse are disjoint with respect
to the objects that they contain).

If we assume that the packs which we treat as candidates for verbatim
reuse are disjoint with respect to their objects, we need to make only
modest modifications to the verbatim pack-reuse code itself. Most
notably, we need to remove the assumption that the bits in the
reachability bitmap corresponding to objects from the single reuse pack
begin at the first bit position.

Future patches will unwind these assumptions and reimplement their
existing functionality as special cases of the more general assumptions
(e.g. that reuse bits can start anywhere within the bitset, but happen
to start at 0 for all existing cases).

This patch does not yet relax any of those assumptions. Instead, it
implements a foundational data-structure, the "Disjoint Packs" (`DISP`)
chunk of the multi-pack index. The `DISP` chunk's contents are described
in detail here. Importantly, the `DISP` chunk contains information to
map regions of a multi-pack index's reachability bitmap to the packs
whose objects they represent.

For now, this chunk is only written, not read (outside of the test-tool
used in this patch to test the new chunk's behavior). Future patches
will begin to make use of this new chunk.

This patch implements reading (though no callers outside of the above
one perform any reading) and writing this new chunk. It also extends the
`--stdin-packs` format used by the `git multi-pack-index write` builtin
to be able to designate that a given pack is to be marked as "disjoint"
by prefixing it with a '+' character.

[^1]: Modulo patching any `OFS_DELTA`'s that cross over a region of the
  pack that wasn't used verbatim.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |   4 +
 Documentation/gitformat-pack.txt       | 109 +++++++++++++++++++++++
 builtin/multi-pack-index.c             |  10 ++-
 midx.c                                 | 116 ++++++++++++++++++++++---
 midx.h                                 |   5 ++
 pack-bitmap.h                          |   9 ++
 t/helper/test-read-midx.c              |  31 ++++++-
 t/t5319-multi-pack-index.sh            |  58 +++++++++++++
 8 files changed, 325 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 3696506eb3..d130e65b28 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -49,6 +49,10 @@ write::
 	--stdin-packs::
 		Write a multi-pack index containing only the set of
 		line-delimited pack index basenames provided over stdin.
+		Lines beginning with a '+' character (followed by the
+		pack index basename as before) have their pack marked as
+		"disjoint". See the "`DISP` chunk and disjoint packs"
+		section in linkgit:gitformat-pack[5] for more.
 
 	--refs-snapshot=<path>::
 		With `--bitmap`, optionally specify a file which
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 9fcb29a9c8..658682ddd5 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -396,6 +396,22 @@ CHUNK DATA:
 	    is padded at the end with between 0 and 3 NUL bytes to make the
 	    chunk size a multiple of 4 bytes.
 
+	Disjoint Packfiles (ID: {'D', 'I', 'S', 'P'})
+	    Stores a table of three 4-byte unsigned integers in network order.
+	    Each table entry corresponds to a single pack (in the order that
+	    they appear above in the `PNAM` chunk). The values for each table
+	    entry are as follows:
+	    - The first bit position (in psuedo-pack order, see below) to
+	      contain an object from that pack.
+	    - The number of bits whose objects are selected from that pack.
+	    - A "meta" value, whose least-significant bit indicates whether or
+	      not the pack is disjoint with respect to other packs. The
+	      remaining bits are unused.
+	    Two packs are "disjoint" with respect to one another when they have
+	    disjoint sets of objects. In other words, any object found in a pack
+	    contained in the set of disjoint packfiles is guaranteed to be
+	    uniquely located among those packs.
+
 	OID Fanout (ID: {'O', 'I', 'D', 'F'})
 	    The ith entry, F[i], stores the number of OIDs with first
 	    byte at most i. Thus F[255] stores the total
@@ -509,6 +525,99 @@ packs arranged in MIDX order (with the preferred pack coming first).
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
 
+=== `DISP` chunk and disjoint packs
+
+The Disjoint Packfiles (`DISP`) chunk encodes additional information
+about the objects in the multi-pack index's reachability bitmap. Recall
+that objects from the MIDX are arranged in "pseudo-pack" order (see:
+above) for reachability bitmaps.
+
+From the example above, suppose we have packs "a", "b", and "c", with
+10, 15, and 20 objects, respectively. In pseudo-pack order, those would
+be arranged as follows:
+
+    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
+
+When working with single-pack bitmaps (or, equivalently, multi-pack
+reachability bitmaps without any packs marked as disjoint),
+linkgit:git-pack-objects[1] performs ``verbatim'' reuse, attempting to
+reuse chunks of the existing packfile instead of adding objects to the
+packing list.
+
+When a chunk of bytes are reused from an existing pack, any objects
+contained therein do not need to be added to the packing list, saving
+memory and CPU time. But a chunk from an existing packfile can only be
+reused when the following conditions are met:
+
+  - The chunk contains only objects which were requested by the caller
+    (i.e. does not contain any objects which the caller didn't ask for
+    explicitly or implicitly).
+
+  - All objects stored as offset- or reference-deltas also include their
+    base object in the resulting pack.
+
+Additionally, packfiles many not contain more than one copy of any given
+object. This introduces an additional constraint over the set of packs
+we may want to reuse. The most straightforward approach is to mandate
+that the set of packs is disjoint with respect to the set of objects
+contained in each pack. In other words, for each object `o` in the union
+of all objects stored by the disjoint set of packs, `o` is contained in
+exactly one pack from the disjoint set.
+
+One alternative design choice for multi-pack reuse might instead involve
+imposing a chunk-level constraint that allows packs in the reusable set
+to contain multiple copies across different packs, but restricts each
+chunk against including more than one copy of such an object. This is in
+theory possible to implement, but significantly more complicated than
+forcing packs themselves to be disjoint. Most notably, we would have to
+keep track of which objects have already been sent during verbatim
+pack-reuse, defeating the main purpose of verbatim pack reuse (that we
+don't have to keep track of individual objects).
+
+The `DISP` chunk encodes the necessary information in order to implement
+multi-pack reuse over a disjoint set of packs as described above.
+Specifically, the `DISP` chunk encodes three pieces of information (all
+32-bit unsigned integers in network byte-order) for each packfile `p`
+that is stored in the MIDX, as follows:
+
+`bitmap_pos`:: The first bit position (in pseudo-pack order) in the
+  multi-pack index's reachability bitmap occupied by an object from `p`.
+
+`bitmap_nr`:: The number of bit positions (including the one at
+  `bitmap_pos`) that encode objects from that pack `p`.
+
+`disjoint`:: Metadata, including whether or not the pack `p` is
+  ``disjoint''. The least significant bit stores whether or not the pack
+  is disjoint. The remaining bits are reserved for future use.
+
+For example, the `DISP` chunk corresponding to the above example (with
+packs ``a'', ``b'', and ``c'') would look like:
+
+[cols="1,2,2,2"]
+|===
+| |`bitmap_pos` |`bitmap_nr` |`disjoint`
+
+|packfile ``a''
+|`0`
+|`10`
+|`0x1`
+
+|packfile ``b''
+|`10`
+|`15`
+|`0x1`
+
+|packfile ``c''
+|`25`
+|`20`
+|`0x1`
+|===
+
+With these constraints and information in place, we can treat each
+packfile marked as disjoint as individually reusable in the same fashion
+as verbatim pack reuse is performed on individual packs prior to the
+implementation of the `DISP` chunk.
+
 == cruft packs
 
 The cruft packs feature offer an alternative to Git's traditional mechanism of
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index a72aebecaa..0f1dd4651d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -106,11 +106,17 @@ static int git_multi_pack_index_write_config(const char *var, const char *value,
 	return 0;
 }
 
+#define DISJOINT ((void*)(uintptr_t)1)
+
 static void read_packs_from_stdin(struct string_list *to)
 {
 	struct strbuf buf = STRBUF_INIT;
-	while (strbuf_getline(&buf, stdin) != EOF)
-		string_list_append(to, buf.buf);
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		if (*buf.buf == '+')
+			string_list_append(to, buf.buf + 1)->util = DISJOINT;
+		else
+			string_list_append(to, buf.buf);
+	}
 	string_list_sort(to);
 
 	strbuf_release(&buf);
diff --git a/midx.c b/midx.c
index 591b3c636e..f55020072f 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,7 @@
 
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_DISJOINTPACKS 0x44495350 /* "DISP" */
 #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
@@ -182,6 +183,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
 		   &m->chunk_large_offsets_len);
+	pair_chunk(cf, MIDX_CHUNKID_DISJOINTPACKS,
+		   (const unsigned char **)&m->chunk_disjoint_packs,
+		   &m->chunk_disjoint_packs_len);
 
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
 		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
@@ -275,6 +279,23 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 	return 0;
 }
 
+int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+		       struct bitmapped_pack *bp, uint32_t pack_int_id)
+{
+	if (!m->chunk_disjoint_packs)
+		return error(_("MIDX does not contain the DISP chunk"));
+
+	if (prepare_midx_pack(r, m, pack_int_id))
+		return error(_("could not load disjoint pack %"PRIu32), pack_int_id);
+
+	bp->p = m->packs[pack_int_id];
+	bp->bitmap_pos = get_be32(m->chunk_disjoint_packs + 3 * pack_int_id);
+	bp->bitmap_nr = get_be32(m->chunk_disjoint_packs + 3 * pack_int_id + 1);
+	bp->disjoint = !!get_be32(m->chunk_disjoint_packs + 3 * pack_int_id + 2);
+
+	return 0;
+}
+
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
 {
 	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
@@ -457,11 +478,18 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+#define BITMAP_POS_UNKNOWN (~((uint32_t)0))
+
 struct pack_info {
 	uint32_t orig_pack_int_id;
 	char *pack_name;
 	struct packed_git *p;
-	unsigned expired : 1;
+
+	uint32_t bitmap_pos;
+	uint32_t bitmap_nr;
+
+	unsigned expired : 1,
+		 disjoint : 1;
 };
 
 static void fill_pack_info(struct pack_info *info,
@@ -473,6 +501,7 @@ static void fill_pack_info(struct pack_info *info,
 	info->orig_pack_int_id = orig_pack_int_id;
 	info->pack_name = pack_name;
 	info->p = p;
+	info->bitmap_pos = BITMAP_POS_UNKNOWN;
 }
 
 static int pack_info_compare(const void *_a, const void *_b)
@@ -516,6 +545,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 {
 	struct write_midx_context *ctx = data;
 	struct packed_git *p;
+	struct string_list_item *item = NULL;
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
@@ -534,11 +564,13 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		 * should be performed independently (likely checking
 		 * to_include before the existing MIDX).
 		 */
-		if (ctx->m && midx_contains_pack(ctx->m, file_name))
-			return;
-		else if (ctx->to_include &&
-			 !string_list_has_string(ctx->to_include, file_name))
+		if (ctx->m && midx_contains_pack(ctx->m, file_name)) {
 			return;
+		} else if (ctx->to_include) {
+			item = string_list_lookup(ctx->to_include, file_name);
+			if (!item)
+				return;
+		}
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
@@ -559,6 +591,8 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
 			       ctx->nr);
+		if (item)
+			ctx->info[ctx->nr].disjoint = !!item->util;
 		ctx->nr++;
 	}
 }
@@ -568,7 +602,8 @@ struct pack_midx_entry {
 	uint32_t pack_int_id;
 	time_t pack_mtime;
 	uint64_t offset;
-	unsigned preferred : 1;
+	unsigned preferred : 1,
+		 disjoint : 1;
 };
 
 static int midx_oid_compare(const void *_a, const void *_b)
@@ -586,6 +621,12 @@ static int midx_oid_compare(const void *_a, const void *_b)
 	if (a->preferred < b->preferred)
 		return 1;
 
+	/* Sort objects in a disjoint pack last when multiple copies exist. */
+	if (a->disjoint < b->disjoint)
+		return -1;
+	if (a->disjoint > b->disjoint)
+		return 1;
+
 	if (a->pack_mtime > b->pack_mtime)
 		return -1;
 	else if (a->pack_mtime < b->pack_mtime)
@@ -671,6 +712,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					   &fanout->entries[fanout->nr],
 					   cur_object);
 		fanout->entries[fanout->nr].preferred = 0;
+		fanout->entries[fanout->nr].disjoint = 0;
 		fanout->nr++;
 	}
 }
@@ -696,6 +738,7 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 				cur_object,
 				&fanout->entries[fanout->nr],
 				preferred);
+		fanout->entries[fanout->nr].disjoint = info->disjoint;
 		fanout->nr++;
 	}
 }
@@ -764,14 +807,22 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 		 * Take only the first duplicate.
 		 */
 		for (cur_object = 0; cur_object < fanout.nr; cur_object++) {
-			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
-						&fanout.entries[cur_object].oid))
-				continue;
+			struct pack_midx_entry *ours = &fanout.entries[cur_object];
+			if (cur_object) {
+				struct pack_midx_entry *prev = &fanout.entries[cur_object - 1];
+				if (oideq(&prev->oid, &ours->oid)) {
+					if (prev->disjoint && ours->disjoint)
+						die(_("duplicate object '%s' among disjoint packs '%s', '%s'"),
+						    oid_to_hex(&prev->oid),
+						    info[prev->pack_int_id].pack_name,
+						    info[ours->pack_int_id].pack_name);
+					continue;
+				}
+			}
 
 			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
 				   alloc_objects);
-			memcpy(&deduplicated_entries[*nr_objects],
-			       &fanout.entries[cur_object],
+			memcpy(&deduplicated_entries[*nr_objects], ours,
 			       sizeof(struct pack_midx_entry));
 			(*nr_objects)++;
 		}
@@ -814,6 +865,27 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
 	return 0;
 }
 
+static int write_midx_disjoint_packs(struct hashfile *f, void *data)
+{
+	struct write_midx_context *ctx = data;
+	size_t i;
+
+	for (i = 0; i < ctx->nr; i++) {
+		struct pack_info *pack = &ctx->info[i];
+		if (pack->expired)
+			continue;
+
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN && pack->bitmap_nr)
+			BUG("pack '%s' has no bitmap position, but has %d bitmapped object(s)",
+			    pack->pack_name, pack->bitmap_nr);
+
+		hashwrite_be32(f, pack->bitmap_pos);
+		hashwrite_be32(f, pack->bitmap_nr);
+		hashwrite_be32(f, !!pack->disjoint);
+	}
+	return 0;
+}
+
 static int write_midx_oid_fanout(struct hashfile *f,
 				 void *data)
 {
@@ -981,8 +1053,19 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	QSORT(data, ctx->entries_nr, midx_pack_order_cmp);
 
 	ALLOC_ARRAY(pack_order, ctx->entries_nr);
-	for (i = 0; i < ctx->entries_nr; i++)
+	for (i = 0; i < ctx->entries_nr; i++) {
+		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
+		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
+			pack->bitmap_pos = i;
+		pack->bitmap_nr++;
 		pack_order[i] = data[i].nr;
+	}
+	for (i = 0; i < ctx->nr; i++) {
+		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
+			pack->bitmap_pos = 0;
+	}
 	free(data);
 
 	trace2_region_leave("midx", "midx_pack_order", the_repository);
@@ -1283,6 +1366,7 @@ static int write_midx_internal(const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
+	int pack_disjoint_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -1495,8 +1579,10 @@ static int write_midx_internal(const char *object_dir,
 	}
 
 	for (i = 0; i < ctx.nr; i++) {
-		if (!ctx.info[i].expired)
-			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
+		if (ctx.info[i].expired)
+			continue;
+		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
+		pack_disjoint_concat_len += 3 * sizeof(uint32_t);
 	}
 
 	/* Check that the preferred pack wasn't expired (if given). */
@@ -1556,6 +1642,8 @@ static int write_midx_internal(const char *object_dir,
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
 			  write_midx_revindex);
+		add_chunk(cf, MIDX_CHUNKID_DISJOINTPACKS,
+			  pack_disjoint_concat_len, write_midx_disjoint_packs);
 	}
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
diff --git a/midx.h b/midx.h
index a5d98919c8..cdd16a8378 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,7 @@
 struct object_id;
 struct pack_entry;
 struct repository;
+struct bitmapped_pack;
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
 #define GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP \
@@ -33,6 +34,8 @@ struct multi_pack_index {
 
 	const unsigned char *chunk_pack_names;
 	size_t chunk_pack_names_len;
+	const uint32_t *chunk_disjoint_packs;
+	size_t chunk_disjoint_packs_len;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_object_offsets;
@@ -58,6 +61,8 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
 off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos);
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 5273a6a019..b7fa1a42a9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -52,6 +52,15 @@ typedef int (*show_reachable_fn)(
 
 struct bitmap_index;
 
+struct bitmapped_pack {
+	struct packed_git *p;
+
+	uint32_t bitmap_pos;
+	uint32_t bitmap_nr;
+
+	unsigned disjoint : 1;
+};
+
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index e9a444ddba..4b44995dca 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -100,10 +100,37 @@ static int read_midx_preferred_pack(const char *object_dir)
 	return 0;
 }
 
+static int read_midx_bitmapped_packs(const char *object_dir)
+{
+	struct multi_pack_index *midx = NULL;
+	struct bitmapped_pack pack;
+	uint32_t i;
+
+	setup_git_directory();
+
+	midx = load_multi_pack_index(object_dir, 1);
+	if (!midx)
+		return 1;
+
+	for (i = 0; i < midx->num_packs; i++) {
+		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
+			return 1;
+
+		printf("%s\n", pack_basename(pack.p));
+		printf("  bitmap_pos: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_pos);
+		printf("  bitmap_nr: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_nr);
+		printf("  disjoint: %s\n", pack.disjoint & 0x1 ? "yes" : "no");
+	}
+
+	close_midx(midx);
+
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");
+		usage("read-midx [--show-objects|--checksum|--preferred-pack|--bitmap] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
@@ -111,5 +138,7 @@ int cmd__read_midx(int argc, const char **argv)
 		return read_midx_checksum(argv[2]);
 	else if (!strcmp(argv[1], "--preferred-pack"))
 		return read_midx_preferred_pack(argv[2]);
+	else if (!strcmp(argv[1], "--bitmap"))
+		return read_midx_bitmapped_packs(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c4c6060cee..fd24e0c952 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1157,4 +1157,62 @@ test_expect_success 'reader notices too-small revindex chunk' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'disjoint packs are stored via the DISP chunk' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for i in 1 2 3 4 5
+		do
+			test_commit "$i" &&
+			git repack -d || return 1
+		done &&
+
+		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename | sort >packs &&
+
+		git multi-pack-index write --stdin-packs <packs &&
+		test_must_fail test-tool read-midx --bitmap $objdir 2>err &&
+		cat >expect <<-\EOF &&
+		error: MIDX does not contain the DISP chunk
+		EOF
+		test_cmp expect err &&
+
+		sed -e "s/^/+/g" packs >in &&
+		git multi-pack-index write --stdin-packs --bitmap \
+			--preferred-pack="$(head -n1 <packs)" <in &&
+		test-tool read-midx --bitmap $objdir >actual &&
+		for i in $(test_seq $(wc -l <packs))
+		do
+			sed -ne "${i}s/\.idx$/\.pack/p" packs &&
+			echo "  bitmap_pos: $(( $(( $i - 1 )) * 3 ))" &&
+			echo "  bitmap_nr: 3" &&
+			echo "  disjoint: yes" || return 1
+		done >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'non-disjoint packs are detected' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git repack -d &&
+		test_commit other &&
+		git repack -a &&
+
+		ls -la .git/objects/pack/ &&
+
+		find $objdir/pack -type f -name "*.idx" |
+			sed -e "s/.*\/\(.*\)$/+\1/g" >in &&
+
+		test_must_fail git multi-pack-index write --stdin-packs \
+			--bitmap <in 2>err &&
+		grep "duplicate object.* among disjoint packs" err
+	)
+'
+
 test_done
-- 
2.43.0.24.g980b318f98

