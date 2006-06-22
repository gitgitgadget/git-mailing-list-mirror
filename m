From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix commit --edit flag when using SVN:: libraries
Date: Thu, 22 Jun 2006 01:22:46 -0700
Message-ID: <11509645661829-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 22 10:22:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtKSk-0007ed-6b
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 10:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWFVIWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 04:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWFVIWt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 04:22:49 -0400
Received: from hand.yhbt.net ([66.150.188.102]:61348 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964859AbWFVIWs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 04:22:48 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 89EB17DC021;
	Thu, 22 Jun 2006 01:22:46 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 22 Jun 2006 01:22:46 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.g937a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22310>

Trying to open an interactive editor in the console while stdout is
being piped to the parent process doesn't work out very well.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 7e7f2f0..08c3010 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -479,17 +479,18 @@ sub commit_lib {
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 	my $commit_msg = "$GIT_SVN_DIR/.svn-commit.tmp.$$";
 
+	if (defined $LC_ALL) {
+		$ENV{LC_ALL} = $LC_ALL;
+	} else {
+		delete $ENV{LC_ALL};
+	}
 	foreach my $c (@revs) {
+		my $log_msg = get_commit_message($c, $commit_msg);
+
 		# fork for each commit because there's a memory leak I
 		# can't track down... (it's probably in the SVN code)
 		defined(my $pid = open my $fh, '-|') or croak $!;
 		if (!$pid) {
-			if (defined $LC_ALL) {
-				$ENV{LC_ALL} = $LC_ALL;
-			} else {
-				delete $ENV{LC_ALL};
-			}
-			my $log_msg = get_commit_message($c, $commit_msg);
 			my $ed = SVN::Git::Editor->new(
 					{	r => $r_last,
 						ra => $SVN,
@@ -535,6 +536,7 @@ sub commit_lib {
 			($r_last, $cmt_last) = ($r_new, $cmt_new);
 		}
 	}
+	$ENV{LC_ALL} = 'C';
 	unlink $commit_msg;
 }
 
-- 
1.4.0.g937a
