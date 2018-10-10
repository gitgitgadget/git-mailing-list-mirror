Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE741F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJXWj (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 19:22:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37433 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXWj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so6237553qto.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ydyz4r16Kleoxv/So7OSCW0M3qVPclu0Hs4NyaQDQfY=;
        b=kRoeHAza068H6Lz38Kwx808LjURCQldvGRWKJCo3fZ6uOlrG80WqKOwXljE437OU3J
         kcsFz+0PljaTFYv5lI3i3AJwrCRHOsWR0owAsdMIEggcF32Rz+Vy94vDBDm9JzWJSAwi
         7xy8T5TYgPohUDB1J+m/siLr6vwE4Fk288Ed1n0zdqI9IUbjPpH8FKlSpf/2mOz9NV4C
         xT7/H81g2SkXqQ+VlzIKLJqJQYGSSPlLhmOPpL3DYLZznlx2oFIy6qz9kTKUk4LVaG2k
         003yn7/UMhxX2RuwZdRkWeYRUzdnuTUKSn0v5qWm9xb0Dcx46M13KXgSVWNjhQpCcrkc
         5gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ydyz4r16Kleoxv/So7OSCW0M3qVPclu0Hs4NyaQDQfY=;
        b=OgfnHMuUCmpjoCH4HIA2s3oX8mc/fbVfMpOKnYwW/bHTKf//0Fa3vJBxHVBttXoR70
         hfcEKpr9W14kAEmTQzDWiSALyHTd8JiEeIDq7e3Np/aGAdNuclPEfUhLL9hT9qk/8chG
         BlKqYQXozrRwn+QAru5JXjgeXX5dQd5+7HGn2PrISobyROmLjbmZ914iyw4MB9ESnhQs
         rI/DjRkEuceegbFlCElt4vaJ1BiEe+Xh4BaDnOxuXxERBB+0l4TBnmk2J0x9rLUedWgw
         mbGi0gLlbAQbB7PUAbR5QbqlO5OtguQRvTumFGtYqpgvUD/p7WwtYiYsI6sYfxCsUqUf
         jUPA==
X-Gm-Message-State: ABuFfohv22VGvLudBtF+rdyCXwOWMCxULmrQ0Nk7MuUAiSw+vU9oIzVV
        LzoBR9Lx8IYB7i/jhJRMYh60eB5ecak=
X-Google-Smtp-Source: ACcGV62W0LQNoREpHhHyFub4KaVwkJWg82T9IBcl4LarvsVYMer4iABXBDOB82fqw8ffKCAG5h8fXA==
X-Received: by 2002:ad4:514c:: with SMTP id g12-v6mr27932088qvq.168.1539187189496;
        Wed, 10 Oct 2018 08:59:49 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d89-v6sm13704920qkj.29.2018.10.10.08.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:59:48 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v8 0/7] speed up index load through parallelization
Date:   Wed, 10 Oct 2018 11:59:31 -0400
Message-Id: <20181010155938.20996-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180823154053.20212-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Fixed issues identified in review the most impactful probably being plugging
some leaks and improved error handling.  Also added better error messages
and some code cleanup to code I'd touched.

The biggest change in the interdiff is the impact of renaming ieot_offset to
ieot_start and ieot_work to ieot_blocks in hopes of making it easier to read
and understand the code.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/6caa0bac46
Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v8 && git checkout 6caa0bac46


### Interdiff (v7..v8):

