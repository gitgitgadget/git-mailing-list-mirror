From: Aaron Crane <git@aaroncrane.co.uk>
Subject: [PATCH] cvsimport: new -R option: generate revision-to-commit mapping
Date: Sun, 31 Jan 2010 12:43:44 +0000
Message-ID: <bc341e101001310443x18e02281i2e4d18334ead700b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 13:45:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbZBF-0004o2-Dm
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 13:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab0AaMoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 07:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401Ab0AaMoD
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 07:44:03 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60472 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab0AaMoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 07:44:01 -0500
Received: by ewy19 with SMTP id 19so1163966ewy.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 04:43:59 -0800 (PST)
Received: by 10.216.88.79 with SMTP id z57mr2011438wee.22.1264941839325; Sun, 
	31 Jan 2010 04:43:59 -0800 (PST)
X-Originating-IP: [87.194.157.167]
X-Google-Sender-Auth: 73bee3beba0cb9e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138542>

Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
---
See also the thread beginning at
http://thread.gmane.org/gmane.comp.version-control.git/138079

This is my first Git submission, so I'd welcome any comments, especially
if there's something wrong with the way I'm sending this.

 Documentation/git-cvsimport.txt |   15 ++++++++++++++-
 git-cvsimport.perl              |   20 ++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ddfcb3d..19e8c9f 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
 	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [<CVS_module>]
+	      [-r <remote>] [-R <revision-to-commit-file>] [<CVS_module>]


 DESCRIPTION
@@ -157,6 +157,19 @@ It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
 'git cvsexportcommit'.

+-R <revision-to-commit-file>::
+	Generate a file containing a mapping from CVS revision numbers to
+	newly-created Git commit IDs.  The generated file will contain one
+	line for each (filename, revision) pair found by 'cvsps'; each line
+	will look like
++
+---------
+src/widget.c 1.1 1d862f173cdc7325b6fa6d2ae1cfd61fd1b512b7
+---------
++
+This option may be useful if you have CVS revision numbers stored in commit
+messages, bug-tracking systems, email archives, and the like.
+
 -h::
 	Print a short usage message and exit.

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 4853bf7..8ef89c6 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";

-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email);

 sub usage(;$) {
@@ -40,7 +40,7 @@ Usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [-r remote] [CVS_module]
+       [-r remote] [-R revision-to-commit-file] [CVS_module]
 END
 	exit(1);
 }
@@ -110,7 +110,7 @@ sub read_repo_config {
 	}
 }

-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
+my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R:";
 read_repo_config($opts);
 Getopt::Long::Configure( 'no_ignore_case', 'bundling' );

@@ -175,6 +175,10 @@ if (@opt_M) {
 	push (@mergerx, map { qr/$_/ } @opt_M);
 }

+open my $revision_map, '>', $opt_R
+    or die "Can't open -R file $opt_R: $!\n"
+	if defined $opt_R;
+
 # Remember UTC of our starting time
 # we'll want to avoid importing commits
 # that are too recent
@@ -742,7 +746,7 @@ sub write_tree () {
 }

 my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my (@old,@new,@skipped,%ignorebranch);
+my (@old,@new,@skipped,%ignorebranch,@commit_revisions);

 # commits that cvsps cannot place anywhere...
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
@@ -825,6 +829,11 @@ sub commit {
 	system('git' , 'update-ref', "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";

+	if ($revision_map) {
+		print $revision_map "@$_ $cid\n" for @commit_revisions;
+	}
+	@commit_revisions = ();
+
 	if ($tag) {
 	        my ($xtag) = $tag;
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
@@ -959,6 +968,7 @@ while (<CVS>) {
 		    push(@skipped, $fn);
 		    next;
 		}
+		push @commit_revisions, [$fn, $rev];
 		print "Fetching $fn   v $rev\n" if $opt_v;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
 		if ($size == -1) {
@@ -981,7 +991,9 @@ while (<CVS>) {
 		unlink($tmpname);
 	} elsif ($state == 9 and
/^\s+(.+?):\d+(?:\.\d+)+->(\d+(?:\.\d+)+)\(DEAD\)\s*$/) {
 		my $fn = $1;
+		my $rev = $2;
 		$fn =~ s#^/+##;
+		push @commit_revisions, [$fn, $rev];
 		push(@old,$fn);
 		print "Delete $fn\n" if $opt_v;
 	} elsif ($state == 9 and /^\s*$/) {
-- 
1.6.6.1
