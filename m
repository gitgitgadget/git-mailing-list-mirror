Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881C11F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbcFZEQK (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:16:10 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38976 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbcFZEOs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 00:14:48 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id EAAFE2B206A;
	Sat, 25 Jun 2016 21:14:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=aydta
	JIYsSU8veChXLNoYMysEKA=; b=aFnMxsxrdoadQ1wJm1kz32/1VnmGFcKfL32dQ
	c5oxEd6zwUjunUJkfO3b910XIZS2WVuANF+LA1AjBohRocfcDRqcp5wKrNHDsWaU
	ZStccBCNJ3Z7JfK3zCrPH/xMRV0zkgUqXuNuu8h4pwSvA9SxVW+o7Rwdm1biAgB8
	2ouSss=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 581282B205C;
	Sat, 25 Jun 2016 21:14:47 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 19/20] trace: measure where the time is spent in the index-heavy operations
Date:	Sun, 26 Jun 2016 00:14:23 -0400
Message-Id: <1466914464-10358-19-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
In-Reply-To: <1466914464-10358-1-git-send-email-novalis@novalis.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

All the known heavy code blocks are measured (except object database
access). This should help identify if an optimization is effective or
not. An unoptimized git-status would give something like below (92% of
time is accounted). To sum up the effort of making git scale better:

 - read cache line is being addressed by index-helper
 - preload/refresh index by watchman
 - read packed refs by lmdb backend
 - diff-index by rebuilding cache-tree
 - read directory by untracked cache and watchman
 - write index by split index
 - name hash potientially by index-helper

read-cache.c:2075         performance: 0.004058570 s: read cache .../index
preload-index.c:104       performance: 0.004419864 s: preload index
read-cache.c:1265         performance: 0.000185224 s: refresh index
refs/files-backend.c:1100 performance: 0.001935788 s: read packed refs
diff-lib.c:240            performance: 0.000144132 s: diff-files
diff-lib.c:506            performance: 0.013592000 s: diff-index
name-hash.c:128           performance: 0.000614177 s: initialize name hash
dir.c:2030                performance: 0.015814103 s: read directory
read-cache.c:2565         performance: 0.004052343 s: write index, changed mask = 2
trace.c:420               performance: 0.048365509 s: git command: './git' 'status'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c           |  4 ++++
 dir.c                |  2 ++
 name-hash.c          |  2 ++
 preload-index.c      |  2 ++
 read-cache.c         | 11 +++++++++++
 refs/files-backend.c |  2 ++
 6 files changed, 23 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index bc49c70..7af7f9a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -90,6 +90,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	uint64_t start = getnanotime();
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -236,6 +237,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-files");
 	return 0;
 }
 
@@ -491,6 +493,7 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
+	uint64_t start = getnanotime();
 
 	ent = revs->pending.objects;
 	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
@@ -500,6 +503,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	diffcore_fix_diff_index(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-index");
 	return 0;
 }
 
diff --git a/dir.c b/dir.c
index 850d4fb..024b13c 100644
--- a/dir.c
+++ b/dir.c
@@ -1991,6 +1991,7 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 {
 	struct path_simplify *simplify;
 	struct untracked_cache_dir *untracked;
+	uint64_t start = getnanotime();
 
 	/*
 	 * Check out create_simplify()
@@ -2026,6 +2027,7 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
+	trace_performance_since(start, "read directory %.*s", len, path);
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/name-hash.c b/name-hash.c
index 6d9f23e..b3966d8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -115,6 +115,7 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 static void lazy_init_name_hash(struct index_state *istate)
 {
 	int nr;
+	uint64_t start = getnanotime();
 
 	if (istate->name_hash_initialized)
 		return;
@@ -124,6 +125,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	for (nr = 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized = 1;
+	trace_performance_since(start, "initialize name hash");
 }
 
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
diff --git a/preload-index.c b/preload-index.c
index c1fe3a3..7bb4809 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -72,6 +72,7 @@ static void preload_index(struct index_state *index,
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
+	uint64_t start = getnanotime();
 
 	if (!core_preload_index)
 		return;
@@ -100,6 +101,7 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	trace_performance_since(start, "preload index");
 }
 #endif
 
diff --git a/read-cache.c b/read-cache.c
index fde778b..ee777c1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1189,6 +1189,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
+	uint64_t start = getnanotime();
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1273,6 +1274,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new);
 	}
+	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
 
@@ -2092,12 +2094,15 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	uint64_t start;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	start = getnanotime();
 	ret = do_read_index(istate, path, 0);
+	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
@@ -2112,6 +2117,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	split_index->base->keep_mmap = istate->keep_mmap;
 	split_index->base->to_shm    = istate->to_shm;
 	split_index->base->from_shm  = istate->from_shm;
+	start = getnanotime();
 	ret = do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -2123,6 +2129,9 @@ int read_index_from(struct index_state *istate, const char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	trace_performance_since(start, "read cache %s",
+				git_path("sharedindex.%s",
+					 sha1_to_hex(split_index->base_sha1)));
 
 done:
 	if (ret > 0 && istate->from_shm && istate->last_update)
@@ -2468,6 +2477,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int watchman = 0;
+	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2588,6 +2598,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 	return 0;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f8..57571ce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1048,6 +1048,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	struct ref_entry *last = NULL;
 	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
+	uint64_t start = getnanotime();
 
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
 		unsigned char sha1[20];
@@ -1096,6 +1097,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	}
 
 	strbuf_release(&line);
+	trace_performance_since(start, "read packed refs");
 }
 
 /*
-- 
1.9.1

