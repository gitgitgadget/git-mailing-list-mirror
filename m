From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: split the path from the url correctly with limited perms
Date: Fri, 11 Aug 2006 23:21:41 -0700
Message-ID: <20060812062134.GA7609@localdomain>
References: <11553198891741-git-send-email-normalperson@yhbt.net> <7vac6asux4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 08:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBmsi-0005HJ-Nj
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 08:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWHLGVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 02:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWHLGVq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 02:21:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34441 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751091AbWHLGVq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Aug 2006 02:21:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6B8DD7DC025;
	Fri, 11 Aug 2006 23:21:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 23:21:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac6asux4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25252>

This version of the splitter (that only affects SVN:: library
users) works when one only has limited read-permissions to
the repository they're fetching from.

Updated from the original patch to workaround some SVN bug
somewhere, which only seems to happen against file://
repositories...  Here's the diff against the original patch I
submitted:

@@ -1159,8 +1159,8 @@ sub repo_path_split {
 	}

 	if ($_use_lib) {
-		$SVN = libsvn_connect($full_url);
-		my $url = $SVN->get_repos_root;
+		my $tmp = libsvn_connect($full_url);
+		my $url = $tmp->get_repos_root;
 		$full_url =~ s#^\Q$url\E/*##;
 		push @repo_path_split_cache, qr/^(\Q$url\E)/;
 		return ($url, $full_url);

Somehow connecting to a repository with the full url makes the
returned SVN::Ra object act strangely and break things, so now
we just drop the SVN::Ra object that we made our initial
connection with...

Thanks to Junio for remembering to run the test suite when I
thought the change was too trivial (I tested it against remote
repostories, of course).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7d9839e..0d58bb9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1158,27 +1158,24 @@ sub repo_path_split {
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
+		my $tmp = libsvn_connect($full_url);
+		my $url = $tmp->get_repos_root;
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
1.4.1.g018f
