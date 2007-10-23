From: Adam Roben <aroben@apple.com>
Subject: [PATCH 9/9] git-svn: Make fetch ~1.7x faster
Date: Mon, 22 Oct 2007 22:46:37 -0700
Message-ID: <1193118397-4696-10-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
 <1193118397-4696-5-git-send-email-aroben@apple.com>
 <1193118397-4696-6-git-send-email-aroben@apple.com>
 <1193118397-4696-7-git-send-email-aroben@apple.com>
 <1193118397-4696-8-git-send-email-aroben@apple.com>
 <1193118397-4696-9-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCck-0007YT-4r
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXJWFr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbXJWFr1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:27 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:61936 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id D733415F2467;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id BA37128055;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a8e60bb000000c52-64-471d8adf5196
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 9031C2804C;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-9-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62104>

We were spending a lot of time forking/execing git-cat-file and
git-hash-object. We now use command_bidi_pipe to keep one instance of each
running and feed it input on stdin.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 git-svn.perl |   94 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 22bb47b..8b72046 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -236,6 +236,8 @@ eval {
 };
 fatal $@ if $@;
 post_fetch_checkout();
+Git::Commands->close_cat_blob();
+Git::Commands->close_hash_object();
 exit 0;
 
 ####################### primary functions ######################
@@ -2683,14 +2685,8 @@ sub apply_textdelta {
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
+		my $contents = Git::Commands->cat_blob($fb->{blob});
+		print $base $contents;
 
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
@@ -2729,13 +2725,7 @@ sub close_file {
 			$buf eq 'link ' or die "$path has mode 120000",
 			                       "but is not a link\n";
 		}
-		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
-		if (!$pid) {
-			open STDIN, '<&', $fh or croak $!;
-			exec qw/git-hash-object -w --stdin/ or croak $!;
-		}
-		chomp($hash = do { local $/; <$out> });
-		close $out or croak $!;
+		$hash = Git::Commands->hash_object($fh);
 		close $fh or croak $!;
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 		close $fb->{base} or croak $!;
@@ -3063,13 +3053,8 @@ sub chg_file {
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
+	my $blob = Git::Commands->cat_blob($m->{sha1_b});
+	print $fh $blob;
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
@@ -4272,6 +4257,71 @@ sub full_path {
 	       $path . (length $self->{right} ? "/$self->{right}" : '');
 }
 
+package Git::Commands;
+use vars qw/$_cat_blob_pid $_cat_blob_in $_cat_blob_out $_cat_blob_ctx $_cat_blob_separator
+	    $_hash_object_pid $_hash_object_in $_hash_object_out $_hash_object_ctx/;
+use strict;
+use warnings;
+use File::Temp qw/tempfile/;
+use Git qw/command_bidi_pipe command_close_bidi_pipe/;
+
+sub _open_cat_blob_if_needed {
+	return if defined($_cat_blob_pid);
+	$_cat_blob_separator = "--------------GITCATFILESEPARATOR-----------";
+
+	($_cat_blob_pid, $_cat_blob_in, $_cat_blob_out, $_cat_blob_ctx) = command_bidi_pipe(qw(git-cat-file blob --stdin --separator), $_cat_blob_separator);
+}
+
+sub close_cat_blob {
+	return unless defined($_cat_blob_pid);
+
+	command_close_bidi_pipe($_cat_blob_pid, $_cat_blob_in, $_cat_blob_out, $_cat_blob_ctx);
+}
+
+sub cat_blob {
+	my (undef, $sha1) = @_;
+
+	_open_cat_blob_if_needed();
+	print $_cat_blob_out "$sha1\n";
+	my @file = ();
+	while (my $line = <$_cat_blob_in>) {
+		my $last = 0;
+		if ($line =~ s/\Q$_cat_blob_separator\E$//) {
+			chomp($line);
+			$last = 1;
+		}
+		push(@file, $line);
+		last if $last;
+	}
+	return join('', @file);
+}
+
+sub _open_hash_object_if_needed {
+	return if defined($_hash_object_pid);
+
+	($_hash_object_pid, $_hash_object_in, $_hash_object_out, $_hash_object_ctx) = command_bidi_pipe(qw(git-hash-object -w --stdin-paths));
+}
+
+sub close_hash_object {
+	return unless defined($_hash_object_pid);
+
+	command_close_bidi_pipe($_hash_object_pid, $_hash_object_in, $_hash_object_out, $_hash_object_ctx);
+}
+
+sub hash_object {
+	my (undef, $fh) = @_;
+
+	my ($tmp_fh, $tmp_filename) = tempfile(UNLINK => 1);
+	while (my $line = <$fh>) {
+		print $tmp_fh $line;
+	}
+	close($tmp_fh);
+	_open_hash_object_if_needed();
+	print $_hash_object_out $tmp_filename . "\n";
+	chomp(my $hash = <$_hash_object_in>);
+	return $hash;
+}
+
 __END__
 
 Data structures:
-- 
1.5.3.4.1333.ga2f32
