From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Sun, 20 Jan 2008 15:19:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201519320.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGbyx-0005JU-7B
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 16:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbYATPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 10:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbYATPUN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 10:20:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753709AbYATPUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 10:20:11 -0500
Received: (qmail invoked by alias); 20 Jan 2008 15:20:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 20 Jan 2008 16:20:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kEgAsXNkkIhBKRHKb5/EY4ibTLR1hXR/REtbPR9
	GQkWd/Z9vnJjUO
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801201515060.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71179>


As in run_diff_index(), we call unpack_trees() with the oneway_diff()
function in do_diff_cache() now.  This makes the function diff_cache()
obsolete.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Obviously on top of Junio's + Linus' patch.

 diff-lib.c |   92 ++++++++---------------------------------------------------
 1 files changed, 13 insertions(+), 79 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dc7b514..7941486 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -580,81 +580,6 @@ static int show_modified(struct rev_info *revs,
 	return 0;
 }
 
-static int diff_cache(struct rev_info *revs,
-		      struct cache_entry **ac, int entries,
-		      const char **pathspec,
-		      int cached, int match_missing)
-{
-	while (entries) {
-		struct cache_entry *ce = *ac;
-		int same = (entries > 1) && ce_same_name(ce, ac[1]);
-
-		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
-			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
-			break;
-
-		if (!ce_path_match(ce, pathspec))
-			goto skip_entry;
-
-		switch (ce_stage(ce)) {
-		case 0:
-			/* No stage 1 entry? That means it's a new file */
-			if (!same) {
-				show_new_file(revs, ce, cached, match_missing);
-				break;
-			}
-			/* Show difference between old and new */
-			show_modified(revs, ac[1], ce, 1,
-				      cached, match_missing);
-			break;
-		case 1:
-			/* No stage 3 (merge) entry?
-			 * That means it's been deleted.
-			 */
-			if (!same) {
-				diff_index_show_file(revs, "-", ce,
-						     ce->sha1, ce->ce_mode);
-				break;
-			}
-			/* We come here with ce pointing at stage 1
-			 * (original tree) and ac[1] pointing at stage
-			 * 3 (unmerged).  show-modified with
-			 * report-missing set to false does not say the
-			 * file is deleted but reports true if work
-			 * tree does not have it, in which case we
-			 * fall through to report the unmerged state.
-			 * Otherwise, we show the differences between
-			 * the original tree and the work tree.
-			 */
-			if (!cached &&
-			    !show_modified(revs, ce, ac[1], 0,
-					   cached, match_missing))
-				break;
-			diff_unmerge(&revs->diffopt, ce->name,
-				     ntohl(ce->ce_mode), ce->sha1);
-			break;
-		case 3:
-			diff_unmerge(&revs->diffopt, ce->name,
-				     0, null_sha1);
-			break;
-
-		default:
-			die("impossible cache entry stage");
-		}
-
-skip_entry:
-		/*
-		 * Ignore all the different stages for this file,
-		 * we've handled the relevant cases now.
-		 */
-		do {
-			ac++;
-			entries--;
-		} while (entries && ce_same_name(ce, ac[0]));
-	}
-	return 0;
-}
-
 /*
  * This turns all merge entries into "stage 3". That guarantees that
  * when we read in the new tree (into "stage 1"), we won't lose sight
@@ -758,6 +683,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	int i;
 	struct cache_entry **dst;
 	struct cache_entry *last = NULL;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
 
 	/*
 	 * This is used by git-blame to run diff-cache internally;
@@ -786,8 +713,15 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	tree = parse_tree_indirect(tree_sha1);
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
-	if (read_tree(tree, 1, opt->paths))
-		return error("unable to read tree %s", sha1_to_hex(tree_sha1));
-	return diff_cache(&revs, active_cache, active_nr, revs.prune_data,
-			  1, 0);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.index_only = 1;
+	opts.merge = 1;
+	opts.fn = oneway_diff;
+	opts.unpack_data = &revs;
+
+	init_tree_desc(&t, tree->buffer, tree->size);
+	unpack_trees(1, &t, &opts);
+	return 0;
 }
-- 
1.5.4.rc3.44.g6cd4
