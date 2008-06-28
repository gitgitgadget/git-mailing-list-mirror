From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] Revert "git-svn: Speed up fetch"
Date: Sat, 28 Jun 2008 16:57:53 -0400
Message-ID: <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
References: <20080628194808.GA29908@atjola.homenet>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: Eric Wong <normalperson@yhbt.net>, Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 22:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KChVw-0003xi-UA
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 22:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYF1U55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 16:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYF1U55
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 16:57:57 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:40800
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751503AbYF1U54 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2008 16:57:56 -0400
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 28 Jun 2008 16:57:54 -0400
Received: (qmail 27377 invoked from network); 28 Jun 2008 20:57:53 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 28 Jun 2008 20:57:53 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 39A8B15DB3; Sat, 28 Jun 2008 16:57:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <20080628194808.GA29908@atjola.homenet>
X-OriginalArrivalTime: 28 Jun 2008 20:57:54.0279 (UTC) FILETIME=[A2950770:01C8D961]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86743>

This reverts commit ffe256f9bac8a40ff751a9341a5869d98f72c285, because it
was causing errors of the form:

Checksum mismatch: trunk/.depend 16e748c219f9f95bf3d05c6b2af5444290bc8471
expected: 05fb5edb8c8057be006c7e913ae0c764
     got: 763b9a426c5bd61e0a85252459d37cfa
     
Note that the exact failing file and checksum seems to vary if you clear
the repository and try again.

Conflicts:

	git-svn.perl
---
Obviously it would be better to actually fix the bug here than the revert
the patch (because the patch really *does* make fetch go a lot faster), but
I don't know where to begin, and it's a pain to debug because of the
variability.

 git-svn.perl |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4c9c59b..a02bcf4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4,7 +4,7 @@
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
-		$sha1 $sha1_short $_revision $_repository
+		$sha1 $sha1_short $_revision
 		$_q $_authors %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
@@ -223,7 +223,6 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 		}
 		$ENV{GIT_DIR} = $git_dir;
 	}
-	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
@@ -305,7 +304,6 @@ sub do_git_init_db {
 			}
 		}
 		command_noisy(@init_db);
-		$_repository = Git->repository(Repository => ".git");
 	}
 	my $set;
 	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
@@ -322,7 +320,6 @@ sub init_subdir {
 	mkpath([$repo_path]) unless -d $repo_path;
 	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
 	$ENV{GIT_DIR} = '.git';
-	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
 sub cmd_clone {
@@ -3040,7 +3037,6 @@ use vars qw/@ISA/;
 use strict;
 use warnings;
 use Carp qw/croak/;
-use File::Temp qw/tempfile/;
 use IO::File qw//;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
@@ -3196,9 +3192,14 @@ sub apply_textdelta {
 	my $base = IO::File->new_tmpfile;
 	$base->autoflush(1);
 	if ($fb->{blob}) {
-		print $base 'link ' if ($fb->{mode_a} == 120000);
-		my $size = $::_repository->cat_blob($fb->{blob}, $base);
-		die "Failed to read object $fb->{blob}" if ($size < 0);
+		defined (my $pid = fork) or croak $!;
+		if (!$pid) {
+			open STDOUT, '>&', $base or croak $!;
+			print STDOUT 'link ' if ($fb->{mode_a} == 120000);
+			exec qw/git-cat-file blob/, $fb->{blob} or croak $!;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
@@ -3239,18 +3240,14 @@ sub close_file {
 				sysseek($fh, 0, 0) or croak $!;
 			}
 		}
-
-		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
-		my $result;
-		while ($result = sysread($fh, my $string, 1024)) {
-			syswrite($tmp_fh, $string, $result);
+		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
+		if (!$pid) {
+			open STDIN, '<&', $fh or croak $!;
+			exec qw/git-hash-object -w --stdin/ or croak $!;
 		}
-		defined $result or croak $!;
-		close $tmp_fh or croak $!;
-
+		chomp($hash = do { local $/; <$out> });
+		close $out or croak $!;
 		close $fh or croak $!;
-
-		$hash = $::_repository->hash_and_insert_object($tmp_filename);
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 		close $fb->{base} or croak $!;
 	} else {
@@ -3576,8 +3573,13 @@ sub chg_file {
 	} elsif ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
-	my $size = $::_repository->cat_blob($m->{sha1_b}, $fh);
-	croak "Failed to read object $m->{sha1_b}" if ($size < 0);
+	defined(my $pid = fork) or croak $!;
+	if (!$pid) {
+		open STDOUT, '>&', $fh or croak $!;
+		exec qw/git-cat-file blob/, $m->{sha1_b} or croak $!;
+	}
+	waitpid $pid, 0;
+	croak $? if $?;
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
-- 
1.5.4.3
