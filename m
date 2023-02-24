Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9494C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXGjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBXGjU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F2521F8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:16 -0800 (PST)
Received: (qmail 3678 invoked by uid 109); 24 Feb 2023 06:39:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31104 invoked by uid 111); 24 Feb 2023 06:39:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/21] mark "pointless" data pointers in callbacks
Message-ID: <Y/hbk3/wMqhqTRAF@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both the object_array_filter() and trie_find() functions use callback
functions that let the caller specify which elements match. These
callbacks take a void pointer in case the caller wants to pass in extra
data. But in each case, the single user of these functions just passes
NULL, and the callback ignores the extra pointer.

We could just remove these unused parameters from the callback interface
entirely. But it's good practice to provide such a pointer, as it guides
future callers of the function in the right direction (rather than
tempting them to access global data). Plus it's consistent with other
generic callback interfaces.

So let's instead annotate the unused parameters, in order to silence the
compiler's -Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c     | 3 ++-
 revision.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 492e17ad12..0b641233e3 100644
--- a/path.c
+++ b/path.c
@@ -347,7 +347,8 @@ static void init_common_trie(void)
  * Helper function for update_common_dir: returns 1 if the dir
  * prefix is common.
  */
-static int check_common(const char *unmatched, void *value, void *baton)
+static int check_common(const char *unmatched, void *value,
+			void *baton UNUSED)
 {
 	struct common_dir *dir = value;
 
diff --git a/revision.c b/revision.c
index 21f5f572c2..4a24fc3fcd 100644
--- a/revision.c
+++ b/revision.c
@@ -4159,7 +4159,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
  * Return true for entries that have not yet been shown.  (This is an
  * object_array_each_func_t.)
  */
-static int entry_unshown(struct object_array_entry *entry, void *cb_data_unused)
+static int entry_unshown(struct object_array_entry *entry, void *cb_data UNUSED)
 {
 	return !(entry->item->flags & SHOWN);
 }
-- 
2.39.2.981.g6157336f25

