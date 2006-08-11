From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: split the path from the url correctly with limited perms
Date: Fri, 11 Aug 2006 11:11:28 -0700
Message-ID: <11553198891741-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 11 20:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBbU5-0002nw-9j
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 20:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWHKSLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 14:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHKSLf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 14:11:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52357 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751222AbWHKSLe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 14:11:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D5B8D7DC025;
	Fri, 11 Aug 2006 11:11:29 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 11:11:29 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc1.g018f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25234>

This version of the splitter (that only affects SVN:: library
users) works when one only has limited read-permissions to
the repository they're fetching from.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6453771..a033237 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1160,27 +1160,24 @@ sub repo_path_split {
 		}
 	}
 
-	my ($url, $path) = ($full_url =~ m!^([a-z\+]+://[^/]*)(.*)$!i);
-	$path =~ s#^/+##;
-	my @paths = split(m#/+#, $path);
-
 	if ($_use_lib) {
-		while (1) {
-			$SVN = libsvn_connect($url);
-			last if (defined $SVN &&
-				defined eval { $SVN->get_latest_revnum });
-			my $n = shift @paths || last;
-			$url .= "/$n";
-		}
+		$SVN = libsvn_connect($full_url);
+		my $url = $SVN->get_repos_root;
+		$full_url =~ s#^\Q$url\E/*##;
+		push @repo_path_split_cache, qr/^(\Q$url\E)/;
+		return ($url, $full_url);
 	} else {
+		my ($url, $path) = ($full_url =~ m!^([a-z\+]+://[^/]*)(.*)$!i);
+		$path =~ s#^/+##;
+		my @paths = split(m#/+#, $path);
 		while (quiet_run(qw/svn ls --non-interactive/, $url)) {
 			my $n = shift @paths || last;
 			$url .= "/$n";
 		}
+		push @repo_path_split_cache, qr/^(\Q$url\E)/;
+		$path = join('/',@paths);
+		return ($url, $path);
 	}
-	push @repo_path_split_cache, qr/^(\Q$url\E)/;
-	$path = join('/',@paths);
-	return ($url, $path);
 }
 
 sub setup_git_svn {
-- 
1.4.2.rc1.g018f
