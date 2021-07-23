Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A35C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC2F60EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhGWItG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:49:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhGWItB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:49:01 -0400
Received: (qmail 10943 invoked by uid 109); 23 Jul 2021 09:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 09:29:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23682 invoked by uid 111); 23 Jul 2021 09:29:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 05:29:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 05:29:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] pack-bitmap: check pack validity when opening bitmap
Message-ID: <YPqL/pZt6hNYN4hB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects adds an entry to its list of objects to pack, it may
mark the packfile and offset that contains the file, which we can later
use to output the object verbatim.  If the packfile is deleted while we
are running (e.g., by another process running "git repack"), we may die
in use_pack() if the pack file cannot be opened.

We worked around this in 4c08018204 (pack-objects: protect against
disappearing packs, 2011-10-14) by making sure we can open the pack
before recording it as a source. This detects a pack which has already
disappeared while generating the packing list, and because we keep the
pack's file descriptor (or an mmap window) open, it means we can access
it later (unless you exceed core.packedgitlimit).

The bitmap code that was added later does not do this; it adds entries
to the packlist without checking that the packfile is still valid, and
is vulnerable to this race. It needs the same treatment as 4c08018204.

However, rather than add it in just that one spot, it makes more sense
to simply open and check the packfile when we open the bitmap.
Technically you can use the .bitmap without even looking in the .pack
file (e.g., if you are just printing a list of objects without accessing
them), but it's much simpler to do it early. That covers all later
direct uses of the pack (due to the cached descriptor) without having to
check each one directly. For example, in pack-objects we need to protect
the packlist entries, but we also access the pack directly as part of
the reuse_partial_pack_from_bitmap() feature. This patch covers both
cases.

There's no test here, because the problem is inherently racy. I
reproduced and verified the fix with this script:

  rm -rf parent.git push.git fetch.git

  push() {
    (
      cd push.git &&
      echo content >>file &&
      git add file &&
      git commit -qm "change $1" &&
      git push -q origin HEAD &&
      echo "push $1..."
    ) &&
    (
      cd parent.git &&
      git repack -ad -q &&
      echo "repack $1..."
    )
  }

  fetch() {
    rm -rf fetch.git &&
    git clone -q file://$PWD/parent.git fetch.git &&
    echo "fetch $1..."
  }

  git init --bare parent.git &&
  git --git-dir=parent.git config transfer.unpacklimit 1 &&
  git clone parent.git push.git &&
  (for i in `seq 1 1000`; do push $i || break; done) &
  pusher=$!
  (for i in `seq 1 1000`; do fetch $i || break; done) &
  fetcher=$!
  wait $fetcher
  kill $pusher

That simulates a race between a client cloning and a push triggering a
repack on the server. Without this patch, it generally fails within a
couple hundred iterations with:

  remote: fatal: packfile ./objects/pack/.tmp-1377349-pack-498afdec371232bdb99d1757872f5569331da61e.pack cannot be accessed
  error: git upload-pack: git-pack-objects died with error.
  fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
  remote: aborting due to possible repository corruption on the remote side.
  fatal: early EOF
  fatal: fetch-pack: invalid index-pack output

With this patch, it reliably runs through all thousand attempts.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote this patch in 2015 after seeing this race in production, and
we've been running with it at GitHub ever since. I think I didn't
upstream it back then because it was an incomplete fix without
further changes to the pack-reuse code. And then of course I forgot all
about it. Those pack-reuse changes came upstream in a14aebeac3 (Merge
branch 'jk/packfile-reuse-cleanup', 2020-02-14), so this is a complete
fix now (and recipe above is almost certainly triggering the problem in
the reuse code path, since we'd generally be sending the whole pack).

 pack-bitmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index bfc10148f5..c3a2c03b59 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -298,6 +298,11 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	if (!is_pack_valid(packfile)) {
+		close(fd);
+		return -1;
+	}
+
 	bitmap_git->pack = packfile;
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
-- 
2.32.0.784.g92e169d3d7
