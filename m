Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5787CC61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 11:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBKLP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKLP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 06:15:27 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61B20067
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 03:15:26 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 08D131F5A0;
        Sat, 11 Feb 2023 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676114127;
        bh=i0S4B1O5x77W2lDbLK2yz2QyFsv2Bh5UKCDJfweGr2s=;
        h=From:To:Cc:Subject:Date:From;
        b=cScG8m+CJpmjGCPlu1eIqNpFtYky/EZdg1Wehxv4I3nRrkSCDPCGl24V4zCfkkeUQ
         bCXzfFFbCRkxF22jHBpybKh+ygainQ1HQpuHo+8QPVrUOw8lKfOZgmmYupn00kRZmE
         R01G6pgMiCw1nJATeYF8yHp11JlpxQqKaS+XejIo=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH] commit-reach: avoid NULL dereference
Date:   Sat, 11 Feb 2023 11:15:26 +0000
Message-Id: <20230211111526.2028178-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loop at the top of can_all_from_reach_with_flag() already
accounts for `from->objects[i].item' being NULL, so it follows
the cleanup loop should also account for a NULL `from_one'.

I managed to segfault here on one of my giant, many-remote repos
using `git fetch --negotiation-tip=...  --negotiation-only'
where the --negotiation-tip= argument was a glob which (inadvertently)
captured more refs than I wanted.  I have not reproduced this
in a standalone test case.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Not sure if somebody who understands the code better can come
 up with a good standalone test case.  I figure using the top
 loop as reference is sufficient evidence that this fix is needed.

 commit-reach.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..1d7056338b7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -807,8 +807,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
 	free(list);
 
-	for (i = 0; i < from->nr; i++)
-		from->objects[i].item->flags &= ~assign_flag;
+	for (i = 0; i < from->nr; i++) {
+		struct object *from_one = from->objects[i].item;
+
+		if (from_one)
+			from_one->flags &= ~assign_flag;
+	}
 
 	return result;
 }
