From: Jeff King <peff@peff.net>
Subject: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 03:13:24 -0500
Message-ID: <20141107081324.GA19845@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 09:13:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmefj-00072W-Es
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 09:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaKGIN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 03:13:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:37472 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751292AbaKGIN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 03:13:27 -0500
Received: (qmail 451 invoked by uid 102); 7 Nov 2014 08:13:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 02:13:27 -0600
Received: (qmail 16601 invoked by uid 107); 7 Nov 2014 08:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 03:13:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2014 03:13:24 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that "git checkout $tree -- $path" will _always_ unlink and
write a new copy of each matching path, even if they are up-to-date with
the index and the content in $tree is the same.

Here's a simple reproduction:

    # some repo with a file in it
    git init
    echo content >foo && git add foo && git commit -m foo
    
    # give the file a known timestamp (it doesn't matter what)
    perl -e 'utime(123, 123, @ARGV)' foo
    git update-index --refresh
    
    # now check out an identical copy
    git checkout HEAD -- foo
    
    # and check whether it was updated
    perl -le 'print ((stat)[9]) for @ARGV' foo

which yields a modern timestamp, showing that the file was rewritten.

If you use

    git checkout -- foo

instead to checkout from the index, that works fine (the final line
prints 123). Similarly, if you load the new index and checkout
separately, like:

    git read-tree -m $tree
    git checkout -- foo

that also works. Of course it is not quite the same; read-tree loads the
whole index from $tree, whereas checkout would only touch a subset of
the entries. And that's the culprit; checkout does not use unpack-trees
to only touch the entries that need updating. It uses read_tree_recursive
with a pathspec, and just replaces any index entries that match.

Below is a patch which makes it do what I expect by silently copying
flags and stat-data from the old entry, but I feel like it is going in
the wrong direction. Besides causing a few tests to fail (which I
suspect is because I implemented it at the wrong layer), it really feels
like this should be using unpack-trees or something similar.

After all, that is what "git reset $tree -- foo" does, and it gets this
case right (in fact, you can replace the read-tree above with it). It
looks like it actually does a pathspec-limited index-diff rather than
unpack-trees, but the end effect is the same (and while checkout could
just pass "update" to unpack-trees, we need to handle checking out
directly from the index anyway, so I do not think it is a big deal to
keep the index update as a separate step).

Is there a reason that we don't use this diff technique for checkout?

Anyway, here is the (wrong) patch I came up with initially.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29b0f6d..802e556 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -273,19 +273,13 @@ static int checkout_paths(const struct checkout_opts *opts,
 		ce->ce_flags &= ~CE_MATCHED;
 		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
 			continue;
-		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
-			/*
-			 * "git checkout tree-ish -- path", but this entry
-			 * is in the original index; it will not be checked
-			 * out to the working tree and it does not matter
-			 * if pathspec matched this entry.  We will not do
-			 * anything to this entry at all.
-			 */
-			continue;
+
 		/*
-		 * Either this entry came from the tree-ish we are
-		 * checking the paths out of, or we are checking out
-		 * of the index.
+		 * If we are checking out from a tree-ish, we already
+		 * did our pathspec matching.  However, since we then
+		 * drop the CE_UPDATE flag from any paths that do not
+		 * need updating, we don't know which ones were not
+		 * mentioned and which ones were simply up-to-date.
 		 *
 		 * If it comes from the tree-ish, we already know it
 		 * matches the pathspec and could just stamp
diff --git a/read-cache.c b/read-cache.c
index 8f3e9eb..fb2240b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -962,8 +962,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-		if (!new_only)
+		if (!new_only) {
+			struct cache_entry *old = istate->cache[pos];
+			if (!is_null_sha1(ce->sha1) &&
+			    !hashcmp(old->sha1, ce->sha1))
+				copy_cache_entry(ce, old);
 			replace_index_entry(istate, pos, ce);
+		}
 		return 0;
 	}
 	pos = -pos-1;
