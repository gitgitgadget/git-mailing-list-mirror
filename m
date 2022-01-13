Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE43C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 20:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiAMUcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiAMUcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 15:32:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A3C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 12:32:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h10so12284405wrb.1
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=+NDAx8HSogIZUloubWsAAHajoe2V1Xx9AQosOQAdkkc=;
        b=UXVsNpCcYtibVILKa6OffRhxtUdGkKFblr4QtKEGm6/ajRWHRYLta47Cj6XMjSRth2
         PmaJYOC55Yo7dTNy2yLPMdgKNK9QSmRaWuOMhvJS+hC5jeMokXs0c5XV5MwcHQCnobTb
         de3g8J5maCTu45Pox2DD/K8jal0jgeCHoYrGepUUIVwsXtOXNHQP935ZobberKdAuDhZ
         tqR/XTxsCBAT6vBVFgHGpO5wwFYwomfZm38F+vSTAvmXn0cH1qED/QcWI/4qeNELzSpK
         gXLEZh8+kcA6QfCR/7T4LnMED0r5tcVsb2JdO9XomWVZXJ4MMzg04ERImYMoIXkoG08E
         Jl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+NDAx8HSogIZUloubWsAAHajoe2V1Xx9AQosOQAdkkc=;
        b=Yo/Po8dRDP10CVa+eKg/BwLFFWpxEIg9X5Rvh+k9fjCPpamqngrmYbVg2OTb7IsP0I
         KCGgVhbzF2QJfOTzEHJPIigyjTFle3FkCtFDeifOzmOBxRQF+BHYRGGyx6bXwfxhjt0l
         HevoHzHA8qC1g006f7x8XBZZmLLmi8aS9QFPDtgq54kwGm3QKeqB0kaLcfDES/Cjl1RI
         tp+IDRu5Ej6B/oaLLMdUS8irWsF8MxNk+AHNnUph5iIO2+fZxjVkB/fsbcI9aLu10wdH
         gwXFiRC8nybRPh5UJMRYdnfPKXpNK2lOdIdFjqMzPhztl+eX+QVn0zINxHVbf8MXF32U
         JWTA==
X-Gm-Message-State: AOAM530o7YtOs/XqFwLYKLVmQvxsX78OFMZZxeIBZt0/4vgoQCtmIu4Y
        7jffZguIBcPzrCP6bitXpU3lB4lcVuA=
X-Google-Smtp-Source: ABdhPJz1MbMaDlFCgkC/6FeQz17XvyCksVlZHdLyn6oF4BSyN8hsJ8ODMPjgz2UVjdQ8ufCg2HS7kg==
X-Received: by 2002:a5d:46d2:: with SMTP id g18mr5399262wrs.701.1642105927256;
        Thu, 13 Jan 2022 12:32:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c125sm3391326wma.36.2022.01.13.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:32:06 -0800 (PST)
Message-Id: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 20:32:05 +0000
Subject: [PATCH] promisor-remote.c: use oidset for deduplication
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

swap out oid_array for oidset in promisor-remote.c since we get
a deduplicated set of oids to operate on.

swap our calls for oid_array for oidset in callers of
promisor_remote_get_direct().

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
    promisor-remote.c: use oidset for deduplication
    
    
    swap out oid_array for oidset in promisor-remote.c since we get a
    deduplicated set of oids to operate on. Any direct fetch we can save
    will be well worth it.
    
    oidset does use a slightly larger memory footprint than oid_array, so
    this change is a tradeoff between memory footprint and network calls.
    
    What I'm not sure about is if it's worth swapping out all the calls of
    oid_array for oidset in callers of promisor_remote_get_direct().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1187%2Fjohn-cai%2Fjc-dedupe-promisor-fetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1187/john-cai/jc-dedupe-promisor-fetch-v1
Pull-Request: https://github.com/git/git/pull/1187

 builtin/index-pack.c   |  9 +++---
 builtin/pack-objects.c |  9 +++---
 diff.c                 | 13 +++-----
 diffcore-rename.c      | 12 +++----
 diffcore.h             |  3 +-
 merge-ort.c            |  8 ++---
 object-file.c          |  4 ++-
 promisor-remote.c      | 72 ++++++++++++++----------------------------
 promisor-remote.h      |  6 ++--
 read-cache.c           |  9 +++---
 10 files changed, 57 insertions(+), 88 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..7de2eb42794 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1387,18 +1387,17 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		/*
 		 * Prefetch the delta bases.
 		 */
