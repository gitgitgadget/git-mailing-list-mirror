Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B65C001E0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjHIRPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjHIRPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A11FEF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4F3F524313;
        Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmS-lFB-00; Wed, 09 Aug 2023 19:15:32 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2] sequencer: simplify allocation of result array in todo_list_rearrange_squash()
Date:   Wed,  9 Aug 2023 19:15:32 +0200
Message-Id: <20230809171532.2564880-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The operation doesn't change the number of elements in the array, so we do
not need to allocate the result piecewise.

This moves the re-assignment of todo_list->alloc at the end slighly up,
so it's right after the newly added assert which also refers to `nr`
(and which indeed should come first). Also, the value is more likely to
be still in a register at that point.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- removed redundant assignment of `items` in ALLOC_ARRAY() call
- added 2nd paragraph to commit message
- broken out of the bigger series, as the aggregation just unnecessarily
  holds it up

Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 sequencer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..947cb89e60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6233,7 +6233,7 @@ static int skip_fixupish(const char *subject, const char **p) {
 int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
 	struct hashmap subject2item;
-	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
+	int rearranged = 0, *next, *tail, i, nr = 0;
 	char **subjects;
 	struct commit_todo_item commit_todo;
 	struct todo_item *items = NULL;
@@ -6345,6 +6345,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	}
 
 	if (rearranged) {
+		ALLOC_ARRAY(items, todo_list->nr);
+
 		for (i = 0; i < todo_list->nr; i++) {
 			enum todo_command command = todo_list->items[i].command;
 			int cur = i;
@@ -6357,16 +6359,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 				continue;
 
 			while (cur >= 0) {
-				ALLOC_GROW(items, nr + 1, alloc);
 				items[nr++] = todo_list->items[cur];
 				cur = next[cur];
 			}
 		}
 
+		assert(nr == todo_list->nr);
+		todo_list->alloc = nr;
 		FREE_AND_NULL(todo_list->items);
 		todo_list->items = items;
-		todo_list->nr = nr;
-		todo_list->alloc = alloc;
 	}
 
 	free(next);
-- 
2.40.0.152.g15d061e6df

