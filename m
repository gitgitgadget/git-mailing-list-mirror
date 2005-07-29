From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix interesting git-rev-list corner case
Date: Fri, 29 Jul 2005 15:50:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 00:56:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dydlr-0002TN-R5
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 00:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVG2WzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVG2WxM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 18:53:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262886AbVG2Wur (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 18:50:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6TMoVjA021446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Jul 2005 15:50:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6TMoURA027493;
	Fri, 29 Jul 2005 15:50:30 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This corner-case was triggered by a kernel commit that was not in date
order, due to a misconfigured time zone that made the commit appear three
hours older than it was.

That caused git-rev-list to traverse the commit tree in a non-obvious
order, and made it parse several of the _parents_ of the misplaced commit
before it actually parsed the commit itself. That's fine, but it meant 
that the grandparents of the commit didn't get marked uninteresting, 
because they had been reached through an "interesting" branch.

The reason was that "mark_parents_uninteresting()" (which is supposed to 
mark all existing parents as being uninteresting - duh) didn't actually 
traverse more than one level down the parent chain.

NORMALLY this is fine, since with the date-based traversal order,
grandparents won't ever even have been looked at before their parents (so
traversing the chain down isn't needed, because the next time around when 
we pick out the parent we'll mark _its_ parents uninteresting), but since 
we'd gotten out of order, we'd already seen the parent and thus never got 
around to mark the grandparents.

Anyway, the fix is simple. Just traverse parent chains recursively.  
Normally the chain won't even exist (since the parent hasn't been parsed
yet), so this is not actually going to trigger except in this strange 
corner-case.

Add a comment to the simple one-liner, since this was a bit subtle, and I 
had to really think things through to understand how it could happen.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -228,6 +228,17 @@ static void mark_parents_uninteresting(s
 		commit->object.flags |= UNINTERESTING;
 
 		/*
+		 * Normally we haven't parsed the parent
+		 * yet, so we won't have a parent of a parent
+		 * here. However, it may turn out that we've
+		 * reached this commit some other way (where it
+		 * wasn't uninteresting), in which case we need
+		 * to mark its parents recursively too..
+		 */
+		if (commit->parents)
+			mark_parents_uninteresting(commit);
+
+		/*
 		 * A missing commit is ok iff its parent is marked 
 		 * uninteresting.
 		 *