-		struct oid_array to_fetch = OID_ARRAY_INIT;
+		struct oidset to_fetch = OIDSET_INIT;
 		for (i = 0; i < nr_ref_deltas; i++) {
 			struct ref_delta_entry *d = sorted_by_pos[i];
 			if (!oid_object_info_extended(the_repository, &d->oid,
 						      NULL,
 						      OBJECT_INFO_FOR_PREFETCH))
 				continue;
-			oid_array_append(&to_fetch, &d->oid);
+			oidset_insert(&to_fetch, &d->oid);
 		}
-		promisor_remote_get_direct(the_repository,
-					   to_fetch.oid, to_fetch.nr);
-		oid_array_clear(&to_fetch);
+		promisor_remote_get_direct(the_repository, &to_fetch);
+		oidset_clear(&to_fetch);
 	}
 
 	for (i = 0; i < nr_ref_deltas; i++) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..4cef3bd78b2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1894,7 +1894,7 @@ static int can_reuse_delta(const struct object_id *base_oid,
 }
 
 static void prefetch_to_pack(uint32_t object_index_start) {
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 	uint32_t i;
 
 	for (i = object_index_start; i < to_pack.nr_objects; i++) {
@@ -1905,11 +1905,10 @@ static void prefetch_to_pack(uint32_t object_index_start) {
 					      NULL,
 					      OBJECT_INFO_FOR_PREFETCH))
 			continue;
-		oid_array_append(&to_fetch, &entry->idx.oid);
+		oidset_insert(&to_fetch, &entry->idx.oid);
 	}
-	promisor_remote_get_direct(the_repository,
-				   to_fetch.oid, to_fetch.nr);
-	oid_array_clear(&to_fetch);
+	promisor_remote_get_direct(the_repository, &to_fetch);
+	oidset_clear(&to_fetch);
 }
 
 static void check_object(struct object_entry *entry, uint32_t object_index)
diff --git a/diff.c b/diff.c
index c862771a589..e48a5c7bfcc 100644
--- a/diff.c
+++ b/diff.c
@@ -6609,14 +6609,14 @@ void diffcore_fix_diff_index(void)
 }
 
 void diff_add_if_missing(struct repository *r,
-			 struct oid_array *to_fetch,
+			 struct oidset *to_fetch,
 			 const struct diff_filespec *filespec)
 {
 	if (filespec && filespec->oid_valid &&
 	    !S_ISGITLINK(filespec->mode) &&
 	    oid_object_info_extended(r, &filespec->oid, NULL,
 				     OBJECT_INFO_FOR_PREFETCH))
-		oid_array_append(to_fetch, &filespec->oid);
+		oidset_insert(to_fetch, &filespec->oid);
 }
 
 void diff_queued_diff_prefetch(void *repository)
@@ -6624,7 +6624,7 @@ void diff_queued_diff_prefetch(void *repository)
 	struct repository *repo = repository;
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -6632,12 +6632,9 @@ void diff_queued_diff_prefetch(void *repository)
 		diff_add_if_missing(repo, &to_fetch, p->two);
 	}
 
-	/*
-	 * NEEDSWORK: Consider deduplicating the OIDs sent.
-	 */
-	promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
+	promisor_remote_get_direct(repo, &to_fetch);
 
