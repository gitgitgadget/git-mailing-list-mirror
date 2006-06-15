From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: Eliminate temp file usage in libsvn_get_file()
Date: Thu, 15 Jun 2006 13:55:31 -0700
Message-ID: <11504049343825-git-send-email-normalperson@yhbt.net>
References: <11504049313192-git-send-email-normalperson@yhbt.net> <11504049322660-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 15 22:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqysM-0007IT-BS
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031348AbWFOUzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031349AbWFOUzg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:55:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8924 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1031348AbWFOUzf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 16:55:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 358C97DC022;
	Thu, 15 Jun 2006 13:55:34 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Jun 2006 13:55:34 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504049322660-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21910>

This means we'll have a loose object when we encounter a symlink
but that's not the common case.

We also don't have to worry about svn:eol-style when using the
SVN libraries, either.  So remove the code to deal with that.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   56 +++++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 27f1d68..149149f 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -31,6 +31,7 @@ use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
 use File::Spec qw//;
 use POSIX qw/strftime/;
+use IPC::Open3;
 use Memoize;
 memoize('revisions_eq');
 
@@ -2335,47 +2336,36 @@ sub libsvn_get_file {
 	my $p = $f;
 	return unless ($p =~ s#^\Q$SVN_PATH\E/?##);
 
-	my $fd = IO::File->new_tmpfile or croak $!;
+	my ($hash, $pid, $in, $out);
 	my $pool = SVN::Pool->new;
-	my ($r, $props) = $SVN->get_file($f, $rev, $fd, $pool);
+	defined($pid = open3($in, $out, '>&STDERR',
+				qw/git-hash-object -w --stdin/)) or croak $!;
+	my ($r, $props) = $SVN->get_file($f, $rev, $in, $pool);
+	$in->flush == 0 or croak $!;
+	close $in or croak $!;
 	$pool->clear;
-	$fd->flush == 0 or croak $!;
-	seek $fd, 0, 0 or croak $!;
-	if (my $es = $props->{'svn:eol-style'}) {
-		my $new_fd = IO::File->new_tmpfile or croak $!;
-		eol_cp_fd($fd, $new_fd, $es);
-		close $fd or croak $!;
-		$fd = $new_fd;
-		seek $fd, 0, 0 or croak $!;
-		$fd->flush == 0 or croak $!;
-	}
-	my $mode = '100644';
-	if (exists $props->{'svn:executable'}) {
-		$mode = '100755';
-	}
+	chomp($hash = do { local $/; <$out> });
+	close $out or croak $!;
+	waitpid $pid, 0;
+	$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
+
+	my $mode = exists $props->{'svn:executable'} ? '100755' : '100644';
 	if (exists $props->{'svn:special'}) {
 		$mode = '120000';
-		local $/;
-		my $link = <$fd>;
+		my $link = `git-cat-file blob $hash`;
 		$link =~ s/^link // or die "svn:special file with contents: <",
 						$link, "> is not understood\n";
-		seek $fd, 0, 0 or croak $!;
-		truncate $fd, 0 or croak $!;
-		print $fd $link or croak $!;
-		seek $fd, 0, 0 or croak $!;
-		$fd->flush == 0 or croak $!;
-	}
-	my $pid = open my $ho, '-|';
-	defined $pid or croak $!;
-	if (!$pid) {
-		open STDIN, '<&', $fd or croak $!;
-		exec qw/git-hash-object -w --stdin/ or croak $!;
+		defined($pid = open3($in, $out, '>&STDERR',
+				qw/git-hash-object -w --stdin/)) or croak $!;
+		print $in $link;
+		$in->flush == 0 or croak $!;
+		close $in or croak $!;
+		chomp($hash = do { local $/; <$out> });
+		close $out or croak $!;
+		waitpid $pid, 0;
+		$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
 	}
-	chomp(my $hash = do { local $/; <$ho> });
-	close $ho or croak $?;
-	$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
 	print $gui $mode,' ',$hash,"\t",$p,"\0" or croak $!;
-	close $fd or croak $?;
 }
 
 sub libsvn_log_entry {
-- 
1.4.0
