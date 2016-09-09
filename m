Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A751F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbcIITZp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:25:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34396 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754700AbcIITZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:25:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id a144so3582202oii.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pJWcl4M6x776e/Pi0GaeI+H88Y2KsmdSW5ryYzj7QuA=;
        b=jQ2W0AvJLiMz2QOgSt0QBNkvjRh0XZml88FYNemNe3HOvqDT/BDD7smWc5/taPmEK7
         OLQs/JlmpxTKMQkRJG2iEFNQWMkLDSt85bv96tIhwRWcHMPosjosNarr1NYR1oixn8kt
         HaAvDZ54saXWH/+3u5td5dQjYXKdqz99aVbOjP1va/q7YpQNmsfc8ENVquDa5w6j77Ab
         lYDi3a5H5GT6coUvbIrbTO1Vmf2ZgIgeyQ9Nd/7A13FYheZwyGltHpcDRUycwtxfkAyC
         D5mWfCg/+l0Q9HHf6+dyaTB1tPoREZfbFxFPdWPIXwg5Sv5jpIhyT9PUVtl/KpXNgvGu
         s9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pJWcl4M6x776e/Pi0GaeI+H88Y2KsmdSW5ryYzj7QuA=;
        b=mgajF9pebPlPZj3/ntgmJAKqSCGz/g50i6c0XoGZnu5gELpK9CFgn1mdgQZ/3mepni
         ZRrmvYxx/g1h6Z/VwmW/plW7FJUhGJ5R/nlOIEWHlNfykksxocepELMniyXh8TjxQgkE
         3Rjqbeb8x0s4dBNLuzfqIFf1bx5d6P+vEHK1Qr/fD8ZMJ+K9YhybBLwhyx+CEg6tHLW9
         +VOogtMBsDAIrmszJAZKDymTfsSBSyyJ8/PrJYMm+1SFyohuDKb6FJvJYZ2B/94w9ug0
         mjPvKL/dIjfgSbOsasAGlYjsdlaMqFt+1/l07lx1o8scWi1k1lyF4vzlas3Z7xoAt8J9
         FPZA==
X-Gm-Message-State: AE9vXwMbH8SjOe9C80e53Q/CHakgrVBU4mKvHbH8QM9uM0c9kAOgbXEf8dpmcGHvdrlxhg==
X-Received: by 10.202.221.198 with SMTP id u189mr7455038oig.149.1473449140934;
        Fri, 09 Sep 2016 12:25:40 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m205sm2169090itg.8.2016.09.09.12.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 12:25:39 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v2] checkout: eliminate unnecessary merge for trivial checkout
Date:   Fri,  9 Sep 2016 15:25:20 -0400
Message-Id: <20160909192520.4812-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.10.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git to avoid unnecessary merge during trivial checkout.  When
running 'git checkout -b foo' git follows a common code path through
the expensive merge_working_tree even when it is unnecessary.  As a
result, 95% of the time is spent in merge_working_tree doing the 2-way
merge between the new and old commit trees that is unneeded.

The time breakdown is as follows:

    merge_working_tree <-- 95%
        unpack_trees <-- 80%
            traverse_trees <-- 50%
            cache_tree_update <-- 17%
            mark_new_skip_worktree <-- 10%

With a large repo, this cost is pronounced.  Using "git checkout -b r"
to create and switch to a new branch costs 166 seconds (all times worst
case with a cold file system cache).

git.c:406               trace: built-in: git 'checkout' '-b' 'r'
read-cache.c:1667       performance: 17.442926555 s: read_index_from
name-hash.c:128         performance: 2.912145231 s: lazy_init_name_hash
read-cache.c:2208       performance: 4.387713335 s: write_locked_index
trace.c:420             performance: 166.458921289 s: git command:
                                        'c:\Users\benpeart\bin\git.exe' 'checkout' '-b' 'r'
Switched to a new branch 'r'

By adding a test to skip the unnecessary call to merge_working_tree in
this case reduces the cost to 16 seconds.

git.c:406               trace: built-in: git 'checkout' '-b' 's'
read-cache.c:1667       performance: 16.100742476 s: read_index_from
trace.c:420             performance: 16.461547867 s: git command: 'c:\Users\benpeart\bin\git.exe' 'checkout' '-b' 's'
Switched to a new branch 's'

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/checkout.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..4396cb3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -38,6 +38,10 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	/*
+	 * If new checkout options are added, needs_working_tree_merge
+	 * should be updated accordingly.
+	 */
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -802,6 +806,87 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	free(refs.objects);
 }
 
+static int needs_working_tree_merge(const struct checkout_opts *opts,
+	const struct branch_info *old,
+	const struct branch_info *new)
+{
+	/*
+	 * We must do the merge if we are actually moving to a new
+	 * commit tree.
+	 */
+	if (!old->commit || !new->commit ||
+		oidcmp(&old->commit->tree->object.oid, &new->commit->tree->object.oid))
+		return 1;
+
+	/*
+	 * opts->patch_mode cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	/*
+	 * opts->quiet only impacts output so doesn't require a merge
+	 */
+
+	/*
+	 * Honor the explicit request for a three-way merge or to throw away
+	 * local changes
+	 */
+	if (opts->merge || opts->force)
+		return 1;
+
+	/*
+	 * Checking out the requested commit may require updating the working
+	 * directory and index, let the merge handle it.
+	 */
+	if (opts->force_detach)
+		return 1;
+
+	/*
+	 * opts->writeout_stage cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	 /*
+	  * Honor the explicit ignore requests
+	  */
+	if (!opts->overwrite_ignore || opts->ignore_skipworktree
+		|| opts->ignore_other_worktrees)
+		return 1;
+
+	 /*
+	  * opts->show_progress only impacts output so doesn't require a merge
+	  */
+
+	 /*
+	 * If we're not creating a new branch, by definition we're changing
+	 * the existing one so need to do the merge
+	 */
+	if (!opts->new_branch)
+		return 1;
+
+	/*
+	 * new_branch_force is defined to "create/reset and checkout a branch"
+	 * so needs to go through the merge to do the reset
+	 */
+	if (opts->new_branch_force)
+		return 1;
+
+	/*
+	 * A new orphaned branch requrires the index and the working tree to be
+	 * adjusted to <start_point>
+	 */
+	if (opts->new_orphan_branch)
+		return 1;
+
+	/*
+	 * Remaining variables are not checkout options but used to track state
+	 * that doesn't trigger the need for a merge.
+	 */
+
+	return 0;
+}
+
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new)
 {
@@ -827,10 +912,16 @@ static int switch_branches(const struct checkout_opts *opts,
 		parse_commit_or_die(new->commit);
 	}
 
-	ret = merge_working_tree(opts, &old, new, &writeout_error);
-	if (ret) {
-		free(path_to_free);
-		return ret;
+	/*
+	 * Optimize the performance of "git checkout foo" by skipping the call
+	 * to merge_working_tree where possible.
+	 */
+	if (needs_working_tree_merge(opts, &old, new)) {
+		ret = merge_working_tree(opts, &old, new, &writeout_error);
+		if (ret) {
+			free(path_to_free);
+			return ret;
+		}
 	}
 
 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-- 
2.10.0.windows.1

