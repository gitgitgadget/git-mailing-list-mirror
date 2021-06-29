Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A5C11F6A
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3D61DC2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhF2INs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:13:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48148 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhF2INq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 716181F9F3
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 08:11:09 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] xmmap: inform Linux users of tuning knobs on ENOMEM
Date:   Tue, 29 Jun 2021 08:11:08 +0000
Message-Id: <20210629081108.28657-5-e@80x24.org>
In-Reply-To: <20210629081108.28657-1-e@80x24.org>
References: <20210629081108.28657-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases where we can't (or haven't gotten around to) attempting
graceful handling of mmap failures, Linux users may benefit from
additional information on how to avoid the problem.

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 4c043f1f3c..4139a5ebe6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1027,8 +1027,14 @@ void *xmmap(void *start, size_t length,
 	int prot, int flags, int fd, off_t offset)
 {
 	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
-	if (ret == MAP_FAILED)
+	if (ret == MAP_FAILED) {
+#if defined(__linux__)
+		if (errno == ENOMEM)
+			die_errno(_(
+"mmap failed, check sys.vm.max_map_count and/or RLIMIT_DATA"));
+#endif /* OS-specific bits */
 		die_errno(_("mmap failed"));
+	}
 	return ret;
 }
 
