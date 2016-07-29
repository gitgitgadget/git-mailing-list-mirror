Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5896D1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbcG2QU2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:20:28 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35419 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcG2QUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:20:25 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so5429774pad.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:20:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l47U3SKoteKjM6txM5xxhjavO38INr4wy2P3BKS7WMY=;
        b=ZoMVHJ9kezlkviZp4OqqlwD6fUAinuTGCTGzrnRRIMr96OLPHrjkP/rHS1fNptqfYa
         hz3tlVxRsgOY5U5B3v4F7PmeiX9W5yIehV6CMFNKH+RwqmzJugdG5D/LaEK2TSvJOAQL
         0YKbHbHPJn48wkSX9RSCk19Lkf4tU1n36kYOKnml2DGqjoeHYSrT2xABW7tj1Ea2gyUw
         IPWJvGmlj+yeA7ulqycxTMxcKVL+qqK3oaoGmnz3YdH/HCoKlaFkEaFh5usxkvu9QODm
         nm8AMFBztV7yKD47laVMbTPtzpKQNNYdD8x1olgMrMwex1Lfb5POYHwnb2T3Ka9ZIOOM
         mbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l47U3SKoteKjM6txM5xxhjavO38INr4wy2P3BKS7WMY=;
        b=EUxinbS9MsNwDvmH5eAJjMOJ29MOfD7MBif/x3UecaVr2Hw49LRSpcjqgtDcFmf/H5
         JZ/RmxowUYebpdR9wxqVDiE7O5+HMckGLekHpZWrwwH396MxFTdOvrpUrituh59K4fXL
         2UK+8GY7O0aqmOkeHFRfYKTuy4a2gt+p/AJY9a8DMj2RUQIFjc6UOr5WharfZEYT4XLg
         vqQs/WRq2Qi9xjxWMDz9qE0iI9KW4jnravEGbxQo4+a9F+T9qxxwc39qTskLrO7rkrmo
         S3YwmebM988V6aMt1Gw5aCKKBRFXXnF6ie/NL53SNneMI/s0LCCCDndU2RBMah1e04gR
         4UIg==
X-Gm-Message-State: AEkooutPLM0HbZ/9A/odrtWJlDb5oBdXBcjwAUxq9g+nEaqsOdtMbzJjfujxqfUCL1C8oA==
X-Received: by 10.66.9.42 with SMTP id w10mr69773345paa.34.1469809224717;
        Fri, 29 Jul 2016 09:20:24 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010:1::5b0])
        by smtp.gmail.com with ESMTPSA id i69sm26193282pfk.30.2016.07.29.09.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:20:24 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kewillf@microsoft.com>,
	Kevin Willford <kcwillford@gmail.com>
Subject: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
Date:	Fri, 29 Jul 2016 12:19:20 -0400
Message-Id: <20160729161920.3792-5-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.42.gb7633a3
In-Reply-To: <20160729161920.3792-1-kcwillford@gmail.com>
References: <20160729161920.3792-1-kcwillford@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

The `rebase` family of Git commands avoid applying patches that were
already integrated upstream. They do that by using the revision walking
option that computes the patch IDs of the two sides of the rebase
(local-only patches vs upstream-only ones) and skipping those local
patches whose patch ID matches one of the upstream ones.

In many cases, this causes unnecessary churn, as already the set of
paths touched by a given commit would suffice to determine that an
upstream patch has no local equivalent.

This hurts performance in particular when there are a lot of upstream
patches, and/or large ones.

Therefore, let's introduce the concept of a "diff-header-only" patch ID,
compare those first, and only evaluate the "full" patch ID lazily.

Please note that in contrast to the "full" patch IDs, those
"diff-header-only" patch IDs are prone to collide with one another, as
adjacent commits frequently touch the very same files. Hence we now
have to be careful to allow multiple hash entries with the same hash.
We accomplish that by using the hashmap_add() function that does not even
test for hash collisions.  This also allows us to evaluate the full patch ID
lazily, i.e. only when we found commits with matching diff-header-only
patch IDs.

We add a performance test that demonstrates ~1-6% improvement.  In
practice this will depend on various factors such as how many upstream
changes and how big those changes are along with whether file system
caches are cold or warm.  As Git's test suite has no way of catching
performance regressions, we also add a regression test that verifies
that the full patch ID computation is skipped when the diff-header-only
computation suffices.

Signed-off-by: Kevin Willford <kcwillford@gmail.com>
---
 builtin/log.c                        |  2 +-
 patch-ids.c                          | 22 ++++++++++++++++------
 patch-ids.h                          |  2 +-
 t/perf/p3400-rebase.sh               | 36 ++++++++++++++++++++++++++++++++++++
 t/t6007-rev-list-cherry-pick-file.sh | 17 +++++++++++++++++
 5 files changed, 71 insertions(+), 8 deletions(-)
 create mode 100644 t/perf/p3400-rebase.sh

