Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3F21F453
	for <e@80x24.org>; Sun, 28 Apr 2019 08:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfD1IHJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 04:07:09 -0400
Received: from 078.vps.ho.ua ([91.228.147.78]:54688 "EHLO vpa.nn.kiev.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfD1IHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 04:07:09 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 04:07:08 EDT
Received: by vpa.nn.kiev.ua (Postfix, from userid 1000)
        id 826B894400E0; Sun, 28 Apr 2019 11:01:38 +0300 (EEST)
Date:   Sun, 28 Apr 2019 11:01:38 +0300
From:   Valentin Nechayev <netch@netch.kiev.ua>
To:     git@vger.kernel.org
Subject: [PATCH] gc: avoid permanent repacking if pack size limit is in effect
Message-ID: <20190428080138.GM599@netch.kiev.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With pack.packSizeLimit, a really huge repository can suffer from
repacking on any operation with it, because git detects too many
packs and tries merging them.

Setting gc.autoPackLimit cures the symptom but causes small pack
merge to be avoided at all, which isn't the good behavior we want.

Fix this by counting only packs that are relatively small. With
current filesystem behavior, the margin of 1/4 of pack size limit
looks a good default.
---
 builtin/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8943bcc3..0273d6e5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -48,6 +48,7 @@ static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
+static unsigned long pack_size_limit = 0;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
@@ -155,6 +156,7 @@ static void gc_config(void)
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
+	git_config_get_ulong("pack.packsizelimit", &pack_size_limit);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
 	git_config(git_default_config, NULL);
@@ -229,9 +231,11 @@ static int too_many_packs(void)
 		if (p->pack_keep)
 			continue;
 		/*
-		 * Perhaps check the size of the pack and count only
-		 * very small ones here?
+		 * Check the size of the pack and count only
+		 * relatively small ones here.
 		 */
+		if (pack_size_limit > 0 && p->pack_size >= pack_size_limit / 4)
+			continue;
 		cnt++;
 	}
 	return gc_auto_pack_limit < cnt;
-- 
2.17.1

