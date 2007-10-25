From: Adam Roben <aroben@apple.com>
Subject: [PATCH 9/9] git-svn: Make fetch ~1.7x faster
Date: Thu, 25 Oct 2007 03:25:27 -0700
Message-ID: <1193307927-3592-10-git-send-email-aroben@apple.com>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
 <1193307927-3592-2-git-send-email-aroben@apple.com>
 <1193307927-3592-3-git-send-email-aroben@apple.com>
 <1193307927-3592-4-git-send-email-aroben@apple.com>
 <1193307927-3592-5-git-send-email-aroben@apple.com>
 <1193307927-3592-6-git-send-email-aroben@apple.com>
 <1193307927-3592-7-git-send-email-aroben@apple.com>
 <1193307927-3592-8-git-send-email-aroben@apple.com>
 <1193307927-3592-9-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzvl-0007WS-J4
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761AbXJYK01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756074AbXJYK00
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:26 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:64385 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158AbXJYK0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:07 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 4A47816D1BE2;
	Thu, 25 Oct 2007 03:26:06 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 2BFCC2808E;
	Thu, 25 Oct 2007 03:26:06 -0700 (PDT)
X-AuditID: 11807134-a6e5cbb000000c52-49-47206f3eeac7
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 071F6280A8;
	Thu, 25 Oct 2007 03:26:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
In-Reply-To: <1193307927-3592-9-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62302>

We were spending a lot of time forking/execing git-cat-file and
git-hash-object. We now maintain a global Git repository object in order to use
Git.pm's more efficient hash_and_insert_object and cat_blob methods.

Signed-off-by: Adam Roben <aroben@apple.com>
---
Eric Wong wrote:
> > +sub hash_object {
> > +   my (undef, $fh) = @_;
> > +
> > +   my ($tmp_fh, $tmp_filename) = tempfile(UNLINK => 1);
> > +   while (my $line = <$fh>) {
> > +           print $tmp_fh $line;
> > +   }
> > +   close($tmp_fh);
> 
> Related to the above.  It's better to sysread()/syswrite() or
> read()/print() in a loop with a predefined buffer size rather than to
> use a readline() since you could be dealing with files with very long
> lines or binaries with no newline characters in them at all.

Fixed.

> > +   _open_hash_object_if_needed();
> > +   print $_hash_object_out $tmp_filename . "\n";
> 
> Minor, but
> 
>         print $_hash_object_out $tmp_filename, "\n";
> 
> avoids creating a new string.

Fixed.

 git-svn.perl |   40 ++++++++++++++++++----------------------
 1 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 22bb47b..fcb07f5 100755
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
@@ -225,6 +225,7 @@ unless ($cmd =~ /(?:clone|init|multi-init)$/) {
 		}
 		$ENV{GIT_DIR} = $git_dir;
 	}
+	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();
@@ -332,6 +333,7 @@ sub cmd_init {
 	                       "as a command-line argument\n";
 	init_subdir(@_);
 	do_git_init_db();
+	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 
 	Git::SVN->init($url);
 }
@@ -2541,6 +2543,7 @@ use vars qw/@ISA/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Temp qw/tempfile/;
 use IO::File qw//;
 use Digest::MD5;
 
@@ -2683,14 +2686,8 @@ sub apply_textdelta {
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
+		my $contents = $::_repository->cat_blob($fb->{blob});
+		print $base $contents;
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
@@ -2729,14 +2726,18 @@ sub close_file {
 			$buf eq 'link ' or die "$path has mode 120000",
 			                       "but is not a link\n";
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
@@ -3063,13 +3064,8 @@ sub chg_file {
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
+	my $blob = $::_repository->cat_blob($m->{sha1_b});
+	print $fh $blob;
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
-- 
1.5.3.4.1337.g8e67d-dirty
