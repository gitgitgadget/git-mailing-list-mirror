From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] cvsimport: add support for new style remote layout
Date: Wed, 30 May 2007 01:56:41 +0100
Message-ID: <3a477a76f6c5396feee452678fb8110c@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 03:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtCrw-0001bc-Be
	for gcvg-git@gmane.org; Wed, 30 May 2007 03:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXE3BUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 21:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbXE3BUo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 21:20:44 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:38069
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750823AbXE3BUn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2007 21:20:43 -0400
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 May 2007 21:20:43 EDT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1HtCUT-0006V2-K3
	for git@vger.kernel.org; Wed, 30 May 2007 01:56:41 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48719>


cvsimport creates any branches found in the remote CVS repository
in the refs/heads namespace.  This makes sense for a repository
conversion.  When using git as a sane interface to a remote CVS
repository, that repository may well remain as the 'master'
respository.  In this model it makes sense to import the CVS
repository into the refs/remotes namespace.

Add a new option '-r <remote>' to set the remote name for
this import.  When this option is specified branches are named
refs/remotes/<remote>/branch, with HEAD named as master matching
git-clone separate remotes layout.  Without branches are placed
ion refs/heads, with HEAD named origin as before.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---

	Given that separate remotes is the default for 1.5
	it could be argued that this the default should be the
	equivalent of '-r origin'.  This patch does not do that.
---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f68afe7..f16ac3d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
 my (%conv_author_name, %conv_author_email);
 
 sub usage(;$) {
@@ -114,7 +114,7 @@ sub read_repo_config {
     }
 }
 
-my $opts = "haivmkuo:d:p:C:z:s:M:P:A:S:L:";
+my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
 read_repo_config($opts);
 getopts($opts) or usage();
 usage if $opt_h;
@@ -134,13 +134,21 @@ if ($opt_d) {
 } else {
 	usage("CVSROOT needs to be set");
 }
-$opt_o ||= "origin";
 $opt_s ||= "-";
 $opt_a ||= 0;
 
 my $git_tree = $opt_C;
 $git_tree ||= ".";
 
+my $remote;
+if (defined $opt_r) {
+	$remote = 'refs/remotes/' . $opt_r;
+	$opt_o ||= "master";
+} else {
+	$opt_o ||= "origin";
+	$remote = 'refs/heads';
+}
+
 my $cvs_tree;
 if ($#ARGV == 0) {
 	$cvs_tree = $ARGV[0];
@@ -522,7 +530,7 @@ sub get_headref ($$) {
     my $name    = shift;
     my $git_dir = shift; 
     
-    my $f = "$git_dir/refs/heads/$name";
+    my $f = "$git_dir/$remote/$name";
     if (open(my $fh, $f)) {
 	    chomp(my $r = <$fh>);
 	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
@@ -573,12 +581,12 @@ unless (-d $git_dir) {
 
 	# Get the last import timestamps
 	my $fmt = '($ref, $author) = (%(refname), %(author));';
-	open(H, "git-for-each-ref --perl --format='$fmt' refs/heads |") or
+	open(H, "git-for-each-ref --perl --format='$fmt' $remote |") or
 		die "Cannot run git-for-each-ref: $!\n";
 	while (defined(my $entry = <H>)) {
 		my ($ref, $author);
 		eval($entry) || die "cannot eval refs list: $@";
-		my ($head) = ($ref =~ m|^refs/heads/(.*)|);
+		my ($head) = ($ref =~ m|^$remote/(.*)|);
 		$author =~ /^.*\s(\d+)\s[-+]\d{4}$/;
 		$branch_date{$head} = $1;
 	}
@@ -701,9 +709,9 @@ sub commit {
 		$index{$branch} = tmpnam();
 		$ENV{GIT_INDEX_FILE} = $index{$branch};
 		if ($ancestor) {
-		    system("git-read-tree", $ancestor);
+		    system("git-read-tree", "$remote/$ancestor");
 		} else {
-		    system("git-read-tree", $branch);
+		    system("git-read-tree", "$remote/$branch");
 		}
 		die "read-tree failed: $?\n" if $?;
 	    }
@@ -762,7 +770,7 @@ sub commit {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	system("git-update-ref refs/heads/$branch $cid") == 0
+	system("git-update-ref $remote/$branch $cid") == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
@@ -883,12 +891,12 @@ while (<CVS>) {
 				print STDERR "Branch $branch erroneously stems from itself -- changed ancestor to $opt_o\n";
 				$ancestor = $opt_o;
 			}
-			if (-f "$git_dir/refs/heads/$branch") {
+			if (-f "$git_dir/$remote/$branch") {
 				print STDERR "Branch $branch already exists!\n";
 				$state=11;
 				next;
 			}
-			unless (open(H,"$git_dir/refs/heads/$ancestor")) {
+			unless (open(H,"$git_dir/$remote/$ancestor")) {
 				print STDERR "Branch $ancestor does not exist!\n";
 				$ignorebranch{$branch} = 1;
 				$state=11;
@@ -896,7 +904,7 @@ while (<CVS>) {
 			}
 			chomp(my $id = <H>);
 			close(H);
-			unless (open(H,"> $git_dir/refs/heads/$branch")) {
+			unless (open(H,"> $git_dir/$remote/$branch")) {
 				print STDERR "Could not create branch $branch: $!\n";
 				$ignorebranch{$branch} = 1;
 				$state=11;
@@ -1010,13 +1018,13 @@ if ($orig_branch) {
 		die "Fast-forward update failed: $?\n" if $?;
 	}
 	else {
-		system(qw(git-merge cvsimport HEAD), "refs/heads/$opt_o");
+		system(qw(git-merge cvsimport HEAD), "$remote/$opt_o");
 		die "Could not merge $opt_o into the current branch.\n" if $?;
 	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("git-update-ref", "refs/heads/master", "refs/heads/$opt_o")
+	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
 		unless -f "$git_dir/refs/heads/master";
 	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
