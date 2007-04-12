From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-clone: Better handling of failed fetches of HEAD over HTTP
Date: Thu, 12 Apr 2007 21:25:33 +1200
Message-ID: <11763699332101-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 12 11:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbvqb-0006x4-Rb
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 11:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946034AbXDLJng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 05:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946035AbXDLJnf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 05:43:35 -0400
Received: from smtp3.clear.net.nz ([203.97.33.64]:34924 "EHLO
	smtp3.clear.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946040AbXDLJlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 05:41:04 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2007 05:41:04 EDT
Received: from localhost.localdomain
 (121-73-4-156.cable.telstraclear.net [121.73.4.156])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0JGD000AAOUT3Z20@smtp3.clear.net.nz> for git@vger.kernel.org;
 Thu, 12 Apr 2007 21:25:41 +1200 (NZST)
X-Mailer: git-send-email 1.5.1.106.ga32037
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44331>

Junio said:
> Why not default to 'master' (if found) and issue a warning?

A common problem when cloning over http is that the repo has
a symlink for HEAD, and apache refuses to serve symlinks by
default.

With this patch, the clone will fallback to trying to get
refs/heads/master -- which often works. If it cannot get
HEAD or refs/heads/master, then it will die, aborting the clone.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-clone.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 513b574..e98e064 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -64,7 +64,14 @@ Perhaps git-update-server-info needs to be run there?"
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
-	rm -f "$GIT_DIR/REMOTE_HEAD"
+		(echo "Could not get "$1/HEAD", perhaps it is a symlink: trying with refs/heads/master" &&
+		http_fetch "$1/refs/heads/master" "$GIT_DIR/REMOTE_HEAD") ||
+		rm -f "$GIT_DIR/REMOTE_HEAD"
+
+	if test ! -f "$GIT_DIR/REMOTE_HEAD"
+	then
+		die "Could not retrieve $1/HEAD nor $1/refs/heads/master ."
+	fi
 }
 
 quiet=
-- 
1.5.1.106.ga32037
