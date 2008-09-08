From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Mon,  8 Sep 2008 12:53:01 -0400
Message-ID: <1220892781-24343-1-git-send-email-marcus@griep.us>
References: <1220889063-20387-1-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Abhijit Menon-Sen <ams@toroid.org>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 18:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kck0D-0002PU-1U
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYIHQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYIHQxF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:53:05 -0400
Received: from boohaunt.net ([209.40.206.144]:38745 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbYIHQxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:53:04 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 75FFF1878D08; Mon,  8 Sep 2008 12:53:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.400.gd2470
In-Reply-To: <1220889063-20387-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95273>

Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
interface introduced in 0.14, as pointed out by Tom G. Christensen.

This modifies Git.pm to use the more established tempfile() interface
and updates 'git svn' to match.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 This patch v2 cleans up a few code items, corrects a misspelling,
 and ensures that the temp file gets unlinked when we exit, now
 that we are requesting the filename.  Otherwise, the previous
 comments stand:
 
 Per the earlier patch versions by Abhijit Menon-Sen and Tom G. Christensen.
 Both of you may want to run a test and add your 'Tested-by' to the thread
 if everything works out before Eric Wong adds his 'Acked-by'.

 git-svn.perl |    4 ++--
 perl/Git.pm  |   42 ++++++++++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ee3f5ed..c92bd8e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3304,7 +3304,7 @@ sub close_file {
 					my $out = syswrite($tmp_fh, $str, $res);
 					defined($out) && $out == $res
 						or croak("write ",
-							$tmp_fh->filename,
+							Git::temp_fname($tmp_fh),
 							": $!\n");
 				}
 				defined $res or croak $!;
@@ -3315,7 +3315,7 @@ sub close_file {
 		}
 
 		$hash = $::_repository->hash_and_insert_object(
-				$fh->filename);
+				Git::temp_fname($fh));
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 
 		Git::temp_release($fb->{base}, 1);
diff --git a/perl/Git.pm b/perl/Git.pm
index 102e6a4..3f5514c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path hash_object git_cmd_try
                 remote_refs
-                temp_acquire temp_release temp_reset);
+                temp_acquire temp_release temp_reset temp_fname);
 
 
 =head1 DESCRIPTION
@@ -937,7 +937,7 @@ sub _close_cat_blob {
 
 { # %TEMP_* Lexical Context
 
-my (%TEMP_LOCKS, %TEMP_FILES);
+my (%TEMP_FILEMAP, %TEMP_FILES);
 
 =item temp_acquire ( NAME )
 
@@ -965,7 +965,7 @@ sub temp_acquire {
 
 	my $temp_fd = _temp_cache($name);
 
-	$TEMP_LOCKS{$temp_fd} = 1;
+	$TEMP_FILES{$temp_fd}{locked} = 1;
 	$temp_fd;
 }
 
@@ -991,16 +991,16 @@ the same string.
 sub temp_release {
 	my ($self, $temp_fd, $trunc) = _maybe_self(@_);
 
-	if (ref($temp_fd) ne 'File::Temp') {
+	if (exists $TEMP_FILEMAP{$temp_fd}) {
 		$temp_fd = $TEMP_FILES{$temp_fd};
 	}
-	unless ($TEMP_LOCKS{$temp_fd}) {
+	unless ($TEMP_FILES{$temp_fd}{locked}) {
 		carp "Attempt to release temp file '",
 			$temp_fd, "' that has not been locked";
 	}
 	temp_reset($temp_fd) if $trunc and $temp_fd->opened;
 
-	$TEMP_LOCKS{$temp_fd} = 0;
+	$TEMP_FILES{$temp_fd}{locked} = 0;
 	undef;
 }
 
@@ -1009,9 +1009,9 @@ sub _temp_cache {
 
 	_verify_require();
 
-	my $temp_fd = \$TEMP_FILES{$name};
+	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
-		if ($TEMP_LOCKS{$$temp_fd}) {
+		if ($TEMP_FILES{$$temp_fd}{locked}) {
 			throw Error::Simple("Temp file with moniker '",
 				$name, "' already in use");
 		}
@@ -1021,12 +1021,13 @@ sub _temp_cache {
 			carp "Temp file '", $name,
 				"' was closed. Opening replacement.";
 		}
-		$$temp_fd = File::Temp->new(
-			TEMPLATE => 'Git_XXXXXX',
-			DIR => File::Spec->tmpdir
+		my $fname;
+		($$temp_fd, $fname) = File::Temp->tempfile(
+			'Git_XXXXXX', UNLINK => 1
 			) or throw Error::Simple("couldn't open new temp file");
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;
+		$TEMP_FILES{$$temp_fd}{fname} = $fname;
 	}
 	$$temp_fd;
 }
@@ -1053,8 +1054,25 @@ sub temp_reset {
 		or throw Error::Simple("expected file position to be reset");
 }
 
+=item temp_fname ( NAME )
+
+=item temp_fname ( FILEHANDLE )
+
+Returns the filename associated with the given tempfile.
+
+=cut
+
+sub temp_fname {
+	my ($self, $temp_fd) = _maybe_self(@_);
+
+	if (exists $TEMP_FILEMAP{$temp_fd}) {
+		$temp_fd = $TEMP_FILEMAP{$temp_fd};
+	}
+	$TEMP_FILES{$temp_fd}{fname};
+}
+
 sub END {
-	unlink values %TEMP_FILES if %TEMP_FILES;
+	unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
 }
 
 } # %TEMP_* Lexical Context
-- 
1.6.0.1.400.gd2470
