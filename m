From: Adam Roben <aroben@apple.com>
Subject: [PATCH 11/11] git-svn: Speed up fetch
Date: Wed, 23 Apr 2008 15:17:53 -0400
Message-ID: <1208978273-98146-12-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
 <1208978273-98146-7-git-send-email-aroben@apple.com>
 <1208978273-98146-8-git-send-email-aroben@apple.com>
 <1208978273-98146-9-git-send-email-aroben@apple.com>
 <1208978273-98146-10-git-send-email-aroben@apple.com>
 <1208978273-98146-11-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUz-00058u-Rh
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbYDWTSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbYDWTSV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:21 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49428 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbYDWTSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:07 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 29FA2293B011;
	Wed, 23 Apr 2008 12:18:07 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 0AF192807F;
	Wed, 23 Apr 2008 12:18:07 -0700 (PDT)
X-AuditID: 1180711d-abb97bb000000ed7-46-480f8b6efb93
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 3ED7728050;
	Wed, 23 Apr 2008 12:18:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-11-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80247>

We were spending a lot of time forking/execing git-cat-file and
git-hash-object. We now maintain a global Git repository object in order to use
Git.pm's more efficient hash_and_insert_object and cat_blob methods.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 git-svn.perl |   42 ++++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b864b54..5ef9d23 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4,7 +4,7 @@
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
-		$sha1 $sha1_short $_revision
+		$sha1 $sha1_short $_revision $_repository
 		$_q $_authors %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
@@ -220,6 +220,7 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 		}
 		$ENV{GIT_DIR} = $git_dir;
 	}
+	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
@@ -301,6 +302,7 @@ sub do_git_init_db {
 			}
 		}
 		command_noisy(@init_db);
+		$_repository = Git->repository(Repository => ".git");
 	}
 	my $set;
 	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
@@ -317,6 +319,7 @@ sub init_subdir {
 	mkpath([$repo_path]) unless -d $repo_path;
 	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
 	$ENV{GIT_DIR} = '.git';
+	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
 sub cmd_clone {
@@ -3010,6 +3013,7 @@ use vars qw/@ISA/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Temp qw/tempfile/;
 use IO::File qw//;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
@@ -3165,14 +3169,9 @@ sub apply_textdelta {
 	my $base = IO::File->new_tmpfile;
 	$base->autoflush(1);
 	if ($fb->{blob}) {
-		defined (my $pid = fork) or croak $!;
-		if (!$pid) {
-			open STDOUT, '>&', $base or croak $!;
-			print STDOUT 'link ' if ($fb->{mode_a} == 120000);
-			exec qw/git-cat-file blob/, $fb->{blob} or croak $!;
-		}
-		waitpid $pid, 0;
-		croak $? if $?;
+		print $base 'link ' if ($fb->{mode_a} == 120000);
+		my $size = $::_repository->cat_blob($fb->{blob}, $base);
+		die "Failed to read object $fb->{blob}" unless $size;
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
@@ -3213,14 +3212,18 @@ sub close_file {
 				sysseek($fh, 0, 0) or croak $!;
 			}
 		}
-		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
-		if (!$pid) {
-			open STDIN, '<&', $fh or croak $!;
-			exec qw/git-hash-object -w --stdin/ or croak $!;
+
+		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
+		my $result;
+		while ($result = sysread($fh, my $string, 1024)) {
+			syswrite($tmp_fh, $string, $result);
 		}
-		chomp($hash = do { local $/; <$out> });
-		close $out or croak $!;
+		defined $result or croak $!;
+		close $tmp_fh or croak $!;
+
 		close $fh or croak $!;
+
+		$hash = $::_repository->hash_and_insert_object($tmp_filename);
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 		close $fb->{base} or croak $!;
 	} else {
@@ -3546,13 +3549,8 @@ sub chg_file {
 	} elsif ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
-	defined(my $pid = fork) or croak $!;
-	if (!$pid) {
-		open STDOUT, '>&', $fh or croak $!;
-		exec qw/git-cat-file blob/, $m->{sha1_b} or croak $!;
-	}
-	waitpid $pid, 0;
-	croak $? if $?;
+	my $size = $::_repository->cat_blob($m->{sha1_b}, $fh);
+	croak "Failed to read object $m->{sha1_b}" unless $size;
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
-- 
1.5.5.1.152.g9aeb7
