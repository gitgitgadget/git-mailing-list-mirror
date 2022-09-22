Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155DC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 10:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIVKON (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiIVKNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 06:13:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2AD98C1
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 03:13:37 -0700 (PDT)
Received: (qmail 5661 invoked by uid 109); 22 Sep 2022 10:13:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 10:13:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 983 invoked by uid 111); 22 Sep 2022 10:13:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 06:13:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 06:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] fsck: turn off save_commit_buffer
Message-ID: <Yyw1UIhhj5zVtl1T@coredump.intra.peff.net>
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing a commit, the default behavior is to stuff the original
buffer into a commit_slab (which takes ownership of it). But for a tool
like fsck, this isn't useful. While we may look at the buffer further as
part of fsck_commit(), we'll always do so through a separate pointer;
attaching the buffer to the slab doesn't help.

Worse, it means we have to remember to free the commit buffer in all
call paths. We do so in fsck_obj(), which covers a regular "git fsck".
But with "--connectivity-only", we forget to do so in both
traverse_one_object(), which covers reachable objects, and
mark_unreachable_referents(), which covers unreachable ones. As a
result, that mode ends up storing an uncompressed copy of every commit
on the heap at once.

We could teach the code paths for --connectivity-only to also free
commit buffers. But there's an even easier fix: we can just turn off the
save_commit_buffer flag, and then we won't attach them to the commits in
the first place.

This reduces the peak heap of running "git fsck --connectivity-only" in
a clone of linux.git from ~2GB to ~1GB. According to massif, the
remaining memory goes where you'd expect: the object structs themselves,
the obj_hash containing them, and the delta base cache.

Note that we'll leave the call to free commit buffers in fsck_obj() for
now; it's not quite redundant because of a related bug that we'll fix in
a subsequent commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 34e575a170..b45de003d4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -855,6 +855,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	errors_found = 0;
 	read_replace_refs = 0;
+	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
-- 
2.38.0.rc1.583.ga560cd8328

