Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988521F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFGOEK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:10 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44397 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeFGOD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id 185-v6so6593842qkk.11
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WROsFltY6LkRmfO3P8BZN5i+b1N00XYT5H4+/A7ylAg=;
        b=PuAsXHTiV01rfiYDlDpdyL0M5uxmlSbe5EzAwy1euc1uo/hvJ9TzmzTUG2yhrWchqU
         WkdUumLsXqNQeSSVFVPSRWM2fJCwHw/sKP1/4vvIwoh/RE98/nONrK8UW+T1HdPDd2P6
         cwcKYx+DnJ10g9UrYakDGicHzbP7WE7QQW8snLKGver2guCuxnGwt1b+hE7+PUVQmO2R
         etP84bqbdbqYjUBJB/sIuhfHZL2LZO0fRRRym+FmOIbypZ1N0scFJsPSOiZOD0Fe+vu9
         rh9RzPoqWLEOa6EjTtaG9EIRxYGNwxw7+YmYD///ri3HjphfDK+ducdSMUKYG3NMx3QD
         FOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WROsFltY6LkRmfO3P8BZN5i+b1N00XYT5H4+/A7ylAg=;
        b=ucf9Qkaon3wFqv3rLE/5rnt91f/wUVHZDqWdjWMPvfJ3lf7XWnukc/xeYwusdYs0Me
         ONvUlBf+dSd46yGjXsxUElzB7LM8XTE5/mixgLc45aipAKYw16khHxx4av6GRmCqZrlT
         kMTISc8ronpg4/IhVjXwKnrJXiv3Il1wWgA0kWS5LHK6YSjjWyywCg1EzTqXdLGrFm5p
         DnMK6iC3xS0ay8hSHvCTylhkLSphWXxgY42BbubSsdQxBC8BBItSAaFsPvBTtaTe8zzo
         4SvJnC5SI1KaRFYwAR1TVhf3VijCg5gf17HjKxao1i7G9LFXWj0yGlAyMu4zOSI5fgOo
         vv+g==
X-Gm-Message-State: APt69E0g4sJK2mdLBr44hcl/fIWj2bXpFtqiZVWjDI1lDQz2ouPylg3s
        WnVK8L+pgif0nw1WLXi1/fRnBI5u
X-Google-Smtp-Source: ADUXVKIIGJoJFTjzPEJrErgQAb61l0dtxaIz9w99jxiQm8JI282zm1JQy7JUUuG7ccst9bm1KBqdXg==
X-Received: by 2002:a37:7b02:: with SMTP id w2-v6mr1540230qkc.247.1528380236047;
        Thu, 07 Jun 2018 07:03:56 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:55 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 11/23] midx: sort and deduplicate objects from packfiles
Date:   Thu,  7 Jun 2018 10:03:26 -0400
Message-Id: <20180607140338.32440-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a list of objects and their offsets to a multi-pack-index
(MIDX), we need to collect the list of objects contained in the
packfiles. There may be multiple copies of some objects, so this list
must be deduplicated.

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
 midx.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/midx.c b/midx.c
index 923acda72e..b20d52713c 100644
--- a/midx.c
+++ b/midx.c
@@ -4,6 +4,7 @@
 #include "csum-file.h"
 #include "lockfile.h"
 #include "object-store.h"
+#include "packfile.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
@@ -190,6 +191,140 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	}
 }
 
+static uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
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
+struct pack_midx_entry {
+	struct object_id oid;
+	uint32_t pack_int_id;
+	time_t pack_mtime;
+	uint64_t offset;
+};
+
+static int midx_oid_compare(const void *_a, const void *_b)
+{
+	struct pack_midx_entry *a = (struct pack_midx_entry *)_a;
+	struct pack_midx_entry *b = (struct pack_midx_entry *)_b;
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
+		die("failed to located object %d in packfile", cur_object);
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
+	uint32_t nr_fanout, alloc_fanout, alloc_objects, total_objects = 0;
+	struct pack_midx_entry *entries_by_fanout = NULL;
+	struct pack_midx_entry *deduplicated_entries = NULL;
+
+	for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
+		if (open_pack_index(p[cur_pack]))
+			continue;
+
+		total_objects += p[cur_pack]->num_objects;
+	}
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
+		nr_fanout = 0;
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
+	FREE_AND_NULL(entries_by_fanout);
+	return deduplicated_entries;
+}
+
 static size_t write_midx_pack_lookup(struct hashfile *f,
 				     char **pack_names,
 				     uint32_t nr_packs)
@@ -254,6 +389,7 @@ int write_midx_file(const char *object_dir)
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
+	uint32_t nr_entries;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -312,6 +448,8 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, nr_packs);
 	sort_packs_by_name(pack_names, nr_packs, pack_perm);
 
+	get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
-- 
2.18.0.rc1

