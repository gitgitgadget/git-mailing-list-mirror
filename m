From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Try to resurrect the handling for 'diff-index -m'
Date: Sun, 20 Jan 2008 15:21:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201521230.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGc0M-0005cP-EF
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 16:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYATPWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 10:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYATPWH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 10:22:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753432AbYATPWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 10:22:06 -0500
Received: (qmail invoked by alias); 20 Jan 2008 15:22:02 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp032) with SMTP; 20 Jan 2008 16:22:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lLZc0QSWl2b/3ihSaJl9EZYBDbkPHMCeyCDGr5N
	UmhP/9mgkCrTSN
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801201515060.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71180>


run_diff_index() had special handling for 'diff-index -m', which
was lost in the conversion to use unpack_trees() instead of
diff_cache().

---

Also on top of the patches of Junio and Linus.

I am not too certain about this; I just tried to reproduce what the old
code did.

 diff-lib.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 7941486..27032a9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -614,11 +614,19 @@ static int oneway_diff(struct cache_entry **src,
 		tree = NULL;
 
 	/*
+	 * Backward compatibility wart - "diff-index -m" does
+	 * not mean "do not ignore merges", but totally different.
+	 * Therefore, the "match_missing" argument is set to
+	 * "!revs->ignore_merges".
+	 */
+
+	/*
 	 * Something added to the tree?
 	 */
 	if (!tree) {
 		if (ce_path_match(idx, revs->prune_data))
-			show_new_file(revs, idx, o->index_only, 0);
+			show_new_file(revs, idx, o->index_only,
+					!revs->ignore_merges);
 		return 1;
 	}
 
@@ -627,13 +635,15 @@ static int oneway_diff(struct cache_entry **src,
 	 */
 	if (!idx) {
 		if (ce_path_match(tree, revs->prune_data))
-			diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
+			diff_index_show_file(revs, "-",
+					tree, tree->sha1, tree->ce_mode);
 		return 0;
 	}
 
 	/* Show difference between old and new */
 	if (ce_path_match(idx, revs->prune_data))
-		show_modified(revs, tree, idx, 1, o->index_only, 0);
+		show_modified(revs, tree, idx, 1, o->index_only,
+				!revs->ignore_merges);
 	return 1;
 }
 
@@ -644,14 +654,6 @@ int run_diff_index(struct rev_info *revs, int cached)
 	const char *tree_name;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	int match_missing = 0;
-
-	/*
-	 * Backward compatibility wart - "diff-index -m" does
-	 * not mean "do not ignore merges", but totally different.
-	 */
-	if (!revs->ignore_merges)
-		match_missing = 1;
 
 	mark_merge_entries();
 
-- 
1.5.4.rc3.44.g6cd4
