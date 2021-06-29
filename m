Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE79C11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8961DF2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhF2INo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:13:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48078 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhF2INo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5F3A91F8C9
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 08:11:09 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] check_packed_git_idx: attempt to handle ENOMEM from mmap
Date:   Tue, 29 Jun 2021 08:11:07 +0000
Message-Id: <20210629081108.28657-4-e@80x24.org>
In-Reply-To: <20210629081108.28657-1-e@80x24.org>
References: <20210629081108.28657-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This benefits unprivileged users who lack permissions to raise
the `sys.vm.max_map_count' sysctl and/or RLIMIT_DATA resource
limit.

It appears none of our multithreaded code is calling this,
or is doing so while holding appropropriate locks to serialize
access to the object database.

Unconditionally calling unuse_one_window() before xmmap_gently()
revealed no test suite failures:

	--- a/packfile.c
	+++ b/packfile.c
	@@ -98,6 +98,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
			return error("index file %s is too small", path);
		}
		do {
	+		unuse_one_window(p);
			idx_map = xmmap_gently(NULL, idx_size, PROT_READ, MAP_PRIVATE,
						fd, 0);
		} while (idx_map == MAP_FAILED && errno == ENOMEM

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 4bc7fa0f36..2904560f52 100644
--- a/packfile.c
+++ b/packfile.c
@@ -97,7 +97,11 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		close(fd);
 		return error("index file %s is too small", path);
 	}
-	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	do {
+		idx_map = xmmap_gently(NULL, idx_size, PROT_READ, MAP_PRIVATE,
+					fd, 0);
+	} while (idx_map == MAP_FAILED && errno == ENOMEM
+		&& unuse_one_window(p));
 	close(fd);
 
 	ret = load_idx(path, hashsz, idx_map, idx_size, p);
