From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Sun, 20 Jan 2008 13:53:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801201338140.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site> <alpine.LSU.1.00.0801201519320.5731@racer.site> <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGi7R-0004Ri-5o
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 22:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYATVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 16:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbYATVxv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 16:53:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32935 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755808AbYATVxu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 16:53:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KLrFLf028767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 13:53:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KLrFsK004382;
	Sun, 20 Jan 2008 13:53:15 -0800
In-Reply-To: <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.722 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71195>



On Sun, 20 Jan 2008, Linus Torvalds wrote:
> 
> The following patch gets us closer, but really only for the "--cached" 
> case (for the non-cached case, it should use the working tree entry ratehr 
> than generate a unmerged entry), and I also suspect there's a case it gets 
> wrong for the case of the unmerged path not existign in the tree at all 
> (the "if (tree)" entry basically ends up being a stand-in for the "is this 
> the first index entry for this path we see" case).

This cleanup patch really looks big and fairly ugly, but it splits up the 
magic rules for "unpack_trees()" and adds a lot of comments about what is 
going on, and in the presense lays the groundwork for doing a much better 
job on unmerged entries - it now keeps track of how many index entries we 
have that match the tree entry we found, so it should be pretty trivial 
to now add the logic to do a combined diff..

It replaces the previous patch, and should fix both of the issues I 
mention above. It adds a lot more lines than it removes, but much of that 
is due to some comments and a lot cleaner abstractions, so that the 
resulting code is, I think, quite a bit more obvious.

The unpack_trees() interface really isn't trivial (it can't be: the things 
we need to do with the index for a merge - at the same time as traversing 
it! - are quite involved). So clarifying all that is definitely worth it.

With this patch in place, I think Dscho's two other patches are now good 
to go, and we now generate the same output we used to. In addition, we now 
have the infrastructure to generate *better* output, so if we want to make 
"git diff HEAD" generate a nice combined diff, this sets the stage for 
that.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diff-lib.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 23d0fa6..2a3a9ff 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -668,45 +668,113 @@ static void mark_merge_entries(void)
 	}
 }
 
-static int oneway_diff(struct cache_entry **src,
-	struct unpack_trees_options *o,
-	int remove)
+/*
+ * This gets a mix of an existing index and a tree, one pathname entry
+ * at a time. The index entry may be a single stage-0 one, but it could
+ * also be multiple unmerged entries (in which case you idx_pos/idx_nr
+ * will give you the position and number of entries in the index).
+ */
+static void do_oneway_diff(struct unpack_trees_options *o,
+	struct cache_entry *idx,
+	struct cache_entry *tree,
+	int idx_pos, int idx_nr)
 {
-	struct cache_entry *idx = src[0];
-	struct cache_entry *tree = src[1];
 	struct rev_info *revs = o->unpack_data;
 
-	/*
-	 * Unpack-trees generates a DF/conflict entry if
-	 * there was a directory in the index and a tree
-	 * in the tree. From a diff standpoint, that's a
-	 * delete of the tree and a create of the file.
-	 */
-	if (tree == o->df_conflict_entry)
-		tree = NULL;
+	if (o->index_only && idx && ce_stage(idx)) {
+		if (tree)
+			diff_unmerge(&revs->diffopt, idx->name, idx->ce_mode, idx->sha1);
+		return;
+	}
 
 	/*
 	 * Something added to the tree?
 	 */
 	if (!tree) {
-		if (ce_path_match(idx, revs->prune_data))
-			show_new_file(revs, idx, o->index_only, 0);
-		return 1;
+		show_new_file(revs, idx, o->index_only, 0);
+		return;
 	}
 
 	/*
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		if (ce_path_match(tree, revs->prune_data))
-			diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
-		return 0;
+		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
+		return;
 	}
 
 	/* Show difference between old and new */
-	if (ce_path_match(idx, revs->prune_data))
-		show_modified(revs, tree, idx, 1, o->index_only, 0);
-	return 1;
+	show_modified(revs, tree, idx, 1, o->index_only, 0);
+}
+
+/*
+ * Count how many index entries go with the first one
+ */
+static inline int count_skip(const struct cache_entry *src, int pos)
+{
+	int skip = 1;
+
+	/* We can only have multiple entries if the first one is not stage-0 */
+	if (ce_stage(src)) {
+		struct cache_entry **p = active_cache + pos;
+		int namelen = ce_namelen(src);
+
+		for (;;) {
+			const struct cache_entry *ce;
+			pos++;
+			if (pos >= active_nr)
+				break;
+			ce = *++p;
+			if (ce_namelen(ce) != namelen)
+				break;
+			if (memcmp(ce->name, src->name, namelen))
+				break;
+			skip++;
+		}
+	}
+	return skip;
+}
+
+/*
+ * The unpack_trees() interface is designed for merging, so
+ * the different source entries are designed primarily for
+ * the source trees, with the old index being really mainly
+ * used for being replaced by the result.
+ *
+ * For diffing, the index is more important, and we only have a
+ * single tree.  
+ *
+ * We're supposed to return how many index entries we want to skip.
+ *
+ * This wrapper makes it all more readable, and takes care of all
+ * the fairly complex unpack_trees() semantic requirements, including
+ * the skipping, the path matching, the type conflict cases etc.
+ */
+static int oneway_diff(struct cache_entry **src,
+	struct unpack_trees_options *o,
+	int index_pos)
+{
+	int skip = 0;
+	struct cache_entry *idx = src[0];
+	struct cache_entry *tree = src[1];
+	struct rev_info *revs = o->unpack_data;
+
+	if (index_pos >= 0)
+		skip = count_skip(idx, index_pos);
+
+	/*
+	 * Unpack-trees generates a DF/conflict entry if
+	 * there was a directory in the index and a tree
+	 * in the tree. From a diff standpoint, that's a
+	 * delete of the tree and a create of the file.
+	 */
+	if (tree == o->df_conflict_entry)
+		tree = NULL;
+
+	if (ce_path_match(idx ? idx : tree, revs->prune_data))
+		do_oneway_diff(o, idx, tree, index_pos, skip);
+
+	return skip;
 }
 
 int run_diff_index(struct rev_info *revs, int cached)
