From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 3/3] git-svn: Add config to control the path of mergeinfo
Date: Thu, 28 Nov 2013 10:52:17 -0500
Message-ID: <1385653937-29595-4-git-send-email-andrew.kw.w@gmail.com>
References: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 16:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm3t9-0004qy-2I
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 16:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab3K1PwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 10:52:19 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46222 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab3K1PwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 10:52:13 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so14114972iec.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 07:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uIizmpIq2dvTTRrF5uaAQqzZ5GCBqdYFqlNOq0RENfg=;
        b=G8gqAtXsV9Ekbw2Udc8pzJ3gXkYxoNJVIhOGO1zFRoRl8KTwwNDYbNGtN8PVKyZAIN
         LHDbCO0KGqHDECX6hzps8xK6uR8MOzyuZZkTkKfQ27B7ZPmD0C3xgT4QwescA6LDOxdy
         CWIj9Er1LxPjIFU3CawqPhAW0Y2JoJTtG8eV29L+QRyYydtXmtJpo2umJIFJoO6A2Ojm
         thsGxzzWKS6dFzZXr49LElAym7OtyShH1NY2UL2XxrmTzH6hIL5NwTd3JuPyAbFRkeja
         8sE1u1Wvvfc5feCBibqPVbUEcctfrhJZlRI/tUB2FB/wx+35pi7qPoqnnA8qo+RspSEi
         z7Kw==
X-Received: by 10.43.106.198 with SMTP id dv6mr9867115icc.51.1385653932452;
        Thu, 28 Nov 2013 07:52:12 -0800 (PST)
Received: from zanarkand.local (24-212-191-132.cable.teksavvy.com. [24.212.191.132])
        by mx.google.com with ESMTPSA id qi3sm45309190igc.8.2013.11.28.07.52.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 07:52:11 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238498>

