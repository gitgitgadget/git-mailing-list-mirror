From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsserver: imitate git-update-ref when committing
Date: Wed, 26 Jul 2006 22:51:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262249010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 22:52:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5qMP-00018l-7C
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 22:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWGZUvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWGZUvz
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 16:51:55 -0400
Received: from mail.gmx.net ([213.165.64.21]:56017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750914AbWGZUvz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 16:51:55 -0400
Received: (qmail invoked by alias); 26 Jul 2006 20:51:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 26 Jul 2006 22:51:53 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Martin Langhoff <martin@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24247>


git-update-ref writes into the lockfile, and renames it afterwards. Like 
commit v1.3.0-rc3~22, it is not only cleaner, but also helps with shared 
setups: every developer can have a different primary group; what matters 
is that $GIT_DIR/refs/heads has to be writable by a group you are in.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-cvsserver.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1b70cd9..2c1b0c7 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1144,9 +1144,7 @@ sub req_ci
         exit;
     }
 
-    open FILE, ">", "$ENV{GIT_DIR}refs/heads/$state->{module}";
-    print FILE $commithash;
-    close FILE;
+    print LOCKFILE $commithash;
 
     $updater->update();
 
@@ -1173,7 +1171,9 @@ sub req_ci
     }
 
     close LOCKFILE;
-    unlink($lockfile);
+    my $reffile = "$ENV{GIT_DIR}refs/heads/$state->{module}";
+    unlink($reffile);
+    rename($lockfile, $reffile);
     chdir "/";
 
     print "ok\n";
-- 
1.4.2.rc2.g2b3d-dirty
