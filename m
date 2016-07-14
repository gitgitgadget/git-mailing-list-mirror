Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A1720196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcGNUTE (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:19:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35902 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcGNUTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:19:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so1015018pfg.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 13:19:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h1nmYJIOcplXmK3VU+C6U6Oq/24fGut4kXJpGrSpIV4=;
        b=kxXv0P3vtJjvdlMQGsMLwsFWu8Fo8vTg1ouANAGAOltL/3YQtR+kGwu29c23vWAkX8
         CO9Bqndi16HuZI0lPs+WuxrphWFevIVPUoUpCtKR1aHHoxWSAtQ1bdAIXMITyn1DQFe9
         CyVbQCNVnsXfdxzXPpaVv02G5F495FsUIRu20/u+ru1noA/kRf4ivlQmmXlBCnOxPod+
         oRb1YlKfqm2EbiW0cm3zzK900kkcMcUeEzBJOwuOD72kVCuy6SWlSBDN1cTBgR7jcp4R
         EqPCp9kC68guo4oh5hAluyzJyfEoNIA8LYwTPbrN3v0k1HBF3sYjUpmqGPdjPW+2rLZA
         O3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h1nmYJIOcplXmK3VU+C6U6Oq/24fGut4kXJpGrSpIV4=;
        b=VbrZMlHQqQaBSOABsQK/LCm+F0jzJeiXoX/aaesh9cLCmcz9ZMRGC/mzd9hjMq6l+z
         MhpJpe4txwuAUeOvAhyaqKgbFrsNSY7swyIZNQb0gY8YYGn6sgb25f1iFiQzNPjbYa0N
         RjKP9/0sJn+/Qb1PewgAoa2Y9VLp5VYaW0TU/LTmssdTR2HC3eVHmvpTsXSEjs5ZeIKk
         tuVrLEU8+MgJijHFVPG0gS2Sq09QvXQJDRJ0ITvzXE6iZmk1nz12CRtGvSiw3Jte4JAl
         QqiXhKCCTZRa98GeQvsaa1Ig3uW134cTQncrGYL6kGava9jgEBejkx/hyc/QQcfredSf
         Z8wg==
X-Gm-Message-State: ALyK8tJ7IbAtA/FM7oJSqRkkfBNn7DY5IeaQwcAADcpzF7CsNiPUc8xcaO4D4EcsLT5D9A==
X-Received: by 10.98.72.201 with SMTP id q70mr15505244pfi.159.1468527540957;
        Thu, 14 Jul 2016 13:19:00 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010::600])
        by smtp.gmail.com with ESMTPSA id vt10sm6711523pab.43.2016.07.14.13.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 13:18:59 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kcwillford@gmail.com>
Subject: [PATCH] Use path comparison for patch ids before the file content
Date:	Thu, 14 Jul 2016 16:17:58 -0400
Message-Id: <20160714201758.13180-1-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.0.windows.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When limiting the list in a revision walk using cherry pick, patch ids are
calculated by producing the diff of the content of the files.  This would
be more efficent by using a patch id looking at the paths that were
changed in the commits and only if all the file changed are the same fall
back to getting the content of the files in the commits to determine if
the commits are the same.

This change uses a hashmap to store entries with a hash of the patch id
calculated by just using the file paths.  The entries constist of the
commit and the patch id calculated using file contents which is initially
empty.  If there are commits that are found in the hashmap it means that
the same files were changed in the commits and the file contents need to
be checked in order to determine if the commits are truly the same.  The
patch id that is calcuated based on the file contents is then stored in the
hashmap entry if needed in later comparisons.  If the commits are determined to be
the same the cherry_flag is set on the commit being checked as well as the
commit in the hashmap entry saving running though the original list of
commits checking a seen flag.  This will speed up a rebase where the
upstream has many changes but none of them have been pulled into the
current branch.
---
 diff.c      |  16 +++++----
 diff.h      |   2 +-
 patch-ids.c | 114 +++++++++++++++++++++++++++++-------------------------------
 patch-ids.h |   7 ++--
 revision.c  |  19 ++--------
 5 files changed, 73 insertions(+), 85 deletions(-)

diff --git a/diff.c b/diff.c
index fa78fc1..f38b663 100644
--- a/diff.c
+++ b/diff.c
@@ -4449,7 +4449,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
+static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int use_path_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4484,9 +4484,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
-		if (fill_mmfile(&mf1, p->one) < 0 ||
-				fill_mmfile(&mf2, p->two) < 0)
-			return error("unable to read files to diff");
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
@@ -4521,6 +4518,13 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
 
+		if (use_path_only)
+			continue;
+
+		if (fill_mmfile(&mf1, p->one) < 0 ||
+			fill_mmfile(&mf2, p->two) < 0)
+			return error("unable to read files to diff");
+
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
 			git_SHA1_Update(&ctx, sha1_to_hex(p->one->sha1), 40);
@@ -4541,11 +4545,11 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
+int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1, int use_path_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1);
+	int result = diff_get_patch_id(options, sha1, use_path_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index 125447b..7883729 100644
--- a/diff.h
+++ b/diff.h
@@ -342,7 +342,7 @@ extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
+extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index a4d0016..f0262ce 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -4,8 +4,9 @@
 #include "sha1-lookup.h"
 #include "patch-ids.h"
 
-int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1)
+
+static int ll_commit_patch_id(struct commit *commit, struct diff_options *options,
+	unsigned char *sha1, int use_path_only)
 {
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
@@ -13,93 +14,90 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
-}
 
-static const unsigned char *patch_id_access(size_t index, void *table)
-{
-	struct patch_id **id_table = table;
-	return id_table[index]->patch_id;
+
+	return diff_flush_patch_id(options, sha1, use_path_only);
 }
 
