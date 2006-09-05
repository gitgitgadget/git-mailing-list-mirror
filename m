From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Tue, 5 Sep 2006 21:46:11 +0300
Message-ID: <20060905184611.GB14732@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 20:41:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKfrE-0008Bl-3b
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 20:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWIESlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWIESlG
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 14:41:06 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:26901 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932204AbWIESlC
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 14:41:02 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 5 Sep 2006 21:40:56 +0300
Received: by sashak (sSMTP sendmail emulation); Tue,  5 Sep 2006 21:46:11 +0300
To: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 05 Sep 2006 18:40:56.0838 (UTC) FILETIME=[D3248A60:01C6D11A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26481>

Hi,

This feature was useful with importing https://openib.org/svn/gen2 .

Sasha

This add '-S' option. When specified svn-import will try to parse
commit message for 'Signed-off-by: ...' line, and if found will use
the name and email address extracted at first occurrence as this commit
author name and author email address. Committer name and email are
extracted in usual way.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 git-svnimport.perl |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 26dc454..7113cf5 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,7 +31,7 @@ die "Need SVN:Core 1.2.1 or better" if $
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S);
 
 sub usage() {
 	print STDERR <<END;
@@ -39,12 +39,12 @@ Usage: ${\basename $0}     # fetch/updat
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [SVN_URL]
+       [-m] [-M regex] [-A author_file] [-S] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDhiI:l:mM:o:rs:t:T:uv") or usage();
+getopts("A:b:C:dDhiI:l:mM:o:rs:t:T:Suv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -531,21 +531,30 @@ sub copy_path($$$$$$$$) {
 
 sub commit {
 	my($branch, $changed_paths, $revision, $author, $date, $message) = @_;
-	my($author_name,$author_email,$dest);
+	my($committer_name,$committer_email,$dest);
+	my($author_name,$author_email);
 	my(@old,@new,@parents);
 
 	if (not defined $author or $author eq "") {
-		$author_name = $author_email = "unknown";
+		$committer_name = $committer_email = "unknown";
 	} elsif (defined $users_file) {
 		die "User $author is not listed in $users_file\n"
 		    unless exists $users{$author};
-		($author_name,$author_email) = @{$users{$author}};
+		($committer_name,$committer_email) = @{$users{$author}};
 	} elsif ($author =~ /^(.*?)\s+<(.*)>$/) {
-		($author_name, $author_email) = ($1, $2);
+		($committer_name, $committer_email) = ($1, $2);
 	} else {
 		$author =~ s/^<(.*)>$/$1/;
-		$author_name = $author_email = $author;
+		$committer_name = $committer_email = $author;
 	}
+
+	if ($opt_S && $message =~ /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
+        	($author_name, $author_email) = ($1, $2);
+	} else {
+		$author_name = $committer_name;
+		$author_email = $committer_email;
+	}
+
 	$date = pdate($date);
 
 	my $tag;
@@ -772,8 +781,8 @@ #	}
 				"GIT_AUTHOR_NAME=$author_name",
 				"GIT_AUTHOR_EMAIL=$author_email",
 				"GIT_AUTHOR_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
-				"GIT_COMMITTER_NAME=$author_name",
-				"GIT_COMMITTER_EMAIL=$author_email",
+				"GIT_COMMITTER_NAME=$committer_name",
+				"GIT_COMMITTER_EMAIL=$committer_email",
 				"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
 				"git-commit-tree", $tree,@par);
 			die "Cannot exec git-commit-tree: $!\n";
@@ -825,7 +834,7 @@ #	}
 		print $out ("object $cid\n".
 		    "type commit\n".
 		    "tag $dest\n".
-		    "tagger $author_name <$author_email>\n") and
+		    "tagger $committer_name <$committer_email>\n") and
 		close($out)
 		    or die "Cannot create tag object $dest: $!\n";
 
-- 
1.4.2
