Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E694B1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbeAGSPz (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:55 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44241 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbeAGSPK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:10 -0500
Received: by mail-qk0-f195.google.com with SMTP id v188so11712319qkh.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QrTFBnTbvzdsvXBVq7VwZ0ow9Qblvzfg+GDtXZ1R8c=;
        b=WY9xjRGjU/Q0pxF6q5bi9p97q+UMXK6m6BubqjjR6TE0X7MmwthO60Xkk3tRVYWxq5
         DEzwSBIb494W+2jOFE54rzBc7JcZIG8EI6teG5hl81KdAXMrlvRSz6Pv2J/cHIByADtY
         BmpwCB9mTwvgzSU/t7c1DqJaH4dlgHyHIUcyWXFdYQ1ktLDFgDD6kmA1Cd/vghVjUEmq
         9L1nZ4GMgPZHQUG99sPI2+u46LIinT6ineC4H0HXXJJxz8e88dUd6Ww6ymMdaaBy2BOW
         sZFYOs8IFgMoylvOLk9DkdjFGXPxkg8RXopPEa/z5/PAovWNHsB1Z7pwgArtGFoVPKi/
         E3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5QrTFBnTbvzdsvXBVq7VwZ0ow9Qblvzfg+GDtXZ1R8c=;
        b=t7Pl5XU1hONIY4pM9JxEBXvcB193bIhpne4Td0TyzIS7TqLQpXKdEJjwky26glvu71
         891H6C1mWfvCXL2K63GFo8I46wfQoa1ijOPUGxuxjBQY3w8VUlm4a4eNKtXFrU61McaF
         8uqk/xRYhmKI/qRUYkVx0EejNA7EyKFJB6+fBKKlZjiFEH/K5Qq6QfQcLHhIzfqkdSMI
         g+TpwxkdgQ/w+x26F8Peufq+Bd7h8K0EITqQNPWt+hNccbhcYSHjcOBVrDI5IgUmsPiw
         SUELREgDveeFSfxy8US47Y9LaXUxfaQ/rwmfzmbdyg3jcXBIjHI1pyCLK2g2R9SF2qFI
         tVeQ==
X-Gm-Message-State: AKwxyteK3bmz42YPcm6AV6jQsmPIuX70xnkkguH3ypw2v8o+tCco4hep
        3TD1At9qWv46nDQ3VzdzkIrF1GDsjdk=
X-Google-Smtp-Source: ACJfBou0PaX5gQ/ZFwSk72aDYogZIlSLNNtt2eVUQk8R3eFEfEo2vA1s30u/2BxvZgjvrb6XPoxKqw==
X-Received: by 10.55.143.193 with SMTP id r184mr13057939qkd.191.1515348909578;
        Sun, 07 Jan 2018 10:15:09 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:08 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 04/18] midx: write multi-pack indexes for an object list
Date:   Sun,  7 Jan 2018 13:14:45 -0500
Message-Id: <20180107181459.222909-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_midx_file() method takes a list of packfiles and indexed
objects with offset information and writes according to the format
in Documentation/technical/pack-format.txt. The chunks are separated
into methods.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile |   1 +
 midx.c   | 412 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h   |  42 +++++++
 3 files changed, 455 insertions(+)
 create mode 100644 midx.c
 create mode 100644 midx.h

diff --git a/Makefile b/Makefile
index 2a81ae22e9..d0d810951f 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += midx.o
 LIB_OBJS += mru.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
