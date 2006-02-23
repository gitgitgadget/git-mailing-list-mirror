From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Port git-annotate to qx{} syntax, and make default output
 more like CVS
Date: Thu, 23 Feb 2006 14:53:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602231442390.24946@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Feb 23 14:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCGuS-0000yn-LS
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 14:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWBWNx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWBWNx3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 08:53:29 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:27795 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751182AbWBWNx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 08:53:28 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 8E3CB14EA;
	Thu, 23 Feb 2006 14:53:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 81281116C;
	Thu, 23 Feb 2006 14:53:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6A4ACA0C;
	Thu, 23 Feb 2006 14:53:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16646>


This uses the qx{} syntax Alex digged up, and it makes output without "-l"
quite similar to CVS's annotate output.

Oh, and it ignores a dirty work file. In fact, it even ignores a clean 
work file, but fetches a clean version from the repository.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-annotate.perl |   82 +++++++++++++++++++++++++----------------------------
 1 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/git-annotate.perl b/git-annotate.perl
index 3800c46..e9e5a3d 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -37,14 +37,14 @@ my @stack = (
 
 our (@lineoffsets, @pendinglineoffsets);
 our @filelines = ();
-open(F,"<",$filename)
-	or die "Failed to open filename: $!";
 
-while(<F>) {
+our $blob_sha1 = qx{git-ls-tree HEAD "$filename"};
+$blob_sha1 =~ s/^.*blob (\S*).*$/$1/;
+foreach (qx{git-cat-file blob $blob_sha1}) {
 	chomp;
 	push @filelines, $_;
 }
-close(F);
+!$? or exit $?;
 our $leftover_lines = @filelines;
 our %revs;
 our @revqueue;
@@ -91,13 +91,12 @@ foreach my $l (@filelines) {
 		if (!$opt_l && length($rev) > 8) {
 			$rev = substr($rev,0,8);
 		}
+		printf("%s\t(%10s\t%s):%s\n", $rev, $committer,
+			format_date($date), $output);
 	} else {
-		$output = $l;
-		($rev, $committer, $date) = ('unknown', 'unknown', 'unknown');
+		printf("%s\t(%10s\t%10s\t%d)%s\n", $rev, $committer,
+			format_date($date), $i++, $output);
 	}
-
-	printf("%s\t(%10s\t%10s\t%d)%s\n", $rev, $committer,
-		format_date($date), $i++, $output);
 }
 
 sub init_claim {
@@ -143,20 +142,24 @@ sub handle_rev {
 sub git_rev_list {
 	my ($rev, $file) = @_;
 
+	my @revs;
 	if ($opt_S) {
 		open(P, '<' . $opt_S);
+		while(my $line = <P>) {
+			chomp $line;
+			my ($rev, @parents) = split /\s+/, $line;
+			push @revs, [ $rev, @parents ];
+		}
+		close(P);
 	} else {
-		open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)
-			or die "Failed to exec git-rev-list: $!";
-	}
-
-	my @revs;
-	while(my $line = <P>) {
-		chomp $line;
-		my ($rev, @parents) = split /\s+/, $line;
-		push @revs, [ $rev, @parents ];
+		foreach (qx{git-rev-list --parents --remove-empty $rev -- $file}
+) {
+			chomp $_;
+			my ($rev, @parents) = split /\s+/, $_;
+			push @revs, [ $rev, @parents ];
+		}
+		!$? or exit $?;
 	}
-	close(P);
 
 	printf("0 revs found for rev %s (%s)\n", $rev, $file) if (@revs == 0);
 	return @revs;
@@ -165,13 +168,11 @@ sub git_rev_list {
 sub find_parent_renames {
 	my ($rev, $file) = @_;
 
-	open(P,"-|","git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
-		or die "Failed to exec git-diff: $!";
-
 	local $/ = "\0";
 	my %bound;
 	my $junk = <P>;
-	while (my $change = <P>) {
+	foreach (qx{git-diff-tree -M50 -r --name-status -z $rev}) {
+		my $change = $_;
 		chomp $change;
 		my $filename = <P>;
 		chomp $filename;
@@ -189,7 +190,7 @@ sub find_parent_renames {
 			}
 		}
 	}
-	close(P);
+	!$? or exit $?;
 
 	return \%bound;
 }
@@ -198,15 +199,12 @@ sub find_parent_renames {
 sub git_find_parent {
 	my ($rev, $filename) = @_;
 
-	open(REVPARENT,"-|","git-rev-list","--remove-empty", "--parents","--max-count=1","$rev","--",$filename)
-		or die "Failed to open git-rev-list to find a single parent: $!";
+	my $parentline = qx{git-rev-list --remove-empty --parents --max-count=1 $rev -- $filename};
+	!$? or die "Failed to open git-rev-list to find a single parent: $!";
 
-	my $parentline = <REVPARENT>;
 	chomp $parentline;
 	my ($revfound,$parent) = split m/\s+/, $parentline;
 
-	close(REVPARENT);
-
 	return $parent;
 }
 
@@ -217,17 +215,13 @@ sub git_diff_parse {
 	my ($parent, $rev, %revinfo) = @_;
 
 	my ($ri, $pi) = (0,0);
-	open(DIFF,"-|","git-diff-tree","-M","-p",$rev,$parent,"--",
-			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
-		or die "Failed to call git-diff for annotation: $!";
-
 	my $slines = $revs{$rev}{'lines'};
 	my @plines;
 
 	my $gotheader = 0;
 	my ($remstart, $remlength, $addstart, $addlength);
 	my ($hunk_start, $hunk_index, $hunk_adds);
-	while(<DIFF>) {
+	foreach (qx{git-diff-tree -M -p $rev $parent -- $revs{$rev}{'filename'} $revs{$parent}{'filename'}}) {
 		chomp;
 		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
 			($remstart, $remlength, $addstart, $addlength) = ($1, $2, $3, $4);
@@ -279,7 +273,7 @@ sub git_diff_parse {
 		}
 		$hunk_index++;
 	}
-	close(DIFF);
+	!$? or exit $?;
 	for (my $i = $ri; $i < @{$slines} ; $i++) {
 		push @plines, $slines->[$ri++];
 	}
@@ -300,15 +294,12 @@ sub git_cat_file {
 	my $blobline = `git-ls-tree $parent $filename`;
 	my ($mode, $type, $blob, $tfilename) = split(/\s+/, $blobline, 4);
 
-	open(C,"-|","git-cat-file", "blob", $blob)
-		or die "Failed to git-cat-file blob $blob (rev $parent, file $filename): " . $!;
-
 	my @lines;
-	while(<C>) {
+	foreach (qx{git-cat-file blob $blob}) {
 		chomp;
 		push @lines, $_;
 	}
-	close(C);
+	!$? or die "Failed to git-cat-file blob $blob (rev $parent, file $filename).";
 
 	return @lines;
 }
@@ -325,11 +316,9 @@ sub claim_line {
 
 sub git_commit_info {
 	my ($rev) = @_;
-	open(COMMIT, "-|","git-cat-file", "commit", $rev)
-		or die "Failed to call git-cat-file: $!";
 
 	my %info;
-	while(<COMMIT>) {
+	foreach (qx{git-cat-file commit $rev}) {
 		chomp;
 		last if (length $_ == 0);
 
@@ -343,7 +332,7 @@ sub git_commit_info {
 			$info{'committer_date'} = $3;
 		}
 	}
-	close(COMMIT);
+	!$? or exit $?;
 
 	return %info;
 }
@@ -351,6 +340,11 @@ sub git_commit_info {
 sub format_date {
 	my ($timestamp, $timezone) = split(' ', $_[0]);
 
+	if (!$opt_l) {
+		return strftime("%Y-%b-%d", gmtime($timestamp));
+	}
+
 	return strftime("%Y-%m-%d %H:%M:%S " . $timezone, gmtime($timestamp));
 }
 
+
