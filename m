From: Linus Torvalds <torvalds@osdl.org>
Subject: Use less memory in "git log"
Date: Thu, 13 Apr 2006 10:01:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604130950130.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 13 19:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU5CD-0006sO-9i
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 19:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWDMRBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDMRBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 13:01:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751068AbWDMRBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 13:01:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3DH14tH020601
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Apr 2006 10:01:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3DH12rX022723;
	Thu, 13 Apr 2006 10:01:04 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18662>


This trivially avoids keeping the commit message data around after we 
don't need it any more, avoiding a continually growing "git log" memory 
footprint.

It's not a huge deal, but it's somewhat noticeable. For the current kernel 
tree, doing a full "git log" I got

 - before: /usr/bin/time git log > /dev/null 
	0.81user 0.02system 0:00.84elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+8851minor)pagefaults 0swaps

 - after: /usr/bin/time git log > /dev/null 
	0.79user 0.03system 0:00.83elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+5039minor)pagefaults 0swaps

ie the touched pages dropped from 8851 to 5039. For the historic kernel 
archive, the numbers are 18357->11037 minor page faults.

We could/should in theory free the commits themselves, but that's really a 
lot harder, since during revision traversal we may hit the same commit 
twice through different children having it as a parent, even after we've 
shown it once (when that happens, we'll silently ignore it next time, but 
we still need the "struct commit" to know).

And as the commit message data is clearly the biggest part of the commit, 
this is the really easy 60% solution.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git.c b/git.c
index d6f17db..78ed403 100644
--- a/git.c
+++ b/git.c
@@ -391,6 +391,8 @@ static int cmd_log(int argc, const char 
 		if (do_diff)
 			log_tree_commit(&opt, commit);
 		shown = 1;
+		free(commit->buffer);
+		commit->buffer = NULL;
 	}
 	free(buf);
 	return 0;
