Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6438E1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 14:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbcHIOEQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 10:04:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52007 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932190AbcHIOEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 10:04:15 -0400
Received: (qmail 31072 invoked by uid 109); 9 Aug 2016 14:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 14:04:14 +0000
Received: (qmail 20745 invoked by uid 111); 9 Aug 2016 14:04:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 10:04:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 10:04:12 -0400
Date:	Tue, 9 Aug 2016 10:04:12 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over
 packs
Message-ID: <20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
 <20160729041524.GG22408@sigill.intra.peff.net>
 <20160729054536.GA27343@sigill.intra.peff.net>
 <xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
 <20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
 <xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
 <20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
 <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 10:16:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It worries me a lot to lose the warning unconditionally, though.
> >> That's the (only) coal-mine canary that lets us notice a problem
> >> when we actually start hitting that last-ditch cycle breaking too
> >> often.
> >
> > The dedicated cycle-detection will lose that warning, too (it doesn't
> > touch that code, but it's effectively checking the same thing earlier).
> >
> > I agree it's unfortunate to lose. On the other hand, it is being lost
> > because we are correctly handling the cycles, and there is nothing to
> > warn about. So it ceases to be a problem, and starts being a normal,
> > acceptable thing.
> 
> That unfortunately is beside the point.  The existing cycle breaking
> was meant to be a last ditch effort to avoid producing a broken pack
> (i.e. a suboptimal pack without cycle is better than unusable pack
> with delta cycle), while letting us know that we found a case where
> the remainder of the pack building machinery does not function well
> without it (so that we know we broke something when we tweaked the
> machinery without intending to break it).  Squelching the warnings
> feels similar to "we see too many valgrind warnings, so let's stop
> running valgrind"; I was hoping there would be a solution more like
> "instead of not running, let's teach valgrind this and that codepath
> is OK".

I don't think there is a way to do "this code path is OK", exactly.
Though by putting cycle-breaking at the check_object() stage, the
warning at the write_object() stage would continue to ensure that we
don't introduce any new cycles with our delta search. So that does have
some value.

Here's the code to do the cycle-breaking. Aside from the "hacky" bit,
it's quite simple.  I added a new state enum to object_entry to handle
the graph traversal. Since it only needs 2 bits, I _assume_ a compiler
can fit it in with the bitfields above (or at the very least give it its
own single byte so we just use what would otherwise be struct padding).
But I didn't check; if it turns out not to be the case we can easily
emulate it with two bitfields.  The write_object() check abuses the
"idx.offset" field to keep the same state, but we could convert it to
use these flags if we care.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c91d54a..07b6fea 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1499,6 +1499,67 @@ static int pack_offset_sort(const void *_a, const void *_b)
 			(a->in_pack_offset > b->in_pack_offset);
 }
 
+/*
+ * Follow the chain of deltas from this entry onward, throwing away any links
+ * that cause us to hit a cycle (as determined by the DFS state flags in
+ * the entries).
+ */
+static void break_delta_cycles(struct object_entry *entry)
+{
+	/* If it's not a delta, it can't be part of a cycle. */
+	if (!entry->delta) {
+		entry->dfs_state = DFS_DONE;
+		return;
+	}
+
+	switch (entry->dfs_state) {
+	case DFS_NONE:
+		/*
+		 * This is the first time we've seen the object. We become part
+		 * of the active potential cycle and recurse.
+		 */
+		entry->dfs_state = DFS_ACTIVE;
+		break_delta_cycles(entry->delta);
+		entry->dfs_state = DFS_DONE;
+		break;
+
+	case DFS_DONE:
+		/* object already examined, and not part of a cycle */
+		break;
+
+	case DFS_ACTIVE:
+		/*
+		 * We found a cycle that needs broken. We have to not only
+		 * drop our entry->delta link, but we need to remove
+		 * ourselves from the delta_sibling chain of our base.
+		 */
+		{
+			struct object_entry **p = &entry->delta->delta_child;
+			while (*p) {
+				if (*p == entry)
+					*p = (*p)->delta_sibling;
+				else
+					p = &(*p)->delta_sibling;
+			}
+		}
+		entry->delta = NULL;
+
+		/*
+		 * XXX This is hacky. We need to figure out our real size (not
+		 * the delta size). check_object() already does this, so let's
+		 * just re-run it, but telling it not to reuse any deltas. This
+		 * probably should just be a single function to track down the
+		 * size from the delta (or even just sha1_object_info(),
+		 * though that is a little less efficient because we already
+		 * know which pack we're in).
+		 */
+		reuse_delta = 0;
+		check_object(entry);
+		reuse_delta = 1;
+		break;
+	}
+}
+
 static void get_object_details(void)
 {
 	uint32_t i;
@@ -1516,6 +1577,13 @@ static void get_object_details(void)
 			entry->no_try_delta = 1;
 	}
 
+	/*
+	 * This must happen in a second pass, since we rely on the delta
+	 * information for the whole list being completed.
+	 */
+	for (i = 0; i < to_pack.nr_objects; i++)
+		break_delta_cycles(&to_pack.objects[i]);
+
 	free(sorted_by_offset);
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..cc9b9a9 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -27,6 +27,15 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+
+	/*
+	 * State flags for depth-first search used for analyzing delta cycles.
+	 */
+	enum {
+		DFS_NONE = 0,
+		DFS_ACTIVE,
+		DFS_DONE
+	} dfs_state;
 };
 
 struct packing_data {


It seems to perform well, and it does break the cycles (the later check
during the write does not kick in, and we get no warnings). I didn't dig
into the fates of specific objects, but any cycles should be added to
the delta-compression phase.

The resulting pack size is almost exactly what it was with hitting the
write_object() check. So that means all of my testing was really not
that interesting, because the extra space isn't coming from the delta
cycles at all. It's simply an artifact of the different set of objects
we happen to find (just as reversing the pack list produces a different
order, with a different size).

So it happens to be a 3% loss in this case. I'm not convinced it would
not actually be a win in some other cases. But more importantly, in a
repository with fewer packs, it would likely be a much smaller
difference (in either direction), just because there's less play in
where we find a given object.

I think my preference is to clean up the "hacky" bit of this patch, and
then apply the earlier MRU patch on top of it (which takes my repack
from 44 minutes to 5 minutes for this particular test set). I see you
graduated the earlier bits of the series to "master" already.

-Peff