-static int patch_pos(struct patch_id **table, int nr, const unsigned char *id)
+int commit_patch_id(struct commit *commit, struct diff_options *options,
+		    unsigned char *sha1)
 {
-	return sha1_pos(id, table, nr, patch_id_access);
+	return ll_commit_patch_id(commit, options, sha1, 0);
 }
 
-#define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
-struct patch_id_bucket {
-	struct patch_id_bucket *next;
-	int nr;
-	struct patch_id bucket[BUCKET_SIZE];
-};
-
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
+	hashmap_init(&ids->patches, NULL, 0);
 	return 0;
 }
 
 int free_patch_ids(struct patch_ids *ids)
 {
-	struct patch_id_bucket *next, *patches;
-
-	free(ids->table);
-	for (patches = ids->patches; patches; patches = next) {
-		next = patches->next;
-		free(patches);
-	}
+	hashmap_free(&ids->patches, 1);
 	return 0;
 }
 
-static struct patch_id *add_commit(struct commit *commit,
-				   struct patch_ids *ids,
-				   int no_add)
+struct patch_id *has_commit_patch_id(struct commit *commit,
+				     struct patch_ids *ids)
 {
-	struct patch_id_bucket *bucket;
-	struct patch_id *ent;
+	struct patch_id *entry;
 	unsigned char sha1[20];
-	int pos;
+	unsigned char sha1_2[20];
+	struct patch_id key;
 
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
+	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 1))
 		return NULL;
-	pos = patch_pos(ids->table, ids->nr, sha1);
-	if (0 <= pos)
-		return ids->table[pos];
-	if (no_add)
+
+	memset(&key, 0, sizeof(key));
+	hashmap_entry_init(&key, sha1hash(sha1));
+	key.commit = commit;
+
+	entry = hashmap_get(&ids->patches, &key, NULL);
+	if (!entry)
+		return NULL;
+
+	/*
+	 * Since we found a match in the hashmap that means the
+	 * same files where changed in this commit so we need to
+	 * get the patch id using the contents of the files to
+	 * compare with each of the commits in the hash bucket
+	 * to determine if the commits are truely the same
+	 */
+	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 0))
 		return NULL;
 
-	pos = -1 - pos;
+	for (; entry; entry = hashmap_get_next(&ids->patches, entry)) {
+		if (is_null_sha1(entry->patch_id))
+		{
+			if (ll_commit_patch_id(entry->commit, &ids->diffopts, sha1_2, 0))
+				return NULL;
+
+			hashcpy(entry->patch_id, sha1_2);
+		}
 
-	bucket = ids->patches;
-	if (!bucket || (BUCKET_SIZE <= bucket->nr)) {
-		bucket = xcalloc(1, sizeof(*bucket));
-		bucket->next = ids->patches;
-		ids->patches = bucket;
+		if (!hashcmp(entry->patch_id, sha1))
+			return entry;
 	}
-	ent = &bucket->bucket[bucket->nr++];
-	hashcpy(ent->patch_id, sha1);
-
-	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
-	if (pos < ids->nr)
-		memmove(ids->table + pos + 1, ids->table + pos,
-			sizeof(ent) * (ids->nr - pos));
-	ids->nr++;
-	ids->table[pos] = ent;
-	return ids->table[pos];
-}
 
-struct patch_id *has_commit_patch_id(struct commit *commit,
-				     struct patch_ids *ids)
-{
-	return add_commit(commit, ids, 1);
+	return NULL;
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	return add_commit(commit, ids, 0);
-}
+	unsigned char sha1[20];
+	if (ll_commit_patch_id(commit, &ids->diffopts, sha1, 1))
+		return NULL;
+
+	struct patch_id *key = xmalloc(sizeof(*key));
+	memset(key, 0, sizeof(*key));
+	hashmap_entry_init(key, sha1hash(sha1));
+	key->commit = commit;
+	hashmap_add(&ids->patches, key);
+
+	return key;
+}
\ No newline at end of file
diff --git a/patch-ids.h b/patch-ids.h
index eeb56b3..58e55ae 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -2,15 +2,14 @@
 #define PATCH_IDS_H
 
 struct patch_id {
+	struct hashmap_entry ent;
 	unsigned char patch_id[20];
-	char seen;
+	struct commit *commit;
 };
 
 struct patch_ids {
+	struct hashmap patches;
 	struct diff_options diffopts;
-	int nr, alloc;
-	struct patch_id **table;
-	struct patch_id_bucket *patches;
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
diff --git a/revision.c b/revision.c
index edba5b7..f715345 100644
--- a/revision.c
+++ b/revision.c
@@ -846,7 +846,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		 */
 		if (left_first != !!(flags & SYMMETRIC_LEFT))
 			continue;
-		commit->util = add_commit_patch_id(commit, &ids);
+		add_commit_patch_id(commit, &ids);
 	}
 
 	/* either cherry_mark or cherry_pick are true */
@@ -873,23 +873,10 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		id = has_commit_patch_id(commit, &ids);
 		if (!id)
 			continue;
-		id->seen = 1;
-		commit->object.flags |= cherry_flag;
-	}
-
-	/* Now check the original side for seen ones */
-	for (p = list; p; p = p->next) {
-		struct commit *commit = p->item;
-		struct patch_id *ent;
 
-		ent = commit->util;
-		if (!ent)
-			continue;
-		if (ent->seen)
-			commit->object.flags |= cherry_flag;
-		commit->util = NULL;
+		commit->object.flags |= cherry_flag;
+		id->commit->object.flags |= cherry_flag;
 	}
-
 	free_patch_ids(&ids);
 }
 
-- 
2.9.0.windows.1

