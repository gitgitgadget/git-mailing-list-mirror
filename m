From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix git-rev-list "date order" with --topo-order
Date: Mon, 14 Nov 2005 10:01:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511140940100.3263@g5.osdl.org>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net> <pan.2005.11.14.04.36.38.784541@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 19:04:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebied-00023F-Go
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVKNSBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVKNSBy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:01:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751213AbVKNSBx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 13:01:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAEI1SnO023256
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 10:01:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAEI1Q1h020183;
	Mon, 14 Nov 2005 10:01:27 -0800
To: Matthias Urlichs <smurf@smurf.noris.de>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <pan.2005.11.14.04.36.38.784541@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11829>


This fixes git-rev-list so that when there are multiple branches, we still 
sort the heads in proper approximate date order even when sorting the 
output topologically.

This makes things like

	gitk --all -d

work sanely and show the branches in date order (where "date order" is 
obviously modified by the paren-child dependency requirements of the 
topological sort).

The trivial fix is to just build the "work" list in date order rather than 
inserting the new work entries at the beginning.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should also fix this report, although Matthias should double-test..

On Mon, 14 Nov 2005, Matthias Urlichs wrote:
> 
> >           $ gitk $(cd .git/lost+found/commit && echo ??*)
> 
> Along those lines... I just tried that, it found a whole heap of old
> commits I didn't yet clean up, and they're sorted by their SHA1.
> 
> In other words, actually finding the latest commit in there was a
> nontrivial task.
> 
> I don't speak tcl, so could somebody please change "gitk -d" to sort its
> command line by date (newest first, of course)?  Thanks.

diff --git a/commit.c b/commit.c
index 534c03e..ebf4db6 100644
--- a/commit.c
+++ b/commit.c
@@ -536,7 +536,7 @@ int count_parents(struct commit * commit
 void sort_in_topological_order(struct commit_list ** list)
 {
 	struct commit_list * next = *list;
-	struct commit_list * work = NULL;
+	struct commit_list * work = NULL, **insert;
 	struct commit_list ** pptr = list;
 	struct sort_node * nodes;
 	struct sort_node * next_nodes;
@@ -580,11 +580,12 @@ void sort_in_topological_order(struct co
          * the tips serve as a starting set for the work queue.
          */
 	next=*list;
+	insert = &work;
 	while (next) {
 		struct sort_node * node = (struct sort_node *)next->item->object.util;
 
 		if (node->indegree == 0) {
-			commit_list_insert(next->item, &work);
+			insert = &commit_list_insert(next->item, insert)->next;
 		}
 		next=next->next;
 	}
