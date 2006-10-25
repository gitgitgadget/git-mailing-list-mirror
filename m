X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport: support for partial imports
Date: Thu, 26 Oct 2006 00:50:26 +0200
Message-ID: <20061025225026.GA13031@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:45:20 +0000 (UTC)
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 25 Oct 2006 22:45:03.0331 (UTC) FILETIME=[35C98330:01C6F887]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30118>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrUo-0002H9-Ix for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965246AbWJYWpK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWJYWpK
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:45:10 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:24456 "EHLO
 taurus.voltaire.com") by vger.kernel.org with ESMTP id S965246AbWJYWpI (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:45:08 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 00:45:03 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 26 Oct 2006 00:50:26
 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This adds support for partial svn imports. Let's assume that SVN
repository layout looks like:

  $trunk/path/to/our/project
  $branches/path/to/our/project
  $tags/path/to/our/project

, and we would like to import only tree under this specific
'path/to/our/project' and not whole tree under $trunk, $branches, etc..
Now we will be be able to do it by using '-P path/to/our/project' option
with git-svnimport.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 git-svnimport.perl |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index f6eff8e..cbaa8ab 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,7 +31,7 @@ die "Need SVN:Core 1.2.1 or better" if $
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,$opt_P);
 
 sub usage() {
 	print STDERR <<END;
@@ -39,17 +39,19 @@ Usage: ${\basename $0}     # fetch/updat
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [-F] [SVN_URL]
+       [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:Suv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
 my $trunk_name = $opt_T || "trunk";
 my $branch_name = $opt_b || "branches";
+my $project_name = $opt_P || "";
+$project_name = "/" . $project_name if ($project_name);
 
 @ARGV == 1 or @ARGV == 2 or usage();
 
@@ -427,6 +429,20 @@ sub get_ignore($$$$$) {
 	}
 }
 
+sub project_path($$)
+{
+	my ($path, $project) = @_;
+
+	$path = "/".$path unless ($path =~ m#^\/#) ;
+	return $1 if ($path =~ m#^$project\/(.*)$#);
+
+	$path =~ s#\.#\\\.#g;
+	$path =~ s#\+#\\\+#g;
+	return "/" if ($project =~ m#^$path.*$#);
+
+	return undef;
+}
+
 sub split_path($$) {
 	my($rev,$path) = @_;
 	my $branch;
@@ -446,7 +462,11 @@ sub split_path($$) {
 		print STDERR "$rev: Unrecognized path: $path\n" unless (defined $no_error{$path});
 		return ()
 	}
-	$path = "/" if $path eq "";
+	if ($path eq "") {
+		$path = "/";
+	} elsif ($project_name) {
+		$path = project_path($path, $project_name);
+	}
 	return ($branch,$path);
 }
 
@@ -898,6 +918,7 @@ sub commit_all {
 	while(my($path,$action) = each %$changed_paths) {
 		($branch,$path) = split_path($revision,$path);
 		next if not defined $branch;
+		next if not defined $path;
 		$done{$branch}{$path} = $action;
 	}
 	while(($branch,$changed_paths) = each %done) {
-- 
1.4.3.1.g9f9e
