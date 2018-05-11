Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795ED1F406
	for <e@80x24.org>; Fri, 11 May 2018 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeEKSCB (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:02:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:36374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751333AbeEKSCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:02:01 -0400
Received: (qmail 16670 invoked by uid 109); 11 May 2018 18:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 18:02:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7921 invoked by uid 111); 11 May 2018 18:02:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 14:02:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 14:01:59 -0400
Date:   Fri, 11 May 2018 14:01:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] mark_parents_uninteresting(): drop missing object check
Message-ID: <20180511180158.GB12543@sigill.intra.peff.net>
References: <20180511180029.GA11290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511180029.GA11290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow UNINTERESTING objects in a traversal to be
unavailable. As part of this, mark_parents_uninteresting()
checks whether we have a particular uninteresting parent; if
not, we will mark it as "parsed" so that later code skips
it.

This code is redundant and even a little bit harmful, so
let's drop it.

It's redundant because when our parse_object() call in
add_parents_to_list() fails, we already quietly skip
UNINTERESTING parents. This redundancy is a historical
artifact. The mark_parents_uninteresting() protection is
from 454fbbcde3 (git-rev-list: allow missing objects when
the parent is marked UNINTERESTING, 2005-07-10). Much later,
aeeae1b771 (revision traversal: allow UNINTERESTING objects
to be missing, 2009-01-27) covered more cases by making the
actual parse more gentle.

  As an aside, even if this weren't redundant, it would be
  insufficient. The gentle parsing handles both missing and
  corrupted objects, whereas the has_object_file() check
  we're getting rid of covers only missing ones.

And the code we're dropping is harmful for two reasons:

  1. We spend extra time on the object lookup, even though
     we don't actually need the information at this point
     (and will just repeat that lookup later when we parse
     for the common case that we _do_ have the object).

  2. It "lies" about the commit by setting the parsed flag,
     even though we didn't load any useful data into the
     struct. This shouldn't matter for the UNINTERESTING
     case, but we may later clear our flags and do another
     traversal in the same process. While pretty unlikely,
     it's possible that we could then look at the same
     commit without the UNINTERESTING flag, in which case
     we'd produce the wrong result (we'd think it's a commit
     with no parents, when in fact we should probably die
     due to the missing object).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/revision.c b/revision.c
index ef70f69f08..cee4f3a4b4 100644
--- a/revision.c
+++ b/revision.c
@@ -103,18 +103,6 @@ void mark_parents_uninteresting(struct commit *commit)
 		struct commit *commit = pop_commit(&parents);
 
 		while (commit) {
-			/*
-			 * A missing commit is ok iff its parent is marked
-			 * uninteresting.
-			 *
-			 * We just mark such a thing parsed, so that when
-			 * it is popped next time around, we won't be trying
-			 * to parse it and get an error.
-			 */
-			if (!commit->object.parsed &&
-			    !has_object_file(&commit->object.oid))
-				commit->object.parsed = 1;
-
 			if (commit->object.flags & UNINTERESTING)
 				break;
 
-- 
2.17.0.988.gec4b43b3e5

