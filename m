Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6DB2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdESMw2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:52:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752655AbdESMw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:52:27 -0400
Received: (qmail 2559 invoked by uid 109); 19 May 2017 12:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:52:26 +0000
Received: (qmail 27801 invoked by uid 111); 19 May 2017 12:53:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:53:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:52:25 -0400
Date:   Fri, 19 May 2017 08:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 07/15] get_sha1_with_context: always initialize
 oc->symlink_path
Message-ID: <20170519125224.gnfifzcyly2n5te6@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_sha1_with_context() function zeroes out the
oc->symlink_path strbuf, but doesn't use strbuf_init() to
set up the usual invariants (like pointing to the slopbuf).
We don't actually write to the oc->symlink_path strbuf
unless we call get_tree_entry_follow_symlinks(), and that
function does initialize it. However, readers may still look
at the zero'd strbuf.

In practice this isn't a triggerable bug. The only caller
that looks at it only does so when the mode we found is 0.
This doesn't happen for non-tree-entries (where we return
S_IFINVALID). A broken tree entry could have a mode of 0,
but canon_mode() quietly rewrites that into S_IFGITLINK.
So the "0" mode should only come up when we did indeed find
a symlink.

This is mostly just an accident of how the code happens to
work, though. Let's future-proof ourselves to make sure the
strbuf is properly initialized for all calls (it's only a
few struct member assignments, not a heap allocation).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 1 +
 tree-walk.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index a11d08dd8..35b16efc6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1511,6 +1511,7 @@ static int get_sha1_with_context_1(const char *name,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
+	strbuf_init(&oc->symlink_path, 0);
 	ret = get_sha1_1(name, namelen, sha1, flags);
 	if (!ret)
 		return ret;
diff --git a/tree-walk.c b/tree-walk.c
index ff7760568..c7ecfc856 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -589,7 +589,6 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 	int i;
 
 	init_tree_desc(&t, NULL, 0UL);
-	strbuf_init(result_path, 0);
 	strbuf_addstr(&namebuf, name);
 	hashcpy(current_tree_sha1, tree_sha1);
 
-- 
2.13.0.219.g63f6bc368

