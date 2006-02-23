From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Convert open("-|") to qx{} calls
Date: Thu, 23 Feb 2006 15:33:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Feb 23 15:33:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCHXK-0001bE-Qp
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 15:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWBWOdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 09:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWBWOdT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 09:33:19 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:42695 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751260AbWBWOdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 09:33:18 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 2DCB01646;
	Thu, 23 Feb 2006 15:33:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 218CAA92;
	Thu, 23 Feb 2006 15:33:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0B70C1172;
	Thu, 23 Feb 2006 15:33:16 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16649>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Since of these 4, I only use cvsimport myself, I could only test
	that. Could someone who uses the others give them a hard beating?

 git-cvsimport.perl  |   64 +++++++++++++++++++--------------------------------
 git-rerere.perl     |    9 ++-----
 git-send-email.perl |    9 ++-----
 git-svnimport.perl  |   62 ++++++++++++++-----------------------------------
 4 files changed, 46 insertions(+), 98 deletions(-)

b37d21c223fdc0ef7fc6af889432f6b51ac82992
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b46469a..da009f2 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -478,9 +478,9 @@ unless(-d $git_dir) {
 		       "Either use the correct '-o branch' option,\n".
 		       "or import to a new repository.\n";
 
-	open(F, "git-symbolic-ref HEAD |") or
-		die "Cannot run git-symbolic-ref: $!\n";
-	chomp ($last_branch = <F>);
+	$last_branch = qx{git-symbolic-ref HEAD};
+	!$? or exit $?;
+	chomp ($last_branch);
 	$last_branch = basename($last_branch);
 	close(F);
 	unless($last_branch) {
@@ -516,13 +516,12 @@ EOM
 			or die "Bad head branch: $head: $!\n";
 		chomp(my $ftag = <F>);
 		close(F);
-		open(F,"git-cat-file commit $ftag |");
-		while(<F>) {
+		foreach (qx{git-cat-file commit $ftag}) {
 			next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;
 			$branch_date{$head} = $1;
 			last;
 		}
-		close(F);
+		!$? or exit $?;
 	}
 	closedir(D);
 }
@@ -538,24 +537,21 @@ if ($opt_A) {
 	write_author_info("$git_dir/cvs-authors");
 }
 
-my $pid = open(CVS,"-|");
-die "Cannot fork: $!\n" unless defined $pid;
-unless($pid) {
-	my @opt;
-	@opt = split(/,/,$opt_p) if defined $opt_p;
-	unshift @opt, '-z', $opt_z if defined $opt_z;
-	unshift @opt, '-q'         unless defined $opt_v;
-	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
-		push @opt, '--cvs-direct';
-	}
-	if ($opt_P) {
-	    exec("cat", $opt_P);
-	} else {
-	    exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
-	    die "Could not start cvsps: $!\n";
-	}
+my @opt;
+@opt = split(/,/,$opt_p) if defined $opt_p;
+unshift @opt, '-z', $opt_z if defined $opt_z;
+unshift @opt, '-q'         unless defined $opt_v;
+unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
+	push @opt, '--cvs-direct';
 }
 
+my @input;
+if ($opt_P) {
+    @input = qx{cat $opt_P};
+} else {
+    @input = qx{cvsps --norc opt -u -A --root $opt_d $cvs_tree};
+    !$? or exit $?;
+}
 
 ## cvsps output:
 #---------------------
@@ -603,17 +599,11 @@ my $commit = sub {
 		die "Cannot add files: $?\n" if $?;
 	}
 
-	$pid = open(C,"-|");
-	die "Cannot fork: $!" unless defined $pid;
-	unless($pid) {
-		exec("git-write-tree");
-		die "Cannot exec git-write-tree: $!\n";
-	}
-	chomp(my $tree = <C>);
+	my $tree = qx{git-write-tree};
+	!$? or exit $?;
+	chomp($tree);
 	length($tree) == 40
 		or die "Cannot get tree id ($tree): $!\n";
-	close(C)
-		or die "Error running git-write-tree: $?\n";
 	print "Tree ID $tree\n" if $opt_v;
 
 	my $parent = "";
@@ -734,7 +724,7 @@ my $commit = sub {
 	}
 };
 