-	oid_array_clear(&to_fetch);
+	oidset_clear(&to_fetch);
 }
 
 void diffcore_std(struct diff_options *options)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bebd4ed6a42..2fe89ef01b8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -95,7 +95,7 @@ static void inexact_prefetch(void *prefetch_options)
 {
 	struct inexact_prefetch_options *options = prefetch_options;
 	int i;
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 
 	for (i = 0; i < rename_dst_nr; i++) {
 		if (rename_dst[i].p->renamed_pair)
@@ -118,8 +118,8 @@ static void inexact_prefetch(void *prefetch_options)
 		diff_add_if_missing(options->repo, &to_fetch,
 				    rename_src[i].p->one);
 	}
-	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
-	oid_array_clear(&to_fetch);
+	promisor_remote_get_direct(options->repo, &to_fetch);
+	oidset_clear(&to_fetch);
 }
 
 static int estimate_similarity(struct repository *r,
@@ -837,7 +837,7 @@ static void basename_prefetch(void *prefetch_options)
 	struct strintmap *dests = options->dests;
 	struct dir_rename_info *info = options->info;
 	int i;
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 
 	/*
 	 * TODO: The following loops mirror the code/logic from
@@ -890,8 +890,8 @@ static void basename_prefetch(void *prefetch_options)
 		}
 	}
 
-	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
-	oid_array_clear(&to_fetch);
+	promisor_remote_get_direct(options->repo, &to_fetch);
+	oidset_clear(&to_fetch);
 }
 
 static int find_basename_matches(struct diff_options *options,
diff --git a/diffcore.h b/diffcore.h
index badc2261c20..9f593e01165 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -11,6 +11,7 @@ struct repository;
 struct strintmap;
 struct strmap;
 struct userdiff_driver;
+struct oidset;
 
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
@@ -229,7 +230,7 @@ int diffcore_count_changes(struct repository *r,
  * repository, add that OID to to_fetch.
  */
 void diff_add_if_missing(struct repository *r,
-			 struct oid_array *to_fetch,
+			 struct oidset *to_fetch,
 			 const struct diff_filespec *filespec);
 
 #endif
diff --git a/merge-ort.c b/merge-ort.c
index c3197970219..107c086bb6a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3903,7 +3903,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 					struct string_list *plist)
 {
 	struct string_list_item *e;
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 
 	if (opt->repo != the_repository || !has_promisor_remote())
 		return;
@@ -3939,12 +3939,12 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 			    S_ISREG(vi->mode) &&
 			    oid_object_info_extended(opt->repo, &vi->oid, NULL,
 						     OBJECT_INFO_FOR_PREFETCH))
-				oid_array_append(&to_fetch, &vi->oid);
+				oidset_insert(&to_fetch, &vi->oid);
 		}
 	}
 
