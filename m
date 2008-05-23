From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 6/8] git-svn: Speed up fetch
Date: Fri, 23 May 2008 16:19:41 +0200
Message-ID: <1211552384-29636-7-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY57-00066y-UA
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYEWOQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbYEWOQZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:25 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51696 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751586AbYEWOQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:16 -0400
Received: (qmail 332 invoked by uid 89); 23 May 2008 14:14:57 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:56 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82701>

From: Adam Roben <aroben@apple.com>

We were spending a lot of time forking/execing git-cat-file and
git-hash-object. We now maintain a global Git repository object in order to use
Git.pm's more efficient hash_and_insert_object and cat_blob methods.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 git-svn.perl |   42 ++++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b70f8ef..33e9266 100755
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
@@ -3017,6 +3020,7 @@ use vars qw/@ISA/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Temp qw/tempfile/;
 use IO::File qw//;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
@@ -3172,14 +3176,9 @@ sub apply_textdelta {
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
@@ -3220,14 +3219,18 @@ sub close_file {
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
@@ -3553,13 +3556,8 @@ sub chg_file {
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
1.5.5.1
