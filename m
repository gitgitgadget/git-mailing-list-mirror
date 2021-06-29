Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DCDC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E026161DC4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhF2INj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:13:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47958 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhF2INi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2C89F1F8C7
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 08:11:09 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] use_pack: attempt to handle ENOMEM from mmap
Date:   Tue, 29 Jun 2021 08:11:05 +0000
Message-Id: <20210629081108.28657-2-e@80x24.org>
In-Reply-To: <20210629081108.28657-1-e@80x24.org>
References: <20210629081108.28657-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since use_pack() can already safely munmap packs to respect
core.packedGitLimit, attempt to gracefully handle ENOMEM
errors the same way by unmapping a window and retrying.

This benefits unprivileged users who lack permissions to raise
the `sys.vm.max_map_count' sysctl and/or RLIMIT_DATA resource
limit.

I've also verified it is safe to release a pack here by
unconditionally calling unuse_one_window() before
xmmap_gently():

	--- a/packfile.c
	+++ b/packfile.c
	@@ -649,6 +649,7 @@ unsigned char *use_pack(struct packed_git *p,
					&& unuse_one_window(p))
					; /* nothing */
				do {
	+				unuse_one_window(p);
					win->base = xmmap_gently(NULL, win->len,
						PROT_READ, MAP_PRIVATE,
						p->pack_fd, win->offset);

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 755aa7aec5..a0da790fb4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -648,9 +648,12 @@ unsigned char *use_pack(struct packed_git *p,
 			while (packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
 				; /* nothing */
-			win->base = xmmap_gently(NULL, win->len,
-				PROT_READ, MAP_PRIVATE,
-				p->pack_fd, win->offset);
+			do {
+				win->base = xmmap_gently(NULL, win->len,
+					PROT_READ, MAP_PRIVATE,
+					p->pack_fd, win->offset);
+			} while (win->base == MAP_FAILED && errno == ENOMEM
+				&& unuse_one_window(p));
 			if (win->base == MAP_FAILED)
 				die_errno("packfile %s cannot be mapped",
 					  p->pack_name);
