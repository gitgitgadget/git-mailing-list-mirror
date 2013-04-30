From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Tue, 30 Apr 2013 21:37:18 +0400
Message-ID: <51800470.6905700a.65c8.00b8@mx.google.com>
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEhf-0004K2-70
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760864Ab3D3Rup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:50:45 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:55157 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760805Ab3D3Rum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:50:42 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so676583lab.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:from:date:subject:to:cc;
        bh=xp5z4bpz1221TP4pYZxYc+s2MUz64p+2NkSLOjjBLJ4=;
        b=mqPYARqI4hQG8hq2xjgnVM7hK51otvdedXsBJIYg7yz+gbrCdARiE1ylqqhVjJox1D
         PvTFAgJ4Ks/micV4nWH5qQE4MkmBTu5Z+FIQ63Rawi22Er0lJdXnJNIYIx9dhFoq4ZFX
         whFTd2c1W1RzXIPIh+oTnc9yQCmwqL1gEsd/lMRLY8RlMKGsHFSL9UOVOzBIoKoU8BHN
         pucNnkR8TdzKdheXXEYCJe7wRFp7e/SYA5pNm0pJsEXa19rQSFftS6L7JghZq/0h6imd
         9pKi7hPz9SQXT3VcdGgWDUW7iRj1D73IHtLjHnRwgcLppCOHzWmiLGUEsgBYKzmhdXVW
         Kzbw==
X-Received: by 10.112.160.226 with SMTP id xn2mr24411lbb.16.1367344241128;
        Tue, 30 Apr 2013 10:50:41 -0700 (PDT)
Received: from [192.168.0.78] ([178.71.111.32])
        by mx.google.com with ESMTPSA id r9sm18577lbr.3.2013.04.30.10.50.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 10:50:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222971>

.git/config is written on each commit. It's slow
---
 perl/Git/SVN/Fetcher.pm | 77 +++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index e658889..a5ad4cd 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -1,5 +1,6 @@
 package Git::SVN::Fetcher;
 use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
+            $_package_inited
             @deleted_gpath %added_placeholder $repo_id/;
 use strict;
 use warnings;
@@ -26,32 +27,9 @@ sub new {
 		                  _mark_empty_symlinks($git_svn, $switch_path);
 	}
 
-	# some options are read globally, but can be overridden locally
-	# per [svn-remote "..."] section.  Command-line options will *NOT*
-	# override options set in an [svn-remote "..."] section
-	$repo_id = $git_svn->{repo_id};
-	my $k = "svn-remote.$repo_id.ignore-paths";
-	my $v = eval { command_oneline('config', '--get', $k) };
-	$self->{ignore_regex} = $v;
-
-	$k = "svn-remote.$repo_id.preserve-empty-dirs";
-	$v = eval { command_oneline('config', '--get', '--bool', $k) };
-	if ($v && $v eq 'true') {
-		$_preserve_empty_dirs = 1;
-		$k = "svn-remote.$repo_id.placeholder-filename";
-		$v = eval { command_oneline('config', '--get', $k) };
-		$_placeholder_filename = $v;
-	}
-
-	# Load the list of placeholder files added during previous invocations.
-	$k = "svn-remote.$repo_id.added-placeholder";
-	$v = eval { command_oneline('config', '--get-all', $k) };
-	if ($_preserve_empty_dirs && $v) {
-		# command() prints errors to stderr, so we only call it if
-		# command_oneline() succeeded.
-		my @v = command('config', '--get-all', $k);
-		$added_placeholder{ dirname($_) } = $_ foreach @v;
-	}
+	_try_init_package($git_svn);
+	$self->{_save_ph} = { %added_placeholder };
+	$self->{ignore_regex} = $_ignore_regex;
 
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
@@ -64,6 +42,43 @@ sub new {
 	$self;
 }
 
+sub _try_init_package {
+	if (!$_package_inited) {
+		my ( $git_svn ) = @_;
+
+		$_package_inited = 1;
+		$repo_id = $git_svn->{repo_id};
+
+		# some options are read globally, but can be overridden locally
+		# per [svn-remote "..."] section.  Command-line options will *NOT*
+		# override options set in an [svn-remote "..."] section
+
+		my $k = "svn-remote.$repo_id.ignore-paths";
+		my $v = eval { command_oneline('config', '--get', $k) };
+		$_ignore_regex = $v;
+
+		$k = "svn-remote.$repo_id.preserve-empty-dirs";
+		$v = eval { command_oneline('config', '--get', '--bool', $k) };
+		if ($v && $v eq 'true') {
+			$_preserve_empty_dirs = 1;
+			$k = "svn-remote.$repo_id.placeholder-filename";
+			$v = eval { command_oneline('config', '--get', $k) };
+			$_placeholder_filename = $v;
+
+			# Load the list of placeholder files added during previous invocations.
+			$k = "svn-remote.$repo_id.added-placeholder";
+			$v = eval { command_oneline('config', '--get-all', $k) };
+			if ($v) {
+				# command() prints errors to stderr, so we only call it if
+				# command_oneline() succeeded.
+				my @v = command('config', '--get-all', $k);
+				$added_placeholder{ dirname($_) } = $_ foreach @v;
+			}
+		}
+	}
+	undef
+}
+
 # this uses the Ra object, so it must be called before do_{switch,update},
 # not inside them (when the Git::SVN::Fetcher object is passed) to
 # do_{switch,update}
@@ -123,8 +138,6 @@ sub is_path_ignored {
 	return 1 if in_dot_git($path);
 	return 1 if defined($self->{ignore_regex}) &&
 	            $path =~ m!$self->{ignore_regex}!;
-	return 0 unless defined($_ignore_regex);
-	return 1 if $path =~ m!$_ignore_regex!o;
 	return 0;
 }
 
@@ -506,6 +519,14 @@ sub add_placeholder_file {
 
 sub stash_placeholder_list {
 	my ($self) = @_;
+
+	for ( keys %added_placeholder ) {
+		goto theydiffer if (!delete $self->{_save_ph}{$_});
+	}
+	return undef if (!keys $self->{_save_ph});
+
+theydiffer:
+
 	my $k = "svn-remote.$repo_id.added-placeholder";
 	my $v = eval { command_oneline('config', '--get-all', $k) };
 	command_noisy('config', '--unset-all', $k) if $v;
-- 
1.8.1.5
