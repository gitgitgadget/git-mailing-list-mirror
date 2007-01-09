From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: detect early of we are up to date and avoid costly rev-list
Date: Tue,  9 Jan 2007 15:10:32 +1300
Message-ID: <11683086324018-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 09 03:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H46RY-0008Rx-Ee
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 03:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbXAICKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 21:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbXAICKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 21:10:25 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:55007 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXAICKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 21:10:25 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1H46RR-0003LQ-J8; Tue, 09 Jan 2007 15:10:21 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1H46Rc-0000Ha-00; Tue, 09 Jan 2007 15:10:32 +1300
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.5.0.rc0.g4017-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36295>

if the SHA1 of our head matches the last SHA1 seen in the DB, avoid further
processing.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-cvsserver.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index df39512..0b75f9c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2184,7 +2184,10 @@ sub update
     # first lets get the commit list
     $ENV{GIT_DIR} = $self->{git_path};
 
-    my $commitinfo = `git-cat-file commit $self->{module} 2>&1`;
+    my $commitsha1 = `git rev-parse $self->{module}`;
+    chomp $commitsha1;
+
+    my $commitinfo = `git cat-file commit $self->{module} 2>&1`;
     unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
     {
         die("Invalid module '$self->{module}'");
@@ -2194,6 +2197,10 @@ sub update
     my $git_log;
     my $lastcommit = $self->_get_prop("last_commit");
 
+    if ($lastcommit eq $commitsha1) { # up-to-date
+         return 1;
+    }
+
     # Start exclusive lock here...
     $self->{dbh}->begin_work() or die "Cannot lock database for BEGIN";
 
-- 
1.5.0.rc0.g4017-dirty
