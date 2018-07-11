Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4339D1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 05:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeGKFVL (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 01:21:11 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46754 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeGKFVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 01:21:11 -0400
Received: by mail-yw0-f194.google.com with SMTP id e23-v6so8202232ywe.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 22:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPf2NhNQq1xRko0cJR7YFJtAunZ0eR66x0x1k/MoqM4=;
        b=sKtk3eFxvjxBJSnl5QuqpFSmtt8V5EDK4+HEr41KCQBQtNrCIUDSRoXg+8G/Lu61EU
         rxjdHhNtq5zj7vJPBwokvDyTxHCuEZNSqpRNoF1orJAkEl6QyaGtNa5DhcqtYnrVLslI
         pevY1AwKdDDhfUN8YB15sE5/wS3/iaUNm3CTbm900yuMppJag3mpJlUnlAqlTYsLWc4i
         lIcKrdWgJFBZGiKH9fSSrJCPLNSNu69BBEEJIrbjGTasU038uP56QXVX9d8bwCF6adXP
         4ErmJOZAsflBL73cct316Z/jM/QRW2coyPftEO1ikHZobSby2xMS3vYuo75zPzDQXGgI
         nOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPf2NhNQq1xRko0cJR7YFJtAunZ0eR66x0x1k/MoqM4=;
        b=QoyoN/jbtgLBjQEViKMc0nDw1UdQc7zMC0+5b6vVWEY+eq5rck4th1ciI8H9XVis4R
         rX6GblkYNFSiQ37aoFOblLfIey9mrOHk6fBlrSKF56QOBPodnw2UkBs9F5QZNBJCGvym
         URi17Idc6PgxvSuZHu8pZ5xIl5AAzmncGGFqevn5Ng1uDVxoo3voMCc947V32U0QziUQ
         y1UwK24ygiZhVoqq41zdjnKtlx4Mc23RpFpE3G3JNheRF/NquHPvMGmMEVLncf+3KzRG
         mHE2Ktq74DK4ZxbU30ICS9FE58enH/+HAj6vUk/HGSxUqfP4YHdjoBKpVEVQvR8BMDBx
         1+Bg==
X-Gm-Message-State: APt69E0BOqGumN+xrYvEFT9IFSOOj2J5kYb6Du4gjl1Zpk3YZs+kDJ/x
        zKqi0Vh1RozpJ1Aff42ITGsEJw==
X-Google-Smtp-Source: AAOMgpdz+oUG56sTV80B9f8nK4lyyOFl/8AQGWRQmnfPZAVNqhy3HvyKT8J9hsSlLrE1Uy3mSdS8SQ==
X-Received: by 2002:a81:6006:: with SMTP id u6-v6mr13478613ywb.225.1531286321818;
        Tue, 10 Jul 2018 22:18:41 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x185-v6sm7561851ywb.69.2018.07.10.22.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:18:41 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] read-cache: fix directory/file conflict handling in read_index_unmerged()
Date:   Tue, 10 Jul 2018 22:18:34 -0700
Message-Id: <20180711051834.28181-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180711051834.28181-1-newren@gmail.com>
References: <20180711051834.28181-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_index_unmerged() has two intended purposes:
  * return 1 if there are any unmerged entries, 0 otherwise
  * drops any higher-stage entries down to stage #0

There are several callers of read_index_unmerged() that check the return
value to see if it is non-zero, all of which then die() if that condition
is met.  For these callers, dropping higher-stage entries down to stage #0
is a waste of resources, and returning immediately on first unmerged entry
would be better.  But it's probably only a very minor difference and isn't
the focus of this series.

The remaining callers ignore the return value and call this function for
the side effect of dropping higher-stage entries down to stage #0.  As
mentioned in commit e11d7b596970 ("'reset --merge': fix unmerged case",
2009-12-31),

    The _only_ reason we want to keep a previously unmerged entry in the
    index at stage #0 is so that we don't forget the fact that we have
    corresponding file in the work tree in order to be able to remove it
    when the tree we are resetting to does not have the path.

