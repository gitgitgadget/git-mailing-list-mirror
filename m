From: Linus Torvalds <torvalds@osdl.org>
Subject: gitk "parent information" in commit window
Date: Sun, 7 Aug 2005 13:58:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 23:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1sFL-0003Cm-1j
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbVHGU7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 16:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbVHGU7A
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 16:59:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752740AbVHGU67 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 16:58:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j77KwvjA008254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Aug 2005 13:58:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j77KwusN022820;
	Sun, 7 Aug 2005 13:58:56 -0700
To: Paul Mackerras <paulus@samba.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This adds a useful "Parent:" line to the git commit information window.

It looks something like this (from the infamous octopus merge):

	Author: Junio C Hamano <junkio@cox.net>  2005-05-05 16:16:54
	Committer: Junio C Hamano <junkio@cox.net>  2005-05-05 16:16:54
	Parent: fc54a9c30ccad3fde5890d2c0ca2e2acc0848fbc  (Update git-apply-patch-script ...)
	Parent: 9e30dd7c0ecc9f10372f31539d0122db97418353  (Make git-prune-script executa ...)
	Parent: c4b83e618f1df7d8ecc9392fa40e5bebccbe6b5a  (Do not write out new index if ...)
	Parent: 660265909fc178581ef327076716dfd3550e6e7b  (diff-cache shows differences  ...)
	Parent: b28858bf65d4fd6d8bb070865518ec43817fe7f3  (Update diff engine for symlin ...)
	
	    Octopus merge of the following five patches.
	    
	      Update git-apply-patch-script for symbolic links.
	      Make git-prune-script executable again.
	      Do not write out new index if nothing has changed.
	      diff-cache shows differences for unmerged paths without --cache.
	      Update diff engine for symlinks stored in the cache.
	    
	    Signed-off-by: Junio C Hamano <junkio@cox.net>

where all the parent commit ID's are clickable, because the new lines are 
added as part of the "comment" string, and thus the regular clickability 
thing will match them automatically.

I think this is good. And my random-tcl-monkey-skills are clearly getting 
better (although it's perfectly possible that somebody who actually knows 
what he is doing would have done things differently).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
[ Btw, the patch was generated against a tree that had Paul's hovering 
  patches merged. Junio, I don't think you've merged that yet, so this may 
  apply better to Paul's tree than to standard git. But I _think_ it will 
  apply cleanly to either one ]

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -1799,9 +1799,21 @@ proc selectline {l isnew} {
 	}
 	$ctext insert end "\n"
     }
-    $ctext insert end "\n"
+ 
     set commentstart [$ctext index "end - 1c"]
-    set comment [lindex $info 5]
+    set comment {}
+    foreach p $parents($id) {
+	set l "..."
+	if {[info exists commitinfo($p)]} {
+	    set l [lindex $commitinfo($p) 0]
+	    if {[string length $l] > 32} {
+		set l "[string range $l 0 28] ..."
+	    }
+	}
+	append comment "Parent: $p  ($l)\n"
+    }
+    append comment "\n"
+    append comment [lindex $info 5]
     $ctext insert end $comment
     $ctext insert end "\n"
 
