Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2BC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjHHT0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjHHTZu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:25:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258E59DFD
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:50:24 -0700 (PDT)
Received: (qmail 2517 invoked by uid 109); 8 Aug 2023 18:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 18:50:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22892 invoked by uid 111); 8 Aug 2023 18:50:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 14:50:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 14:50:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] repack: free geometry struct
Message-ID: <20230808185023.GA3498623@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the program is ending, we call clear_pack_geometry() to free any
resources in the pack_geometry struct. But the struct itself is
allocated on the heap, and leak-checkers will complain about the
resulting small leak.

This one was marked by Coverity as a "new" leak, though it has existed
since 0fabafd0b9 (builtin/repack.c: add '--geometric' option,
2021-02-22). This might be because recent unrelated changes in the file
confused it about what is new and what is not. But regardless, it is
worth addressing.

We can fix it easily by free-ing the struct. We'll convert our "clear"
function to "free", since the allocation happens in the matching init()
function (though since there is only one call to each, and the struct is
local to this file, it's mostly academic).

Another option would be to put the struct on the stack rather than the
heap. However, this gets tricky, as we check the pointer against NULL in
several places to decide whether we're in geometric mode.

Signed-off-by: Jeff King <peff@peff.net>
---
I did actually put together the "put it on the stack" patch, which swaps
out:

  if (geometry)

for:

  if (geometric_factor)

to get around the NULL checks. But besides being noisy for little gain,
it ends up with some subtle gotchas, because we pass "&geometry" into
some functions which don't have access to "geometric_factor" (so now
extra call-sites have to keep track of "is this struct valid enough to
pass").

 builtin/repack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index aea5ca9d44..97051479e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -492,15 +492,13 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
-static void clear_pack_geometry(struct pack_geometry *geometry)
+static void free_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
 		return;
 
 	free(geometry->pack);
-	geometry->pack_nr = 0;
-	geometry->pack_alloc = 0;
-	geometry->split = 0;
+	free(geometry);
 }
 
 struct midx_snapshot_ref_data {
@@ -1228,7 +1226,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
-	clear_pack_geometry(geometry);
+	free_pack_geometry(geometry);
 
 	return ret;
 }
-- 
2.42.0.rc0.376.g66bfc4f195
