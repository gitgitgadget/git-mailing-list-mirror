Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D3920984
	for <e@80x24.org>; Tue, 13 Sep 2016 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbcIMO05 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 10:26:57 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33057 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755231AbcIMO04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 10:26:56 -0400
Received: by mail-qt0-f195.google.com with SMTP id p47so1393055qtc.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M9csByvgVhKWScnaiUWjbpbabyNygSLv8hirl022nuU=;
        b=pF1ptHCjseMO9cDDEPwSDFDeEiiVOEL7MgxMsDBB3x42ks9PfCUnBsr9pplfbdG66e
         P77KBpMqr046Ypbq2h3JiH1yjBOgB2zLaTNqjimJd1TR80Yir2MWSzwhrwL8sUCv/flo
         r2cEQC7DrUlnkv6FIQEHR/uMP7W+D6Uk8z9A4aTaLp/rDyMDShKMlUimEf411qsaH5hC
         XOnlp9t6vxuQAiygn62oh5yhU+izq9CbQmUs5x5TCuGsJJa4pt9MoO63NCikJbOdtR+3
         725EixHh0eH/RuDho+DyBVkC5gClZogSPytroEK+gTR5JRFelnotiQyUKMMsVXUOc89R
         +TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M9csByvgVhKWScnaiUWjbpbabyNygSLv8hirl022nuU=;
        b=Z4QpXdhRIzEoU5Nwuou/6y5uVTaRrCBPfQvrqWeH77Pk0QJIdmjOf47x5hEdqnL0TO
         331Z5NpCQC2tSvdr6SS7v0AMvStMojc1jR6UOK/X7dGG7+0OPQ/GZAdWPEx1LMXOcAen
         JjRjqvo1EZJO0DvvxcsX3HGOY7ztVXNXk7uh2oxG/1C0vcIcpAtUlJIhPey7BvfzY5uD
         k7hPOmpX09/j7SA1K/czYyyOmCPt/ktKhpa0UXsqgU35qdRXpHPGyzujdLGpgFu7QHpw
         QIdM1vgaLN0lHNEHvmT8/D77IYNPfNBpDhFaA69XFuACOR5VRfb/qMq5/71NM8NwLZtS
         +OsA==
X-Gm-Message-State: AE9vXwPu/ghPQ9iCC7+WotyJ/N5SZNOgzOQxc64GTv2c0gpmjyFkiCt4H8DwjSaM1B+r3w==
X-Received: by 10.200.34.81 with SMTP id p17mr1308806qtp.7.1473776815103;
        Tue, 13 Sep 2016 07:26:55 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j67sm13529048qkf.41.2016.09.13.07.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 07:26:53 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
Date:   Tue, 13 Sep 2016 10:26:28 -0400
Message-Id: <20160913142628.15440-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.10.0.windows.1.1.ga62c40a.dirty
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
 builtin/checkout.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..8b2f428 100644
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
@@ -460,11 +464,99 @@ static void setup_branch_path(struct branch_info *branch)
 	branch->path = strbuf_detach(&buf, NULL);
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
+	/*
+	 * Honor the explicit ignore requests
+	 */
+	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
+		opts->ignore_other_worktrees)
+		return 1;
+
+	/*
+	 * opts->show_progress only impacts output so doesn't require a merge
+	 */
+
+	/*
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
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old,
 			      struct branch_info *new,
 			      int *writeout_error)
 {
+	/*
+	 * Optimize the performance of "git checkout -b foo" by avoiding
+	 * the expensive merge, index and working directory updates if they
+	 * are not needed.
+	 */
+	if (!needs_working_tree_merge(opts, old, new))
+		return 0;
+
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-- 
2.10.0.windows.1

