From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix bisection terminating condition
Date: Tue, 30 Aug 2005 11:04:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508301038340.4426@g5.osdl.org>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:12:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAATh-0007mN-L4
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 20:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVH3SEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVH3SEp
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 14:04:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932246AbVH3SEo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2005 14:04:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7UI4ejA019610
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Aug 2005 11:04:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7UI4d2w016667;
	Tue, 30 Aug 2005 11:04:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7959>


When testing bisection and using gitk to visualize the result, it was 
obvious that the termination condition was broken.

We know what the bad entry is only when the bisection ends up telling us 
to test the known-bad entry again.

Also, add a safety net: if somebody marks as good something that includes 
the known-bad point, we now notice and complain, instead of writing an 
empty revision to the new bisection branch.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-bisect-script b/git-bisect-script
--- a/git-bisect-script
+++ b/git-bisect-script
@@ -105,12 +105,16 @@ bisect_next() {
 	good=$(git-rev-parse --sq --revs-only --not \
 		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
 	rev=$(eval "git-rev-list --bisect $good $bad") || exit
-	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
-	if [ "$nr" -le "1" ]; then
+	if [ -z "$rev" ]; then
+	    echo "$bad was both good and bad"
+	    exit 1
+	fi
+	if [ "$rev" = "$bad" ]; then
 	    echo "$rev is first bad commit"
 	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
+	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
 	echo "Bisecting: $nr revisions left to test after this"
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout new-bisect || exit
