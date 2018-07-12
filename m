Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794441F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeGLTv2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34828 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so10634488qtp.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpvWVdk/ye4cApJlxavPu+nsBc2mW7ThCmzc0MFjr9c=;
        b=QBFk6jdUTbyQVMZKhri4C81RKSuWJLdyV9Q0h0KMrcTNvRlhXfp3y0g8X6qHjw+hNz
         9iGMFCQtbZk6La5/9OuKUxUFv3C5NimMdbaljs0PFHf8fod8BUM9PyEhTZUbCHCL7lzg
         3UXaKR1gfFdmG2Z3hSQQLkt2TyUB+7M0ytiKqLjqDs2YAxY+ansifQ0UpKBCKnYbsvaI
         kT5Z7VflkPtzSyWGnFOIEErq0hZGgamw/z9aO5EjGOdN1eaFT2zk20Zj5/50ra8/WxUe
         0uv9UH9+nrywUCyZUWDWXJ78hNuGV8xNaPaHXJaBNY6JHv17OjS0a7PFxkWEhFLEC8xT
         OrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wpvWVdk/ye4cApJlxavPu+nsBc2mW7ThCmzc0MFjr9c=;
        b=HhX5lJOSKXV5Cfx/B39PIgzAVhQE+n75POh9ZdBG46C6FqVpag2GtSJIO3ERyScb/O
         jb0zR1DSxinKFX1I93SgB79YfoJtl/EYbKjTms01U1CaOI2Hw7TuZbgaK2DaJfCKnzZv
         /2xlGUbsu2cKEr63/QKIgdNQcot/hH+m+wanDdwP5AWA4elrQRKQ1HsaI2sLCaXK9uRA
         1DP3Aqxw9x/5pYbLGzHlET5GPrLwkX2dSEdWcOPK0XSjPNi38AzlciPw9EmRfcPtPEXK
         NEeTFPD7Rfp9FxNT2f/Sc1YN0ZI8LB2H+msvIOoFLO/qsUJ1RoD+MKa+62KQMu4+Gdam
         6XpQ==
X-Gm-Message-State: AOUpUlHRajFnJO1MW4zUrchLREp3uqVP5lW+mV5vkbk9MwaUDJXN7eoX
        ZqDLi93qMM8ey8phOzPWuVoR2t1TBEU=
X-Google-Smtp-Source: AAOMgpeLjE3c3AyRlghWkaxQtSLapGE3zAoJMznLXIcEaMJerITlQ36kQi2QNtv2MJNVq6r4t4IH3g==
X-Received: by 2002:ac8:3d5:: with SMTP id z21-v6mr3234737qtg.272.1531424426955;
        Thu, 12 Jul 2018 12:40:26 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:26 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 12/23] midx: sort and deduplicate objects from packfiles
Date:   Thu, 12 Jul 2018 15:39:29 -0400
Message-Id: <20180712193940.21065-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a list of objects and their offsets to a multi-pack-index,
we need to collect the list of objects contained in the packfiles. There
may be multiple copies of some objects, so this list must be deduplicated.

It is possible to artificially get into a state where there are many
duplicate copies of objects. That can create high memory pressure if we
are to create a list of all objects before de-duplication. To reduce
this memory pressure without a significant performance drop,
automatically group objects by the first byte of their object id. Use
the IDX fanout tables to group the data, copy to a local array, then
sort.

Copy only the de-duplicated entries. Select the duplicate based on the
most-recent modified time of a packfile containing the object.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c |  17 +++++++
 packfile.h |   2 +
 3 files changed, 147 insertions(+)

diff --git a/midx.c b/midx.c
index fcdf6553ce..29f8de5ee6 100644
--- a/midx.c
+++ b/midx.c
@@ -4,6 +4,7 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "packfile.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
@@ -182,12 +183,21 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		packs->list[packs->nr] = add_packed_git(full_path,
 							full_path_len,
 							0);
+
 		if (!packs->list[packs->nr]) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
+		if (open_pack_index(packs->list[packs->nr])) {
+			warning(_("failed to open pack-index '%s'"),
+				full_path);
+			close_pack(packs->list[packs->nr]);
+			FREE_AND_NULL(packs->list[packs->nr]);
+			return;
+		}
+
 		packs->names[packs->nr] = xstrdup(file_name);
 		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
@@ -228,6 +238,119 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	free(pairs);
 }
 
