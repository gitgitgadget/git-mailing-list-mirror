Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2621CC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjHaGZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjHaGZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:25:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EAAE49
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:25:02 -0700 (PDT)
Received: (qmail 21173 invoked by uid 109); 31 Aug 2023 06:23:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:23:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3027 invoked by uid 111); 31 Aug 2023 06:23:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:23:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:23:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/10] lower core.maxTreeDepth default to 2048
Message-ID: <20230831062320.GJ3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my Linux system, all of our recursive tree walking algorithms can run
up to the 4096 default limit without segfaulting. But not all platforms
will have stack sizes as generous (nor might even Linux if we kick off a
recursive walk within a thread).

In particular, several of the tests added in the previous few commits
fail in our Windows CI environment. Through some guess-and-check
pushing, I found that 3072 is still too much, but 2048 is OK.

These are obviously vague heuristics, and there is nothing to promise
that another system might not have trouble at even lower values. But it
seems unlikely anybody will be too angry about a 2048-depth limit (this
is close to the default max-pathname limit on Linux even for a
pathological path like "a/a/a/..."). So let's just lower it.

Some alternatives are:

  - configure separate defaults for Windows versus other platforms.

  - just skip the tests on Windows. This leaves Windows users with the
    annoying case that they can be crashed by running out of stack
    space, but there shouldn't be any security implications (they can't
    go deep enough to hit integer overflow problems).

Since the original default was arbitrary, it seems less confusing to
just lower it, keeping behavior consistent across platforms.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this could be squashed into patch 5. But I thought that
following the sequence of logic (from "4096 is probably OK" to "whoops,
it's not") had some value to share. AFAIK GitHub is still running with
the 4096 limit; I discovered the Windows issue only while preparing this
for upstream. But I still find it highly unlikely that somebody would
run into it in practice.

 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 8e25b5ef02..bb3c2a96a3 100644
--- a/environment.c
+++ b/environment.c
@@ -81,7 +81,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
-int max_allowed_tree_depth = 4096;
+int max_allowed_tree_depth = 2048;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
-- 
2.42.0.561.gaa987ecc69
