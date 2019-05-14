Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F79A1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfENSsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:06 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40533 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfENSsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:05 -0400
Received: by mail-yb1-f196.google.com with SMTP id q17so47941ybg.7
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+b+B0hPRxslRGZUTnk8feyDiLOkqteu4EnGF2GSbZv0=;
        b=d4b5JQjw6A41F/F26izAa2hedTOIkHJA6eKuaNqdHtjQ2lvZzcSxTOmufSZYNihcM8
         hk4uxe8IenerWV0KgzucpEMpkTSkzMQapUEAxcpqt08oC9I1G6gG3Pm/LC6AhccgXEuE
         9Xqzc2fMhCIrjr0j3ynKCbDENsf+Kan1HdOR0hXfWT++XdqjSDgMRH4Okqn+5hdELwQ6
         cttPlGuXUc/Ydruxj+zCLLLcdTOWl1MDYEjB1jaw2tULZ1VCeAJSv3M8fjbZxQYdTUgj
         FxIJSHzfeCbnqjQYu8e5fXJvbTadS6cLvO92ZnFuOtzmqaiLq9uK/7aBHfd+1FyI0+qb
         wTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b+B0hPRxslRGZUTnk8feyDiLOkqteu4EnGF2GSbZv0=;
        b=fZ8vvn5aNNz4P/4TVARgJcVoB51UULg6DCOnQOOoU/05gbXzrIB1uM6la8EALH9IHP
         vuGcVXOgTlPZM5Y0fkILHwx6zLiOIeri0poda3PuGKLtxYZ/wYLR+MFrPdSiNrSAM+b/
         FMwi8jU10COlSnU4A+Ew8UvN7JIcrnSuO1jwSZxTgV7ZxcMcWGOOoUKn3b5h8XZZ3qFq
         2KN7Vg5gz+lxWOxzvO73TLJGJYYF7Tdf5ccb71lqKj31zIOQjquJKzjgW9Zguoe1VPxr
         RaKVFdPdnqXbE9ag0dmN5q/dD9zAr/2CIW/bB7eCSwcyqoyW2pvlWfGu9HmapTMMpjtv
         gX4A==
X-Gm-Message-State: APjAAAW3RE6YdY15pt9eMYD6yF+tgOw/GYwCGCBWVqln8NTsE7Z3CbUV
        IZpYByWMWyrtQGy8zA/3waMyPR48LBw=
X-Google-Smtp-Source: APXvYqzxUgjmpcLhTXX+XpYgoU9Z5vMZ+SxBYi8LeP5JtnTL/lAZI/K5IQxBNjI4kGxiLgDqotSfGw==
X-Received: by 2002:a25:3796:: with SMTP id e144mr18616379yba.173.1557859683646;
        Tue, 14 May 2019 11:48:03 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:03 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 05/11] midx: refactor permutation logic and pack sorting
Date:   Tue, 14 May 2019 18:47:48 +0000
Message-Id: <20190514184754.3196-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of the expire subcommand, refactor the way we sort
the packfiles by name. This will greatly simplify our approach to
dropping expired packs from the list.

First, create 'struct pack_info' to replace 'struct pack_pair'.
This struct contains the necessary information about a pack,
including its name, a pointer to its packfile struct (if not
already in the multi-pack-index), and the original pack-int-id.

Second, track the pack information using an array of pack_info
structs in the pack_list struct. This simplifies the logic around
the multiple arrays we were tracking in that struct.

Finally, update get_sorted_entries() to not permute the pack-int-id
and instead supply the permutation to write_midx_object_offsets().
This requires sorting the packs after get_sorted_entries().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 156 +++++++++++++++++++++++++--------------------------------
 1 file changed, 69 insertions(+), 87 deletions(-)

diff --git a/midx.c b/midx.c
index 62404620ad..6d4b84e243 100644
--- a/midx.c
+++ b/midx.c
@@ -427,12 +427,23 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+struct pack_info {
+	uint32_t orig_pack_int_id;
+	char *pack_name;
+	struct packed_git *p;
+};
+
+static int pack_info_compare(const void *_a, const void *_b)
+{
+	struct pack_info *a = (struct pack_info *)_a;
+	struct pack_info *b = (struct pack_info *)_b;
+	return strcmp(a->pack_name, b->pack_name);
+}
+
 struct pack_list {
-	struct packed_git **list;
-	char **names;
+	struct pack_info *info;
 	uint32_t nr;
-	uint32_t alloc_list;
-	uint32_t alloc_names;
+	uint32_t alloc;
 	struct multi_pack_index *m;
 };
 