+struct pack_midx_entry {
+	struct object_id oid;
+	uint32_t pack_int_id;
+	time_t pack_mtime;
+	uint64_t offset;
+};
+
+static int midx_oid_compare(const void *_a, const void *_b)
+{
+	const struct pack_midx_entry *a = (const struct pack_midx_entry *)_a;
+	const struct pack_midx_entry *b = (const struct pack_midx_entry *)_b;
+	int cmp = oidcmp(&a->oid, &b->oid);
+
+	if (cmp)
+		return cmp;
+
+	if (a->pack_mtime > b->pack_mtime)
+		return -1;
+	else if (a->pack_mtime < b->pack_mtime)
+		return 1;
+
+	return a->pack_int_id - b->pack_int_id;
+}
+
+static void fill_pack_entry(uint32_t pack_int_id,
+			    struct packed_git *p,
+			    uint32_t cur_object,
+			    struct pack_midx_entry *entry)
+{
+	if (!nth_packed_object_oid(&entry->oid, p, cur_object))
+		die(_("failed to locate object %d in packfile"), cur_object);
+
+	entry->pack_int_id = pack_int_id;
+	entry->pack_mtime = p->mtime;
+
+	entry->offset = nth_packed_object_offset(p, cur_object);
+}
+
+/*
+ * It is possible to artificially get into a state where there are many
+ * duplicate copies of objects. That can create high memory pressure if
+ * we are to create a list of all objects before de-duplication. To reduce
+ * this memory pressure without a significant performance drop, automatically
+ * group objects by the first byte of their object id. Use the IDX fanout
+ * tables to group the data, copy to a local array, then sort.
+ *
+ * Copy only the de-duplicated entries (selected by most-recent modified time
+ * of a packfile containing the object).
+ */
+static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
+						  uint32_t *perm,
+						  uint32_t nr_packs,
+						  uint32_t *nr_objects)
+{
+	uint32_t cur_fanout, cur_pack, cur_object;
+	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
+	struct pack_midx_entry *entries_by_fanout = NULL;
+	struct pack_midx_entry *deduplicated_entries = NULL;
+
+	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++)
+		total_objects += p[cur_pack]->num_objects;
+
+	/*
+	 * As we de-duplicate by fanout value, we expect the fanout
+	 * slices to be evenly distributed, with some noise. Hence,
+	 * allocate slightly more than one 256th.
+	 */
+	alloc_objects = alloc_fanout = total_objects > 3200 ? total_objects / 200 : 16;
+
+	ALLOC_ARRAY(entries_by_fanout, alloc_fanout);
+	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
+	*nr_objects = 0;
+
+	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
+		uint32_t nr_fanout = 0;
+
+		for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
+			uint32_t start = 0, end;
+
+			if (cur_fanout)
+				start = get_pack_fanout(p[cur_pack], cur_fanout - 1);
+			end = get_pack_fanout(p[cur_pack], cur_fanout);
+
+			for (cur_object = start; cur_object < end; cur_object++) {
+				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
+				fill_pack_entry(perm[cur_pack], p[cur_pack], cur_object, &entries_by_fanout[nr_fanout]);
+				nr_fanout++;
+			}
+		}
+
+		QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
+
+		/*
+		 * The batch is now sorted by OID and then mtime (descending).
+		 * Take only the first duplicate.
+		 */
+		for (cur_object = 0; cur_object < nr_fanout; cur_object++) {
+			if (cur_object && !oidcmp(&entries_by_fanout[cur_object - 1].oid,
+						  &entries_by_fanout[cur_object].oid))
+				continue;
+
+			ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
+			memcpy(&deduplicated_entries[*nr_objects],
+			       &entries_by_fanout[cur_object],
+			       sizeof(struct pack_midx_entry));
+			(*nr_objects)++;
+		}
+	}
+
+	free(entries_by_fanout);
+	return deduplicated_entries;
+}
+
 static size_t write_midx_pack_names(struct hashfile *f,
 				    char **pack_names,
 				    uint32_t num_packs)
@@ -271,6 +394,8 @@ int write_midx_file(const char *object_dir)
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
+	uint32_t nr_entries;
+	struct pack_midx_entry *entries = NULL;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -296,6 +421,8 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
+	entries = get_sorted_entries(packs.list, pack_perm, packs.nr, &nr_entries);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
@@ -365,5 +492,6 @@ int write_midx_file(const char *object_dir)
 
 	free(packs.list);
 	free(packs.names);
+	free(entries);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index ee1ab9b804..3d652212c6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -196,6 +196,23 @@ int open_pack_index(struct packed_git *p)
 	return ret;
 }
 
+uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
+{
+	const uint32_t *level1_ofs = p->index_data;
+
+	if (!level1_ofs) {
+		if (open_pack_index(p))
+			return 0;
+		level1_ofs = p->index_data;
+	}
+
+	if (p->index_version > 1) {
+		level1_ofs += 2;
+	}
+
+	return ntohl(level1_ofs[value]);
+}
+
 static struct packed_git *alloc_packed_git(int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
diff --git a/packfile.h b/packfile.h
index d2ad30300a..b0eed44c0b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -69,6 +69,8 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
+extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
+
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
-- 
2.18.0.118.gd4f65b8d14

