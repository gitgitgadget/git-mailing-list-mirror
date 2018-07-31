Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2160C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeGaUqm (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:46:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732006AbeGaUqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:46:42 -0400
Received: (qmail 1507 invoked by uid 109); 31 Jul 2018 19:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 19:05:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4453 invoked by uid 111); 31 Jul 2018 19:05:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 15:05:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 15:04:59 -0400
Date:   Tue, 31 Jul 2018 15:04:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180731190459.GA3372@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
 <20180731172304.GA16977@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731172304.GA16977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:

> On Tue, Jul 31, 2018 at 10:17:15AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > +...
> > > +		} else if (cmp > 0) {
> > >  			/* path2 does not appear in one */
> > > +			score += score_missing(two.entry.mode, two.entry.path);
> > > +			update_tree_entry(&two);
> > > +			continue;
> > > +		} if (oidcmp(one.entry.oid, two.entry.oid)) {
> > 
> > As the earlier ones do the "continue at the end of the block", this
> > does not affect the correctness, but I think you either meant "else if"
> > or a fresh "if/else" that is disconnected from the previous if/else if/...
> > chain.
> 
> Yes, thanks. I actually started to write it without the "continue" at
> all, and a big "else" that checked the "we have both" case. But I backed
> that out (in favor of a smaller diff), and forgot to add back in the
> "else if".

So here it is fixed, and with a commit message. I'm not happy to omit a
regression test, but I actually couldn't come up with a minimal one that
tickled the problem, because we're playing around with heuristics. So I
compensated by probably over-explaining in the commit message. But
clearly this is not a well-tested code path given the length of time
between introducing and detecting the bug.

-- >8 --
Subject: [PATCH] score_trees(): fix iteration over trees with missing entries

In score_trees(), we walk over two sorted trees to find
which entries are missing or have different content between
the two.  So if we have two trees with these entries:

  one   two
  ---   ---
  a     a
  b     c
  c     d

we'd expect the loop to:

  - compare "a" to "a"

  - compare "b" to "c"; because these are sorted lists, we
    know that the second tree does not have "b"

  - compare "c" to "c"

  - compare "d" to end-of-list; we know that the first tree
    does not have "d"

And prior to d8febde370 (match-trees: simplify score_trees()
using tree_entry(), 2013-03-24) that worked. But after that
commit, we mistakenly increment the tree pointers for every
loop iteration, even when we've processed the entry for only
one side. As a result, we end up doing this:

  - compare "a" to "a"

  - compare "b" to "c"; we know that we do not have "b", but
    we still increment both tree pointers; at this point
    we're out of sync and all further comparisons are wrong

  - compare "c" to "d" and mistakenly claim that the second
    tree does not have "c"

  - exit the loop, mistakenly not realizing that the first
    tree does not have "d"

So contrary to the claim in d8febde370, we really do need to
manually use update_tree_entry(), because advancing the tree
pointer depends on the entry comparison.

That means we must stop using tree_entry() to access each
entry, since it auto-advances the pointer. Instead:

  - we'll use tree_desc.size directly to know if there's
    anything left to look at (which is what tree_entry() was
    doing under the hood)

  - rather than do an extra struct assignment to "e1" and
    "e2", we can just access the "entry" field of tree_desc
    directly

That makes us a little more intimate with the tree_desc
code, but that's not uncommon for its callers.

There's no regression test here, as it's a little tricky to
trigger this with a minimal example. The user-visible effect
is that the heuristics fail to correlate two trees that
should be. But in a minimal example, there aren't a lot of
other trees to match, so we often end up doing the right
thing anyway.

A real-world example (from the original bug report) is:

-- >8 --
git init repo
cd repo

echo init >file
git add file
git commit -m init

git remote add tig https://github.com/jonas/tig.git
git fetch tig
git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0
git read-tree --prefix=src/ -u tig-2.3.0
git commit -m 'get upstream tig-2.3.0'

echo update >file
git commit -a -m update

git merge -s subtree tig-2.4.0
-- 8< --

Before this patch, we fail to realize that the tig-2.4.0
content should go into the "src" directory.

Signed-off-by: Jeff King <peff@peff.net>
---
 match-trees.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 4cdeff53e1..37653308d3 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -83,34 +83,43 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
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
+		} else if (cmp > 0) {
 			/* path2 does not appear in one */
-			score += score_missing(e2.mode, e2.path);
-		else if (oidcmp(e1.oid, e2.oid))
-			/* they are different */
-			score += score_differs(e1.mode, e2.mode, e1.path);
-		else
-			/* same subtree or blob */
-			score += score_matches(e1.mode, e2.mode, e1.path);
+			score += score_missing(two.entry.mode, two.entry.path);
+			update_tree_entry(&two);
+		} else {
+			/* path appears in both */
+			if (oidcmp(one.entry.oid, two.entry.oid)) {
+				/* they are different */
+				score += score_differs(one.entry.mode,
+						       two.entry.mode,
+						       one.entry.path);
+			} else {
+				/* same subtree or blob */
+				score += score_matches(one.entry.mode,
+						       two.entry.mode,
+						       one.entry.path);
+			}
+			update_tree_entry(&one);
+			update_tree_entry(&two);
+		}
 	}
 	free(one_buf);
 	free(two_buf);
-- 
2.18.0.796.g4bfd63b683

