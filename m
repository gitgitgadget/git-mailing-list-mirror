Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A112B1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfJREzD (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:55:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725926AbfJREzD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:55:03 -0400
Received: (qmail 9356 invoked by uid 109); 18 Oct 2019 04:48:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:48:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14057 invoked by uid 111); 18 Oct 2019 04:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:51:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:48:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/23] fsck: stop checking commit->tree value
Message-ID: <20191018044820.GE17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check in fsck_commit_buffer() that commit->tree isn't NULL, which in
turn generally comes from a previous parse by parse_commit(). But this
isn't really accomplishing anything. The two things we might care about
are:

  - was there a syntactically valid "tree <oid>" line in the object? But
    we've just done our own parse in fsck_commit_buffer() to check this.

  - does it point to a valid tree object? But checking the "tree"
    pointer here doesn't actually accomplish that; it just shows that
    lookup_tree() didn't return NULL, which only means that we haven't
    yet seen that oid as a non-tree in this process.

    A real connectivity check would exhaustively walk all graph links,
    and we do that already in a separate function.

So this code isn't helping anything. And it makes the fsck code slightly
more confusing and rigid (e.g., it requires that any commit structs have
already been parsed). Let's drop it.

As a bit of history, the presence of this code looks like a leftover
from early fsck code (which did rely on parse_commit() to do most of the
parsing). The check comes from ff5ebe39b0 (Port fsck-cache to use
parsing functions, 2005-04-18), but we later added an explicit walk in
355885d531 (add generic, type aware object chain walker, 2008-02-25).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index cdb7d8db03..6dfc533fb0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -800,11 +800,6 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
-	if (!get_commit_tree(commit)) {
-		err = report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", oid_to_hex(&tree_oid));
-		if (err)
-			return err;
-	}
 	if (memchr(buffer_begin, '\0', size)) {
 		err = report(options, &commit->object, FSCK_MSG_NUL_IN_COMMIT,
 			     "NUL byte in the commit object body");
-- 
2.23.0.1228.gee29b05929