@@ -445,66 +456,32 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		if (packs->m && midx_contains_pack(packs->m, file_name))
 			return;
 
-		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
-		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
+		ALLOC_GROW(packs->info, packs->nr + 1, packs->alloc);
 
-		packs->list[packs->nr] = add_packed_git(full_path,
-							full_path_len,
-							0);
+		packs->info[packs->nr].p = add_packed_git(full_path,
+							  full_path_len,
+							  0);
 
-		if (!packs->list[packs->nr]) {
+		if (!packs->info[packs->nr].p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
-		if (open_pack_index(packs->list[packs->nr])) {
+		if (open_pack_index(packs->info[packs->nr].p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
-			close_pack(packs->list[packs->nr]);
-			FREE_AND_NULL(packs->list[packs->nr]);
+			close_pack(packs->info[packs->nr].p);
+			FREE_AND_NULL(packs->info[packs->nr].p);
 			return;
 		}
 
-		packs->names[packs->nr] = xstrdup(file_name);
+		packs->info[packs->nr].pack_name = xstrdup(file_name);
+		packs->info[packs->nr].orig_pack_int_id = packs->nr;
 		packs->nr++;
 	}
 }
 
-struct pack_pair {
-	uint32_t pack_int_id;
-	char *pack_name;
-};
-
-static int pack_pair_compare(const void *_a, const void *_b)
-{
-	struct pack_pair *a = (struct pack_pair *)_a;
-	struct pack_pair *b = (struct pack_pair *)_b;
-	return strcmp(a->pack_name, b->pack_name);
-}
-
-static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
-{
-	uint32_t i;
-	struct pack_pair *pairs;
-
-	ALLOC_ARRAY(pairs, nr_packs);
-
-	for (i = 0; i < nr_packs; i++) {
-		pairs[i].pack_int_id = i;
-		pairs[i].pack_name = pack_names[i];
-	}
-
-	QSORT(pairs, nr_packs, pack_pair_compare);
-
-	for (i = 0; i < nr_packs; i++) {
-		pack_names[i] = pairs[i].pack_name;
-		perm[pairs[i].pack_int_id] = i;
-	}
-
-	free(pairs);
-}
-
 struct pack_midx_entry {
 	struct object_id oid;
 	uint32_t pack_int_id;
@@ -530,7 +507,6 @@ static int midx_oid_compare(const void *_a, const void *_b)
 }
 
 static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
-				      uint32_t *pack_perm,
 				      struct pack_midx_entry *e,
 				      uint32_t pos)
 {
@@ -538,7 +514,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 		return 1;
 
 	nth_midxed_object_oid(&e->oid, m, pos);
-	e->pack_int_id = pack_perm[nth_midxed_pack_int_id(m, pos)];
+	e->pack_int_id = nth_midxed_pack_int_id(m, pos);
 	e->offset = nth_midxed_offset(m, pos);
 
 	/* consider objects in midx to be from "old" packs */
@@ -572,8 +548,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * of a packfile containing the object).
  */
 static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
-						  struct packed_git **p,
-						  uint32_t *perm,
+						  struct pack_info *info,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
 {
@@ -584,7 +559,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	uint32_t start_pack = m ? m->num_packs : 0;
 
 	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
-		total_objects += p[cur_pack]->num_objects;
+		total_objects += info[cur_pack].p->num_objects;
 
 	/*
 	 * As we de-duplicate by fanout value, we expect the fanout
@@ -609,7 +584,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 
 			for (cur_object = start; cur_object < end; cur_object++) {
 				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
-				nth_midxed_pack_midx_entry(m, perm,
+				nth_midxed_pack_midx_entry(m,
 							   &entries_by_fanout[nr_fanout],
 							   cur_object);
 				nr_fanout++;
@@ -620,12 +595,12 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 			uint32_t start = 0, end;
 
 			if (cur_fanout)
-				start = get_pack_fanout(p[cur_pack], cur_fanout - 1);
-			end = get_pack_fanout(p[cur_pack], cur_fanout);
+				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
+			end = get_pack_fanout(info[cur_pack].p, cur_fanout);
 
 			for (cur_object = start; cur_object < end; cur_object++) {
 				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
-				fill_pack_entry(perm[cur_pack], p[cur_pack], cur_object, &entries_by_fanout[nr_fanout]);
+				fill_pack_entry(cur_pack, info[cur_pack].p, cur_object, &entries_by_fanout[nr_fanout]);
 				nr_fanout++;
 			}
 		}
@@ -654,7 +629,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 }
 
 static size_t write_midx_pack_names(struct hashfile *f,
-				    char **pack_names,
+				    struct pack_info *info,
 				    uint32_t num_packs)
 {
 	uint32_t i;
@@ -662,14 +637,14 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	size_t written = 0;
 
 	for (i = 0; i < num_packs; i++) {
-		size_t writelen = strlen(pack_names[i]) + 1;
+		size_t writelen = strlen(info[i].pack_name) + 1;
 
-		if (i && strcmp(pack_names[i], pack_names[i - 1]) <= 0)
+		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
-			    pack_names[i - 1],
-			    pack_names[i]);
+			    info[i - 1].pack_name,
+			    info[i].pack_name);
 
-		hashwrite(f, pack_names[i], writelen);
+		hashwrite(f, info[i].pack_name, writelen);
 		written += writelen;
 	}
 
@@ -740,6 +715,7 @@ static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
 }
 
 static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_needed,
+					uint32_t *perm,
 					struct pack_midx_entry *objects, uint32_t nr_objects)
 {
 	struct pack_midx_entry *list = objects;
@@ -749,7 +725,7 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		hashwrite_be32(f, obj->pack_int_id);
+		hashwrite_be32(f, perm[obj->pack_int_id]);
 
 		if (large_offset_needed && obj->offset >> 31)
 			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
@@ -822,20 +798,17 @@ int write_midx_file(const char *object_dir)
 	packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
-	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
-	packs.alloc_names = packs.alloc_list;
-	packs.list = NULL;
-	packs.names = NULL;
-	ALLOC_ARRAY(packs.list, packs.alloc_list);
-	ALLOC_ARRAY(packs.names, packs.alloc_names);
+	packs.alloc = packs.m ? packs.m->num_packs : 16;
+	packs.info = NULL;
+	ALLOC_ARRAY(packs.info, packs.alloc);
 
 	if (packs.m) {
 		for (i = 0; i < packs.m->num_packs; i++) {
-			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
-			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
+			ALLOC_GROW(packs.info, packs.nr + 1, packs.alloc);
 
-			packs.list[packs.nr] = NULL;
-			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
+			packs.info[packs.nr].orig_pack_int_id = i;
+			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
+			packs.info[packs.nr].p = NULL;
 			packs.nr++;
 		}
 	}
@@ -845,10 +818,7 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	ALLOC_ARRAY(pack_perm, packs.nr);
-	sort_packs_by_name(packs.names, packs.nr, pack_perm);
-
-	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -857,8 +827,21 @@ int write_midx_file(const char *object_dir)
 			large_offsets_needed = 1;
 	}
 
+	QSORT(packs.info, packs.nr, pack_info_compare);
+
+	/*
+	 * pack_perm stores a permutation between pack-int-ids from the
+	 * previous multi-pack-index to the new one we are writing:
+	 *
+	 * pack_perm[old_id] = new_id
+	 */
+	ALLOC_ARRAY(pack_perm, packs.nr);
+	for (i = 0; i < packs.nr; i++) {
+		pack_perm[packs.info[i].orig_pack_int_id] = i;
+	}
+
 	for (i = 0; i < packs.nr; i++)
-		pack_name_concat_len += strlen(packs.names[i]) + 1;
+		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
 
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
@@ -929,7 +912,7 @@ int write_midx_file(const char *object_dir)
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, packs.names, packs.nr);
+				written += write_midx_pack_names(f, packs.info, packs.nr);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
@@ -941,7 +924,7 @@ int write_midx_file(const char *object_dir)
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
-				written += write_midx_object_offsets(f, large_offsets_needed, entries, nr_entries);
+				written += write_midx_object_offsets(f, large_offsets_needed, pack_perm, entries, nr_entries);
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
@@ -964,15 +947,14 @@ int write_midx_file(const char *object_dir)
 
 cleanup:
 	for (i = 0; i < packs.nr; i++) {
-		if (packs.list[i]) {
-			close_pack(packs.list[i]);
-			free(packs.list[i]);
+		if (packs.info[i].p) {
+			close_pack(packs.info[i].p);
+			free(packs.info[i].p);
 		}
-		free(packs.names[i]);
+		free(packs.info[i].pack_name);
 	}
 
-	free(packs.list);
-	free(packs.names);
+	free(packs.info);
 	free(entries);
 	free(pack_perm);
 	free(midx_name);
-- 
2.22.0.rc0

