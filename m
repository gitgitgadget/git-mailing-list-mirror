Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC221C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 11:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiKPLEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiKPLDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 06:03:46 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A02F389
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 02:50:14 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 085CB1F910
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1668595814;
        bh=Ko2+ir6hiG+Ob+MTs9w7UL7HeincEUyLNn2Lt8JCakE=;
        h=From:To:Subject:Date:From;
        b=ws43TKZX3HUHkmxclExApSIDx9um7s6srOidCvX26kJBbh+cOoGLEkpY9IhEIlxL2
         ePcyKTjrk1qBoodhgwcj8hsL43f7JZOUuE8Dpqic93y+PirO/Wu5vuGzbLfDq/EX76
         ALch5p22kzYDrTXNlbz25WhxmuCO98p7l6/DHIJg=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] delta-islands: free island-related data after use
Date:   Wed, 16 Nov 2022 10:50:13 +0000
Message-Id: <20221116105013.1777440-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my use case involving 771 islands of Linux on kernel.org,
this reduces memory usage by around 25MB.  The bulk of that
comes from free_remote_islands, since free_island_regexes only
saves around 40k.

This memory is saved early in the memory-intensive pack process,
making it available for the remainder of the long process.

Signed-off-by: Eric Wong <e@80x24.org>
---
  Note: I only noticed this when I screwed up up a pack.island RE,
  ended up with hundreds of thousands of islands instead of 771,
  and kept OOM-ing :x

  Memory savings were measured using the following patch which
  relies on a patched LD_PRELOAD-based malloc debugger:
  https://80x24.org/spew/20221116095404.3974691-1-e@80x24.org/raw

  Will try to hunt down more memory savings in the nearish future.

 delta-islands.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/delta-islands.c b/delta-islands.c
index 26f9e99e1a..391e947cc6 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -454,6 +454,31 @@ static void deduplicate_islands(struct repository *r)
 	free(list);
 }
 
+static void free_island_regexes(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < island_regexes_nr; i++)
+		regfree(&island_regexes[i]);
+
+	FREE_AND_NULL(island_regexes);
+	island_regexes_alloc = island_regexes_nr = 0;
+}
+
+static void free_remote_islands(void)
+{
+	const char *island_name;
+	struct remote_island *rl;
+
+	kh_foreach(remote_islands, island_name, rl, {
+		free((void *)island_name);
+		oid_array_clear(&rl->oids);
+		free(rl);
+	});
+	kh_destroy_str(remote_islands);
+	remote_islands = NULL;
+}
+
 void load_delta_islands(struct repository *r, int progress)
 {
 	island_marks = kh_init_oid_map();
@@ -461,7 +486,9 @@ void load_delta_islands(struct repository *r, int progress)
 
 	git_config(island_config_callback, NULL);
 	for_each_ref(find_island_for_ref, NULL);
+	free_island_regexes();
 	deduplicate_islands(r);
+	free_remote_islands();
 
 	if (progress)
 		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
