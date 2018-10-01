Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682E01F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJAUYR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41587 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbeJAUYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15-v6so13934530qtp.8
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VM9+riDOIdO2imNrziF2T4pihYKpsxg9CPRjLs9d7SU=;
        b=Coqc7rTnN7TeDEVU6x+WwF8PjMVCO+/iupPJYvdi6Sgy8397ApXU+R6YoHCgiDEf0U
         uPcTTqo4BOY1aQipXv6wq5zIMto+r5iqZMXL1+HPcfBv9k/tiUs+KCkk4H1YjfyCbbyC
         00slaUTRL/+wLYL3gwyKYZQcq0ZuhG2rOxBIfIJs21CN6WzWLBc2k+o/ffZqI96HsXfx
         gbFBLKvnS3QCaaK8mLY6l08p8Ng17QhjOc294c6qsdV+4w9t+4ABjobZu9ykZeaK4gdO
         q1TS7jr3hd/uMyrcRDgVOzoAMPMl9nrUjkzLb9PcXMfusdJ891jObKteg9qmlT753+3T
         HKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VM9+riDOIdO2imNrziF2T4pihYKpsxg9CPRjLs9d7SU=;
        b=flSres3zKevYcJXPJI1JhdK/jOYwCaKxJtDVqmdb60jR1fR6emNFBxcgb11jSdgJpV
         qVs0BvcA2T3ZE1RpcWlIenjPdoYlEdl9mmmFfOUc++XwMZGUVSpw4OnDNnNsiKTN3V3e
         hFOUgvFm+wBu3FqvbQgefi1fQLGIA0qziWQj+7D4t8jlHkPiVg7DB0lpmMDpBP4cI7BL
         QU6dfPy+JsYlYG3DgG0wnA/ezopEYbVesMg9WMdFnC0QlWIqicLMdRjTwTHQEPl+jLV5
         G2TpFKLT4NQTPVdIti/1FiFOfSA79r9EFx4tz6ywG1CMj9u64qxKW2C6JhSKgASDKeX7
         mbdw==
X-Gm-Message-State: ABuFfoisA9/swJofzMK5AiqKXpCOYT8jTkfhbFfF6XyFOGGxSS8IMv0Q
        uiPi2NewivlSHpqLPDAu8odZlPla/gI=
X-Google-Smtp-Source: ACcGV62inHLge7MXfDU2lxYRX7Gxr6Nf7faBgAbiNlpQN8ufwXmSd9Gc476I+weCOxg15XOWq9Q7kg==
X-Received: by 2002:a0c:f94e:: with SMTP id i14-v6mr8649316qvo.50.1538401582455;
        Mon, 01 Oct 2018 06:46:22 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:21 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 7/7] read-cache: load cache entries on worker threads
Date:   Mon,  1 Oct 2018 09:45:56 -0400
Message-Id: <20181001134556.33232-8-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181001134556.33232-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This patch helps address the CPU cost of loading the index by utilizing
the Index Entry Offset Table (IEOT) to divide loading and conversion of
the cache entries across multiple threads in parallel.

I used p0002-read-cache.sh to generate some performance data:

Test w/100,000 files reduced the time by 32.24%
Test w/1,000,000 files reduced the time by -4.77%

Note that on the 1,000,000 files case, multi-threading the cache entry parsing
does not yield a performance win.  This is because the cost to parse the
index extensions in this repo, far outweigh the cost of loading the cache
entries.

The high cost of parsing the index extensions is driven by the cache tree
and the untracked cache extensions. As this is currently the longest pole,
any reduction in this time will reduce the overall index load times so is
worth further investigation in another patch series.

Signed-off-by: Ben Peart <peartben@gmail.com>
---
 read-cache.c | 224 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 189 insertions(+), 35 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9557376e78..14402a0738 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1720,7 +1720,8 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file(), get_git_dir());
 }
 
