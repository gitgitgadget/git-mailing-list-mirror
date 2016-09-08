Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5611F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbcIHUo7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:44:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35919 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbcIHUo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:44:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id s71so3698235oih.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7rs8kyWJRaM1TJiyYXKAjVAsalhN1mRZ9XflD3ZqFac=;
        b=tEeVeQqyf8lgDv916aou6Bvc5ExpdfEF/OQSzLSA0kJ2VKmIIHJEjm+wAj7/+wC+I1
         C92y8lQnZ6Sx8bSa2BgL2a0ftUs/T8zUa33MmXfqvvEgDgWVH8rS3i3e1uJCrVglnHKP
         a+2Icl/pUBNgUbk0uY6hVSuf597fixexcsAGMXHcdVxNZIVHrYr0UrKJhxnSgW48apS9
         eiRLLW0bd+ufRo64yPM++AtLnm/OS+TtZOnIDQNik1s8pEP7CfbSJCj7XRilSj5WbBzh
         s5sd4a6Ym09CB1PghSGq7J77iG4UpOTRwYDV9wZaGnzAaZ7zJuOCtuh7yrRm2D/PwOUh
         FRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7rs8kyWJRaM1TJiyYXKAjVAsalhN1mRZ9XflD3ZqFac=;
        b=L7vPU69BFu/gjC6OSk87OG8UgZ5tf7dvz8ZqsQBuHKeTKNRrmA38D40Pui5kL9i+1Q
         11uiPjjs9WUrVMu03vo2E81++LbL3B7rIN9Oz3eBVrGIUduiVODGIHKi7h64mjaLj4mF
         YmOcXG1vTv+iusYqe4WEj/xQit16Yz9qB3rbFOCMRq7NRrzC1g39zUsj6UdpXEfnFUqD
         43nsWBTz1b6YVQmQ72YX/Qgr8n+XtMN7UOgm6ZT6bXVrzOEJZUP8l5lK5UoULRjLQA5n
         S36g4blyh9JlfVgRdQNOgRCh01OCpT4dce6viMt/tzCcAv9A0fAUKNyzhGJ9egxpKZtK
         ZY0A==
X-Gm-Message-State: AE9vXwOpQPvk1HYXLeAStHd+S/r+nMZpHfrkhMNXBb7nTutTr/kTcHITwUTVOP6R5SF93w==
X-Received: by 10.202.87.2 with SMTP id l2mr2271940oib.112.1473367498077;
        Thu, 08 Sep 2016 13:44:58 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id r200sm205794itc.13.2016.09.08.13.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 13:44:57 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, =peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH] checkout: eliminate unnecessary merge for trivial checkout
Date:   Thu,  8 Sep 2016 16:44:31 -0400
Message-Id: <20160908204431.14612-1-benpeart@microsoft.com>
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
 builtin/checkout.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..595d64b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -827,10 +827,25 @@ static int switch_branches(const struct checkout_opts *opts,
 		parse_commit_or_die(new->commit);
 	}
 
-	ret = merge_working_tree(opts, &old, new, &writeout_error);
-	if (ret) {
-		free(path_to_free);
-		return ret;
+	/*
+	 * Optimize the performance of checkout when the current and
+	 * new branch have the same OID and avoid the trivial merge.
+	 * For example, a "git checkout -b foo" just needs to create
+	 * the new ref and report the stats.
+	 */
+	if (!old.commit || !new->commit
+		|| oidcmp(&old.commit->object.oid, &new->commit->object.oid)
+		|| !opts->new_branch || opts->new_branch_force || opts->new_orphan_branch
+		|| opts->patch_mode || opts->merge || opts->force || opts->force_detach
+		|| opts->writeout_stage || !opts->overwrite_ignore
+		|| opts->ignore_skipworktree || opts->ignore_other_worktrees
+		|| opts->new_branch_log || opts->branch_exists || opts->prefix
+		|| opts->source_tree) {
+		ret = merge_working_tree(opts, &old, new, &writeout_error);
+		if (ret) {
+			free(path_to_free);
+			return ret;
+		}
 	}
 
 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-- 
2.10.0.windows.1

