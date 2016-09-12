Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB30207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbcILR4r (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:56:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751092AbcILR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:56:46 -0400
Received: (qmail 20693 invoked by uid 109); 12 Sep 2016 17:56:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 17:56:44 +0000
Received: (qmail 14970 invoked by uid 111); 12 Sep 2016 17:56:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 13:56:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 13:56:41 -0400
Date:   Mon, 12 Sep 2016 13:56:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 0/2] patch-id for merges
Message-ID: <20160912175641.nj4h6oupbwaedwbx@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
 <xmqqfup8aiud.fsf@gitster.mtv.corp.google.com>
 <20160912155930.2acw4265nfjq3uyj@sigill.intra.peff.net>
 <xmqq37l53ul2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37l53ul2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 10:18:33AM -0700, Junio C Hamano wrote:

> > +static int patch_id_defined(struct commit *commit)
> > +{
> > +	/* must be 0 or 1 parents */
> > +	return !commit->parents || !commit->parents->next;
> > +}
> 
> If we make the first hunk begin like so:
> 
> > +	if (commit->parents) {
> > +		if (!patch_id_defined(commit))
> > +			return -1;
> 
> I wonder if the compiler gives us the same code.

Good idea. I actually put the "patch_id_defined" check outside the "if"
block you've quoted (otherwise we're making assumptions about the
contents of patch_id_defined).

I didn't check that the compiler generates the same code, but I'm
willing to blindly put faith in it. Either it will inline
patch_id_defined and optimize out the double-conditional, or it probably
doesn't matter in practice. Either way, the compiler is probably smarter
than me, and we should shoot for readability and not repeating
ourselves.

> > I'd probably do a preparatory patch to drop the return value from
> > add_commit_patch_id(). No callers actually look at it.

I decided against this. Technically add_commit_patch_id() can return an
error via the header-only diff_flush_patch_id(), and we'd be shutting
that down. Of course no callers actually _care_ about that right now, so
it doesn't matter at this point. But I'd prefer to punt it down the line
for when somebody does (and the solution may be to distinguish between
those two return codes, or it may be for the caller to have access to
patch_id_defined(); we won't know until we see the code).

So here's the replacement for 2/2:

-- >8 --
Subject: [PATCH] patch-ids: refuse to compute patch-id for merge commit

The patch-id code which powers "log --cherry-pick" doesn't
look at whether each commit is a merge or not. It just feeds
the commit's first parent to the diff, and ignores any
additional parents.

In theory, this might be useful if you wanted to find
equivalence between, say, a merge commit and a squash-merge
that does the same thing.  But it also promotes a false
equivalence between distinct merges. For example, every
"merge -s ours" would look identical to an empty commit
(which is true in a sense, but presumably there was a value
in merging in the discarded history). Since patch-ids are
meant for throwing away duplicates, we should err on the
side of _not_ matching such merges.

Moreover, we may spend a lot of extra time computing these
merge diffs. In the case that inspired this patch, a "git
format-patch --cherry-pick" dropped from over 3 minutes to
less than 3 seconds.

This seems pretty drastic, but is easily explained. The
command was invoked by a "git rebase" of an older topic
branch; there had been tens of thousands of commits on the
upstream branch in the meantime. In addition, this project
used a topic-branch workflow with occasional "back-merges"
from "master" to each topic (to resolve conflicts on the
topics rather than in the merge commits). So there were not
only extra merges, but the diffs for these back-merges were
generally quite large (because they represented _everything_
that had been merged to master since the topic branched).

This patch treats a merge fed to commit_patch_id() or
add_commit_patch_id() as an error, and a lookup for such a
merge via has_commit_patch_id() will always return NULL.
An earlier version of the patch tried to distinguish between
"error" and "patch id for merges not defined", but that
becomes unnecessarily complicated. The only callers are:

  1. revision traversals which want to do --cherry-pick;
     they call add_commit_patch_id(), but do not care if it
     fails. They only want to add what we can, look it up
     later with has_commit_patch_id(), and err on the side
     of not-matching.

  2. format-patch --base, which calls commit_patch_id().
     This _does_ notice errors, but should never feed a
     merge in the first place (and if it were to do so
     accidentally, then this patch is a strict improvement;
     we notice the bug rather than generating a bogus
     patch-id).

So in both cases, this does the right thing.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 patch-ids.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/patch-ids.c b/patch-ids.c
index 77e4663..ce285c2 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -4,9 +4,18 @@
 #include "sha1-lookup.h"
 #include "patch-ids.h"
 
+static int patch_id_defined(struct commit *commit)
+{
+	/* must be 0 or 1 parents */
+	return !commit->parents || !commit->parents->next;
+}
+
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1, int diff_header_only)
 {
+	if (!patch_id_defined(commit))
+		return -1;
+
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
 			       commit->object.oid.hash, "", options);
@@ -77,6 +86,9 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 {
 	struct patch_id patch;
 
+	if (!patch_id_defined(commit))
+		return NULL;
+
 	memset(&patch, 0, sizeof(patch));
 	if (init_patch_id_entry(&patch, commit, ids))
 		return NULL;
@@ -89,6 +101,9 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
 {
 	struct patch_id *key = xcalloc(1, sizeof(*key));
 
+	if (!patch_id_defined(commit))
+		return NULL;
+
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
-- 
2.10.0.230.g6f8d04b

