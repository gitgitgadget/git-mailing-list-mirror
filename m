Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836BEC352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0E206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgBMCRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:17:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:42082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729407AbgBMCRu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:17:50 -0500
Received: (qmail 9822 invoked by uid 109); 13 Feb 2020 02:16:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:16:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8643 invoked by uid 111); 13 Feb 2020 02:26:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:26:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:17:49 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/13] rev-list: consolidate bitmap-disabling options
Message-ID: <20200213021749.GD1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few options are incompatible with bitmaps, like --filter or
pathspec-based pruning. Let's put these checks all up front, so that
further code can trust the use_bitmap_index as the final word.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bce406bd1e..9635b544e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -521,7 +521,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
-	if (filter_options.choice)
+	if (filter_options.choice || revs.prune)
 		use_bitmap_index = 0;
 
 	save_commit_buffer = (revs.verbose_header ||
@@ -533,7 +533,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_delayed_progress(show_progress, 0);
 
-	if (use_bitmap_index && !revs.prune) {
+	if (use_bitmap_index) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
 			int max_count = revs.max_count;
-- 
2.25.0.785.g49bcbe7794

