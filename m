From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix branch ancestry calculation
Date: Wed, 22 Mar 2006 17:29:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 23 02:29:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEdy-0006xJ-Q0
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWCWB3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWCWB3h
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:29:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932447AbWCWB3g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 20:29:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N1TLDZ023649
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 17:29:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N1TKh6005965;
	Wed, 22 Mar 2006 17:29:21 -0800
To: David Mansfield <cvsps@dm.cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17842>


Some branches don't get any ancestors at all, because their ancestor gets 
a "dotcount" value of 0, and are thus not considered any better than not 
having any ancestor. That's obviously wrong. Even a zero-dot-count 
ancestor is better than having none at all.

This fixes the issue by making not having an ancestor branch have a 
goodness value of -1, avoiding the problem (because even a zero dot-count 
will be considered better).

Alternatively, the special-case for the "1.1.1.1" revision should be 
removed (or made to imply a dot-count of 1).

Finally, I suspect that dot-counting in general should ignore any final 
".1" counts, ie "1.2.1.1" should count the same as "1.2.1", which should 
count the same as "1.2", which has a dot-count of 1.

That would automatically make any "1.1.1.1.1...." sequence always count as 
having a dot-count of 0.

I'll send suggestion that as a separate patch, but in the meantime, this 
is a separate issue, and obviously a bug-fix.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

diff --git a/cvsps.c b/cvsps.c
--- a/cvsps.c
+++ b/cvsps.c
@@ -2599,7 +2599,7 @@ static void determine_branch_ancestor(Pa
 	 * note: rev is the pre-commit revision, not the post-commit
 	 */
 	if (!head_ps->ancestor_branch)
-	    d1 = 0;
+	    d1 = -1;
 	else if (strcmp(ps->branch, rev->branch) == 0)
 	    continue;
 	else if (strcmp(head_ps->ancestor_branch, "HEAD") == 0)
