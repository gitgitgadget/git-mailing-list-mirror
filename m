Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A181F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeGaR5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:57:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727569AbeGaR5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:57:03 -0400
Received: (qmail 27296 invoked by uid 109); 31 Jul 2018 16:16:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 16:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1793 invoked by uid 111); 31 Jul 2018 16:16:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 12:16:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 12:15:59 -0400
Date:   Tue, 31 Jul 2018 12:15:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180731161559.GB16910@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 08:53:23AM -0700, Junio C Hamano wrote:

> George Shammas <georgyo@gmail.com> writes:
> 
> > Bisecting around, this might be the commit that introduced the breakage.
> >
> > https://github.com/git/git/commit/d8febde
> 
> Interesting.  I've never used the "-s subtree" strategy without
> "-Xsubtree=..." to explicitly tell where the thing should go for a
> long time, so I am not surprised if I did not notice if an update to
> the heuristics made long time ago had affected tree matching.
> 
> d8febde3 ("match-trees: simplify score_trees() using tree_entry()",
> 2013-03-24) does touch the area that may affect the subtree matching
> behaviour.
> 
> Because it is an update to heuristics, and as such, we need to be
> careful when saying it is or is not "broken".  Some heuristics may
> work better with your particular case, and may do worse with other
> cases.
> 
> But from the log message description, it looks like it was meant to
> be a no-op simplification rewrite that should not affect the outcome,
> so it is a bit surprising.

Yeah, this is definitely not "well, the heuristic changed a bit". It's
just broken. This fixes it, but we should probably add a test.

diff --git a/match-trees.c b/match-trees.c
index 4cdeff53e1..730fff4cfb 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -83,34 +83,40 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 	int score = 0;
 
 	for (;;) {
-		struct name_entry e1, e2;
-		int got_entry_from_one = tree_entry(&one, &e1);
-		int got_entry_from_two = tree_entry(&two, &e2);
 		int cmp;
 
-		if (got_entry_from_one && got_entry_from_two)
-			cmp = base_name_entries_compare(&e1, &e2);
-		else if (got_entry_from_one)
+		if (one.size && two.size)
+			cmp = base_name_entries_compare(&one.entry, &two.entry);
+		else if (one.size)
 			/* two lacks this entry */
 			cmp = -1;
-		else if (got_entry_from_two)
+		else if (two.size)
 			/* two has more entries */
 			cmp = 1;
 		else
 			break;
 
-		if (cmp < 0)
+		if (cmp < 0) {
 			/* path1 does not appear in two */
-			score += score_missing(e1.mode, e1.path);
-		else if (cmp > 0)
+			score += score_missing(one.entry.mode, one.entry.path);
+			update_tree_entry(&one);
+			continue;
+		} else if (cmp > 0) {
 			/* path2 does not appear in one */
-			score += score_missing(e2.mode, e2.path);
-		else if (oidcmp(e1.oid, e2.oid))
+			score += score_missing(two.entry.mode, two.entry.path);
+			update_tree_entry(&two);
+			continue;
+		} if (oidcmp(one.entry.oid, two.entry.oid)) {
 			/* they are different */
-			score += score_differs(e1.mode, e2.mode, e1.path);
-		else
+			score += score_differs(one.entry.mode, two.entry.mode,
+					       one.entry.path);
+		} else {
 			/* same subtree or blob */
-			score += score_matches(e1.mode, e2.mode, e1.path);
+			score += score_matches(one.entry.mode, two.entry.mode,
+					       one.entry.path);
+		}
+		update_tree_entry(&one);
+		update_tree_entry(&two);
 	}
 	free(one_buf);
 	free(two_buf);
