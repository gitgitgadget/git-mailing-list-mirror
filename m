From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 4/7] copy_dir becomes copy_path and handles bothe files and directory
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-00050G-UK@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQXA-0005F2-J4
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbVKBVw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbVKBVw0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:26 -0500
Received: from [195.140.142.33] ([195.140.142.33]:47057 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965284AbVKBVwZ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:25 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003ce-Sq; Wed, 02 Nov 2005 22:52:11 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-00050G-UK; Wed, 02 Nov 2005 23:51:57 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  The A (Add) and R (Replace) actions handling are
	unified. Signed-off-by: Yaacov Akiba Slama <ya@slamail.org> --- [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11050>

The A (Add) and R (Replace) actions handling are unified.

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |   90 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 37 deletions(-)

applies-to: 33a1ca1ccca482b3c467ad4ad10af877b59011f3
0cab115306192e78516588e05045220f96106903
diff --git a/git-svnimport.perl b/git-svnimport.perl
index ea5bbdb..9cee629 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -348,21 +348,42 @@ sub split_path($$) {
 	return ($branch,$path);
 }
 
-sub copy_subdir($$$$$$) {
+sub branch_rev($$) {
+
+	my ($srcbranch,$uptorev) = @_;
+
+	my $bbranches = $branches{$srcbranch};
+	my @revs = reverse sort { ($a eq 'LAST' ? 0 : $a) <=> ($b eq 'LAST' ? 0 : $b) } keys %$bbranches;
+	my $therev;
+	foreach my $arev(@revs) {
+		next if  ($arev eq 'LAST');
+		if ($arev <= $uptorev) {
+			$therev = $arev;
+			last;
+		}
+	}
+	return $therev;
+}
+
+sub copy_path($$$$$$$) {
 	# Somebody copied a whole subdirectory.
 	# We need to find the index entries from the old version which the
 	# SVN log entry points to, and add them to the new place.
 
-	my($newrev,$newbranch,$path,$oldpath,$rev,$new) = @_;
-	my($branch,$srcpath) = split_path($rev,$oldpath);
+	my($newrev,$newbranch,$path,$oldpath,$rev,$node_kind,$new) = @_;
 
-	my $gitrev = $branches{$branch}{$rev};
+	my($srcbranch,$srcpath) = split_path($rev,$oldpath);
+	my $therev = branch_rev($srcbranch, $rev);
+	my $gitrev = $branches{$srcbranch}{$therev};
 	unless($gitrev) {
 		print STDERR "$newrev:$newbranch: could not find $oldpath \@ $rev\n";
 		return;
 	}
-	print "$newrev:$newbranch:$path: copying from $branch:$srcpath @ $rev\n" if $opt_v;
-	$srcpath =~ s#/*$#/#;
+	print "$newrev:$newbranch:$path: copying from $srcbranch:$srcpath @ $rev\n" if $opt_v;
+	if ($node_kind eq $SVN::Node::dir) {
+			$srcpath =~ s#/*$#/#;
+	}
+	
 	open my $f,"-|","git-ls-tree","-r","-z",$gitrev,$srcpath;
 	local $/ = "\0";
 	while(<$f>) {
@@ -370,9 +391,12 @@ sub copy_subdir($$$$$$) {
 		my($m,$p) = split(/\t/,$_,2);
 		my($mode,$type,$sha1) = split(/ /,$m);
 		next if $type ne "blob";
-		$p = substr($p,length($srcpath)-1);
-		print "... found $path$p ...\n" if $opt_v;
-		push(@$new,[$mode,$sha1,$path.$p]);
+		if ($node_kind eq $SVN::Node::dir) {
+			$p = $path . substr($p,length($srcpath)-1);
+		} else {
+			$p = $path;
+		}
+		push(@$new,[$mode,$sha1,$p]);	
 	}
 	close($f) or
 		print STDERR "$newrev:$newbranch: could not list files in $oldpath \@ $rev\n";
@@ -476,39 +500,31 @@ sub commit {
 		foreach my $path(@paths) {
 			my $action = $changed_paths->{$path};
 
-			if ($action->[0] eq "A") {
-				my $f = get_file($revision,$branch,$path);
-				if($f) {
-					push(@new,$f) if $f;
-				} elsif($action->[1]) {
-					copy_subdir($revision,$branch,$path,$action->[1],$action->[2],\@new);
-				} else {
-					my $opath = $action->[3];
-					print STDERR "$revision: $branch: could not fetch '$opath'\n";
+			if ($action->[0] eq "R") {
+				# refer to a file/tree in an earlier commit
+				push(@old,$path); # remove any old stuff
+			}
+			if(($action->[0] eq "A") || ($action->[0] eq "R")) {
+				my $node_kind = node_kind($branch,$path,$revision);
+				if($action->[1]) {
+					copy_path($revision,$branch,$path,$action->[1],$action->[2],$node_kind,\@new);
+				} elsif ($node_kind eq $SVN::Node::file) {
+					my $f = get_file($revision,$branch,$path);
+					if ($f) {
+						push(@new,$f) if $f;
+					} else {
+						my $opath = $action->[3];
+						print STDERR "$revision: $branch: could not fetch '$opath'\n";
+					}
 				}
 			} elsif ($action->[0] eq "D") {
 				push(@old,$path);
 			} elsif ($action->[0] eq "M") {
-				my $f = get_file($revision,$branch,$path);
-				push(@new,$f) if $f;
-			} elsif ($action->[0] eq "R") {
-				# refer to a file/tree in an earlier commit
-				push(@old,$path); # remove any old stuff
-
-				# ... and add any new stuff
-				my($b,$srcpath) = split_path($revision,$action->[1]);
-				$srcpath =~ s#/*$#/#;
-				open my $F,"-|","git-ls-tree","-r","-z", $branches{$b}{$action->[2]}, $srcpath;
-				local $/ = "\0";
-				while(<$F>) {
-					chomp;
-					my($m,$p) = split(/\t/,$_,2);
-					my($mode,$type,$sha1) = split(/ /,$m);
-					next if $type ne "blob";
-					$p = substr($p,length($srcpath)-1);
-					push(@new,[$mode,$sha1,$path.$p]);
+				my $node_kind = node_kind($branch,$path,$revision);
+				if ($node_kind eq $SVN::Node::file) {
+					my $f = get_file($revision,$branch,$path);
+					push(@new,$f) if $f;
 				}
-				close($F);
 			} else {
 				die "$revision: unknown action '".$action->[0]."' for $path\n";
 			}
---
0.99.9.GIT
