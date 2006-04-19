From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix uninteresting tags in new revision parsing
Date: Tue, 18 Apr 2006 20:31:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604182027460.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 19 05:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW3QV-0003rO-RM
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 05:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDSDbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDSDbu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 23:31:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750714AbWDSDbu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 23:31:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J3VgtH000665
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 20:31:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J3VfMd007174;
	Tue, 18 Apr 2006 20:31:41 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18901>


When I unified the revision argument parsing, I introduced a simple bug 
wrt tags that had been marked uninteresting. When it was preparing for the 
revision walk, it would mark all the parent commits of an uninteresting 
tag correctly uninteresting, but it would forget about the commit itself.

This means that when I just did my 2.6.17-rc2 release, and my scripts 
generated the log for "v2.6.17-rc1..v2.6.17-rc2", everything was fine, 
except the commit pointed to by 2.6.17-rc1 (which shouldn't have been 
there) was included. Even though it should obviously have been marked as 
being uninteresting.

Not a huge deal, and the fix is trivial.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/revision.c b/revision.c
index dbd54da..113dd5a 100644
--- a/revision.c
+++ b/revision.c
@@ -152,6 +152,7 @@ static struct commit *handle_commit(stru
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
+			commit->object.flags |= UNINTERESTING;
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