In fact, prior to commit d1a43f2aa4bf ("reset --hard/read-tree --reset -u:
remove unmerged new paths", 2008-10-15), read_index_unmerged() did just
remove unmerged entries from the cache immediately but that had the
unwanted effect of leaving around new untracked files in the tree from
aborted merges.

So, that's the intended purpose of this function.  The problem is that
when directory/files conflicts are present, trying to add the file to the
index at stage 0 fails (because there is still a directory in the way),
and the function returns early with a -1 return code to signify the error.
As noted above, none of the callers who want the drop-to-stage-0 behavior
check the return status, though, so this means all remaining unmerged
entries remain in the index and the callers proceed assuming otherwise.
Users then see errors of the form:

    error: 'DIR-OR-FILE' appears as both a file and as a directory
    error: DIR-OR-FILE: cannot drop to stage #0

and potentially also messages about other unmerged entries which came
lexicographically later than whatever pathname was both a file and a
directory.  Google finds a few hits searching for those messages,
suggesting there were probably a couple people who hit this besides me.
Luckily, calling `git reset --hard` multiple times would workaround
this bug.

Since the whole purpose here is to just put the entry *temporarily* into
the index so that any associated file in the working copy can be removed,
we can just skip the DFCHECK and allow both the file and directory to
appear in the index.  The temporary simultaneous appearance of the
directory and file entries in the index will be removed by the callers
before they attempt to write the index anywhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 read-cache.c                         | 13 ++++++++-----
 t/t1015-read-index-unmerged.sh       |  8 ++++----
 t/t6020-merge-df.sh                  |  3 ---
 t/t6042-merge-rename-corner-cases.sh |  1 -
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 372588260..666d295a5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2632,10 +2632,13 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 
 /*
  * Read the index file that is potentially unmerged into given
- * index_state, dropping any unmerged entries.  Returns true if
- * the index is unmerged.  Callers who want to refuse to work
- * from an unmerged state can call this and check its return value,
- * instead of calling read_cache().
+ * index_state, dropping any unmerged entries to stage #0 (potentially
+ * resulting in a path appearing as both a file and a directory in the
+ * index; the caller is responsible to clear out the extra entries
+ * before writing the index to a tree).  Returns true if the index is
+ * unmerged.  Callers who want to refuse to work from an unmerged
+ * state can call this and check its return value, instead of calling
+ * read_cache().
  */
 int read_index_unmerged(struct index_state *istate)
 {
@@ -2658,7 +2661,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce->ce_flags = create_ce_flags(0) | CE_CONFLICTED;
 		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
-		if (add_index_entry(istate, new_ce, 0))
+		if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
 			return error("%s: cannot drop to stage #0",
 				     new_ce->name);
 	}
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index bbd64587c..5034ed931 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
 	)
 '
 
-test_expect_failure 'read-tree --reset cleans unmerged entries' '
+test_expect_success 'read-tree --reset cleans unmerged entries' '
 	test_when_finished "git -C df_plus_modify_delete clean -f" &&
 	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
 	(
@@ -45,7 +45,7 @@ test_expect_failure 'read-tree --reset cleans unmerged entries' '
 	)
 '
 
-test_expect_failure 'One reset --hard cleans unmerged entries' '
+test_expect_success 'One reset --hard cleans unmerged entries' '
 	test_when_finished "git -C df_plus_modify_delete clean -f" &&
 	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
 	(
@@ -87,7 +87,7 @@ test_expect_success 'setup directory/file conflict + simple edit/edit' '
 	)
 '
 
-test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
+test_expect_success 'git merge --abort succeeds despite D/F conflict' '
 	test_when_finished "git -C df_plus_edit_edit clean -f" &&
 	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
 	(
@@ -103,7 +103,7 @@ test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
 	)
 '
 
-test_expect_failure 'git am --skip succeeds despite D/F conflict' '
+test_expect_success 'git am --skip succeeds despite D/F conflict' '
 	test_when_finished "git -C df_plus_edit_edit clean -f" &&
 	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
 	(
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 2af1beec5..46b506b3b 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -89,9 +89,6 @@ test_expect_success 'modify/delete + directory/file conflict' '
 '
 
 test_expect_success 'modify/delete + directory/file conflict; other way' '
-	# Yes, we really need the double reset since "letters" appears as
-	# both a file and a directory.
-	git reset --hard &&
 	git reset --hard &&
 	git clean -f &&
 	git checkout modify^0 &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 1cbd946fc..583e68997 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -323,7 +323,6 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 	(
 		cd rename-directory-1 &&
 
-		git reset --hard &&
 		git reset --hard &&
 		git clean -fdqx &&
 
-- 
2.18.0.138.g557c5d94c.dirty

