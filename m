Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE691F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409473AbfJREzx (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:55:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392808AbfJREzx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:55:53 -0400
Received: (qmail 9362 invoked by uid 109); 18 Oct 2019 04:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:49:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14062 invoked by uid 111); 18 Oct 2019 04:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:52:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:49:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/23] fsck: stop checking commit->parent counts
Message-ID: <20191018044910.GF17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4516338243 (builtin-fsck: reports missing parent commits,
2008-02-25), we added code to check that fsck found the same number of
parents from parsing the commit itself as we see in the commit struct we
got from parse_commit_buffer(). Back then the rationale was that the
normal commit parser might skip some bad parents.

But earlier in this series, we started treating that reliably as a
parsing error, meaning that we'd complain about it before we even hit
the code in fsck.c.

Let's drop this code, which now makes fsck_commit_buffer() completely
independent of any parsed values in the commit struct (that's
conceptually cleaner, and also opens up more refactoring options).

Note that we can also drop the MISSING_PARENT and MISSING_GRAFT fsck
identifiers. This is no loss, as these would not trigger reliably
anyway.  We'd hit them only when lookup_commit() failed, which occurs
only if we happen to have seen the object with another type already in
the same process. In most cases, we'd actually run into the problem
during the connectivity walk, not here.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6dfc533fb0..a0f8ae7650 100644
--- a/fsck.c
+++ b/fsck.c
@@ -43,10 +43,8 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(MISSING_AUTHOR, ERROR) \
 	FUNC(MISSING_COMMITTER, ERROR) \
 	FUNC(MISSING_EMAIL, ERROR) \
-	FUNC(MISSING_GRAFT, ERROR) \
 	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
 	FUNC(MISSING_OBJECT, ERROR) \
-	FUNC(MISSING_PARENT, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
 	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
 	FUNC(MISSING_TAG, ERROR) \
@@ -739,8 +737,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	unsigned long size, struct fsck_options *options)
 {
 	struct object_id tree_oid, oid;
-	struct commit_graft *graft;
-	unsigned parent_count, parent_line_count = 0, author_count;
+	unsigned author_count;
 	int err;
 	const char *buffer_begin = buffer;
 	const char *p;
@@ -763,24 +760,6 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 				return err;
 		}
 		buffer = p + 1;
-		parent_line_count++;
-	}
-	graft = lookup_commit_graft(the_repository, &commit->object.oid);
-	parent_count = commit_list_count(commit->parents);
-	if (graft) {
-		if (graft->nr_parent == -1 && !parent_count)
-			; /* shallow commit */
-		else if (graft->nr_parent != parent_count) {
-			err = report(options, &commit->object, FSCK_MSG_MISSING_GRAFT, "graft objects missing");
-			if (err)
-				return err;
-		}
-	} else {
-		if (parent_count != parent_line_count) {
-			err = report(options, &commit->object, FSCK_MSG_MISSING_PARENT, "parent objects missing");
-			if (err)
-				return err;
-		}
 	}
 	author_count = 0;
 	while (skip_prefix(buffer, "author ", &buffer)) {
-- 
2.23.0.1228.gee29b05929

