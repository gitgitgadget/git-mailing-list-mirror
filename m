Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EABC1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeHBUur (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:50:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:40714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726580AbeHBUur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:50:47 -0400
Received: (qmail 22616 invoked by uid 109); 2 Aug 2018 18:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 18:58:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26892 invoked by uid 111); 2 Aug 2018 18:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 14:58:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:58:21 -0400
Date:   Thu, 2 Aug 2018 14:58:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180802185821.GD23690@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
 <20180731172304.GA16977@sigill.intra.peff.net>
 <20180731190459.GA3372@sigill.intra.peff.net>
 <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
 <d60fc243-7271-bc49-b687-ade2b6e315ea@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d60fc243-7271-bc49-b687-ade2b6e315ea@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 01, 2018 at 02:58:50AM +0200, René Scharfe wrote:

> Am 31.07.2018 um 23:06 schrieb Junio C Hamano:
> > Jeff King <peff@peff.net> writes:
> > 
> >> On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:
> >> ...
> >> So here it is fixed, and with a commit message. I'm not happy to omit a
> >> regression test, but I actually couldn't come up with a minimal one that
> >> tickled the problem, because we're playing around with heuristics.
> How about something like this? (squashable)

Thanks. This is quite similar to what I tried, but I had started a new
script, and I suspect that what is in t6029's master branch tickles the
heuristic in a more interesting way. Or possibly I just botched my
attempt, though I did spend quite a bit of time fiddling with it. The
master branch seems to only contain one file, "hello". Hmph.

At any rate, it does trigger the bug and demonstrate the fix, so let's
go with it. I see Junio already squashed the tests into
jk/merge-subtree-heuristics, but I think we can cut down the commit
message a bit (and stop claiming that we don't have a test ;) ).  Like
so (and yes, this version omits the extra scissors):

-- >8 --
Subject: score_trees(): fix iteration over trees with missing entries

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

The included test shows off the bug by adding a new entry
"bar.t", which sorts early in the tree and de-syncs the
comparison for "foo.t", which comes after.

Reported-by: George Shammas <georgyo@gmail.com>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 match-trees.c            | 43 ++++++++++++++++++++++++----------------
 t/t6029-merge-subtree.sh | 28 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 17 deletions(-)

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
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3e692454a7..474a850de6 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -29,6 +29,34 @@ test_expect_success 'subtree available and works like recursive' '
 
 '
 
+test_expect_success 'setup branch sub' '
+	git checkout --orphan sub &&
+	git rm -rf . &&
+	test_commit foo
+'
+
+test_expect_success 'setup branch main' '
+	git checkout -b main master &&
+	git merge -s ours --no-commit --allow-unrelated-histories sub &&
+	git read-tree --prefix=dir/ -u sub &&
+	git commit -m "initial merge of sub into main" &&
+	test_path_is_file dir/foo.t &&
+	test_path_is_file hello
+'
+
+test_expect_success 'update branch sub' '
+	git checkout sub &&
+	test_commit bar
+'
+
+test_expect_success 'update branch main' '
+	git checkout main &&
+	git merge -s subtree sub -m "second merge of sub into main" &&
+	test_path_is_file dir/bar.t &&
+	test_path_is_file dir/foo.t &&
+	test_path_is_file hello
+'
+
 test_expect_success 'setup' '
 	mkdir git-gui &&
 	cd git-gui &&
-- 
2.18.0.800.g770d9f3396



