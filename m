From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: leave working directory alone.
Date: Mon, 4 Jul 2005 14:13:09 +0200
Message-ID: <20050704121309.GI18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 14:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpQ7D-0003ca-Pa
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 14:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVGDMbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 08:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVGDMbk
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 08:31:40 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:26003 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261657AbVGDM3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 08:29:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 29DCA137A1F
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:29:54 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 4041E137922
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:29:52 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 2D6974C0D1
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 14:29:52 +0200 (CEST)
Received: (qmail 6327 invoked by uid 500); 4 Jul 2005 12:13:09 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: leave working directory alone.

---
commit 2eb6d82eaa869a1faf4ba3326fd628f76f9f93a8
tree 3e59c8c298e51a8ae20102b4b139c84c79fa54a0
parent 866d13108e969773347828daa9b7f3476ec70cb8
author Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 00:43:26 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 00:43:26 +0200

 git-cvsimport-script |   81 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -80,6 +80,8 @@ package CVSconn;
 # Basic CVS dialog.
 # We're only interested in connecting and downloading, so ...
 
+use File::Spec;
+use File::Temp qw(tempfile);
 use POSIX qw(strftime dup2);
 
 sub new {
@@ -231,11 +233,11 @@ sub _file {
 sub _line {
 	# Read a line from the server.
 	# ... except that 'line' may be an entire file. ;-)
-	my($self) = @_;
+	my($self, $fh) = @_;
 	die "Not in lines" unless defined $self->{'lines'};
 
 	my $line;
-	my $res="";
+	my $res=0;
 	while(defined($line = $self->readline())) {
 		# M U gnupg-cvs-rep/AUTHORS
 		# Updated gnupg-cvs-rep/
@@ -255,16 +257,18 @@ sub _line {
 			chomp $cnt;
 			die "Duh: Filesize $cnt" if $cnt !~ /^\d+$/;
 			$line="";
-			$res="";
+			$res=0;
 			while($cnt) {
 				my $buf;
 				my $num = $self->{'socketi'}->read($buf,$cnt);
 				die "Server: Filesize $cnt: $num: $!\n" if not defined $num or $num<=0;
-				$res .= $buf;
+				print $fh $buf;
+				$res += $num;
 				$cnt -= $num;
 			}
 		} elsif($line =~ s/^ //) {
-			$res .= $line;
+			print $fh $line;
+			$res += length($line);
 		} elsif($line =~ /^M\b/) {
 			# output, do nothing
 		} elsif($line =~ /^Mbinary\b/) {
@@ -277,7 +281,8 @@ sub _line {
 				my $buf;
 				my $num = $self->{'socketi'}->read($buf,$cnt);
 				die "S: Mbinary $cnt: $num: $!\n" if not defined $num or $num<=0;
-				$res .= $buf;
+				print $fh $buf;
+				$res += $num;
 				$cnt -= $num;
 			}
 		} else {
@@ -297,18 +302,21 @@ sub file {
 	my($self,$fn,$rev) = @_;
 	my $res;
 
-	if ($self->_file($fn,$rev)) {
-		$res = $self->_line();
-		return $res if defined $res;
+	my ($fh, $name) = tempfile('gitcvs.XXXXXX', 
+		    DIR => File::Spec->tmpdir(), UNLINK => 1);
+
+	$self->_file($fn,$rev) and $res = $self->_line($fh);
+
+	if (!defined $res) {
+	    # retry
+	    $self->conn();
+	    $self->_file($fn,$rev)
+		    or die "No file command send\n";
+	    $res = $self->_line($fh);
+	    die "No input: $fn $rev\n" unless defined $res;
 	}
 
-	# retry
-	$self->conn();
-	$self->_file($fn,$rev)
-		or die "No file command send\n";
-	$res = $self->_line();
-	die "No input: $fn $rev\n" unless defined $res;
-	return $res;
+	return ($name, $res);
 }
 
 
@@ -457,13 +465,14 @@ my $commit = sub {
 	}
 	while(@new) {
 		my @n2;
-		if(@new > 55) {
-			@n2 = splice(@new,0,50);
+		if(@new > 12) {
+			@n2 = splice(@new,0,10);
 		} else {
 			@n2 = @new;
 			@new = ();
 		}
-		system("git-update-cache","--add","--",@n2);
+		system("git-update-cache","--add",
+			(map { ('--cacheinfo', @$_) } @n2));
 		die "Cannot add files: $?\n" if $?;
 	}
 
@@ -631,7 +640,7 @@ while(<CVS>) {
 		}
 		if(($ancestor || $branch) ne $last_branch) {
 			print "Switching from $last_branch to $branch\n" if $opt_v;
-			system("git-read-tree","-m","-u","$last_branch","$branch");
+			system("git-read-tree","-m","$last_branch","$branch");
 			die "read-tree failed: $?\n" if $?;
 		}
 		if($branch ne $last_branch) {
@@ -648,17 +657,16 @@ while(<CVS>) {
 		my $fn = $1;
 		my $rev = $3;
 		$fn =~ s#^/+##;
-		my $data = $cvs->file($fn,$rev);
-		print "".($init ? "New" : "Update")." $fn: ".length($data)." bytes.\n" if $opt_v;
-		mkpath(dirname($fn),$opt_v);
-		open(F,"> ./$fn")
-			or die "Cannot create '$fn': $!\n";
-		print F $data
-			or die "Cannot write to '$fn': $!\n";
-		close(F)
-			or die "Cannot write to '$fn': $!\n";
-		chmod(pmode($cvs->{'mode'}), $fn);
-		push(@new,$fn); # may be resurrected!
+		my ($tmpname, $size) = $cvs->file($fn,$rev);
+		print "".($init ? "New" : "Update")." $fn: $size bytes.\n" if $opt_v;
+		open my $F, '-|', "git-write-blob $tmpname"
+			or die "Cannot create object: $!\n";
+		my $sha = <$F>;
+		chomp $sha;
+		close $F;
+		unlink($tmpname);
+		my $mode = pmode($cvs->{'mode'});
+		push(@new,[$mode, $sha, $fn]); # may be resurrected!
 	} elsif($state == 9 and /^\s+(\S+):\d(?:\.\d+)+->(\d(?:\.\d+)+)\(DEAD\)\s*$/) {
 		my $fn = $1;
 		$fn =~ s#^/+##;
@@ -688,8 +696,15 @@ if($orig_branch) {
 		unless -f "$git_dir/refs/heads/master";
 }
 
-system("git-read-tree","-m","-u","$last_branch","$orig_branch");
-die "read-tree failed: $?\n" if $?;
+if ($orig_branch) {
+	system("git-read-tree",$last_branch);
+	die "read-tree failed: $?\n" if $?;
+} else {
+	system('git-read-tree', $orig_branch);
+	die "read-tree failed: $?\n" if $?;
+	system('git-checkout-cache', '-a');
+	die "checkout-cache failed: $?\n" if $?;
+}
 
 unlink("$git_dir/HEAD");
 symlink("refs/heads/$orig_branch","$git_dir/HEAD");