-while(<CVS>) {
+foreach (@input) {
 	chomp;
 	if($state == 0 and /^-+$/) {
 		$state = 1;
@@ -846,15 +836,9 @@ while(<CVS>) {
 			print "Drop $fn\n" if $opt_v;
 		} else {
 			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
-			my $pid = open(my $F, '-|');
-			die $! unless defined $pid;
-			if (!$pid) {
-			    exec("git-hash-object", "-w", $tmpname)
-				or die "Cannot create object: $!\n";
-			}
-			my $sha = <$F>;
+			my $sha = qx{git-hash-object -w $tmpname};
+			!$? or exit $?;
 			chomp $sha;
-			close $F;
 			my $mode = pmode($cvs->{'mode'});
 			push(@new,[$mode, $sha, $fn]); # may be resurrected!
 		}
diff --git a/git-rerere.perl b/git-rerere.perl
index d3664ff..0dd04c5 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -131,20 +131,15 @@ sub record_preimage {
 sub find_conflict {
 	my $in;
 	local $/ = "\0";
-	my $pid = open($in, '-|');
-	die "$!" unless defined $pid;
-	if (!$pid) {
-		exec(qw(git ls-files -z -u)) or die "$!: ls-files";
-	}
 	my %path = ();
 	my @path = ();
-	while (<$in>) {
+	foreach (qx{git-ls-files -z -u}) {
 		chomp;
 		my ($mode, $sha1, $stage, $path) =
 		    /^([0-7]+) ([0-9a-f]{40}) ([123])\t(.*)$/s;
 		$path{$path} |= (1 << $stage);
 	}
-	close $in;
+	!$? or exit $?;
 	while (my ($path, $status) = each %path) {
 		if ($status == 14) { push @path, $path; }
 	}
diff --git a/git-send-email.perl b/git-send-email.perl
index b0d095b..bd8fae6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -62,13 +62,8 @@ my $rc = GetOptions("from=s" => \$from,
 sub gitvar {
     my ($var) = @_;
     my $fh;
-    my $pid = open($fh, '-|');
-    die "$!" unless defined $pid;
-    if (!$pid) {
-	exec('git-var', $var) or die "$!";
-    }
-    my ($val) = <$fh>;
-    close $fh or die "$!";
+    my ($val) = qx{git-var $var};
+    !$? or exit $?;
     chomp($val);
     return $val;
 }
diff --git a/git-svnimport.perl b/git-svnimport.perl
index ee2940f..6094a11 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -218,11 +218,10 @@ unless(-d $git_dir) {
 	-f "$git_dir/svn2git"
 		or die "'$git_dir/svn2git' does not exist.\n".
 		       "You need that file for incremental imports.\n";
-	open(F, "git-symbolic-ref HEAD |") or
-		die "Cannot run git-symbolic-ref: $!\n";
-	chomp ($last_branch = <F>);
+	$last_brach = qx{git-symbolic-ref HEAD};
+	!$? or exit $?;
+	chomp $last_branch;
 	$last_branch = basename($last_branch);
-	close(F);
 	unless($last_branch) {
 		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
 		$last_branch = "master";
@@ -321,15 +320,9 @@ sub get_file($$$) {
 		return undef unless defined $name;
 	}
 
-	my $pid = open(my $F, '-|');
-	die $! unless defined $pid;
-	if (!$pid) {
-	    exec("git-hash-object", "-w", $name)
-		or die "Cannot create object: $!\n";
-	}
-	my $sha = <$F>;
+	my $sha = qx{git-hash-object -w $name};
+	!$? or exit $?;
 	chomp $sha;
-	close $F;
 	unlink $name;
 	my $mode = "0644"; # SV does not seem to store any file modes
 	return [$mode, $sha, $path];
@@ -401,14 +394,8 @@ sub copy_path($$$$$$$$) {
 			$srcpath =~ s#/*$#/#;
 	}
 	
-	my $pid = open my $f,'-|';
-	die $! unless defined $pid;
-	if (!$pid) {
-		exec("git-ls-tree","-r","-z",$gitrev,$srcpath)
-			or die $!;
-	}
 	local $/ = "\0";
-	while(<$f>) {
+	foreach (qx{git-ls-tree -r -z $gitrev $srcpath}) {
 		chomp;
 		my($m,$p) = split(/\t/,$_,2);
 		my($mode,$type,$sha1) = split(/ /,$m);
@@ -420,8 +407,7 @@ sub copy_path($$$$$$$$) {
 		}
 		push(@$new,[$mode,$sha1,$p]);	
 	}
-	close($f) or
-		print STDERR "$newrev:$newbranch: could not list files in $oldpath \@ $rev\n";
+	!$? or exit $?;
 }
 
 sub commit {
@@ -472,9 +458,8 @@ sub commit {
 
 	my $rev;
 	if($revision > $opt_s and defined $parent) {
-		open(H,"git-rev-parse --verify $parent |");
-		$rev = <H>;
-		close(H) or do {
+		$rev = qx{git-rev-parse --verify $parent};
+		!$? or do {
 			print STDERR "$revision: cannot find commit '$parent'!\n";
 			return;
 		};
@@ -555,25 +540,20 @@ sub commit {
 		}
 
 		while(@old) {
-			my @o1;
+			my @o2;
 			if(@old > 55) {
-				@o1 = splice(@old,0,50);
+				@o2 = splice(@old,0,50);
 			} else {
-				@o1 = @old;
+				@o2 = @old;
 				@old = ();
 			}
-			my $pid = open my $F, "-|";
-			die "$!" unless defined $pid;
-			if (!$pid) {
-				exec("git-ls-files", "-z", @o1) or die $!;
-			}
-			@o1 = ();
+			my @o1 = ();
 			local $/ = "\0";
-			while(<$F>) {
+			foreach (qx{git-ls-files -z @o1}) {
 				chomp;
 				push(@o1,$_);
 			}
-			close($F);
+			!$? or exit $?;
 
 			while(@o1) {
 				my @o2;
@@ -600,17 +580,11 @@ sub commit {
 			die "Cannot add files: $?\n" if $?;
 		}
 
-		my $pid = open(C,"-|");
-		die "Cannot fork: $!" unless defined $pid;
-		unless($pid) {
-			exec("git-write-tree");
-			die "Cannot exec git-write-tree: $!\n";
-		}
-		chomp(my $tree = <C>);
+		my $tree = qx{git-write-tree};
+		!$? or exit $?;
+		chomp($tree);
 		length($tree) == 40
 			or die "Cannot get tree id ($tree): $!\n";
-		close(C)
-			or die "Error running git-write-tree: $?\n";
 		print "Tree ID $tree\n" if $opt_v;
 
 		my $pr = IO::Pipe->new() or die "Cannot open pipe: $!\n";
-- 
1.2.3.gb37d
