Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBB6209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756822AbdDFIC0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:02:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59271 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756675AbdDFICX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:02:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6ED3CABAF
        for <git@vger.kernel.org>; Thu,  6 Apr 2017 08:02:22 +0000 (UTC)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
Message-ID: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
Date:   Thu, 6 Apr 2017 10:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F868F20BD60C05A22CF3113"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F868F20BD60C05A22CF3113
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello.

Following patch fixes issues that can be seen with -fsanitize=undefined on GCC 7.

Patch was tested with make test.

Thanks,
Martin

--------------2F868F20BD60C05A22CF3113
Content-Type: text/x-patch;
 name="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"

From e6d2d5ee5614acdbe67b79aeb0fdc9b53cf3a828 Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Wed, 5 Apr 2017 14:31:32 +0200
Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.

Memory functions like memmove and memcpy should not be called
with an argument equal to NULL.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 apply.c            | 7 ++++---
 builtin/ls-files.c | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26a..78a83f66b 100644
--- a/apply.c
+++ b/apply.c
@@ -2802,9 +2802,10 @@ static void update_image(struct apply_state *state,
 			img->line + applied_pos + preimage_limit,
 			(img->nr - (applied_pos + preimage_limit)) *
 			sizeof(*img->line));
-	memcpy(img->line + applied_pos,
-	       postimage->line,
-	       postimage->nr * sizeof(*img->line));
+	if (postimage->nr)
+		memcpy(img->line + applied_pos,
+			postimage->line,
+			postimage->nr * sizeof(*img->line));
 	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..01d24314d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -391,8 +391,9 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
-		(last - pos) * sizeof(struct cache_entry *));
+	if (last - pos > 0)
+		memmove(active_cache, active_cache + pos,
+			(last - pos) * sizeof(struct cache_entry *));
 	active_nr = last - pos;
 }
 
-- 
2.12.2


--------------2F868F20BD60C05A22CF3113--