diff --git a/read-cache.c b/read-cache.c
index 14402a0738..7acc2c86f4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1901,7 +1901,7 @@ struct index_entry_offset
 struct index_entry_offset_table
 {
 	int nr;
-	struct index_entry_offset entries[0];
+	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
 #ifndef NO_PTHREADS
@@ -1935,9 +1935,7 @@ static void *load_index_extensions(void *_data)
 		 * extension name (4-byte) and section length
 		 * in 4-byte network byte order.
 		 */
-		uint32_t extsize;
-		memcpy(&extsize, p->mmap + src_offset + 4, 4);
-		extsize = ntohl(extsize);
+		uint32_t extsize = get_be32(p->mmap + src_offset + 4);
 		if (read_index_extension(p->istate,
 					 p->mmap + src_offset,
 					 p->mmap + src_offset + 8,
@@ -2015,8 +2013,8 @@ struct load_cache_entries_thread_data
 	int offset;
 	const char *mmap;
 	struct index_entry_offset_table *ieot;
-	int ieot_offset;        /* starting index into the ieot array */
-	int ieot_work;          /* count of ieot entries to process */
+	int ieot_start;		/* starting index into the ieot array */
+	int ieot_blocks;	/* count of ieot entries to process */
 	unsigned long consumed;	/* return # of bytes in index file processed */
 };
 
@@ -2030,8 +2028,9 @@ static void *load_cache_entries_thread(void *_data)
 	int i;
 
 	/* iterate across all ieot blocks assigned to this thread */
-	for (i = p->ieot_offset; i < p->ieot_offset + p->ieot_work; i++) {
-		p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool, p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
+	for (i = p->ieot_start; i < p->ieot_start + p->ieot_blocks; i++) {
+		p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool,
+			p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset, NULL);
 		p->offset += p->ieot->entries[i].nr;
 	}
 	return NULL;
@@ -2040,48 +2039,45 @@ static void *load_cache_entries_thread(void *_data)
 static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
 			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
 {
-	int i, offset, ieot_work, ieot_offset, err;
+	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
 	unsigned long consumed = 0;
-	int nr;
 
 	/* a little sanity checking */
 	if (istate->name_hash_initialized)
 		BUG("the name hash isn't thread safe");
 
 	mem_pool_init(&istate->ce_mem_pool, 0);
-	data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
 
 	/* ensure we have no more threads than we have blocks to process */
 	if (nr_threads > ieot->nr)
 		nr_threads = ieot->nr;
-	data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
+	data = xcalloc(nr_threads, sizeof(*data));
 
-	offset = ieot_offset = 0;
-	ieot_work = DIV_ROUND_UP(ieot->nr, nr_threads);
+	offset = ieot_start = 0;
+	ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
 	for (i = 0; i < nr_threads; i++) {
 		struct load_cache_entries_thread_data *p = &data[i];
-		int j;
+		int nr, j;
 
-		if (ieot_offset + ieot_work > ieot->nr)
-			ieot_work = ieot->nr - ieot_offset;
+		if (ieot_start + ieot_blocks > ieot->nr)
+			ieot_blocks = ieot->nr - ieot_start;
 
 		p->istate = istate;
 		p->offset = offset;
 		p->mmap = mmap;
 		p->ieot = ieot;
-		p->ieot_offset = ieot_offset;
-		p->ieot_work = ieot_work;
+		p->ieot_start = ieot_start;
+		p->ieot_blocks = ieot_blocks;
 
 		/* create a mem_pool for each thread */
 		nr = 0;
-		for (j = p->ieot_offset; j < p->ieot_offset + p->ieot_work; j++)
+		for (j = p->ieot_start; j < p->ieot_start + p->ieot_blocks; j++)
 			nr += p->ieot->entries[j].nr;
 		if (istate->version == 4) {
 			mem_pool_init(&p->ce_mem_pool,
 				estimate_cache_size_from_compressed(nr));
-		}
-		else {
+		} else {
 			mem_pool_init(&p->ce_mem_pool,
 				estimate_cache_size(mmap_size, nr));
 		}
@@ -2091,9 +2087,9 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 			die(_("unable to create load_cache_entries thread: %s"), strerror(err));
 
 		/* increment by the number of cache entries in the ieot block being processed */
-		for (j = 0; j < ieot_work; j++)
-			offset += ieot->entries[ieot_offset + j].nr;
-		ieot_offset += ieot_work;
+		for (j = 0; j < ieot_blocks; j++)
+			offset += ieot->entries[ieot_start + j].nr;
+		ieot_start += ieot_blocks;
 	}
 
 	for (i = 0; i < nr_threads; i++) {
@@ -2201,10 +2197,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (extension_offset && nr_threads > 1)
 		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
 
-	if (ieot)
+	if (ieot) {
 		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
-	else
+		free(ieot);
+	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+	}
 #else
 	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 #endif
@@ -2705,9 +2703,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
-	int ieot_work = 1;
+	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
-	int nr;
+	int nr, nr_threads;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2742,20 +2740,24 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 
 #ifndef NO_PTHREADS
-	if ((nr = git_config_get_index_threads()) != 1) {
+	nr_threads = git_config_get_index_threads();
+	if (nr_threads != 1) {
 		int ieot_blocks, cpus;
 
 		/*
 		 * ensure default number of ieot blocks maps evenly to the
-		 * default number of threads that will process them
+		 * default number of threads that will process them leaving
+		 * room for the thread to load the index extensions.
 		 */
-		if (!nr) {
+		if (!nr_threads) {
 			ieot_blocks = istate->cache_nr / THREAD_COST;
 			cpus = online_cpus();
 			if (ieot_blocks > cpus - 1)
 				ieot_blocks = cpus - 1;
 		} else {
-			ieot_blocks = nr;
+			ieot_blocks = nr_threads;
+			if (ieot_blocks > istate->cache_nr)
+				ieot_blocks = istate->cache_nr;
 		}
 
 		/*
@@ -2765,13 +2767,17 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (ieot_blocks > 1) {
 			ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
 				+ (ieot_blocks * sizeof(struct index_entry_offset)));
-			ieot->nr = 0;
-			ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
+			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
 		}
 	}
 #endif
 
-	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	offset = lseek(newfd, 0, SEEK_CUR);
+	if (offset < 0) {
+		free(ieot);
+		return -1;
+	}
+	offset += write_buffer_len;
 	nr = 0;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
@@ -2794,7 +2800,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
-		if (ieot && i && (i % ieot_work == 0)) {
+		if (ieot && i && (i % ieot_entries == 0)) {
 			ieot->entries[ieot->nr].nr = nr;
 			ieot->entries[ieot->nr].offset = offset;
 			ieot->nr++;
@@ -2806,7 +2812,12 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			if (previous_name)
 				previous_name->buf[0] = 0;
 			nr = 0;
-			offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+			offset = lseek(newfd, 0, SEEK_CUR);
+			if (offset < 0) {
+				free(ieot);
+				return -1;
+			}
+			offset += write_buffer_len;
 		}
 		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
@@ -2822,16 +2833,23 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 	strbuf_release(&previous_name_buf);
 
-	if (err)
+	if (err) {
+		free(ieot);
 		return err;
+	}
 
 	/* Write extension data here */
-	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	offset = lseek(newfd, 0, SEEK_CUR);
+	if (offset < 0) {
+		free(ieot);
+		return -1;
+	}
+	offset += write_buffer_len;
 	the_hash_algo->init_fn(&eoie_c);
 
 	/*
 	 * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
-	 * can minimze the number of extensions we have to scan through to
+	 * can minimize the number of extensions we have to scan through to
 	 * find it during load.  Write it out regardless of the
 	 * strip_extensions parameter as we need it when loading the shared
 	 * index.
@@ -2844,6 +2862,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
+		free(ieot);
 		if (err)
 			return -1;
 	}
@@ -3460,14 +3479,18 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 
        /* validate the version is IEOT_VERSION */
        ext_version = get_be32(index);
-       if (ext_version != IEOT_VERSION)
+       if (ext_version != IEOT_VERSION) {
+	       error("invalid IEOT version %d", ext_version);
 	       return NULL;
+       }
        index += sizeof(uint32_t);
 
        /* extension size - version bytes / bytes per entry */
        nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
-       if (!nr)
+       if (!nr) {
+	       error("invalid number of IEOT entries %d", nr);
 	       return NULL;
+       }
        ieot = xmalloc(sizeof(struct index_entry_offset_table)
 	       + (nr * sizeof(struct index_entry_offset)));
        ieot->nr = nr;


### Patches

Ben Peart (6):
  read-cache: clean up casting and byte decoding
  eoie: add End of Index Entry (EOIE) extension
  config: add new index.threads config setting
  read-cache: load cache extensions on a worker thread
  ieot: add Index Entry Offset Table (IEOT) extension
  read-cache: load cache entries on worker threads

Nguyễn Thái Ngọc Duy (1):
  read-cache.c: optimize reading index format v4

 Documentation/config.txt                 |   7 +
 Documentation/technical/index-format.txt |  41 ++
 config.c                                 |  18 +
 config.h                                 |   1 +
 read-cache.c                             | 774 +++++++++++++++++++----
 t/README                                 |   5 +
 t/t1700-split-index.sh                   |  13 +-
 7 files changed, 739 insertions(+), 120 deletions(-)


base-commit: fe8321ec057f9231c26c29b364721568e58040f7
-- 
2.18.0.windows.1