diff --git a/midx.c b/midx.c
new file mode 100644
index 0000000000..5c320726ed
--- /dev/null
+++ b/midx.c
@@ -0,0 +1,412 @@
+#include "cache.h"
+#include "git-compat-util.h"
+#include "pack.h"
+#include "packfile.h"
+#include "midx.h"
+
+#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
+#define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
+#define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
+#define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
+#define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
+#define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
+
+#define MIDX_VERSION_1 1
+#define MIDX_VERSION MIDX_VERSION_1
+
+#define MIDX_OID_VERSION_SHA1 1
+#define MIDX_OID_LEN_SHA1 20
+#define MIDX_OID_VERSION MIDX_OID_VERSION_SHA1
+#define MIDX_OID_LEN MIDX_OID_LEN_SHA1
+
+#define MIDX_LARGE_OFFSET_NEEDED 0x80000000
+
+char* get_midx_filename_oid(const char *pack_dir,
+			    struct object_id *oid)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	strbuf_addstr(&head_path, pack_dir);
+	strbuf_addstr(&head_path, "/midx-");
+	strbuf_addstr(&head_path, oid_to_hex(oid));
+	strbuf_addstr(&head_path, ".midx");
+
+	return strbuf_detach(&head_path, NULL);
+}
+
+struct pack_midx_details_internal {
+	uint32_t pack_int_id;
+	uint32_t internal_offset;
+};
+
+static int midx_sha1_compare(const void *_a, const void *_b)
+{
+	struct pack_midx_entry *a = *(struct pack_midx_entry **)_a;
+	struct pack_midx_entry *b = *(struct pack_midx_entry **)_b;
+	return oidcmp(&a->oid, &b->oid);
+}
+
+static void write_midx_chunk_packlookup(
+	struct sha1file *f,
+	const char **pack_names, uint32_t nr_packs)
+{
+	uint32_t i, cur_len = 0;
+
+	for (i = 0; i < nr_packs; i++) {
+		uint32_t swap_len = htonl(cur_len);
+		sha1write(f, &swap_len, 4);
+		cur_len += strlen(pack_names[i]) + 1;
+	}
+}
+
+static void write_midx_chunk_packnames(
+	struct sha1file *f,
+	const char **pack_names, uint32_t nr_packs)
+{
+	uint32_t i;
+	for (i = 0; i < nr_packs; i++)
+		sha1write(f, pack_names[i], strlen(pack_names[i]) + 1);
+}
+
+static void write_midx_chunk_oidfanout(
+	struct sha1file *f,
+	struct pack_midx_entry **objects, uint32_t nr_objects)
+{
+	struct pack_midx_entry **list = objects;
+	struct pack_midx_entry **last = objects + nr_objects;
+	uint32_t count_distinct = 0;
+	uint32_t i;
+
+	/*
+	* Write the first-level table (the list is sorted,
+	* but we use a 256-entry lookup to be able to avoid
+	* having to do eight extra binary search iterations).
+	*/
+	for (i = 0; i < 256; i++) {
+		struct pack_midx_entry **next = list;
+		struct pack_midx_entry *prev = 0;
+		uint32_t swap_distinct;
+
+		while (next < last) {
+			struct pack_midx_entry *obj = *next;
+			if (obj->oid.hash[0] != i)
+				break;
+
+			if (!prev || oidcmp(&(prev->oid), &(obj->oid)))
+				count_distinct++;
+
+			prev = obj;
+			next++;
+		}
+
+		swap_distinct = htonl(count_distinct);
+		sha1write(f, &swap_distinct, 4);
+		list = next;
+	}
+}
+
+static void write_midx_chunk_oidlookup(
+	struct sha1file *f, unsigned char hash_len,
+	struct pack_midx_entry **objects, uint32_t nr_objects)
+{
+	struct pack_midx_entry **list = objects;
+	struct object_id *last_oid = 0;
+	uint32_t i;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_midx_entry *obj = *list++;
+
+		if (last_oid && !oidcmp(last_oid, &obj->oid))
+			continue;
+
+		last_oid = &obj->oid;
+		sha1write(f, obj->oid.hash, (int)hash_len);
+	}
+}
+
+static void write_midx_chunk_objectoffsets(
+	struct sha1file *f, int large_offset_needed,
+	struct pack_midx_entry **objects, uint32_t nr_objects, uint32_t *pack_perm)
+{
+	struct pack_midx_entry **list = objects;
+	struct object_id *last_oid = 0;
+	uint32_t i, nr_large_offset = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_midx_details_internal details;
+		struct pack_midx_entry *obj = *list++;
+
+		if (last_oid && !oidcmp(last_oid, &obj->oid))
+			continue;
+
+		last_oid = &obj->oid;
+
+		details.pack_int_id = htonl(pack_perm[obj->pack_int_id]);
+
+		if (large_offset_needed && obj->offset >> 31)
+			details.internal_offset = (MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
+		else
+			details.internal_offset = (uint32_t)obj->offset;
+
+		details.internal_offset = htonl(details.internal_offset);
+		sha1write(f, &details, 8);
+	}
+}
+
+static void write_midx_chunk_largeoffsets(
+	struct sha1file *f, uint32_t nr_large_offset,
+	struct pack_midx_entry **objects, uint32_t nr_objects)
+{
+	struct pack_midx_entry **list = objects;
+	struct object_id *last_oid = 0;
+
+	while (nr_large_offset) {
+		struct pack_midx_entry *obj = *list++;
+		uint64_t offset = obj->offset;
+		uint32_t split[2];
+
+		if (last_oid && !oidcmp(last_oid, &obj->oid))
+			continue;
+
+		last_oid = &obj->oid;
+
+		if (!(offset >> 31))
+			continue;
+
+		split[0] = htonl(offset >> 32);
+		split[1] = htonl(offset & 0xffffffff);
+
+		sha1write(f, split, 8);
+		nr_large_offset--;
+	}
+}
+
+struct pack_pair {
+	uint32_t pack_int_id;
+	const char *pack_name;
+};
+
+static int pack_pair_compare(const void *_a, const void *_b)
+{
+	struct pack_pair *a = (struct pack_pair *)_a;
+	struct pack_pair *b = (struct pack_pair *)_b;
+	return strcmp(a->pack_name, b->pack_name);
+}
+
+static void sort_packs_by_name(const char **pack_names, uint32_t nr_packs, uint32_t *perm)
+{
+	uint32_t i;
+	struct pack_pair *pairs;
+
+	ALLOC_ARRAY(pairs, nr_packs);
+
+	for (i = 0; i < nr_packs; i++) {
+		pairs[i].pack_int_id = i;
+		pairs[i].pack_name = pack_names[i];
+	}
+
+	QSORT(pairs, nr_packs, pack_pair_compare);
+
+	for (i = 0; i < nr_packs; i++) {
+		pack_names[i] = pairs[i].pack_name;
+		perm[pairs[i].pack_int_id] = i;
+	}
+}
+
+const char *write_midx_file(const char *pack_dir,
+			    const char *midx_name,
+			    const char **pack_names,
+			    uint32_t nr_packs,
+			    struct pack_midx_entry **objects,
+			    uint32_t nr_objects)
+{
+	struct sha1file *f;
+	struct pack_midx_entry **sorted_by_sha;
+	int i, chunk, fd;
+	struct pack_midx_header hdr;
+	uint32_t chunk_ids[7];
+	uint64_t chunk_offsets[7];
+	unsigned char large_offset_needed = 0;
+	unsigned int nr_large_offset = 0;
+	unsigned char final_hash[GIT_MAX_RAWSZ];
+	const char *final_hex;
+	int rename_needed = 0;
+	uint32_t count_distinct = 0;
+	int total_name_len = 0;
+	uint32_t *pack_perm;
+
+	if (!core_midx)
+		return 0;
+
+	/* Sort packs */
+	if (nr_packs) {
+		ALLOC_ARRAY(pack_perm, nr_packs);
+		sort_packs_by_name(pack_names, nr_packs, pack_perm);
+	} else {
+		pack_perm = 0;
+	}
+
+	/* Sort objects */
+	if (nr_objects) {
+		sorted_by_sha = objects;
+
+		QSORT(sorted_by_sha, nr_objects, midx_sha1_compare);
+
+		for (i = 0; i < nr_objects; i++) {
+			if (i &&
+			    !oidcmp(&sorted_by_sha[i-1]->oid, &sorted_by_sha[i]->oid))
+				continue;
+
+			count_distinct++;
+
+			if (sorted_by_sha[i]->offset > 0x7fffffff)
+				nr_large_offset++;
+			if (sorted_by_sha[i]->offset > 0xffffffff)
+				large_offset_needed = 1;
+		}
+	} else {
+		sorted_by_sha = NULL;
+	}
+
+	for (i = 0; i < nr_packs; i++)
+		total_name_len += strlen(pack_names[i]) + 1;
+
+	/* open temp file, or direct file if given */
+	if (!midx_name) {
+		struct strbuf tmp_file = STRBUF_INIT;
+		strbuf_addstr(&tmp_file, pack_dir);
+		strbuf_addstr(&tmp_file, "/tmp_midx_XXXXXX");
+
+		fd = git_mkstemp_mode(tmp_file.buf, 0444);
+		if (fd < 0)
+			die_errno("unable to create '%s'", tmp_file.buf);
+
+		midx_name = strbuf_detach(&tmp_file, NULL);
+		rename_needed = 1;
+	} else {
+		unlink(midx_name);
+		fd = open(midx_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		if (fd < 0)
+			die_errno("unable to create '%s'", midx_name);
+	}
+	f = sha1fd(fd, midx_name);
+
+	/* fill header info */
+	hdr.midx_signature = htonl(MIDX_SIGNATURE);
+	hdr.midx_version = htonl(MIDX_VERSION);
+
+	hdr.hash_version = MIDX_OID_VERSION;
+	hdr.hash_len = MIDX_OID_LEN;
+	hdr.num_base_midx = 0;
+	hdr.num_packs = htonl(nr_packs);
+
+	/*
+	 * We expect the following chunks, which are required:
+	 *
+	 * Packfile Name Lookup
+	 * Packfile Names
+	 * OID Fanout
+	 * OID Lookup
+	 * Object Offsets
+	 */
+	hdr.num_chunks = large_offset_needed ? 6 : 5;
+
+	/* write header to file */
+	assert(sizeof(hdr) == 16);
+	sha1write(f, &hdr, sizeof(hdr));
+
+	/*
+	 * Fill initial chunk values using offsets
+	 * relative to first chunk.
+	 */
+	chunk_offsets[0] = sizeof(hdr) + 12 * (hdr.num_chunks + 1);
+	chunk_ids[0] = MIDX_CHUNKID_PACKLOOKUP;
+	chunk_offsets[1] = chunk_offsets[0] + nr_packs * 4;
+	chunk_ids[1] = MIDX_CHUNKID_OIDFANOUT;
+	chunk_offsets[2] = chunk_offsets[1] + 256 * 4;
+	chunk_ids[2] = MIDX_CHUNKID_OIDLOOKUP;
+	chunk_offsets[3] = chunk_offsets[2] + (uint64_t)count_distinct
+					    * (uint64_t)hdr.hash_len;
+	chunk_ids[3] = MIDX_CHUNKID_OBJECTOFFSETS;
+	chunk_offsets[4] = chunk_offsets[3] + 8 * (uint64_t)count_distinct;
+
+	if (large_offset_needed) {
+		chunk_ids[4] = MIDX_CHUNKID_LARGEOFFSETS;
+		chunk_offsets[5] = chunk_offsets[4] + 8 * (uint64_t)nr_large_offset;
+		chunk_ids[5] = MIDX_CHUNKID_PACKNAMES;
+		chunk_offsets[6] = chunk_offsets[5] + total_name_len;
+		chunk_ids[6] = 0;
+	} else {
+		chunk_ids[4] = MIDX_CHUNKID_PACKNAMES;
+		chunk_offsets[5] = chunk_offsets[4] + total_name_len;
+		chunk_ids[5] = 0;
+	}
+
+	for (i = 0; i <= hdr.num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		sha1write(f, chunk_write, 12);
+	}
+
+	for (chunk = 0; chunk < hdr.num_chunks; chunk++) {
+		switch (chunk_ids[chunk]) {
+		case MIDX_CHUNKID_PACKLOOKUP:
+			write_midx_chunk_packlookup(f, pack_names, nr_packs);
+			break;
+
+		case MIDX_CHUNKID_PACKNAMES:
+			write_midx_chunk_packnames(f, pack_names, nr_packs);
+			break;
+
+		case MIDX_CHUNKID_OIDFANOUT:
+			write_midx_chunk_oidfanout(f, sorted_by_sha, nr_objects);
+			break;
+
+		case MIDX_CHUNKID_OIDLOOKUP:
+			write_midx_chunk_oidlookup(f, hdr.hash_len, sorted_by_sha,
+						   nr_objects);
+			break;
+
+		case MIDX_CHUNKID_OBJECTOFFSETS:
+			write_midx_chunk_objectoffsets(f, large_offset_needed,
+						       sorted_by_sha, nr_objects,
+						       pack_perm);
+			break;
+
+		case MIDX_CHUNKID_LARGEOFFSETS:
+			write_midx_chunk_largeoffsets(f, nr_large_offset,
+						      sorted_by_sha, nr_objects);
+			break;
+
+		case 0:
+			break;
+
+		default:
+			die("unrecognized MIDX chunk id: %08x", chunk_ids[chunk]);
+		}
+	}
+
+	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
+
+	if (rename_needed)
+	{
+		struct object_id oid;
+		char *fname;
+
+		memcpy(oid.hash, final_hash, GIT_MAX_RAWSZ);
+		fname = get_midx_filename_oid(pack_dir, &oid);
+		final_hex = sha1_to_hex(final_hash);
+
+		if (rename(midx_name, fname))
+			die("failed to rename %s to %s", midx_name, fname);
+
+		free(fname);
+	} else {
+		final_hex = midx_name;
+	}
+
+	return final_hex;
+}
diff --git a/midx.h b/midx.h
new file mode 100644
index 0000000000..4b00463651
--- /dev/null
+++ b/midx.h
@@ -0,0 +1,42 @@
+#ifndef MIDX_H
+#define MIDX_H
+
+#include "git-compat-util.h"
+#include "object.h"
+#include "csum-file.h"
+
+extern char *get_midx_filename_oid(const char *pack_dir,
+				   struct object_id *oid);
+
+struct pack_midx_entry {
+	struct object_id oid;
+	uint32_t pack_int_id;
+	off_t offset;
+};
+
+struct pack_midx_header {
+	uint32_t midx_signature;
+	uint32_t midx_version;
+	unsigned char hash_version;
+	unsigned char hash_len;
+	unsigned char num_base_midx;
+	unsigned char num_chunks;
+	uint32_t num_packs;
+};
+
+/*
+ * Write a single MIDX file storing the given entries for the
+ * given list of packfiles. If midx_name is null, then a temp
+ * file will be created and swapped using the result hash value.
+ * Otherwise, write directly to midx_name.
+ *
+ * Returns the final name of the MIDX file within pack_dir.
+ */
+extern const char *write_midx_file(const char *pack_dir,
+				   const char *midx_name,
+				   const char **pack_names,
+				   uint32_t nr_packs,
+				   struct pack_midx_entry **objects,
+				   uint32_t nr_objects);
+
+#endif
-- 
2.15.0

