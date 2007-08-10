From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Optimize the two-way merge of git-read-tree too
Date: Fri, 10 Aug 2007 12:53:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaYm-00016F-9r
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765225AbXHJTyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935520AbXHJTyE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:54:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54123 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752417AbXHJTyA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:54:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJru1o004300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 12:53:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJrpkB005578;
	Fri, 10 Aug 2007 12:53:51 -0700
In-Reply-To: <alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.23__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55572>


On Fri, 10 Aug 2007, Linus Torvalds wrote:
> 
> This trivially optimizes the two-way merge case of git-read-tree too, 
> which affects switching branches.

Side note, if this wasn't obvious: this series of three patches (four, if 
you count the one in this email) obviates the need for Junio's hacky fix 
from yesterday that removed the "-i -m" flags from "git read-tree" in 
git-commit.sh, and made builtin-read-tree sometimes use the "read_tree()" 
function.

Now "unpack_trees()" is just fast enough that we don't need to avoid it 
(although it's probably still a good idea to eventually convert it to use 
the traverse_trees() infrastructure some day - just to avoid having 
extraneous tree traversal functions).

And as mentioned, the three-way case *should* be as trivial as the 
following. It passes all the tests, and I verified that a conflicting 
merge in the 100,000 file horror-case merged correctly (with the conflict 
markers) in 0.687 seconds with this, so it works, but I'm lazy and 
somebody else should double-check it.

(Again - *without* this patch, the merge took 8.355 seconds, so this patch 
really does make a huge difference for merge performance with lots and 
lots of files, and we're not talking percentages, we're talking 
orders-of-magnitude differences!)

		Linus

---
 unpack-trees.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 810816e..ccfeb6e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -667,7 +667,6 @@ int threeway_merge(struct cache_entry **stages,
 	int no_anc_exists = 1;
 	int i;
 
-	remove_entry(remove);		
 	for (i = 1; i < o->head_idx; i++) {
 		if (!stages[i] || stages[i] == o->df_conflict_entry)
 			any_anc_missing = 1;
@@ -730,8 +729,10 @@ int threeway_merge(struct cache_entry **stages,
 	}
 
 	/* #1 */
-	if (!head && !remote && any_anc_missing)
+	if (!head && !remote && any_anc_missing) {
+		remove_entry(remove);
 		return 0;
+	}
 
 	/* Under the new "aggressive" rule, we resolve mostly trivial
 	 * cases that we historically had git-merge-one-file resolve.
@@ -763,6 +764,7 @@ int threeway_merge(struct cache_entry **stages,
 		if ((head_deleted && remote_deleted) ||
 		    (head_deleted && remote && remote_match) ||
 		    (remote_deleted && head && head_match)) {
+			remove_entry(remove);
 			if (index)
 				return deleted_entry(index, index, o);
 			else if (ce && !head_deleted)
@@ -785,6 +787,7 @@ int threeway_merge(struct cache_entry **stages,
 		verify_uptodate(index, o);
 	}
 
+	remove_entry(remove);
 	o->nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #10, #11. */