-static struct cache_entry *create_from_disk(struct index_state *istate,
+static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
+					    unsigned int version,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
@@ -1737,7 +1738,7 @@ static struct cache_entry *create_from_disk(struct index_state *istate,
 	 * number of bytes to be stripped from the end of the previous name,
 	 * and the bytes to append to the result, to come up with its name.
 	 */
-	int expand_name_field = istate->version == 4;
+	int expand_name_field = version == 4;
 
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(&ondisk->flags);
@@ -1761,16 +1762,17 @@ static struct cache_entry *create_from_disk(struct index_state *istate,
 		const unsigned char *cp = (const unsigned char *)name;
 		size_t strip_len, previous_len;
 
-		previous_len = previous_ce ? previous_ce->ce_namelen : 0;
+		/* If we're at the begining of a block, ignore the previous name */
 		strip_len = decode_varint(&cp);
-		if (previous_len < strip_len) {
-			if (previous_ce)
+		if (previous_ce) {
+			previous_len = previous_ce->ce_namelen;
+			if (previous_len < strip_len)
 				die(_("malformed name field in the index, near path '%s'"),
-				    previous_ce->name);
-			else
-				die(_("malformed name field in the index in the first path"));
+					previous_ce->name);
+			copy_len = previous_len - strip_len;
+		} else {
+			copy_len = 0;
 		}
-		copy_len = previous_len - strip_len;
 		name = (const char *)cp;
 	}
 
@@ -1780,7 +1782,7 @@ static struct cache_entry *create_from_disk(struct index_state *istate,
 			len += copy_len;
 	}
 
-	ce = mem_pool__ce_alloc(istate->ce_mem_pool, len);
+	ce = mem_pool__ce_alloc(ce_mem_pool, len);
 
 	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
@@ -1950,6 +1952,52 @@ static void *load_index_extensions(void *_data)
 	return NULL;
 }
 
+/*
+ * A helper function that will load the specified range of cache entries
+ * from the memory mapped file and add them to the given index.
+ */
+static unsigned long load_cache_entry_block(struct index_state *istate,
+			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
+			unsigned long start_offset, const struct cache_entry *previous_ce)
+{
+	int i;
+	unsigned long src_offset = start_offset;
+
+	for (i = offset; i < offset + nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
+		struct cache_entry *ce;
+		unsigned long consumed;
+
+		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
+		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
+		set_index_entry(istate, i, ce);
+
+		src_offset += consumed;
+		previous_ce = ce;
+	}
+	return src_offset - start_offset;
+}
+
+static unsigned long load_all_cache_entries(struct index_state *istate,
+			const char *mmap, size_t mmap_size, unsigned long src_offset)
+{
+	unsigned long consumed;
+
+	if (istate->version == 4) {
+		mem_pool_init(&istate->ce_mem_pool,
+				estimate_cache_size_from_compressed(istate->cache_nr));
+	} else {
+		mem_pool_init(&istate->ce_mem_pool,
+				estimate_cache_size(mmap_size, istate->cache_nr));
+	}
+
+	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
+					0, istate->cache_nr, mmap, src_offset, NULL);
+	return consumed;
+}
+
+#ifndef NO_PTHREADS
+
 /*
  * Mostly randomly chosen maximum thread counts: we
  * cap the parallelism to online_cpus() threads, and we want
@@ -1959,20 +2007,125 @@ static void *load_index_extensions(void *_data)
 
 #define THREAD_COST		(10000)
 
+struct load_cache_entries_thread_data
+{
+	pthread_t pthread;
+	struct index_state *istate;
+	struct mem_pool *ce_mem_pool;
+	int offset;
+	const char *mmap;
+	struct index_entry_offset_table *ieot;
+	int ieot_offset;        /* starting index into the ieot array */
+	int ieot_work;          /* count of ieot entries to process */
+	unsigned long consumed;	/* return # of bytes in index file processed */
+};
+
+/*
+ * A thread proc to run the load_cache_entries() computation
+ * across multiple background threads.
+ */
+static void *load_cache_entries_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p = _data;
+	int i;
+
+	/* iterate across all ieot blocks assigned to this thread */
+	for (i = p->ieot_offset; i < p->ieot_offset + p->ieot_work; i++) {
+		p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool, p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
+		p->offset += p->ieot->entries[i].nr;
+	}
+	return NULL;
+}
+
+static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
+			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
+{
+	int i, offset, ieot_work, ieot_offset, err;
+	struct load_cache_entries_thread_data *data;
+	unsigned long consumed = 0;
+	int nr;
+
+	/* a little sanity checking */
+	if (istate->name_hash_initialized)
+		BUG("the name hash isn't thread safe");
+
+	mem_pool_init(&istate->ce_mem_pool, 0);
+	data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
+
+	/* ensure we have no more threads than we have blocks to process */
+	if (nr_threads > ieot->nr)
+		nr_threads = ieot->nr;
+	data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
+
+	offset = ieot_offset = 0;
+	ieot_work = DIV_ROUND_UP(ieot->nr, nr_threads);
+	for (i = 0; i < nr_threads; i++) {
+		struct load_cache_entries_thread_data *p = &data[i];
+		int j;
+
+		if (ieot_offset + ieot_work > ieot->nr)
+			ieot_work = ieot->nr - ieot_offset;
+
+		p->istate = istate;
+		p->offset = offset;
+		p->mmap = mmap;
+		p->ieot = ieot;
+		p->ieot_offset = ieot_offset;
+		p->ieot_work = ieot_work;
+
+		/* create a mem_pool for each thread */
+		nr = 0;
+		for (j = p->ieot_offset; j < p->ieot_offset + p->ieot_work; j++)
+			nr += p->ieot->entries[j].nr;
+		if (istate->version == 4) {
+			mem_pool_init(&p->ce_mem_pool,
+				estimate_cache_size_from_compressed(nr));
+		}
+		else {
+			mem_pool_init(&p->ce_mem_pool,
+				estimate_cache_size(mmap_size, nr));
+		}
+
+		err = pthread_create(&p->pthread, NULL, load_cache_entries_thread, p);
+		if (err)
+			die(_("unable to create load_cache_entries thread: %s"), strerror(err));
+
+		/* increment by the number of cache entries in the ieot block being processed */
+		for (j = 0; j < ieot_work; j++)
+			offset += ieot->entries[ieot_offset + j].nr;
+		ieot_offset += ieot_work;
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		struct load_cache_entries_thread_data *p = &data[i];
+
+		err = pthread_join(p->pthread, NULL);
+		if (err)
+			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
+		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
+		consumed += p->consumed;
+	}
+
+	free(data);
+
+	return consumed;
+}
+#endif
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
-	int fd, i;
+	int fd;
 	struct stat st;
 	unsigned long src_offset;
 	const struct cache_header *hdr;
 	const char *mmap;
 	size_t mmap_size;
