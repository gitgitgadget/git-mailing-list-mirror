From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] annotate: Handle dirty state and arbitrary revisions.
Date: Sat, 25 Feb 2006 20:48:33 -0500
Message-ID: <11409185133616-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 02:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDB1n-0002MJ-Cl
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 02:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWBZBsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 20:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWBZBsm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 20:48:42 -0500
Received: from mail.autoweb.net ([198.172.237.26]:8417 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751158AbWBZBsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 20:48:41 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FDB1a-00082P-Ar; Sat, 25 Feb 2006 20:48:40 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDB1W-0007gk-3J; Sat, 25 Feb 2006 20:48:34 -0500
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan.michonline.com with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDB1V-0003ev-Ky; Sat, 25 Feb 2006 20:48:33 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: junkio@cox.net
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16766>

Also, use Getopt::Long and only process each rev once.

(Thanks to Morten Welinder for spotting the performance problems.)

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

Or pull from http://h4x0r5.com/~ryan/git/ryan.git/ annotate-upstream

 git-annotate.perl |  150 ++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 113 insertions(+), 37 deletions(-)

9ca393b055b53df4eb9284b39f38c5b42b7f93b1
diff --git a/git-annotate.perl b/git-annotate.perl
index 3800c46..91da6d5 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -8,44 +8,62 @@
 
 use warnings;
 use strict;
-use Getopt::Std;
+use Getopt::Long;
 use POSIX qw(strftime gmtime);
 
 sub usage() {
-	print STDERR 'Usage: ${\basename $0} [-s] [-S revs-file] file
-
-	-l		show long rev
-	-r		follow renames
-	-S commit	use revs from revs-file instead of calling git-rev-list
+	print STDERR 'Usage: ${\basename $0} [-s] [-S revs-file] file [ revision ]
+	-l, --long
+			Show long rev (Defaults off)
+	-r, --rename
+			Follow renames (Defaults on).
+	-S, --rev-file revs-file
+			use revs from revs-file instead of calling git-rev-list
+	-h, --help
+			This message.
 ';
 
 	exit(1);
 }
 
-our ($opt_h, $opt_l, $opt_r, $opt_S);
-getopts("hlrS:") or usage();
-$opt_h && usage();
+our ($help, $longrev, $rename, $starting_rev, $rev_file) = (0, 0, 1);
+
+my $rc = GetOptions(	"long|l" => \$longrev,
+			"help|h" => \$help,
+			"rename|r" => \$rename,
+			"rev-file|S" => \$rev_file);
+if (!$rc or $help) {
+	usage();
+}
 
 my $filename = shift @ARGV;
+if (@ARGV) {
+	$starting_rev = shift @ARGV;
+}
 
 my @stack = (
 	{
-		'rev' => "HEAD",
+		'rev' => defined $starting_rev ? $starting_rev : "HEAD",
 		'filename' => $filename,
 	},
 );
 
-our (@lineoffsets, @pendinglineoffsets);
 our @filelines = ();
-open(F,"<",$filename)
-	or die "Failed to open filename: $!";
 
-while(<F>) {
-	chomp;
-	push @filelines, $_;
+if (defined $starting_rev) {
+	@filelines = git_cat_file($starting_rev, $filename);
+} else {
+	open(F,"<",$filename)
+		or die "Failed to open filename: $!";
+
+	while(<F>) {
+		chomp;
+		push @filelines, $_;
+	}
+	close(F);
+
 }
-close(F);
-our $leftover_lines = @filelines;
+
 our %revs;
 our @revqueue;
 our $head;
@@ -66,7 +84,7 @@ while (my $bound = pop @stack) {
 			next;
 		}
 
-		if (!$opt_r) {
+		if (!$rename) {
 			next;
 		}
 
@@ -78,8 +96,18 @@ while (my $bound = pop @stack) {
 	}
 }
 push @revqueue, $head;
-init_claim($head);
-$revs{$head}{'lineoffsets'} = {};
+init_claim( defined $starting_rev ? $starting_rev : 'dirty');
+unless (defined $starting_rev) {
+	open(DIFF,"-|","git","diff","-R", "HEAD", "--",$filename)
+		or die "Failed to call git diff to check for dirty state: $!";
+
+	_git_diff_parse(*DIFF, $head, "dirty", (
+				'author' => gitvar_name("GIT_AUTHOR_IDENT"),
+				'author_date' => sprintf("%s +0000",time()),
+				)
+			);
+	close(DIFF);
+}
 handle_rev();
 
 
@@ -88,7 +116,7 @@ foreach my $l (@filelines) {
 	my ($output, $rev, $committer, $date);
 	if (ref $l eq 'ARRAY') {
 		($output, $rev, $committer, $date) = @$l;
-		if (!$opt_l && length($rev) > 8) {
+		if (!$longrev && length($rev) > 8) {
 			$rev = substr($rev,0,8);
 		}
 	} else {
@@ -102,7 +130,6 @@ foreach my $l (@filelines) {
 
 sub init_claim {
 	my ($rev) = @_;
-	my %revinfo = git_commit_info($rev);
 	for (my $i = 0; $i < @filelines; $i++) {
 		$filelines[$i] = [ $filelines[$i], '', '', '', 1];
 			# line,
@@ -117,7 +144,9 @@ sub init_claim {
 
 sub handle_rev {
 	my $i = 0;
+	my %seen;
 	while (my $rev = shift @revqueue) {
+		next if $seen{$rev}++;
 
 		my %revinfo = git_commit_info($rev);
 
@@ -143,8 +172,8 @@ sub handle_rev {
 sub git_rev_list {
 	my ($rev, $file) = @_;
 
-	if ($opt_S) {
-		open(P, '<' . $opt_S);
+	if ($rev_file) {
+		open(P, '<' . $rev_file);
 	} else {
 		open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)
 			or die "Failed to exec git-rev-list: $!";
@@ -216,24 +245,31 @@ sub git_find_parent {
 sub git_diff_parse {
 	my ($parent, $rev, %revinfo) = @_;
 
-	my ($ri, $pi) = (0,0);
 	open(DIFF,"-|","git-diff-tree","-M","-p",$rev,$parent,"--",
 			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
 		or die "Failed to call git-diff for annotation: $!";
 
+	_git_diff_parse(*DIFF, $parent, $rev, %revinfo);
+
+	close(DIFF);
+}
+
+sub _git_diff_parse {
+	my ($diff, $parent, $rev, %revinfo) = @_;
+
+	my ($ri, $pi) = (0,0);
 	my $slines = $revs{$rev}{'lines'};
 	my @plines;
 
 	my $gotheader = 0;
-	my ($remstart, $remlength, $addstart, $addlength);
-	my ($hunk_start, $hunk_index, $hunk_adds);
+	my ($remstart);
+	my ($hunk_start, $hunk_index);
 	while(<DIFF>) {
 		chomp;
 		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
-			($remstart, $remlength, $addstart, $addlength) = ($1, $2, $3, $4);
+			$remstart = $1;
 			# Adjust for 0-based arrays
 			$remstart--;
-			$addstart--;
 			# Reinit hunk tracking.
 			$hunk_start = $remstart;
 			$hunk_index = 0;
@@ -279,7 +315,6 @@ sub git_diff_parse {
 		}
 		$hunk_index++;
 	}
-	close(DIFF);
 	for (my $i = $ri; $i < @{$slines} ; $i++) {
 		push @plines, $slines->[$ri++];
 	}
@@ -295,13 +330,13 @@ sub get_line {
 }
 
 sub git_cat_file {
-	my ($parent, $filename) = @_;
-	return () unless defined $parent && defined $filename;
-	my $blobline = `git-ls-tree $parent $filename`;
-	my ($mode, $type, $blob, $tfilename) = split(/\s+/, $blobline, 4);
+	my ($rev, $filename) = @_;
+	return () unless defined $rev && defined $filename;
 
-	open(C,"-|","git-cat-file", "blob", $blob)
-		or die "Failed to git-cat-file blob $blob (rev $parent, file $filename): " . $!;
+	my $blob = git_ls_tree($rev, $filename);
+
+	open(C,"-|","git","cat-file", "blob", $blob)
+		or die "Failed to git-cat-file blob $blob (rev $rev, file $filename): " . $!;
 
 	my @lines;
 	while(<C>) {
@@ -313,6 +348,25 @@ sub git_cat_file {
 	return @lines;
 }
 
+sub git_ls_tree {
+	my ($rev, $filename) = @_;
+
+	open(T,"-|","git","ls-tree",$rev,$filename)
+		or die "Failed to call git ls-tree: $!";
+
+	my ($mode, $type, $blob, $tfilename);
+	while(<T>) {
+		($mode, $type, $blob, $tfilename) = split(/\s+/, $_, 4);
+		last if ($tfilename eq $filename);
+	}
+	close(T);
+
+	return $blob if $filename eq $filename;
+	die "git-ls-tree failed to find blob for $filename";
+
+}
+
+
 
 sub claim_line {
 	my ($floffset, $rev, $lines, %revinfo) = @_;
@@ -354,3 +408,25 @@ sub format_date {
 	return strftime("%Y-%m-%d %H:%M:%S " . $timezone, gmtime($timestamp));
 }
 
+# Copied from git-send-email.perl - We need a Git.pm module..
+sub gitvar {
+    my ($var) = @_;
+    my $fh;
+    my $pid = open($fh, '-|');
+    die "$!" unless defined $pid;
+    if (!$pid) {
+	exec('git-var', $var) or die "$!";
+    }
+    my ($val) = <$fh>;
+    close $fh or die "$!";
+    chomp($val);
+    return $val;
+}
+
+sub gitvar_name {
+    my ($name) = @_;
+    my $val = gitvar($name);
+    my @field = split(/\s+/, $val);
+    return join(' ', @field[0...(@field-4)]);
+}
+
-- 
1.2.3.g9ca3
