From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsimport: use git-update-ref when updating
Date: Thu, 30 Mar 2006 14:06:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603301405160.18852@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Mar 30 14:06:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOvv2-0005Oq-SA
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 14:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWC3MGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 07:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWC3MGU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 07:06:20 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:55695 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932186AbWC3MGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 07:06:19 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 119B3EA0;
	Thu, 30 Mar 2006 14:06:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 05237ACD;
	Thu, 30 Mar 2006 14:06:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E3AFEA73;
	Thu, 30 Mar 2006 14:06:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18193>


This simplifies code, and also fixes a subtle bug: when importing in a
shared repository, where another user last imported from CVS, cvsimport
used to complain that it could not open <branch> for update.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-cvsimport.perl |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 3728294..957af13 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -15,6 +15,7 @@ # You can change that with the '-o' opti
 
 use strict;
 use warnings;
+use Fcntl;
 use Getopt::Std;
 use File::Spec;
 use File::Temp qw(tempfile);
@@ -677,11 +678,7 @@ my $commit = sub {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	open(C,">$git_dir/refs/heads/$branch")
-		or die "Cannot open branch $branch for update: $!\n";
-	print C "$cid\n"
-		or die "Cannot write branch $branch for update: $!\n";
-	close(C)
+	system("git-update-ref refs/heads/$branch $cid") == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if($tag) {