-	const struct cache_entry *previous_ce = NULL;
 	struct load_index_extensions p;
 	size_t extension_offset = 0;
 #ifndef NO_PTHREADS
-	int nr_threads;
+	int nr_threads, cpus;
+	struct index_entry_offset_table *ieot = NULL;
 #endif
 
 	if (istate->initialized)
@@ -2014,10 +2167,18 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	p.mmap = mmap;
 	p.mmap_size = mmap_size;
 
+	src_offset = sizeof(*hdr);
+
 #ifndef NO_PTHREADS
 	nr_threads = git_config_get_index_threads();
-	if (!nr_threads)
-		nr_threads = online_cpus();
+
+	/* TODO: does creating more threads than cores help? */
+	if (!nr_threads) {
+		nr_threads = istate->cache_nr / THREAD_COST;
+		cpus = online_cpus();
+		if (nr_threads > cpus)
+			nr_threads = cpus;
+	}
 
 	if (nr_threads > 1) {
 		extension_offset = read_eoie_extension(mmap, mmap_size);
@@ -2032,29 +2193,22 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 			nr_threads--;
 		}
 	}
-#endif
-
-	if (istate->version == 4) {
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size_from_compressed(istate->cache_nr));
-	} else {
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size(mmap_size, istate->cache_nr));
-	}
 
-	src_offset = sizeof(*hdr);
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-		unsigned long consumed;
+	/*
+	 * Locate and read the index entry offset table so that we can use it
+	 * to multi-thread the reading of the cache entries.
+	 */
+	if (extension_offset && nr_threads > 1)
+		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
 
-		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
-		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
-		set_index_entry(istate, i, ce);
+	if (ieot)
+		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
+	else
+		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+#else
+	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+#endif
 
-		src_offset += consumed;
-		previous_ce = ce;
-	}
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-- 
2.18.0.windows.1

