Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8178C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJXWs (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 19:22:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35770 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJJXWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id v19-v6so6251931qtg.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7khLTFOeNkcY3nhXBlaUR571vCUJrHfKFVxCfPPwQ2Q=;
        b=PREHZ+dgJDXD3IxjNkhMzFdS5dNjb5a004rAOwdk+H/frzjJ+rRc4EXRGfjznceVgR
         U7sI/vX9LF/NUAOyVKHJs2BLcmlEC54ZcGVsS6F+vXMJJwjABqmfNSXuia7phF3nQ4V3
         i/IyWigM01l4Z9MXelYeAmdnyfIzp/ZKaAIVea0EZn+5LWI1cfZn79tKo/8erP7xPcWP
         JSaUR6J4vJdGf57jVYIJFbnEIp0+JCq5JpvxmjBHE6s2xe97dWHevbruotGrLDiljBGq
         wrKbSOmgZlcJgheEc0zUkTXwW6VcELpvBaTt2aqZOW+ATjxxsFHnvpfL8+NgfD40SLD4
         Ss5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7khLTFOeNkcY3nhXBlaUR571vCUJrHfKFVxCfPPwQ2Q=;
        b=PBb8SZe3/CyYeE/Cqnksl+xLwANyGn0/k/iZl/lxagOX4MLRkpNIx4322j2hK/7R/l
         bwSguVdIhdgItgqAO7M+SCCP6kx53hLkFs9B3FU8y4WEuN88+3/L/Wd7sC03YLFb68fh
         frnD0TnSLaWh1JcH2W8XWImuqRcgpJCX6hk8NjitO6Ai9lTpXS1XPBoRvjHxBO8+65eI
         bLezl8ARQTSbGr0bj+KqthRloLyjOxIghfoOGy7IxQsJyWUkCdLpi6eGzph8ZNiC+uHQ
         +vgAwPsAlCWwyJhpQnMC+eoIpKExvSCYDu443B2gifRQF8wiIathme7DRjZENxQ+b+bU
         y4Lg==
X-Gm-Message-State: ABuFfogXUqM5izNxJ44e1RuJBhyJlmlzIMbP6RuaqJMo1LIezTNZag6b
        GjM380rFdn/3GjDi7n2miF8SXk3Sh1U=
X-Google-Smtp-Source: ACcGV62YV7mklVl2DpBWzj3HZ0jA3pHw89Jq7lwKd8SGOHbJCGXfbijfKJeKJyjg7fhzrWL6SbW8sg==
X-Received: by 2002:a0c:f042:: with SMTP id b2-v6mr26847611qvl.232.1539187198517;
        Wed, 10 Oct 2018 08:59:58 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d89-v6sm13704920qkj.29.2018.10.10.08.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:59:57 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v8 7/7] read-cache: load cache entries on worker threads
Date:   Wed, 10 Oct 2018 11:59:38 -0400
Message-Id: <20181010155938.20996-8-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
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

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 read-cache.c | 230 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 193 insertions(+), 37 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3ace29d58f..7acc2c86f4 100644
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
@@ -1948,6 +1950,52 @@ static void *load_index_extensions(void *_data)
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
@@ -1957,20 +2005,123 @@ static void *load_index_extensions(void *_data)
 
 #define THREAD_COST		(10000)
 
