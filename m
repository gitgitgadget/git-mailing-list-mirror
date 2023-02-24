Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385EDC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBXIKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBXIJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 03:09:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9519F17
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 00:09:58 -0800 (PST)
Received: (qmail 4549 invoked by uid 109); 24 Feb 2023 08:09:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 08:09:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31727 invoked by uid 111); 24 Feb 2023 08:09:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 03:09:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 03:09:57 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] fsck: check index files in all worktrees
Message-ID: <Y/hw1YVgCYWX2yNK@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check the index file for the main worktree, but completely ignore the
index files in other worktrees. These should be checked, too, as they
are part of the repository state (and in particular, errors in those
index files may cause repo-wide operations like "git gc" to complain).

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jeff King <peff@peff.net>
---
I mostly cargo-culted the loop from add_index_objects_to_pending(),
which is how they get included in git-prune, git-repack, etc.

I'm not sure if we should be reporting something if we get a negative
return. Last time I dug into this, I think I found that the
index-reading code could not actually return an error (it dies instead).

If we get zero, there are no entries to check. But I'm not sure if we'd
still have extensions? So maybe this ought to be ignoring the return
value from read_index_from() entirely.

 builtin/fsck.c  | 17 +++++++++++++++--
 t/t1450-fsck.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fa101e0db2..ddd13cb2b3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -984,10 +984,23 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (keep_cache_objects) {
+		struct worktree **p;
+
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
-		repo_read_index(the_repository);
-		fsck_index(the_repository->index);
+
+		for (p = get_worktrees(); *p; p++) {
+			struct worktree *wt = *p;
+			struct index_state istate =
+				INDEX_STATE_INIT(the_repository);
+
+			if (read_index_from(&istate,
+					    worktree_git_path(wt, "index"),
+					    get_worktree_git_dir(wt)) > 0)
+				fsck_index(&istate);
+			discard_index(&istate);
+		}
+
 	}
 
 	check_connectivity();
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index fdb886dfe4..3b70ad9e22 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1023,4 +1023,16 @@ test_expect_success 'fsck error on gitattributes with excessive size' '
 	test_cmp expected actual
 '
 
+test_expect_success 'fsck detects problems in worktree index' '
+	test_when_finished "git worktree remove -f wt" &&
+	git worktree add wt &&
+
+	echo "this will be removed to break the worktree index" >wt/file &&
+	git -C wt add file &&
+	blob=$(git -C wt rev-parse :file) &&
+	remove_object $blob &&
+
+	test_must_fail git fsck
+'
+
 test_done
-- 
2.39.2.981.g6157336f25

