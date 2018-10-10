Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1741F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJJXWp (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 19:22:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40187 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJJXWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id a13-v6so3469653qkc.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NguxvchCWRx+eTHiOIE9c1tuF7L8Nutv/DNloC40yRQ=;
        b=Z0c4UfZGabn2YX91VZojbpC3qA/VvD5R+YHuZXbLOqW4Z5etDRJKyomGGY9Czl+/MJ
         YApdA2qV/erIiSN5xA1k+SuPyzGdm1BzOxD7be30W2wkclV3PoGnMQhTsJjcQNQ8M0Ue
         +g6AYi9z+7XNi9YeQj5hQwIkwW7IzrlZMLROLddeuy0gwhNl+fo85U+gQFFZzwjVdUGI
         WeX+2Wv1+JKQKfVRmb8FZTz0Lo5dcWR2xg5b8qFhZgbVjy54YfwGVP7CIwRgAGUvpfKF
         VkyYsOot4KlCX2adxJthDltVKicmP2QXXeFNiK00Xr8trcEnJ0yZz4AAQyBUzE5yo9K8
         a+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NguxvchCWRx+eTHiOIE9c1tuF7L8Nutv/DNloC40yRQ=;
        b=WpX3+zoMVUQZ7j3PCyrS5mJ14xfvnTFSxemrzYyhk6BhRw9XLe0BY3+XUQALGbS9hR
         F0yju6KrDQhgqk3UW4uLsHHdqamTjmhmpgkHzPo8M/ShxApHdIlLwenwGjf3f2ouB2Lq
         faRLzEeyQgzGY5Da8ToJ4i2OqzQtA0u4L7hDDc9J823PLdSFvzrp3f3JmHmJPhfi+wmK
         NowHw7Z48f8MTwpesb5EynuK9sLEw5iPDNaK/nPpm6PmuM81L6l9MohwrpPC/bXoKO6q
         0tTSInq/GLwLJKyOv+PXUvxTSpGq4dEinp3N+IlUnu6/6yJt/6sNEzJv9/iarG5Tec6J
         7TBg==
X-Gm-Message-State: ABuFfoiZYfHAtikj/77bBGl3DmGiVtrEp4n193OidnPuTOWC0/a4ao96
        qglxA7Z0brhNcCIwmZBl5eXUYSfTfQI=
X-Google-Smtp-Source: ACcGV609IDYJvy5FM2+FS1apyaE0wzIb1vTRw8fFYSOXMtu3wTFnjU9TSr7UPi5jPibPGpVfzee+pw==
X-Received: by 2002:a37:37d5:: with SMTP id e204-v6mr26262321qka.1.1539187195810;
        Wed, 10 Oct 2018 08:59:55 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d89-v6sm13704920qkj.29.2018.10.10.08.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:59:54 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v8 5/7] read-cache: load cache extensions on a worker thread
Date:   Wed, 10 Oct 2018 11:59:36 -0400
Message-Id: <20181010155938.20996-6-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This patch helps address the CPU cost of loading the index by loading
the cache extensions on a worker thread in parallel with loading the cache
entries.

In some cases, loading the extensions takes longer than loading the
cache entries so this patch utilizes the new EOIE to start the thread to
load the extensions before loading all the cache entries in parallel.

This is possible because the current extensions don't access the cache
entries in the index_state structure so are OK that they don't all exist
yet.

The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
extensions don't even get a pointer to the index so don't have access to the
cache entries.

CACHE_EXT_LINK only uses the index_state to initialize the split index.
CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
update and dirty flags.

I used p0002-read-cache.sh to generate some performance data:

	Test w/100,000 files reduced the time by 0.53%
	Test w/1,000,000 files reduced the time by 27.78%

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 read-cache.c | 95 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 16 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4781515252..2214b3153d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#include "thread-utils.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1890,6 +1891,44 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
+struct load_index_extensions
+{
+#ifndef NO_PTHREADS
+	pthread_t pthread;
+#endif
+	struct index_state *istate;
+	const char *mmap;
+	size_t mmap_size;
+	unsigned long src_offset;
+};
+
+static void *load_index_extensions(void *_data)
+{
+	struct load_index_extensions *p = _data;
+	unsigned long src_offset = p->src_offset;
+
+	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize = get_be32(p->mmap + src_offset + 4);
+		if (read_index_extension(p->istate,
+					 p->mmap + src_offset,
+					 p->mmap + src_offset + 8,
+					 extsize) < 0) {
+			munmap((void *)p->mmap, p->mmap_size);
+			die(_("index file corrupt"));
+		}
+		src_offset += 8;
+		src_offset += extsize;
+	}
+
+	return NULL;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1900,6 +1939,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	const char *mmap;
 	size_t mmap_size;
 	const struct cache_entry *previous_ce = NULL;
+	struct load_index_extensions p;
+	size_t extension_offset = 0;
+#ifndef NO_PTHREADS
+	int nr_threads;
+#endif
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1936,6 +1980,30 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
 
+	p.istate = istate;
+	p.mmap = mmap;
+	p.mmap_size = mmap_size;
+
+#ifndef NO_PTHREADS
+	nr_threads = git_config_get_index_threads();
+	if (!nr_threads)
+		nr_threads = online_cpus();
+
+	if (nr_threads > 1) {
+		extension_offset = read_eoie_extension(mmap, mmap_size);
+		if (extension_offset) {
+			int err;
+
+			p.src_offset = extension_offset;
+			err = pthread_create(&p.pthread, NULL, load_index_extensions, &p);
+			if (err)
+				die(_("unable to create load_index_extensions thread: %s"), strerror(err));
+
+			nr_threads--;
+		}
+	}
+#endif
+
 	if (istate->version == 4) {
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size_from_compressed(istate->cache_nr));
@@ -1960,22 +2028,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-	while (src_offset <= mmap_size - the_hash_algo->rawsz - 8) {
-		/* After an array of active_nr index entries,
-		 * there can be arbitrary number of extended
-		 * sections, each of which is prefixed with
-		 * extension name (4-byte) and section length
-		 * in 4-byte network byte order.
-		 */
-		uint32_t extsize;
-		extsize = get_be32(mmap + src_offset + 4);
-		if (read_index_extension(istate,
-					 mmap + src_offset,
-					 mmap + src_offset + 8,
-					 extsize) < 0)
-			goto unmap;
-		src_offset += 8;
-		src_offset += extsize;
+	/* if we created a thread, join it otherwise load the extensions on the primary thread */
+#ifndef NO_PTHREADS
+	if (extension_offset) {
+		int ret = pthread_join(p.pthread, NULL);
+		if (ret)
+			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
+	}
+#endif
+	if (!extension_offset) {
+		p.src_offset = src_offset;
+		load_index_extensions(&p);
 	}
 	munmap((void *)mmap, mmap_size);
 	return istate->cache_nr;
-- 
2.18.0.windows.1

