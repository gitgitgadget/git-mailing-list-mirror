From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Mon,  8 Sep 2008 11:51:03 -0400
Message-ID: <1220889063-20387-1-git-send-email-marcus@griep.us>
References: <20080908080548.GA3206@toroid.org>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Abhijit Menon-Sen <ams@toroid.org>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcj2b-0006q1-Cw
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbYIHPvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 11:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYIHPvH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:51:07 -0400
Received: from boohaunt.net ([209.40.206.144]:46528 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbYIHPvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 11:51:06 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id A659A1878D08; Mon,  8 Sep 2008 11:51:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.400.gd2470
In-Reply-To: <20080908080548.GA3206@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95265>

Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
interface introduced in 0.14, as pointed out by Tom G. Christensen.

This modifies Git.pm to use the more established tempfile() interface
and updates 'git svn' to match.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 Per the earlier patch versions by Abhijit Menon-Sen and Tom G. Christensen.
 Both of you may want to run a test and add your 'Tested-by' to the thread
 if everything works out before Eric Wong adds his 'Acked-by'.

 git-svn.perl |    4 ++--
 perl/Git.pm  |   29 +++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ee3f5ed..a6d75db 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3304,7 +3304,7 @@ sub close_file {
 					my $out = syswrite($tmp_fh, $str, $res);
 					defined($out) && $out == $res
 						or croak("write ",
-							$tmp_fh->filename,
+							Git::temp_filename($tmp_fh),
 							": $!\n");
 				}
 				defined $res or croak $!;
@@ -3315,7 +3315,7 @@ sub close_file {
 		}
 
 		$hash = $::_repository->hash_and_insert_object(
-				$fh->filename);
+				Git::temp_filename($fh));
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 
 		Git::temp_release($fb->{base}, 1);
diff --git a/perl/Git.pm b/perl/Git.pm
index 102e6a4..3ea3fb2 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -937,7 +937,7 @@ sub _close_cat_blob {
 
 { # %TEMP_* Lexical Context
 
-my (%TEMP_LOCKS, %TEMP_FILES);
+my (%TEMP_LOCKS, %TEMP_FILES, %TEMP_FILENAMES);
 
 =item temp_acquire ( NAME )
 
@@ -991,7 +991,7 @@ the same string.
 sub temp_release {
 	my ($self, $temp_fd, $trunc) = _maybe_self(@_);
 
-	if (ref($temp_fd) ne 'File::Temp') {
+	if (exists $TEMP_FILES{$temp_fd}) {
 		$temp_fd = $TEMP_FILES{$temp_fd};
 	}
 	unless ($TEMP_LOCKS{$temp_fd}) {
@@ -1021,12 +1021,12 @@ sub _temp_cache {
 			carp "Temp file '", $name,
 				"' was closed. Opening replacement.";
 		}
-		$$temp_fd = File::Temp->new(
-			TEMPLATE => 'Git_XXXXXX',
-			DIR => File::Spec->tmpdir
-			) or throw Error::Simple("couldn't open new temp file");
+		my $fname;
+		($$temp_fd, $fname) = File::Temp->tempfile('Git_XXXXXX')
+			or throw Error::Simple("couldn't open new temp file");
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;
+		$TEMP_FILENAMES{$$temp_fd} = $fname;
 	}
 	$$temp_fd;
 }
@@ -1053,6 +1053,23 @@ sub temp_reset {
 		or throw Error::Simple("expected file position to be reset");
 }
 
+=item temp_filename ( NAME )
+
+=item temp_filename ( FILEHANDLE )
+
+Returns the filenae associated with the given tempfile.
+
+=cut
+
+sub temp_filename {
+	my ($self, $temp_fd) = _maybe_self(@_);
+
+	if (exists $TEMP_FILES{$temp_fd}) {
+		$temp_fd = $TEMP_FILES{$temp_fd};
+	}
+	$TEMP_FILENAMES{$temp_fd};
+}
+
 sub END {
 	unlink values %TEMP_FILES if %TEMP_FILES;
 }
-- 
1.6.0.1.400.gd2470
