Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70BC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED82061DD6
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhF2INn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:13:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48022 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhF2INk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:13:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4CD081F8C8
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 08:11:09 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] map_loose_object_1: attempt to handle ENOMEM from mmap
Date:   Tue, 29 Jun 2021 08:11:06 +0000
Message-Id: <20210629081108.28657-3-e@80x24.org>
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

Multi-threaded callers to map_loose_object_1 (e.g. "git grep")
appear to guard against thread-safety problems.  Other
multi-core aware pieces of code (e.g. parallel-checkout) uses
child processes

Forcing a call to unuse_one_window() once before xmmap_gently()
revealed no test suite failures:

	--- a/object-file.c
	+++ b/object-file.c
	@@ -1197,6 +1197,7 @@ static void *map_loose_object_1(struct repository *r, const char *path,
					return NULL;
				}
				do {
	+				unuse_one_window(NULL);
					map = xmmap_gently(NULL, *size, PROT_READ,
							MAP_PRIVATE, fd, 0);
				} while (map == MAP_FAILED && errno == ENOMEM

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c | 8 +++++++-
 packfile.c    | 2 +-
 packfile.h    | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index f233b440b2..4c043f1f3c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1196,7 +1196,13 @@ static void *map_loose_object_1(struct repository *r, const char *path,
 				close(fd);
 				return NULL;
 			}
-			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+			do {
+				map = xmmap_gently(NULL, *size, PROT_READ,
+						MAP_PRIVATE, fd, 0);
+			} while (map == MAP_FAILED && errno == ENOMEM
+				&& unuse_one_window(NULL));
+			if (map == MAP_FAILED)
+				die_errno("%s cannot be mapped", path);
 		}
 		close(fd);
 	}
diff --git a/packfile.c b/packfile.c
index a0da790fb4..4bc7fa0f36 100644
--- a/packfile.c
+++ b/packfile.c
@@ -265,7 +265,7 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+int unuse_one_window(struct packed_git *current)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
diff --git a/packfile.h b/packfile.h
index 3ae117a8ae..da9a061e30 100644
--- a/packfile.h
+++ b/packfile.h
@@ -196,4 +196,6 @@ int is_promisor_object(const struct object_id *oid);
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
 
+int unuse_one_window(struct packed_git *);
+
 #endif