+struct load_cache_entries_thread_data
+{
+	pthread_t pthread;
+	struct index_state *istate;
+	struct mem_pool *ce_mem_pool;
+	int offset;
+	const char *mmap;
+	struct index_entry_offset_table *ieot;
+	int ieot_start;		/* starting index into the ieot array */
+	int ieot_blocks;	/* count of ieot entries to process */
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
+	for (i = p->ieot_start; i < p->ieot_start + p->ieot_blocks; i++) {
+		p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool,
+			p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
+		p->offset += p->ieot->entries[i].nr;
+	}
+	return NULL;
+}
+
+static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
+			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
+{
+	int i, offset, ieot_blocks, ieot_start, err;
+	struct load_cache_entries_thread_data *data;
+	unsigned long consumed = 0;
+
+	/* a little sanity checking */
+	if (istate->name_hash_initialized)
+		BUG("the name hash isn't thread safe");
+
+	mem_pool_init(&istate->ce_mem_pool, 0);
+
+	/* ensure we have no more threads than we have blocks to process */
+	if (nr_threads > ieot->nr)
+		nr_threads = ieot->nr;
+	data = xcalloc(nr_threads, sizeof(*data));
+
+	offset = ieot_start = 0;
+	ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
+	for (i = 0; i < nr_threads; i++) {
+		struct load_cache_entries_thread_data *p = &data[i];
+		int nr, j;
+
+		if (ieot_start + ieot_blocks > ieot->nr)
+			ieot_blocks = ieot->nr - ieot_start;
+
+		p->istate = istate;
+		p->offset = offset;
+		p->mmap = mmap;
+		p->ieot = ieot;
+		p->ieot_start = ieot_start;
+		p->ieot_blocks = ieot_blocks;
+
+		/* create a mem_pool for each thread */
+		nr = 0;
+		for (j = p->ieot_start; j < p->ieot_start + p->ieot_blocks; j++)
+			nr += p->ieot->entries[j].nr;
+		if (istate->version == 4) {
+			mem_pool_init(&p->ce_mem_pool,
+				estimate_cache_size_from_compressed(nr));
+		} else {
+			mem_pool_init(&p->ce_mem_pool,
+				estimate_cache_size(mmap_size, nr));
+		}
+
+		err = pthread_create(&p->pthread, NULL, load_cache_entries_thread, p);
+		if (err)
+			die(_("unable to create load_cache_entries thread: %s"), strerror(err));
+
+		/* increment by the number of cache entries in the ieot block being processed */
+		for (j = 0; j < ieot_blocks; j++)
+			offset += ieot->entries[ieot_start + j].nr;
+		ieot_start += ieot_blocks;
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
@@ -2012,10 +2163,18 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
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
@@ -2030,29 +2189,24 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 			nr_threads--;
 		}
 	}
-#endif
 
-	if (istate->version == 4) {
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size_from_compressed(istate->cache_nr));
+	/*
+	 * Locate and read the index entry offset table so that we can use it
+	 * to multi-thread the reading of the cache entries.
+	 */
+	if (extension_offset && nr_threads > 1)
+		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
+
+	if (ieot) {
+		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
+		free(ieot);
 	} else {
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size(mmap_size, istate->cache_nr));
+		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
+#else
+	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+#endif
 
-	src_offset = sizeof(*hdr);
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-		unsigned long consumed;
-
-		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
-		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
-		set_index_entry(istate, i, ce);
-
-		src_offset += consumed;
-		previous_ce = ce;
-	}
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
@@ -2549,7 +2703,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
-	int ieot_blocks = 1;
+	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
 
@@ -2602,6 +2756,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 				ieot_blocks = cpus - 1;
 		} else {
 			ieot_blocks = nr_threads;
+			if (ieot_blocks > istate->cache_nr)
+				ieot_blocks = istate->cache_nr;
 		}
 
 		/*
@@ -2611,7 +2767,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (ieot_blocks > 1) {
 			ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
 				+ (ieot_blocks * sizeof(struct index_entry_offset)));
-			ieot_blocks = DIV_ROUND_UP(entries, ieot_blocks);
+			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
 		}
 	}
 #endif
@@ -2644,7 +2800,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
-		if (ieot && i && (i % ieot_blocks == 0)) {
+		if (ieot && i && (i % ieot_entries == 0)) {
 			ieot->entries[ieot->nr].nr = nr;
 			ieot->entries[ieot->nr].offset = offset;
 			ieot->nr++;
-- 
2.18.0.windows.1

