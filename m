From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 2/3] git-svn: Make it scream by minimizing temp files
Date: Mon, 11 Aug 2008 11:53:54 -0400
Message-ID: <1218470035-13864-3-git-send-email-marcus@griep.us>
References: <489DBB8A.2060207@griep.us>
 <1218470035-13864-1-git-send-email-marcus@griep.us>
 <1218470035-13864-2-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZk9-00080k-Dx
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYHKPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbYHKPyE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:54:04 -0400
Received: from boohaunt.net ([209.40.206.144]:33689 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657AbYHKPx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:53:56 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id E35AE1878CE7; Mon, 11 Aug 2008 11:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218470035-13864-2-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91953>

Currently, git-svn would create a temp file on four occasions:
1. Reading a blob out of the object db
2. Creating a delta from svn
3. Hashing and writing a blob into the object db
4. Reading a blob out of the object db (in another place in code)

Any time git-svn did the above, it would dutifully create and then
delete said temp file.  Unfortunately, this means that between 2-4
temporary files are created/deleted per file 'add/modify'-ed in
svn (O(n)).  This causes significant overhead and helps the inode
counter to spin beautifully.

By its nature, git-svn is a serial beast.  Thus, reusing a temp file
does not pose significant problems.  "truncate and seek" takes much
less time than "unlink and create".  This patch centralizes the
tempfile creation and holds onto the tempfile until they are deleted
on exit.  This significantly reduces file overhead, now requiring
at most three (3) temp files per run (O(1)).

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl |   53 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index fe78461..0937918 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1260,7 +1260,7 @@ sub md5sum {
 	my $arg = shift;
 	my $ref = ref $arg;
 	my $md5 = Digest::MD5->new();
-        if ($ref eq 'GLOB' || $ref eq 'IO::File') {
+        if ($ref eq 'GLOB' || $ref eq 'IO::File' || $ref eq 'File::Temp') {
 		$md5->addfile($arg) or croak $!;
 	} elsif ($ref eq 'SCALAR') {
 		$md5->add($$arg) or croak $!;
@@ -1285,6 +1285,8 @@ use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
+use File::Temp ();
+use File::Spec;
 
 my ($_gc_nr, $_gc_period);
 
@@ -1323,10 +1325,11 @@ BEGIN {
 	}
 }
 
-my (%LOCKFILES, %INDEX_FILES);
+my (%LOCKFILES, %INDEX_FILES, %TEMP_FILES);
 END {
 	unlink keys %LOCKFILES if %LOCKFILES;
 	unlink keys %INDEX_FILES if %INDEX_FILES;
+	unlink values %TEMP_FILES if %TEMP_FILES;
 }
 
 sub resolve_local_globs {
@@ -2935,6 +2938,21 @@ sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
 
+sub _temp_file {
+	my ($self, $fd) = @_;
+	if (defined $TEMP_FILES{$fd}) {
+		truncate $TEMP_FILES{$fd}, 0 or croak $!;
+		sysseek $TEMP_FILES{$fd}, 0, 0 or croak $!;
+	} else {
+		$TEMP_FILES{$fd} = File::Temp->new(
+			TEMPLATE => 'GitSvn_XXXXXX',
+			DIR => File::Spec->tmpdir
+			) or croak $!;
+		$TEMP_FILES{$fd}->autoflush(1);
+	}
+	$TEMP_FILES{$fd};
+}
+
 package Git::SVN::Prompt;
 use strict;
 use warnings;
@@ -3225,13 +3243,11 @@ sub change_file_prop {
 
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	my $fh = IO::File->new_tmpfile;
-	$fh->autoflush(1);
+	my $fh = Git::temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
-	my $base = IO::File->new_tmpfile;
-	$base->autoflush(1);
+	my $base = Git::temp_acquire('git_blob');
 	if ($fb->{blob}) {
 		print $base 'link ' if ($fb->{mode_a} == 120000);
 		my $size = $::_repository->cat_blob($fb->{blob}, $base);
@@ -3246,9 +3262,10 @@ sub apply_textdelta {
 		}
 	}
 	seek $base, 0, 0 or croak $!;
-	$fb->{fh} = $dup;
+	$fb->{fh} = $fh;
 	$fb->{base} = $base;
-	[ SVN::TxDelta::apply($base, $fh, undef, $fb->{path}, $fb->{pool}) ];
+	my $return = [ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
+	$return;
 }
 
 sub close_file {
@@ -3277,22 +3294,23 @@ sub close_file {
 			}
 		}
 
-		my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
+		my $tmp_fh = Git::temp_acquire('svn_hash');
 		my $result;
 		while ($result = sysread($fh, my $string, 1024)) {
 			my $wrote = syswrite($tmp_fh, $string, $result);
 			defined($wrote) && $wrote == $result
-				or croak("write $tmp_filename: $!\n");
+				or croak("write $tmp_fh->filename: $!\n");
 		}
 		defined $result or croak $!;
-		close $tmp_fh or croak $!;
 
-		close $fh or croak $!;
 
-		$hash = $::_repository->hash_and_insert_object($tmp_filename);
-		unlink($tmp_filename);
+		Git::temp_release($fh, 1);
+
+		$hash = $::_repository->hash_and_insert_object($tmp_fh->filename);
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
-		close $fb->{base} or croak $!;
+
+		Git::temp_release($fb->{base}, 1);
+		Git::temp_release($tmp_fh, 1);
 	} else {
 		$hash = $fb->{blob} or die "no blob information\n";
 	}
@@ -3662,7 +3680,7 @@ sub chg_file {
 	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
 		$self->change_file_prop($fbat,'svn:executable',undef);
 	}
-	my $fh = IO::File->new_tmpfile or croak $!;
+	my $fh = Git::temp_acquire('git_blob');
 	if ($m->{mode_b} =~ /^120/) {
 		print $fh 'link ' or croak $!;
 		$self->change_file_prop($fbat,'svn:special','*');
@@ -3681,9 +3699,8 @@ sub chg_file {
 	my $atd = $self->apply_textdelta($fbat, undef, $pool);
 	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
 	die "Checksum mismatch\nexpected: $exp\ngot: $got\n" if ($got ne $exp);
+	Git::temp_release($fh, 1);
 	$pool->clear;
-
-	close $fh or croak $!;
 }
 
 sub D {
-- 
1.6.0.rc2.6.g8eda3
