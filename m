From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] An attempt to resolve a rename/rename conflict in recursive merge
Date: Fri, 30 Mar 2007 01:01:56 +0200
Message-ID: <20070329230156.GE2809@steel.home>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <20070329185501.GC2809@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 01:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX3d4-0008Rf-Cl
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 01:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbXC2XB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 19:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945907AbXC2XB7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 19:01:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:46382 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945908AbXC2XB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 19:01:58 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (mrclete mo51) (RZmta 5.5)
	with ESMTP id C06f18j2TFx0TM ; Fri, 30 Mar 2007 01:01:56 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43890277B6;
	Fri, 30 Mar 2007 01:01:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2367FD150; Fri, 30 Mar 2007 01:01:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070329185501.GC2809@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43487>

The structure looks like this:

     o---A-o-o---o-o-o-o-AA
      \   ____\_/
       \ /     \
        B-------o-o-o-BB

There is a rename/rename conflict somewhere around A and B commits.
The conflict was resolved at the merge points. Now, the problem is
that when the merge-recursive generates that virtual merge there seem
to be no way to get to the resolved state. The ends up resolving the
conflict again, and of course does not do it without intelligent help,
leaving index with unresolved entries. git_write_tree fails, returning
NULL and the rest breaks.

I just left all three entries in the index for the virtual commit to
pick them up: it'll usually(always?) generate a conflict which has to
be resolved manually. Many times, perhaps.

The small change in git_write_tree() was useful to see the relevant
portion of the index. The output in rename/rename conflict handling
code modified to improve its readability: it can be a lot of text.

---
 merge-recursive.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c96e1a7..2568c4e 100644
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
@@ -735,8 +743,17 @@ static void conflict_rename_rename(struct rename *ren1,
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
-	update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
-	update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
+	if (index_only) {
+		remove_file_from_cache(dst_name1);
+		remove_file_from_cache(dst_name2);
+		add_cacheinfo(ren1->pair->two->mode, ren1->pair->two->sha1, dst_name1,
+			      0, 0, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(ren1->pair->two->mode, ren2->pair->two->sha1, dst_name2,
+			      0, 0, ADD_CACHE_OK_TO_ADD);
+	} else {
+		update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
+		update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
+	}
 	while (delp--)
 		free(del[delp]);
 }
@@ -852,10 +869,18 @@ static int process_renames(struct path_list *a_renames,
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
+					add_cacheinfo(ren1->pair->one->mode,
+						      ren1->pair->one->sha1,
+						      src,
+						      0, 0, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+				}
 				conflict_rename_rename(ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
-- 
1.5.1.rc2.18.g157b4
