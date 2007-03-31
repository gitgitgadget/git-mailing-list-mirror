From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Keep rename/rename conflicts of intermediate merges while doing recursive merge
Date: Sat, 31 Mar 2007 13:49:38 +0200
Message-ID: <20070331114938.GB4377@steel.home>
References: <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org> <20070331104947.GA4377@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 13:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXc5n-0005FI-Jv
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 13:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXCaLtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbXCaLtl
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 07:49:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43225 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbXCaLtk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 07:49:40 -0400
Received: from tigra.home (Fc8c6.f.strato-dslnet.de [195.4.200.198])
	by post.webmailer.de (mrclete mo17) (RZmta 5.5)
	with ESMTP id E01850j2VAdIeX ; Sat, 31 Mar 2007 13:49:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6B4D9277B6;
	Sat, 31 Mar 2007 13:49:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 47FF2D150; Sat, 31 Mar 2007 13:49:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070331104947.GA4377@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WNdA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43548>

This patch leaves the base name in the resulting intermediate tree, to
propagate the conflict from intermediate merges up to the top-level merge.
---

The result seem to be at least predictable. Still, doesn't it mean
that once a rename/rename conflict is in it has to be resolved
manually forever?

 merge-recursive.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c96e1a7..080b714 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -278,8 +278,16 @@ static struct tree *git_write_tree(void)
 {
 	struct tree *result = NULL;
 
-	if (unmerged_index())
+	if (unmerged_index()) {
+		output(0, "There are unmerged index entries:");
+		int i;
+		for (i = 0; i < active_nr; i++) {
+			struct cache_entry *ce = active_cache[i];
+			if (ce_stage(ce))
+				output(0, "%d %.*s", ce_stage(ce), ce_namelen(ce), ce->name);
+		}
 		return NULL;
+	}
 
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
@@ -735,8 +743,19 @@ static void conflict_rename_rename(struct rename *ren1,
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
-	update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
-	update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
+	if (index_only) {
+		remove_file_from_cache(dst_name1);
+		remove_file_from_cache(dst_name2);
+		/*
+		 * Uncomment to leave the conflicting names in the resulting tree
+		 *
+		 * update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, dst_name1);
+		 * update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, dst_name2);
+		 */
+	} else {
+		update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
+		update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
+	}
 	while (delp--)
 		free(del[delp]);
 }
@@ -852,10 +871,16 @@ static int process_renames(struct path_list *a_renames,
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
 				clean_merge = 0;
 				output(1, "CONFLICT (rename/rename): "
-				       "Rename %s->%s in branch %s "
-				       "rename %s->%s in %s",
+				       "Rename \"%s\"->\"%s\" in branch \"%s\" "
+				       "rename \"%s\"->\"%s\" in \"%s\"%s",
 				       src, ren1_dst, branch1,
-				       src, ren2_dst, branch2);
+				       src, ren2_dst, branch2,
+				       index_only ? " (left unresolved)": "");
+				if (index_only) {
+					remove_file_from_cache(src);
+					update_file(0, ren1->pair->one->sha1,
+						    ren1->pair->one->mode, src);
+				}
 				conflict_rename_rename(ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
-- 
1.5.1.rc2.38.g8d5bf-dirty