Instead of always storing mergeinfo at the root, give an option to store the
merge info in a subdirectory. The subdirectory must exist before we try to set
its property.
---
 git-svn.perl                      | 21 +++++++++++++++------
 perl/Git/SVN/Editor.pm            |  5 ++++-
 t/t9161-git-svn-mergeinfo-push.sh | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b04cac7..bfae579 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -693,7 +693,7 @@ sub merge_merge_info {
 }
 
 sub populate_merge_info {
-	my ($d, $gs, $uuid, $linear_refs, $rewritten_parent) = @_;
+	my ($d, $gs, $uuid, $linear_refs, $rewritten_parent, $merge_info_path) = @_;
 
 	my %parentshash;
 	read_commit_parents(\%parentshash, $d);
@@ -729,7 +729,7 @@ sub populate_merge_info {
 
 			my $ra = Git::SVN::Ra->new($branchurl);
 			my (undef, undef, $props) =
-				$ra->get_dir(canonicalize_path("."), $svnrev);
+				$ra->get_dir(canonicalize_path($merge_info_path), $svnrev);
 			my $par_mergeinfo = $props->{'svn:mergeinfo'};
 			unless (defined $par_mergeinfo) {
 				$par_mergeinfo = '';
@@ -778,7 +778,8 @@ sub populate_merge_info {
 			# We now have a list of all SVN revnos which are
 			# merged by this particular parent. Integrate them.
 			next if $#revsin == -1;
-			my $newmergeinfo = "$branchpath:" . join(',', @revsin);
+			my $newmergeinfo = canonicalize_path("$branchpath/$merge_info_path")
+				. ":" . join(',', @revsin);
 			$aggregate_mergeinfo =
 				merge_merge_info($aggregate_mergeinfo,
 								$newmergeinfo,
@@ -808,7 +809,7 @@ sub populate_merge_info {
 
 			my $ra = Git::SVN::Ra->new($branchurl);
 			my (undef, undef, $props) =
-				$ra->get_dir(canonicalize_path("."), $svnrev);
+				$ra->get_dir(canonicalize_path($merge_info_path), $svnrev);
 			my $parent_mergeinfo = $props->{'svn:mergeinfo'};
 			unless (defined $parent_mergeinfo) {
 				$parent_mergeinfo = '';
@@ -824,7 +825,7 @@ sub populate_merge_info {
 			}
 			my $cherry_branchpath = $1;
 
-			my $cherry_pick_mergeinfo = canonicalize_path("$cherry_branchpath")
+			my $cherry_pick_mergeinfo = canonicalize_path("$cherry_branchpath/$merge_info_path")
 				. ":$cherry_svnrev";
 
 			$aggregate_mergeinfo = merge_merge_info($aggregate_mergeinfo,
@@ -1008,6 +1009,12 @@ sub cmd_dcommit {
 	if (defined($_merge_info)) {
 		$_merge_info =~ tr{ }{\n};
 	}
+	my $merge_info_path = eval {
+		command_oneline(qw/config --get svn.mergeinfopath/)
+		};
+	if (not defined($merge_info_path)) {
+		$merge_info_path = "";
+	}
 	while (1) {
 		my $d = shift @$linear_refs or last;
 		unless (defined $last_rev) {
@@ -1030,7 +1037,8 @@ sub cmd_dcommit {
 				$rev_merge_info = populate_merge_info($d, $gs,
 				                             $uuid,
 				                             $linear_refs,
-				                             $rewritten_parent);
+				                             $rewritten_parent,
+							     $merge_info_path);
 			}
 
 			my %ed_opts = ( r => $last_rev,
@@ -1046,6 +1054,7 @@ sub cmd_dcommit {
 			                       $cmt_rev = $_[0];
 			                },
 					mergeinfo => $rev_merge_info,
+					mergeinfopath => $merge_info_path,
 			                svn_path => '');
 
 			my $err_handler = $SVN::Error::handler;
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index b3bcd47..dcbb8a0 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -42,6 +42,7 @@ sub new {
 	                       "$self->{svn_path}/" : '';
 	$self->{config} = $opts->{config};
 	$self->{mergeinfo} = $opts->{mergeinfo};
+	$self->{mergeinfopath} = $opts->{mergeinfopath};
 	return $self;
 }
 
@@ -484,7 +485,9 @@ sub apply_diff {
 	}
 
 	if (defined($self->{mergeinfo})) {
-		$self->change_dir_prop($self->{bat}{''}, "svn:mergeinfo",
+		my $pbat = $self->ensure_path($self->{mergeinfopath}, \%deletions);
+		$self->change_dir_prop($pbat,
+				       "svn:mergeinfo",
 			               $self->{mergeinfo});
 	}
 	$self->rmdirs if $_rmdir;
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index f348392..8a87ad7 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -121,6 +121,43 @@ test_expect_success 'check cherry-pick mergeinfo' '
 /branches/svnb5:6,11"
 	'
 
+test_expect_success 'make further commits to branch' '
+	git checkout svnb1 &&
+	mkdir sub_directory &&
+	touch sub_directory/newb1file &&
+	git add sub_directory/newb1file &&
+	git commit -m "sub directory b1 commit" &&
+	git svn dcommit &&
+	git checkout svnb2 &&
+	mkdir sub_directory &&
+	touch sub_directory/newb2file &&
+	git add sub_directory/newb2file &&
+	git commit -m "sub directory b2 commit" &&
+	touch sub_directory/newb2file2 &&
+	git add sub_directory/newb2file2 &&
+	git commit -m "sub directory b2 commit 2" &&
+	git svn dcommit
+	'
+
+test_expect_success 'cherry-pick mergeinfo sub directory' '
+	git config svn.mergeinfopath sub_directory &&
+	git checkout svnb1 &&
+	git cherry-pick svnb2 &&
+	git cherry-pick svnb2^ &&
+	git svn dcommit &&
+	git config --unset svn.mergeinfopath
+	'
+
+test_expect_success 'check cherry-pick mergeinfo sub directory' '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	test "$mergeinfo" = "/branches/svnb2:3,8,16-17,20-22
+/branches/svnb3:4,9
+/branches/svnb4:5-6,10-12
+/branches/svnb5:6,11" &&
+	mergeinfo=$(cd sub_directory && svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1/sub_directory) &&
+	test "$mergeinfo" = "/branches/svnb2/sub_directory:27-28"
+	'
+
 test_expect_success 'dcommit a merge at the top of a stack' '
 	git checkout svnb1 &&
 	touch anotherfile &&
-- 
1.8.5.rc3.5.g96ccada