diff --git a/builtin/log.c b/builtin/log.c
index fd1652f..b076993 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1331,7 +1331,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		struct object_id *patch_id;
 		if (commit->util)
 			continue;
-		if (commit_patch_id(commit, &diffopt, sha1))
+		if (commit_patch_id(commit, &diffopt, sha1, 0))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
diff --git a/patch-ids.c b/patch-ids.c
index 69a14a3..0a4828a 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -5,7 +5,7 @@
 #include "patch-ids.h"
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1)
+		    unsigned char *sha1, int diff_header_only)
 {
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
@@ -13,13 +13,21 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1, 0);
+	return diff_flush_patch_id(options, sha1, diff_header_only);
 }
 
 static int patch_id_cmp(struct patch_id *a,
 			struct patch_id *b,
-			void *keydata)
+			struct diff_options *opt)
 {
+	if (is_null_sha1(a->patch_id) &&
+	    commit_patch_id(a->commit, opt, a->patch_id, 0))
+		return error("Could not get patch ID for %s",
+			oid_to_hex(&a->commit->object.oid));
+	if (is_null_sha1(b->patch_id) &&
+	    commit_patch_id(b->commit, opt, b->patch_id, 0))
+		return error("Could not get patch ID for %s",
+			oid_to_hex(&b->commit->object.oid));
 	return hashcmp(a->patch_id, b->patch_id);
 }
 
@@ -43,11 +51,13 @@ static int init_patch_id_entry(struct patch_id *patch,
 			       struct commit *commit,
 			       struct patch_ids *ids)
 {
+	unsigned char header_only_patch_id[GIT_SHA1_RAWSZ];
+
 	patch->commit = commit;
-	if (commit_patch_id(commit, &ids->diffopts, patch->patch_id))
+	if (commit_patch_id(commit, &ids->diffopts, header_only_patch_id, 1))
 		return -1;
 
-	hashmap_entry_init(patch, sha1hash(patch->patch_id));
+	hashmap_entry_init(patch, sha1hash(header_only_patch_id));
 	return 0;
 }
 
@@ -60,7 +70,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
 
-	return hashmap_get(&ids->patches, &patch, NULL);
+	return hashmap_get(&ids->patches, &patch, &ids->diffopts);
 }
 
 struct patch_id *add_commit_patch_id(struct commit *commit,
diff --git a/patch-ids.h b/patch-ids.h
index dea1ecd..0f34ea1 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -13,7 +13,7 @@ struct patch_ids {
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1);
+		    unsigned char *sha1, int);
 int init_patch_ids(struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
new file mode 100644
index 0000000..b3e7d52
--- /dev/null
+++ b/t/perf/p3400-rebase.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Tests rebase performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git checkout -f -b base &&
+	git checkout -b to-rebase &&
+	git checkout -b upstream &&
+	for i in $(seq 100)
+	do
+		# simulate huge diffs
+		echo change$i >unrelated-file$i &&
+		seq 1000 >>unrelated-file$i &&
+		git add unrelated-file$i &&
+		test_tick &&
+		git commit -m commit$i unrelated-file$i &&
+		echo change$i >unrelated-file$i &&
+		seq 1000 | tac >>unrelated-file$i &&
+		git add unrelated-file$i &&
+		test_tick &&
+		git commit -m commit$i-reverse unrelated-file$i ||
+		break
+	done &&
+	git checkout to-rebase &&
+	test_commit our-patch interesting-file
+'
+
+test_perf 'rebase on top of a lot of unrelated changes' '
+	git rebase --onto upstream HEAD^ &&
+	git rebase --onto base HEAD^
+'
+
+test_done
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 28d4f6b..fff3322 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -206,5 +206,22 @@ test_expect_success '--count --left-right' '
 	git rev-list --count --left-right C...D > actual &&
 	test_cmp expect actual
 '
+remove_loose_object () {
+	sha1="$(git rev-parse "$1")" &&
+	remainder=${sha1#??} &&
+	firsttwo=${sha1%$remainder} &&
+	rm .git/objects/$firsttwo/$remainder
+}
+test_expect_success '--cherry-pick avoids looking at full diffs' '
+	git checkout -b shy-diff &&
+	test_commit dont-look-at-me &&
+	echo Hello >dont-look-at-me.t &&
+	test_tick &&
+	git commit -m tip dont-look-at-me.t &&
+	git checkout -b mainline HEAD^ &&
+	test_commit to-cherry-pick &&
+	remove_loose_object shy-diff^:dont-look-at-me.t &&
+	git rev-list --cherry-pick ...shy-diff
+'
 
 test_done
-- 
2.9.2.gvfs.2.42.gb7633a3

