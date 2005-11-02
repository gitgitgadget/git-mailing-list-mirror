From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 5/7] When copying files and/or directories from several branches in one single
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-00050K-VB@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:54:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQXB-0005F2-LU
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbVKBVwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKBVw3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:29 -0500
Received: from [195.140.142.33] ([195.140.142.33]:49105 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965289AbVKBVw1
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:27 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003cf-Sr; Wed, 02 Nov 2005 22:52:14 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-00050K-VB; Wed, 02 Nov 2005 23:51:57 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  revision, all these branches are used as parents of the
	commit. Signed-off-by: Yaacov Akiba Slama <ya@slamail.org> --- [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11049>

revision, all these branches are used as parents of the commit.

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

applies-to: 71ff99dad666ebbb05cb14744df010bf223678c6
7554fc8ad3df5f08a269b4ef0a05acdbc33f2302
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 9cee629..ae82a7c 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -365,12 +365,12 @@ sub branch_rev($$) {
 	return $therev;
 }
 
-sub copy_path($$$$$$$) {
+sub copy_path($$$$$$$$) {
 	# Somebody copied a whole subdirectory.
 	# We need to find the index entries from the old version which the
 	# SVN log entry points to, and add them to the new place.
 
-	my($newrev,$newbranch,$path,$oldpath,$rev,$node_kind,$new) = @_;
+	my($newrev,$newbranch,$path,$oldpath,$rev,$node_kind,$new,$parents) = @_;
 
 	my($srcbranch,$srcpath) = split_path($rev,$oldpath);
 	my $therev = branch_rev($srcbranch, $rev);
@@ -379,6 +379,9 @@ sub copy_path($$$$$$$) {
 		print STDERR "$newrev:$newbranch: could not find $oldpath \@ $rev\n";
 		return;
 	}
+	if ($srcbranch ne $newbranch) {
+		push(@$parents, $branches{$srcbranch}{'LAST'});
+	}
 	print "$newrev:$newbranch:$path: copying from $srcbranch:$srcpath @ $rev\n" if $opt_v;
 	if ($node_kind eq $SVN::Node::dir) {
 			$srcpath =~ s#/*$#/#;
@@ -405,7 +408,7 @@ sub copy_path($$$$$$$) {
 sub commit {
 	my($branch, $changed_paths, $revision, $author, $date, $message) = @_;
 	my($author_name,$author_email,$dest);
-	my(@old,@new);
+	my(@old,@new,@parents);
 
 	if (not defined $author) {
 		$author_name = $author_email = "unknown";
@@ -492,6 +495,8 @@ sub commit {
 		$last_rev = $rev;
 	}
 
+	push (@parents, $rev) if defined $rev;
+
 	my $cid;
 	if($tag and not %$changed_paths) {
 		$cid = $rev;
@@ -507,7 +512,7 @@ sub commit {
 			if(($action->[0] eq "A") || ($action->[0] eq "R")) {
 				my $node_kind = node_kind($branch,$path,$revision);
 				if($action->[1]) {
-					copy_path($revision,$branch,$path,$action->[1],$action->[2],$node_kind,\@new);
+					copy_path($revision,$branch,$path,$action->[1],$action->[2],$node_kind,\@new,\@parents);
 				} elsif ($node_kind eq $SVN::Node::file) {
 					my $f = get_file($revision,$branch,$path);
 					if ($f) {
@@ -592,7 +597,6 @@ sub commit {
 			$pw->close();
 
 			my @par = ();
-			@par = ("-p",$rev) if defined $rev;
 
 			# loose detection of merges
 			# based on the commit msg
@@ -602,11 +606,17 @@ sub commit {
 					if ($mparent eq 'HEAD') { $mparent = $opt_o };
 					if ( -e "$git_dir/refs/heads/$mparent") {
 						$mparent = get_headref($mparent, $git_dir);
-						push @par, '-p', $mparent;
+						push (@parents, $mparent);
 						print OUT "Merge parent branch: $mparent\n" if $opt_v;
 					}
 				}
 			}
+			my %seen_parents = ();
+			my @unique_parents = grep { ! $seen_parents{$_} ++ } @parents;
+			foreach my $bparent (@unique_parents) {
+				push @par, '-p', $bparent;
+				print OUT "Merge parent branch: $bparent\n" if $opt_v;
+			}
 
 			exec("env",
 				"GIT_AUTHOR_NAME=$author_name",
---
0.99.9.GIT
