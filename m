From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix commits over svn+ssh://
Date: Sat, 14 Oct 2006 02:02:37 -0700
Message-ID: <11608165571212-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, 392702@bugs.debian.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 14 11:02:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYfPy-000674-LY
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 11:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWJNJCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 05:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160997AbWJNJCk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 05:02:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:62868 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1160995AbWJNJCj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 05:02:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DFB367DC093;
	Sat, 14 Oct 2006 02:02:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Oct 2006 02:02:37 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.g1cbb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28870>

Once a get_commit_editor has been called from an SVN session, RA
layer operations are not allowed (well, unless you're using
file:// or http(s)://).  So we'll pass an alternate SVN::Ra
object to our editor object for running 'check-path'.

This should fix commits over svnserve (svn:// without ssh, too).

Closes Debian bug #392702, thanks to Pierre Habouzit for
reporting the bug.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a128d90..0f968c8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -536,7 +536,7 @@ sub commit_lib {
 			$SVN = libsvn_connect($repo);
 			my $ed = SVN::Git::Editor->new(
 					{	r => $r_last,
-						ra => $SVN,
+						ra => $SVN_LOG,
 						c => $c,
 						svn_path => $SVN_PATH
 					},
@@ -832,7 +832,7 @@ sub commit_diff {
 	$SVN ||= libsvn_connect($repo);
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
 	my $ed = SVN::Git::Editor->new({	r => $SVN->get_latest_revnum,
-						ra => $SVN, c => $tb,
+						ra => $SVN_LOG, c => $tb,
 						svn_path => $SVN_PATH
 					},
 				$SVN->get_commit_editor($_message,
-- 
1.4.3.rc2.g1cbb0