-	promisor_remote_get_direct(opt->repo, to_fetch.oid, to_fetch.nr);
-	oid_array_clear(&to_fetch);
+	promisor_remote_get_direct(opt->repo, &to_fetch);
+	oidset_clear(&to_fetch);
 }
 
 static void process_entries(struct merge_options *opt,
diff --git a/object-file.c b/object-file.c
index 8be57f48de7..baec8f099de 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1519,6 +1519,7 @@ static int do_oid_object_info_extended(struct repository *r,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	struct oidset to_fetch = OIDSET_INIT;
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
@@ -1587,7 +1588,8 @@ static int do_oid_object_info_extended(struct repository *r,
 			 * TODO Investigate checking promisor_remote_get_direct()
 			 * TODO return value and stopping on error here.
 			 */
-			promisor_remote_get_direct(r, real, 1);
+			oidset_insert(&to_fetch, real);
+			promisor_remote_get_direct(r, &to_fetch);
 			already_retried = 1;
 			continue;
 		}
diff --git a/promisor-remote.c b/promisor-remote.c
index db2ebdc66ef..00166269f60 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -12,12 +12,13 @@ struct promisor_remote_config {
 
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
-			 const struct object_id *oids,
-			 int oid_nr)
+			 struct oidset *oids)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	int i;
 	FILE *child_in;
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	oidset_iter_init(oids, &iter);
 
 	child.git_cmd = 1;
 	child.in = -1;
@@ -31,10 +32,10 @@ static int fetch_objects(struct repository *repo,
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
 
-	trace2_data_intmax("promisor", repo, "fetch_count", oid_nr);
+	trace2_data_intmax("promisor", repo, "fetch_count", oidset_size(oids));
 
-	for (i = 0; i < oid_nr; i++) {
-		if (fputs(oid_to_hex(&oids[i]), child_in) < 0)
+	while((oid = oidset_iter_next(&iter))) {
+		if (fputs(oid_to_hex(oid), child_in) < 0)
 			die_errno(_("promisor-remote: could not write to fetch subprocess"));
 		if (fputc('\n', child_in) < 0)
 			die_errno(_("promisor-remote: could not write to fetch subprocess"));
@@ -198,70 +199,43 @@ int repo_has_promisor_remote(struct repository *r)
 	return !!repo_promisor_remote_find(r, NULL);
 }
 
-static int remove_fetched_oids(struct repository *repo,
-			       struct object_id **oids,
-			       int oid_nr, int to_free)
+static void remove_fetched_oids(struct repository *repo,
+			       struct oidset *oids)
 {
-	int i, remaining_nr = 0;
-	int *remaining = xcalloc(oid_nr, sizeof(*remaining));
-	struct object_id *old_oids = *oids;
-	struct object_id *new_oids;
-
-	for (i = 0; i < oid_nr; i++)
-		if (oid_object_info_extended(repo, &old_oids[i], NULL,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			remaining[i] = 1;
-			remaining_nr++;
-		}
-
-	if (remaining_nr) {
-		int j = 0;
-		CALLOC_ARRAY(new_oids, remaining_nr);
-		for (i = 0; i < oid_nr; i++)
-			if (remaining[i])
-				oidcpy(&new_oids[j++], &old_oids[i]);
-		*oids = new_oids;
-		if (to_free)
-			free(old_oids);
-	}
+	struct oidset_iter iter;
+	const struct object_id *oid;
 
-	free(remaining);
+	oidset_iter_init(oids, &iter);
 
-	return remaining_nr;
+	while((oid = oidset_iter_next(&iter)))
+		if (oid_object_info_extended(repo, oid, NULL,
+					     OBJECT_INFO_SKIP_FETCH_OBJECT)){
+			oidset_remove(oids, oid);
+		}
 }
 
 int promisor_remote_get_direct(struct repository *repo,
-			       const struct object_id *oids,
-			       int oid_nr)
+				       struct oidset *oids)
 {
 	struct promisor_remote *r;
-	struct object_id *remaining_oids = (struct object_id *)oids;
-	int remaining_nr = oid_nr;
-	int to_free = 0;
 	int res = -1;
 
-	if (oid_nr == 0)
+	if (oidset_size(oids) == 0)
 		return 0;
 
 	promisor_remote_init(repo);
 
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
-			if (remaining_nr == 1)
+		if (fetch_objects(repo, r->name, oids) < 0) {
+			if (oidset_size(oids) == 1)
 				continue;
-			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
-							 remaining_nr, to_free);
-			if (remaining_nr) {
-				to_free = 1;
+			remove_fetched_oids(repo, oids);
+			if (oidset_size(oids))
 				continue;
-			}
 		}
 		res = 0;
 		break;
 	}
 
-	if (to_free)
-		free(remaining_oids);
-
 	return res;
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index edc45ab0f5f..c90837d3592 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -3,8 +3,7 @@
 
 #include "repository.h"
 
-struct object_id;
-
+struct oidset;
 /*
  * Promisor remote linked list
  *
@@ -45,7 +44,6 @@ static inline int has_promisor_remote(void)
  * If oid_nr is 0, this function returns 0 (success) immediately.
  */
 int promisor_remote_get_direct(struct repository *repo,
-			       const struct object_id *oids,
-			       int oid_nr);
+			       struct oidset *oids);
 
 #endif /* PROMISOR_REMOTE_H */
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..b78801b1f20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3732,7 +3732,7 @@ void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch)
 {
 	int i;
-	struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct oidset to_fetch = OIDSET_INIT;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -3743,9 +3743,8 @@ void prefetch_cache_entries(const struct index_state *istate,
 					      NULL,
 					      OBJECT_INFO_FOR_PREFETCH))
 			continue;
-		oid_array_append(&to_fetch, &ce->oid);
+		oidset_insert(&to_fetch, &ce->oid);
 	}
-	promisor_remote_get_direct(the_repository,
-				   to_fetch.oid, to_fetch.nr);
-	oid_array_clear(&to_fetch);
+	promisor_remote_get_direct(the_repository, &to_fetch);
+	oidset_clear(&to_fetch);
 }

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
