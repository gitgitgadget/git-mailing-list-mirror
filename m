From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix 'git cvsexportcommit -w $cvsdir ...' when used with
 relative $GIT_DIR
Date: Mon, 11 Feb 2008 02:28:05 +0100
Message-ID: <200802110228.05233.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 03:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOPV-0002vj-Ox
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYBKC2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYBKC2K
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:28:10 -0500
Received: from smtp.getmail.no ([84.208.20.33]:40897 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYBKC2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:28:09 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2008 21:28:09 EST
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JW100301W2VX800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Feb 2008 02:28:07 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW10024OW2TMA00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Feb 2008 02:28:05 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW100885W2TJT50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Feb 2008 02:28:05 +0100 (CET)
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73458>

When using the '-w $cvsdir' option to cvsexportcommit, it will chdir into
$cvsdir before executing several other git commands. If $GIT_DIR is set to
a relative path (e.g. '.'), the git commands executed by cvsexportcommit
will naturally fail with "fatal: Not a git repository".

Therefore, if $GIT_DIR is relative, prepend $PWD to $GIT_DIR before the
chdir to $cvsdir.

Signed-off-by: Johan Herland <johan@herland.net>
---

I'm working on an update hook script for automatically propagating commits 
to a CVS server. My script calls 'git cvsexportcommit -w $cvsdir ...'. 
However, the hooks infrastructure invokes the update hook script with the 
(bare, in my case) Git repo as $PWD and sets up GIT_DIR="." in the script's 
environment. For now, I work around this bug in my script by forcing 
$GIT_DIR to $PWD, but this really seems like a bug in cvsexportcommit.

In my case, this bug can also be fixed by making sure the hook 
infrastructure set up an _absolute_ GIT_DIR for the update hook, something 
I'd consider more polite than the current GIT_DIR=".". Whether we want to 
fix this as well should be discussed. But the patch below is needed in any 
case, since cvsexportcommit may not only be called from hook scripts.


Have fun! :)

...Johan


 git-cvsexportcommit.perl |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d2e50c3..fd4fbfb 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -15,15 +15,18 @@ $opt_h && usage();
 die "Need at least one commit identifier!" unless @ARGV;
 
 if ($opt_w) {
+	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
-		# Remember where our GIT_DIR is before changing to CVS checkout
+		# Oops no GIT_DIR set. Figure out for ourselves
 		my $gd =`git-rev-parse --git-dir`;
 		chomp($gd);
-		if ($gd eq '.git') {
-			my $wd = `pwd`;
-			chomp($wd);
-			$gd = $wd."/.git"	;
-		}
+		$ENV{GIT_DIR} = $gd;
+	}
+	unless ($ENV{GIT_DIR} =~ m[^/]) {
+		# GIT_DIR is relative. Prepend $PWD
+		my $wd = `pwd`;
+		chomp($wd);
+		my $gd = $wd."/".$ENV{GIT_DIR};
 		$ENV{GIT_DIR} = $gd;
 	}
 
-- 
1.5.4.2.g41ac4
