From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: multi-init saves and reuses --tags and --branches arguments
Date: Wed, 11 Oct 2006 11:53:21 -0700
Message-ID: <11605928022833-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 20:53:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXjCr-0002Jt-Ky
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWJKSxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWJKSxY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:53:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:31371 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030237AbWJKSxX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 14:53:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CC15A7DC08E;
	Wed, 11 Oct 2006 11:53:21 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 11:53:22 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.gbe730
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28738>

This should make it much easier to track newly added tags and
branches.  Re-running multi-init without command-line arguments
should now detect new-tags and branches.

--trunk shouldn't change often, but running multi-init on it
is now idempotent.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f5c7d46..5a6c87e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -682,12 +682,17 @@ sub multi_init {
 		}
 		$_trunk = $url . $_trunk;
 	}
+	my $ch_id;
 	if ($GIT_SVN eq 'git-svn') {
-		print "GIT_SVN_ID set to 'trunk' for $_trunk\n";
+		$ch_id = 1;
 		$GIT_SVN = $ENV{GIT_SVN_ID} = 'trunk';
 	}
 	init_vars();
-	init($_trunk);
+	unless (-d $GIT_SVN_DIR) {
+		print "GIT_SVN_ID set to 'trunk' for $_trunk\n" if $ch_id;
+		init($_trunk);
+		sys('git-repo-config', 'svn.trunk', $_trunk);
+	}
 	complete_url_ls_init($url, $_branches, '--branches/-b', '');
 	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
 }
@@ -937,16 +942,21 @@ sub complete_url_ls_init {
 				print STDERR "W: Unrecognized URL: $u\n";
 				die "This should never happen\n";
 			}
+			# don't try to init already existing refs
 			my $id = $pfx.$1;
-			print "init $u => $id\n";
 			$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
 			init_vars();
-			init($u);
+			unless (-d $GIT_SVN_DIR) {
+				print "init $u => $id\n";
+				init($u);
+			}
 		}
 		exit 0;
 	}
 	waitpid $pid, 0;
 	croak $? if $?;
+	my ($n) = ($switch =~ /^--(\w+)/);
+	sys('git-repo-config', "svn.$n", $var);
 }
 
 sub common_prefix {
-- 
1.4.2.3.gc5a8
