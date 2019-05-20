Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D60B1F4B6
	for <e@80x24.org>; Mon, 20 May 2019 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfETNRF (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 09:17:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727319AbfETNRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 09:17:05 -0400
Received: (qmail 25225 invoked by uid 109); 20 May 2019 13:17:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 13:17:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4125 invoked by uid 111); 20 May 2019 13:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 09:17:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 09:17:03 -0400
Date:   Mon, 20 May 2019 09:17:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     gitster@pobox.com, ao2@ao2.it, e@80x24.org, git@vger.kernel.org
Subject: Re: [PATCH] repository.c: always allocate 'index' at repo init time
Message-ID: <20190520131702.GB13474@sigill.intra.peff.net>
References: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
 <20190519025636.24819-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190519025636.24819-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 09:56:36AM +0700, Nguyễn Thái Ngọc Duy wrote:

> This patch goes with the second option, making sure that 'index' is
> always allocated after initialization. It's less effort than the first
> one, and also safer because you could still miss things during the code
> audit. The extra allocation cost is not a real concern.

I think this direction makes sense.

The patch looks good, though I wonder if we could simplify even further
by just embedding an index into the repository object. The purpose of
having it as a pointer, I think, is so that the_repository can point to
the_index. But we could possibly hide the latter behind some macro
trickery like:

  #define the_index (the_repository->index)

I spent a few minutes on a proof of concept patch, but it gets a bit
hairy:

  1. There are some circular dependencies in the header files. We'd need
     repository.h to depend on cache.h to get the definition of
     index_state, but the latter includes repository.h. We'd need to
     break the index bits out of cache.h into index.h, which in turn
     requires breaking out some other parts. I did a sloppy job of it in
     the patch below.

  2. There are hundreds of spots that need to swap out "repo->index" for
     "&repo->index". In the patch below I just did enough to compile
     archive-zip.o, to illustrate. :)

So it's definitely non-trivial to go that way. I'm not sure if it's
worth the effort to switch at this point, but even if it is, your patch
seems like a good thing to do in the meantime.

Either way, I think we could probably revert the non-test portion of my
581d2fd9f2 (get_oid: handle NULL repo->index, 2019-05-14) after this.

-Peff

---
diff --git a/archive-zip.c b/archive-zip.c
index 4d66b5be6e..517e203483 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -353,7 +353,7 @@ static int write_zip_entry(struct archiver_args *args,
 				return error(_("cannot read %s"),
 					     oid_to_hex(oid));
 			crc = crc32(crc, buffer, size);
-			is_binary = entry_is_binary(args->repo->index,
+			is_binary = entry_is_binary(&args->repo->index,
 						    path_without_prefix,
 						    buffer, size);
 			out = buffer;
@@ -430,7 +430,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(&args->repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
@@ -463,7 +463,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(&args->repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 
diff --git a/cache.h b/cache.h
index b4bb2e2c11..d0450025e1 100644
--- a/cache.h
+++ b/cache.h
@@ -17,6 +17,7 @@
 #include "sha1-array.h"
 #include "repository.h"
 #include "mem-pool.h"
+#include "oid.h"
 
 #include <zlib.h>
 typedef struct git_zstream {
@@ -43,28 +44,6 @@ int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
 unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-/* The block size of SHA-1. */
-#define GIT_SHA1_BLKSZ 64
-
-/* The length in bytes and in hex digits of an object name (SHA-256 value). */
-#define GIT_SHA256_RAWSZ 32
-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
-/* The block size of SHA-256. */
-#define GIT_SHA256_BLKSZ 64
-
-/* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
-/* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-};
-
 #define the_hash_algo the_repository->hash_algo
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
@@ -143,16 +122,6 @@ struct cache_header {
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
 
-/*
- * The "cache_time" is just the low 32 bits of the
- * time. It doesn't matter if it overflows - we only
- * check it for equality in the 32 bits we save.
- */
-struct cache_time {
-	uint32_t sec;
-	uint32_t nsec;
-};
-
 struct stat_data {
 	struct cache_time sd_ctime;
 	struct cache_time sd_mtime;
@@ -326,32 +295,6 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define UNTRACKED_CHANGED	(1 << 7)
 #define FSMONITOR_CHANGED	(1 << 8)
 
-struct split_index;
-struct untracked_cache;
-
-struct index_state {
-	struct cache_entry **cache;
-	unsigned int version;
-	unsigned int cache_nr, cache_alloc, cache_changed;
-	struct string_list *resolve_undo;
-	struct cache_tree *cache_tree;
-	struct split_index *split_index;
-	struct cache_time timestamp;
-	unsigned name_hash_initialized : 1,
-		 initialized : 1,
-		 drop_cache_tree : 1,
-		 updated_workdir : 1,
-		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1;
-	struct hashmap name_hash;
-	struct hashmap dir_hash;
-	struct object_id oid;
-	struct untracked_cache *untracked;
-	uint64_t fsmonitor_last_update;
-	struct ewah_bitmap *fsmonitor_dirty;
-	struct mem_pool *ce_mem_pool;
-};
-
 /* Name hashing */
 int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
 void add_name_hash(struct index_state *istate, struct cache_entry *ce);
diff --git a/repository.h b/repository.h
index 4fb6a5885f..3371afceaa 100644
--- a/repository.h
+++ b/repository.h
@@ -1,11 +1,11 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "index.h"
 #include "path.h"
 
 struct config_set;
 struct git_hash_algo;
-struct index_state;
 struct lock_file;
 struct pathspec;
 struct raw_object_store;
@@ -87,7 +87,7 @@ struct repository {
 	 * Repository's in-memory index.
 	 * 'repo_read_index()' can be used to populate 'index'.
 	 */
-	struct index_state *index;
+	struct index_state index;
 
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
