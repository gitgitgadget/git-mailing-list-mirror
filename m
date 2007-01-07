From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport: support for incremental import
Date: Sun, 7 Jan 2007 02:17:19 +0200
Message-ID: <20070107001719.GB16771@sashak.voltaire.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104213142.GE11861@sashak.voltaire.com> <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 01:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3LcB-0002lN-CG
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 01:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbXAGAKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 19:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXAGAKH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 19:10:07 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:18417 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbXAGAKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 19:10:05 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 Jan 2007 02:10:00 +0200
Received: by sashak (sSMTP sendmail emulation); Sun,  7 Jan 2007 02:17:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 07 Jan 2007 00:10:00.0872 (UTC) FILETIME=[2C504A80:01C731F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36106>

This adds ability to do import "in chunks" (default 1000 revisions),
after each chunk git repo will be repacked. The option -R is used to
change default value of chunk size (or how often repository will
repacked).

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---

Chris reported successful test with this patch.

 Documentation/git-svnimport.txt |   10 +++++++++-
 git-svnimport.perl              |   32 +++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index 2c7c7da..b166cf3 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
 		[ -I <ignorefile_name> ] [ -A <author_file> ]
-		[ -P <path_from_trunk> ]
+		[ -R <repack_each_revs>] [ -P <path_from_trunk> ]
 		<SVN_repository_URL> [ <path> ]
 
 
@@ -108,6 +108,14 @@ repository without -A.
 Formerly, this option controlled how many revisions to pull,
 due to SVN memory leaks. (These have been worked around.)
 
+-R <repack_each_revs>::
+	Specify how often git repository should be repacked.
++
+The default value is 1000. git-svnimport will do import in chunks of 1000
+revisions, after each chunk git repository will be repacked. To disable
+this behavior specify some big value here which is mote than number of
+revisions to import.
+
 -P <path_from_trunk>::
 	Partial import of the SVN tree.
 +
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 071777b..afbbe63 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,12 +31,13 @@ $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,$opt_P);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
+    $opt_P,$opt_R);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
-       [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
+       [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
        [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
@@ -44,7 +45,7 @@ END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:uv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -52,6 +53,7 @@ my $trunk_name = $opt_T || "trunk";
 my $branch_name = $opt_b || "branches";
 my $project_name = $opt_P || "";
 $project_name = "/" . $project_name if ($project_name);
+my $repack_after = $opt_R || 1000;
 
 @ARGV == 1 or @ARGV == 2 or usage();
 
@@ -938,11 +940,27 @@ if ($opt_l < $current_rev) {
     exit;
 }
 
-print "Fetching from $current_rev to $opt_l ...\n" if $opt_v;
+print "Processing from $current_rev to $opt_l ...\n" if $opt_v;
 
-my $pool=SVN::Pool->new;
-$svn->{'svn'}->get_log("/",$current_rev,$opt_l,0,1,1,\&commit_all,$pool);
-$pool->clear;
+my $from_rev;
+my $to_rev = $current_rev;
+
+while ($to_rev < $opt_l) {
+	$from_rev = $to_rev;
+	$to_rev = $from_rev + $repack_after;
+	$to_rev = $opt_l if $opt_l < $to_rev;
+	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
+	my $pool=SVN::Pool->new;
+	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all,$pool);
+	$pool->clear;
+	my $pid = fork();
+	die "Fork: $!\n" unless defined $pid;
+	unless($pid) {
+		exec("git-repack", "-d")
+			or die "Cannot repack: $!\n";
+	}
+	waitpid($pid, 0);
+}
 
 
 unlink($git_index);
-- 
1.5.0.rc0.g2484-dirty
