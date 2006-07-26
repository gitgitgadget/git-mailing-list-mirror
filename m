From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-cvsserver: support multiline commit messages
Date: Wed, 26 Jul 2006 21:59:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262157350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 21:59:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5pXc-0007QH-UT
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWGZT7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWGZT7M
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:59:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:13192 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751773AbWGZT7K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 15:59:10 -0400
Received: (qmail invoked by alias); 26 Jul 2006 19:59:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 26 Jul 2006 21:59:09 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Martin Langhoff <martin@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24245>


Earlier, cvsserver barfed when you tried to check in files with a 
multiline commit message.

That is what Argumentx is for... Argument: lines can be followed by
several Argumentx: lines, which means they should be appended.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-cvsserver.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b2837ad..1b70cd9 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -549,12 +549,15 @@ sub req_Argument
 {
     my ( $cmd, $data ) = @_;
 
-    # TODO :  Not quite sure how Argument and Argumentx differ, but I assume
-    # it's for multi-line arguments ... somehow ...
+    # Argumentx means: append to last Argument (with a newline in front)
 
     $log->debug("$cmd : $data");
 
-    push @{$state->{arguments}}, $data;
+    if ( $cmd eq 'Argumentx') {
+        ${$state->{arguments}}[$#{$state->{arguments}}] .= "\n" . $data;
+    } else {
+        push @{$state->{arguments}}, $data;
+    }
 }
 
 # expand-modules \n
-- 
1.4.2.rc2.g96f2-dirty
