From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git resolve" less scary
Date: Mon, 29 Aug 2005 22:36:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508292230300.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 07:37:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9ynK-0004ED-Rw
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 07:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVH3FgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 01:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVH3FgV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 01:36:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750777AbVH3FgV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 01:36:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U5aGjA031154
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 22:36:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U5aGMx014619;
	Mon, 29 Aug 2005 22:36:16 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7948>


When we resolve a merge between two branches, and it removes a file in the 
current branch, we notify the person doing the resolve with a big nice 
notice like

	Removing xyzzy

which is all well and good.

HOWEVER, we also do this when the file was actually removed in the current 
branch, and we're merging with another branch that didn't have it removed 
(or, indeed, if the other branch _did_ have it removed, but the common 
parent was far enough back that the file still existed in there).

And that just doesn't make sense. In that case we're not removing
anything: the file didn't exist in the branch we're merging into in the
first place. So the message just makes people nervous, and makes no sense.

This has been around forever, but I never bothered to do anything about 
it.

Until now.

The trivial fix is to only talk about removing files if the file existed 
in the branch we're merging into, but will not exist in the result.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -21,7 +21,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Deleted in both or deleted in one and unchanged in the other
 #
 "$1.." | "$1.$1" | "$1$1.")
-	echo "Removing $4"
+	if [ "$2" ]; then
+		echo "Removing $4"
+	fi
 	if test -f "$4"; then
 		rm -f -- "$4"
 	fi &&
