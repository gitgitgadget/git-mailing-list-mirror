From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 7/7] Now that the leak is gone, there is by default no limit of revisions to
Date: Wed, 02 Nov 2005 23:51:58 +0200
Message-ID: <E1EXQWU-00050S-09@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:54:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQXC-0005F2-8g
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbVKBVw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbVKBVwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:25 -0500
Received: from [195.140.142.33] ([195.140.142.33]:46545 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965287AbVKBVwW
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:22 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003ch-Kp; Wed, 02 Nov 2005 22:52:11 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWU-00050S-09; Wed, 02 Nov 2005 23:51:58 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  import. No more message about leak when the limit
	(given by the -l parameter) is reached. Signed-off-by: Yaacov Akiba
	Slama <ya@slamail.org> --- [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11052>

import.
No more message about leak when the limit (given by the -l parameter)
is reached.

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

applies-to: 339bb970b075dfbbd321dcd817591cb739a29584
7410494b72db4c48a27d707a18168076e1b5a3dc
diff --git a/git-svnimport.perl b/git-svnimport.perl
index e97f470..ab690f3 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -53,7 +53,6 @@ my $branch_name = $opt_b || "branches";
 
 $opt_o ||= "origin";
 $opt_s ||= 1;
-$opt_l = 100 unless defined $opt_l;
 my $git_tree = $opt_C;
 $git_tree ||= ".";
 
@@ -727,15 +726,16 @@ sub commit_all {
 }
 
 while(++$current_rev <= $svn->{'maxrev'}) {
+	if (defined $opt_l) {
+		$opt_l--;
+		if ($opt_l < 0) {
+			last;
+		}
+	}
 	my $pool=SVN::Pool->new;
 	$svn->{'svn'}->get_log("/",$current_rev,$current_rev,1,1,1,\&_commit_all,$pool);
 	$pool->clear;
 	commit_all();
-	if($opt_l and not --$opt_l) {
-		print STDERR "Stopping, because there is a memory leak (in the SVN library).\n";
-		print STDERR "Please repeat this command; it will continue safely\n";
-		last;
-	}
 }
 
 
---
0.99.9.GIT
