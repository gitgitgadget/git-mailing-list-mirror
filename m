Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D94DC636CD
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 01:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBBBDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBBBDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 20:03:54 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC36A69
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 17:03:53 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0E21D1F5A0
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675299834;
        bh=sJdUfs1g6HUKJnCOZvnNFUlS6CwR4gjz650sZTL34T8=;
        h=From:To:Subject:Date:From;
        b=Tgi1aW/hJy+6+Cofnn09kI6KR7CkJ97q+QI7oebHI6zGHOvEhpExu2O4ktimXS+s9
         v0AvlZceqKWzzifIYMzBYq6P3P2UrTgIi4XwiUoTYmdwwt0EyxX6LPAG7A0Bq+KXHB
         jsUVuI9wnVrUpiVgDGFZdA5fkvJ04QyFu9whaaV8=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] delta-islands: free island_marks and bitmaps
Date:   Thu,  2 Feb 2023 01:03:53 +0000
Message-Id: <20230202010353.23391-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my mirror of linux.git forkgroup with 780 islands, this saves
nearly 4G of heap memory in pack-objects.  This savings only
benefits delta island users of pack bitmaps, as the process
would otherwise be exiting anyways.

However, there's probably not many delta island users, but the
majority of delta island users would also be pack bitmaps users.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Slowly chipping away, this is low-hanging fruit.

 delta-islands.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/delta-islands.c b/delta-islands.c
index 90c0d6958f..7052a3a6ba 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -513,12 +513,29 @@ void propagate_island_marks(struct commit *commit)
 	}
 }
 
+static void free_island_marks(void)
+{
+	struct island_bitmap *bitmap;
+
+	kh_foreach_value(island_marks, bitmap, {
+		if (--bitmap->refcount == 0)
+			free(bitmap);
+	});
+	kh_destroy_oid_map(island_marks);
+	island_marks = (void *)1; /* crash on unintended future use */
+}
+
 int compute_pack_layers(struct packing_data *to_pack)
 {
 	uint32_t i;
 
-	if (!core_island_name || !island_marks)
+	if (!island_marks)
+		return 1;
+
+	if (!core_island_name) {
+		free_island_marks();
 		return 1;
+	}
 
 	for (i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
@@ -533,6 +550,7 @@ int compute_pack_layers(struct packing_data *to_pack)
 				oe_set_layer(to_pack, entry, 0);
 		}
 	}
+	free_island_marks();
 
 	return 2;
 }
