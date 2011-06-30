From: Jeff King <peff@peff.net>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 15:13:39 -0400
Message-ID: <20110630191339.GA9176@sigill.intra.peff.net>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
 <20110630072559.GA4048@pengutronix.de>
 <20110630193023.6056d48e.sfr@canb.auug.org.au>
 <20110630121710.GJ11559@pengutronix.de>
 <BANLkTi=usrsF60Popfu55v3_dXe7Yo0GrA@mail.gmail.com>
 <7v4o37qhi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 21:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcMgN-0007Gj-6L
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab1F3TNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 15:13:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42470
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795Ab1F3TNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 15:13:41 -0400
Received: (qmail 28197 invoked by uid 107); 30 Jun 2011 19:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jun 2011 15:13:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2011 15:13:39 -0400
Content-Disposition: inline
In-Reply-To: <7v4o37qhi6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176503>

On Thu, Jun 30, 2011 at 11:52:17AM -0700, Junio C Hamano wrote:

> I would have to say that it would boil down to "re-do the merge" whichever
> way we implement it, and it is not necessarily a bad thing.  
> 
> There are ideas to implement a mode of "git merge" that works entirely
> in-core without touching the working tree (it may have to write temporary
> blobs and possibly trees to the object store, though). It would let sites
> like github to let its users accept a trivial pull request that can merge
> cleanly on site in the browser without necessarily having to have a local
> checkout used for conflict resolution.
> 
> If such an "in-core merge" feature is implemented cleanly in a reusable
> way, it would be just the matter of comparing the output from it with the
> actual committed result.

Below is my unpolished, probably-buggy-as-hell patch to do the in-core
content merge.  But there are still two sticking points:

  1. This is a dirt-simple 3-way content merge. The actual merge would
     likely have used some more complex strategy. So you're going to see
     discrepancies between a real merge, even a correct one, and what
     this produces (e.g., in the face of renames detected by
     merge-recursive).

  2. This just makes read-tree do the content merge where it doesn't
     conflict, and leaves the conflicted cases unmerged in the index.
     Which is of course the only sane thing to put in the index.

     But what do you want to do about comparing entries with conflicts,
     which are the really interesting bits?  Compare the result to the
     version of the file with conflict markers? If so, where do you want
     to store the file with conflict markers?  I guess we could generate
     an in-core index with the conflict markers that we are just going
     to throw away. That seems pretty hack-ish.

-Peff

-- >8 --
Subject: [PATCH] teach read-tree to do content-level merges

Read-tree will resolve simple 3-way merges, such as a path
touched on one branch but not on the other. With
--aggressive, it will also do some more complex merges, like
both sides adding the same content. But it always stops
short of actually merging content, leaving the unmerged
paths in the index.

One can always use "git merge-index git-merge-one-file -a"
to do a content-level merge of these paths. However, that
has two disadvantages:

  1. It's slower, as we actually invoke merge-one-file for
     each unmerged path, which in turns writes temporary
     files to the filesystem.

  2. It requires a working directory to store the merged
     result. When working in a bare repository, this can be
     inconvenient.

Instead, let's have read-tree perform the content-level
merge in core. If it results in conflicts, read-tree can
simply punt and leave the unmerged entries in the index.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/read-tree.c |    2 +
 unpack-trees.c      |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h      |    1 +
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index df6c4c8..392c378 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -117,6 +117,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			    "3-way merge if no file level merging required", 1),
 		OPT_SET_INT(0, "aggressive", &opts.aggressive,
 			    "3-way merge in presence of adds and removes", 1),
+		OPT_SET_INT(0, "merge-content", &opts.file_level_merge,
+			    "3-way merge of non-conflicting file content", 1),
 		OPT_SET_INT(0, "reset", &opts.reset,
 			    "same as -m, but discard unmerged entries", 1),
 		{ OPTION_STRING, 0, "prefix", &opts.prefix, "<subdirectory>/",
diff --git a/unpack-trees.c b/unpack-trees.c
index 3a61d82..0443fcf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,8 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "xdiff-interface.h"
+#include "blob.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1515,6 +1517,45 @@ static void show_stage_entry(FILE *o,
 }
 #endif
 
+static int file_level_merge(unsigned char sha1[20],
+			    struct cache_entry *old,
+			    struct cache_entry *head,
+			    struct cache_entry *remote)
+{
+	mmfile_t old_data = {0}, head_data = {0}, remote_data = {0};
+	mmbuffer_t resolved = {0};
+	xmparam_t xmp = {{0}};
+	int ret = -1;
+
+	if (remote->ce_mode != head->ce_mode &&
+	    remote->ce_mode != old->ce_mode)
+		goto out;
+
+	read_mmblob(&old_data, old->sha1);
+	if (buffer_is_binary(old_data.ptr, old_data.size))
+		goto out;
+	read_mmblob(&head_data, head->sha1);
+	if (buffer_is_binary(head_data.ptr, head_data.size))
+		goto out;
+	read_mmblob(&remote_data, remote->sha1);
+	if (buffer_is_binary(remote_data.ptr, remote_data.size))
+		goto out;
+
+	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
+	if (xdl_merge(&old_data, &head_data, &remote_data, &xmp, &resolved))
+		goto out;
+	if (write_sha1_file(resolved.ptr, resolved.size, blob_type, sha1) < 0)
+		die("unable to write resolved blob object");
+	ret = 0;
+
+out:
+	free(old_data.ptr);
+	free(head_data.ptr);
+	free(remote_data.ptr);
+	free(resolved.ptr);
+	return ret;
+}
+
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 {
 	struct cache_entry *index;
@@ -1653,6 +1694,34 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 			return -1;
 	}
 
+	if (o->file_level_merge &&
+	    !no_anc_exists && head && remote && !head_match && !remote_match) {
+		int i;
+		struct cache_entry *old = NULL;
+		unsigned char sha1[20];
+
+		for (i = 1; i < o->head_idx; i++) {
+			if (stages[i] && stages[i] != o->df_conflict_entry) {
+				old = stages[i];
+				break;
+			}
+		}
+		if (!old)
+			die("BUG: file-level merge couldn't find ancestor");
+
+		if (file_level_merge(sha1, old, head, remote) == 0) {
+			/* ugh */
+			unsigned char tmp[20];
+			int r;
+
+			hashcpy(tmp, head->sha1);
+			hashcpy(head->sha1, sha1);
+			r = merged_entry(head, index, o);
+			hashcpy(head->sha1, tmp);
+			return r;
+		}
+	}
+
 	o->nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #10, #11. */
diff --git a/unpack-trees.h b/unpack-trees.h
index 7998948..516c2f1 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -40,6 +40,7 @@ struct unpack_trees_options {
 		     trivial_merges_only,
 		     verbose_update,
 		     aggressive,
+		     file_level_merge,
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
-- 
1.7.6.15.ga6419
