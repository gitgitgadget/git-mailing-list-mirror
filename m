From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: avoid creating some small files
Date: Thu, 15 Jun 2006 13:55:29 -0700
Message-ID: <11504049313192-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 15 22:55:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqysK-0007IT-VW
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031335AbWFOUze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031347AbWFOUze
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:55:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7132 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1031335AbWFOUzd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 16:55:33 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 61C0E7DC020;
	Thu, 15 Jun 2006 13:55:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Jun 2006 13:55:31 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21912>

repo_path_split() is already pretty fast, and is already
optimized via caching.

We also don't need to create an exclude file if we're
relying on the SVN libraries.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 884969e..88af9c5 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -1005,12 +1005,6 @@ sub setup_git_svn {
 	close $fh;
 	s_to_file($SVN_URL,"$GIT_SVN_DIR/info/url");
 
-	open my $fd, '>>', "$GIT_SVN_DIR/info/exclude" or croak $!;
-	print $fd '.svn',"\n";
-	close $fd or croak $!;
-	my ($url, $path) = repo_path_split($SVN_URL);
-	s_to_file($url, "$GIT_SVN_DIR/info/repo_url");
-	s_to_file($path, "$GIT_SVN_DIR/info/repo_path");
 }
 
 sub assert_svn_wc_clean {
@@ -1649,6 +1643,12 @@ sub do_update_index {
 
 sub index_changes {
 	return if $_use_lib;
+
+	if (!-f "$GIT_SVN_DIR/info/exclude") {
+		open my $fd, '>>', "$GIT_SVN_DIR/info/exclude" or croak $!;
+		print $fd '.svn',"\n";
+		close $fd or croak $!;
+	}
 	my $no_text_base = shift;
 	do_update_index([qw/git-diff-files --name-only -z/],
 			'remove',
@@ -2018,9 +2018,6 @@ sub migration_check {
 		my $dn = dirname("$GIT_DIR/svn/$x");
 		mkpath([$dn]) unless -d $dn;
 		rename "$GIT_DIR/$x", "$GIT_DIR/svn/$x" or croak "$!: $x";
-		my ($url, $path) = repo_path_split($u);
-		s_to_file($url, "$GIT_DIR/svn/$x/info/repo_url");
-		s_to_file($path, "$GIT_DIR/svn/$x/info/repo_path");
 	}
 	migrate_revdb() if (-d $GIT_SVN_DIR && !-w $REVDB);
 	print "Done upgrading.\n";
@@ -2138,15 +2135,8 @@ sub write_grafts {
 sub read_url_paths {
 	my $l_map = {};
 	git_svn_each(sub { my $x = shift;
-			my $u = file_to_s("$GIT_DIR/svn/$x/info/repo_url");
-			my $p = file_to_s("$GIT_DIR/svn/$x/info/repo_path");
-			# we hate trailing slashes
-			if ($u =~ s#(?:^\/+|\/+$)##g) {
-				s_to_file($u,"$GIT_DIR/svn/$x/info/repo_url");
-			}
-			if ($p =~ s#(?:^\/+|\/+$)##g) {
-				s_to_file($p,"$GIT_DIR/svn/$x/info/repo_path");
-			}
+			my $url = file_to_s("$GIT_DIR/svn/$x/info/url");
+			my ($u, $p) = repo_path_split($url);
 			$l_map->{$u}->{$p} = $x;
 			});
 	return $l_map;
-- 
1.4.0
