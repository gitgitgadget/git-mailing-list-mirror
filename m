Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15BEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjF2SQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF2SQG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 14:16:06 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 11:16:03 PDT
Received: from impout009.msg.chrl.nc.charter.net (impout009aa.msg.chrl.nc.charter.net [47.43.20.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E42D4E
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:16:03 -0700 (PDT)
Received: from localhost.localdomain ([97.71.114.58])
        by cmsmtp with ESMTPA
        id EwA1qYU7YmtNMEwA3qPlhe; Thu, 29 Jun 2023 18:14:31 +0000
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=CJI54DnD c=1 sm=1 tr=0 ts=649dca08
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=Ik-n2YkxXVU78WynldAA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From:   Eric Sunshine <ericsunshine@charter.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fsck: avoid misleading variable name
Date:   Thu, 29 Jun 2023 14:13:33 -0400
Message-ID: <20230629181333.87465-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.41.0.362.gccff93557d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFgvVo6yVkmCKnzKTGwaxZH0I5aZYG25J3NLzusJ/V2KIxlQiApkWHMuDYgpncXHntxdJpqHLMqENTfOxnt5TMiCc9pGyBsDBIokixlr63cJCOW1U21F
 1IWkttAo8Zg1Ud7+2zMxxO+/u1NglQDG6wN7k6WApZ7HXh2zLMqNz1iGjU/P/foXykmSWekVouhzVVvSmylL8qgZmF9N0KXxA+D6+neCwiyFJx6679idigJK
 JMnrDf7gpmhSgoHWd032KtAKwHzQnDvfzlQYoottfWE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When reporting a problem, `git fsck` emits a message such as:

    missing blob 1234abcd (:file)

However, this can be ambiguous when the problem is detected in the index
of a worktree other than the one in which `git fsck` was invoked. To
address this shortcoming, 592ec63b38 (fsck: mention file path for index
errors, 2023-02-24) enhanced the output to mention the path of the index
when the problem is detected in some other worktree:

    missing blob 1234abcd (.git/worktrees/wt/index:file)

Unfortunately, the variable in fsck_index() which controls whether the
index path should be shown is misleadingly named "is_main_index" which
can be misunderstood as referring to the main worktree (i.e. the one
housing the .git/ repository) rather than to the current worktree (i.e.
the one in which `git fsck` was invoked). Avoid such potential confusion
by choosing a name more reflective of its actual purpose.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The associated discussion which led to this patch begins at [1].

[1]: https://lore.kernel.org/git/305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com/

 builtin/fsck.c  | 4 ++--
 t/t1450-fsck.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d9aa4db828..0c00920703 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -808,7 +808,7 @@ static int fsck_resolve_undo(struct index_state *istate,
 }
 
 static void fsck_index(struct index_state *istate, const char *index_path,
-		       int is_main_index)
+		       int is_current_worktree)
 {
 	unsigned int i;
 
@@ -830,7 +830,7 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 		obj->flags |= USED;
 		fsck_put_object_name(&fsck_walk_options, &obj->oid,
 				     "%s:%s",
-				     is_main_index ? "" : index_path,
+				     is_current_worktree ? "" : index_path,
 				     istate->cache[i]->name);
 		mark_object_reachable(obj);
 	}
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8c442adb1a..5805d47eb9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1036,9 +1036,9 @@ test_expect_success 'fsck detects problems in worktree index' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fsck reports problems in main index without filename' '
+test_expect_success 'fsck reports problems in current worktree index without filename' '
 	test_when_finished "rm -f .git/index && git read-tree HEAD" &&
-	echo "this object will be removed to break the main index" >file &&
+	echo "this object will be removed to break current worktree index" >file &&
 	git add file &&
 	blob=$(git rev-parse :file) &&
 	remove_object $blob &&
-- 
2.41.0.362.gccff93557d

