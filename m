Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C3C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCWQsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjCWQrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161710402
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DCD1E24249
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-B0V-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 6/8] sequencer: simplify allocation of result array in todo_list_rearrange_squash()
Date:   Thu, 23 Mar 2023 17:22:33 +0100
Message-Id: <20230323162235.995574-7-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The operation doesn't change the number of elements in the array, so we do
not need to allocate the result piecewise.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f8a7f4e721..fb224445fa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6225,7 +6225,7 @@ static int skip_fixupish(const char *subject, const char **p) {
 int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
 	struct hashmap subject2item;
-	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
+	int rearranged = 0, *next, *tail, i, nr = 0;
 	char **subjects;
 	struct commit_todo_item commit_todo;
 	struct todo_item *items = NULL;
@@ -6334,6 +6334,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	}
 
 	if (rearranged) {
+		items = ALLOC_ARRAY(items, todo_list->nr);
+
 		for (i = 0; i < todo_list->nr; i++) {
 			enum todo_command command = todo_list->items[i].command;
 			int cur = i;
@@ -6346,16 +6348,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
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

