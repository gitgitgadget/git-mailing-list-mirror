From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Tue, 13 Feb 2007 15:12:45 +0000
Message-ID: <200702131512.45412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 16:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzLH-00084D-Fd
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbXBMPMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXBMPMt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:12:49 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:18523 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750732AbXBMPMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:12:48 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 13 Feb 2007 15:15:24 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HGzKq-0008J1-00
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 15:12:48 +0000
X-TUID: eb24903fb4b9c0cf
X-UID: 237
X-Length: 1614
Content-Disposition: inline
X-OriginalArrivalTime: 13 Feb 2007 15:15:24.0828 (UTC) FILETIME=[C932E5C0:01C74F81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39532>

git-cvsserver is analogous to git-receive-pack; a checking from a cvs
client to a central server is like a git-push from a working repository.
Therefore it's nice to use the same access control (and email sending)
that a receive-pack would perform.

This patch tests for an executable update hook; if it is it is run with
the ref being updated and the old and new hashes as normal.  If the
update hook returns an error code the update is aborted and the ref is
never updated.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I'm dubious whether this is the correct thing to do.  It suits me for my
circumstances and I'm arguing that git-cvsserver is more like git-receive-pack
than git-commit; but internally it looks a lot more like git-commit.

Without calling the update hook though, git-cvsserver can completely bypass any
extra access checks that git-receive-pack would have to perform.  Assuming
git-cvsserver is a central repository - I think it's correct to call the update
hook rather than the pre-commit hook.

However, it's a judgement call, so I defer to someone with better judgement
than me :-)

 git-cvsserver.perl |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9371788..b4ef6bc 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1171,6 +1171,21 @@ sub req_ci
         exit;
     }
 
+	# Check that this is allowed, just as we would with a receive-pack
+	my @cmd = ( $ENV{GIT_DIR}.'hooks/update', "refs/heads/$state->{module}",
+			$parenthash, $commithash );
+	if( -x $cmd[0] ) {
+		unless( system( @cmd ) == 0 )
+		{
+			$log->warn("Commit failed (update hook declined to update ref)");
+			print "error 2 Commit failed (update hook declined)\n";
+			close LOCKFILE;
+			unlink($lockfile);
+			chdir "/";
+			exit;
+		}
+	}
+
     print LOCKFILE $commithash;
 
     $updater->update();
-- 
1.5.0.rc4.364.g85b1
