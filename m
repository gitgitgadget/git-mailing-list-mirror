Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A246202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbdCIN24 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:28:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:41259 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbdCIN24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:28:56 -0500
Received: (qmail 19531 invoked by uid 109); 9 Mar 2017 13:28:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:28:50 +0000
Received: (qmail 3665 invoked by uid 111); 9 Mar 2017 13:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 08:28:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 08:28:48 -0500
Date:   Thu, 9 Mar 2017 08:28:48 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/4] ref-filter: use contains_result enum consistently
Message-ID: <20170309132847.ptysbio377cy765j@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cbc60b672 (git tag --contains: avoid stack overflow,
2014-04-24) adapted the -1/0/1 contains status into a
tri-state enum. However, some of the code still used the
numeric values, or assumed that no/yes correspond to C's
boolean true/false.

Let's switch to using the symbolic values everywhere, which
will make it easier to change them.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6546dba73..631978a4f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1513,20 +1513,20 @@ static enum contains_result contains_test(struct commit *candidate,
 {
 	/* was it previously marked as containing a want commit? */
 	if (candidate->object.flags & TMP_MARK)
-		return 1;
+		return CONTAINS_YES;
 	/* or marked as not possibly containing a want commit? */
 	if (candidate->object.flags & UNINTERESTING)
-		return 0;
+		return CONTAINS_NO;
 	/* or are we it? */
 	if (in_commit_list(want, candidate)) {
 		candidate->object.flags |= TMP_MARK;
-		return 1;
+		return CONTAINS_YES;
 	}
 
 	if (parse_commit(candidate) < 0)
-		return 0;
+		return CONTAINS_NO;
 
-	return -1;
+	return CONTAINS_UNKNOWN;
 }
 
 static void push_to_contains_stack(struct commit *candidate, struct contains_stack *contains_stack)
@@ -1540,7 +1540,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		const struct commit_list *want)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
-	int result = contains_test(candidate, want);
+	enum contains_result result = contains_test(candidate, want);
 
 	if (result != CONTAINS_UNKNOWN)
 		return result;
@@ -1557,7 +1557,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 		/*
 		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful 0 or 1.
+		 * therefore contains_test will return a meaningful yes/no.
 		 */
 		else switch (contains_test(parents->item, want)) {
 		case CONTAINS_YES:
@@ -1579,7 +1579,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 static int commit_contains(struct ref_filter *filter, struct commit *commit)
 {
 	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, filter->with_commit);
+		return contains_tag_algo(commit, filter->with_commit) == CONTAINS_YES;
 	return is_descendant_of(commit, filter->with_commit);
 }
 
-- 
2.12.0.445.g818af77e0

