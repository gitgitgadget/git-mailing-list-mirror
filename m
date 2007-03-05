From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] fast-import: Avoid infinite loop after reset
Date: Mon, 5 Mar 2007 12:46:03 -0500
Message-ID: <20070305174603.GA22304@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOHGK-0000yw-9E
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXCERqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXCERqK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:46:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50946 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXCERqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:46:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOHG3-0007cX-1G; Mon, 05 Mar 2007 12:45:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C273B20FBAE; Mon,  5 Mar 2007 12:46:03 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41466>

Johannes Sixt noticed that a 'reset' command applied to a branch that
is already active in the branch LRU cache can cause fast-import to
relink the same branch into the LRU cache twice.  This will cause
the LRU cache to contain a cycle, making unload_one_branch run in an
infinite loop as it tries to select the oldest branch for eviction.

I have trivially fixed the problem by adding an active bit to
each branch object; this bit indicates if the branch is already
in the LRU and allows us to avoid trying to add it a second time.
Converting the pack_id field into a bitfield makes this change take
up no additional memory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This two patch series was made on top of maint and is also pullable
 from my fast-import fork on repo.or.cz.  Merging it with master/next
 may require a minor evil merge as Nico's API changes there might
 be conflicting.

 fast-import.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1ae125a..490f640 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -220,7 +220,8 @@ struct branch
 	const char *name;
 	struct tree_entry branch_tree;
 	uintmax_t last_commit;
-	unsigned int pack_id;
+	unsigned active : 1;
+	unsigned pack_id : PACK_ID_BITS;
 	unsigned char sha1[20];
 };
 
@@ -528,6 +529,7 @@ static struct branch *new_branch(const char *name)
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
 	b->branch_tree.versions[1].mode = S_IFDIR;
+	b->active = 0;
 	b->pack_id = MAX_PACK_ID;
 	branch_table[hc] = b;
 	branch_count++;
@@ -1547,6 +1549,7 @@ static void unload_one_branch(void)
 			e = active_branches;
 			active_branches = e->active_next_branch;
 		}
+		e->active = 0;
 		e->active_next_branch = NULL;
 		if (e->branch_tree.tree) {
 			release_tree_content_recursive(e->branch_tree.tree);
@@ -1559,10 +1562,13 @@ static void unload_one_branch(void)
 static void load_branch(struct branch *b)
 {
 	load_tree(&b->branch_tree);
-	b->active_next_branch = active_branches;
-	active_branches = b;
-	cur_active_branches++;
-	branch_load_count++;
+	if (!b->active) {
+		b->active = 1;
+		b->active_next_branch = active_branches;
+		active_branches = b;
+		cur_active_branches++;
+		branch_load_count++;
+	}
 }
 
 static void file_change_m(struct branch *b)
-- 
1.5.0.3.862.g71037
