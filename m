From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/2] Optimize the two-way merge of git-read-tree too
Date: Fri, 10 Aug 2007 12:31:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaCy-0001lJ-50
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935990AbXHJTbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933577AbXHJTbc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:31:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45559 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758507AbXHJTba (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:31:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJVQwe002833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 12:31:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJVKdR004740;
	Fri, 10 Aug 2007 12:31:20 -0700
In-Reply-To: <alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.924 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_47,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.23__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55567>


This trivially optimizes the two-way merge case of git-read-tree too, 
which affects switching branches.

When you have tons and tons of files in your repository, but there are 
only small differences in the branches (maybe just a couple of files 
changed), the biggest cost of the branch switching was actually just the 
index calculations.

This fixes it (timings for switching between the "testing" and "master" 
branches in the 100,000 file testing-repo-from-hell, where the branches 
only differ in one small file).

Before:
	[torvalds@woody bummer]$ time git checkout master
	real    0m9.919s
	user    0m8.461s
	sys     0m0.264s

After:
	[torvalds@woody bummer]$ time git checkout testing
	real    0m0.576s
	user    0m0.348s
	sys     0m0.228s

so it's easily an order of magnitude different.

This concludes the series. I think we could/should do the three-way merge 
too (to speed up merges), but I'm lazy. Somebody else can do it.

The rule is very simple: you need to remove the old entry if:
 - you want to remove the file entirely
 - you replace it with a "merge conflict" entry (ie a non-stage-0 entry)

and you can avoid removing it if you either

 - keep the old one
 - or resolve it to a new one.

and these rules should all be valid for the three-way case too.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
commit b8d8d6aa12a3ae7e2f7a8cb008413b780e1152ce
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Aug 10 12:13:41 2007 -0700

    Optimize the common cases of git-read-tree
    
    This optimizes bind_merge() and oneway_merge() to not unnecessarily
    remove and re-add the old index entries when they can just get replaced
    by updated ones.
    
    This makes these operations much faster for large trees (where "large"
    is in the 50,000+ file range), because we don't unnecessarily move index
    entries around in the index array all the time.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 unpack-trees.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b4e2618..810816e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -827,7 +827,6 @@ int twoway_merge(struct cache_entry **src,
 	struct cache_entry *oldtree = src[1];
 	struct cache_entry *newtree = src[2];
 
-	remove_entry(remove);
 	if (o->merge_size != 2)
 		return error("Cannot do a twoway merge of %d trees",
 			     o->merge_size);
@@ -850,6 +849,7 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
+			remove_entry(remove);
 			return deleted_entry(oldtree, current, o);
 		}
 		else if (oldtree && newtree &&
@@ -859,6 +859,7 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else {
 			/* all other failures */
+			remove_entry(remove);
 			if (oldtree)
 				reject_merge(oldtree);
 			if (current)
@@ -870,8 +871,8 @@ int twoway_merge(struct cache_entry **src,
 	}
 	else if (newtree)
 		return merged_entry(newtree, current, o);
-	else
-		return deleted_entry(oldtree, current, o);
+	remove_entry(remove);
+	return deleted_entry(oldtree, current, o);
 }
 
 /*
