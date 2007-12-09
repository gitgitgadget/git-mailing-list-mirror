From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: reinstate old rev_db optimization in new rev_map
Date: Sat,  8 Dec 2007 23:27:42 -0800
Message-ID: <1197185262-16765-3-git-send-email-normalperson@yhbt.net>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 08:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1GaF-0002l7-7R
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 08:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbXLIH1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 02:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXLIH1u
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 02:27:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50854 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbXLIH1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 02:27:47 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5E2CF7DC10A;
	Sat,  8 Dec 2007 23:27:45 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 23:27:45 -0800
X-Mailer: git-send-email 1.5.3.7.1114.g6df1d
In-Reply-To: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67602>

This reinstates an old optimization in .rev_db which
stored the highest revision number we scanned, allowing
us to avoid scanning the SVN log for those revisions
again in a subsequent invocation.

This means the last 24-byte record in a .rev_map file
can be a 4-byte SVN revision number with 20-bytes of
zeroes representing a non-existent commit.  This record
can and will be overwritten when a new commit iff
the commit is all zeroes.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   71 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b45c7e3..55484f7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1904,7 +1904,7 @@ sub last_rev_commit {
 		($self->{last_rev}, $self->{last_commit}) = (undef, undef);
 		return (undef, undef);
 	}
-	my ($rev, $commit) = $self->rev_map_max;
+	my ($rev, $commit) = $self->rev_map_max(1);
 	($self->{last_rev}, $self->{last_commit}) = ($rev, $commit);
 	return ($rev, $commit);
 }
@@ -2534,11 +2534,16 @@ sub rebuild {
 #     * 4 bytes for the integer representing an SVN revision number
 #     * 20 bytes representing the sha1 of a git commit
 #   - No empty padding records like the old format
+#     (except the last record, which can be overwritten)
 #   - new records are written append-only since SVN revision numbers
 #     increase monotonically
 #   - lookups on SVN revision number are done via a binary search
-#   - Piping the file to xxd(1) -c24 is a good way of dumping it for
-#     viewing or editing, should the need ever arise.
+#   - Piping the file to xxd -c24 is a good way of dumping it for
+#     viewing or editing (piped back through xxd -r), should the need
+#     ever arise.
+#   - The last record can be padding revision with an all-zero sha1
+#     This is used to optimize fetch performance when using multiple
+#     "fetch" directives in .git/config
 #
 # These files are disposable unless noMetadata or useSvmProps is set
 
@@ -2548,16 +2553,32 @@ sub _rev_map_set {
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
+	my $wr_offset = 0;
 	if ($size > 0) {
 		sysseek($fh, -24, SEEK_END) or croak "seek: $!";
 		my $read = sysread($fh, my $buf, 24) or croak "read: $!";
 		$read == 24 or croak "read only $read bytes (!= 24)";
 		my ($last_rev, $last_commit) = unpack(rev_map_fmt, $buf);
-		if ($last_rev >= $rev) {
-			croak "last_rev is higher!: $last_rev >= $rev";
+		if ($last_commit eq ('0' x40)) {
+			if ($size >= 48) {
+				sysseek($fh, -48, SEEK_END) or croak "seek: $!";
+				$read = sysread($fh, $buf, 24) or
+				    croak "read: $!";
+				$read == 24 or
+				    croak "read only $read bytes (!= 24)";
+				($last_rev, $last_commit) =
+				    unpack(rev_map_fmt, $buf);
+				if ($last_commit eq ('0' x40)) {
+					croak "inconsistent .rev_map\n";
+				}
+			}
+			if ($last_rev >= $rev) {
+				croak "last_rev is higher!: $last_rev >= $rev";
+			}
+			$wr_offset = -24;
 		}
 	}
-	sysseek($fh, 0, SEEK_END) or croak "seek: $!";
+	sysseek($fh, $wr_offset, SEEK_END) or croak "seek: $!";
 	syswrite($fh, pack(rev_map_fmt, $rev, $commit), 24) == 24 or
 	  croak "write: $!";
 }
@@ -2599,7 +2620,7 @@ sub rev_map_set {
 					    "$db => $db_lock ($!)\n";
 	}
 
-	sysopen(my $fh, $db_lock, O_RDWR | O_APPEND | O_CREAT)
+	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
 	     or croak "Couldn't open $db_lock: $!\n";
 	_rev_map_set($fh, $rev, $commit);
 	if ($sync) {
@@ -2622,25 +2643,40 @@ sub rev_map_set {
 	}
 }
 
+# If want_commit, this will return an array of (rev, commit) where
+# commit _must_ be a valid commit in the archive.
+# Otherwise, it'll return the max revision (whether or not the
+# commit is valid or just a 0x40 placeholder).
 sub rev_map_max {
-	my ($self) = @_;
+	my ($self, $want_commit) = @_;
 	$self->rebuild;
 	my $map_path = $self->map_path;
-	stat $map_path or return wantarray ? (0, undef) : 0;
+	stat $map_path or return $want_commit ? (0, undef) : 0;
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
 	if ($size == 0) {
 		close $fh or croak "close: $!";
-		return wantarray ? (0, undef) : 0;
+		return $want_commit ? (0, undef) : 0;
 	}
 
-	sysseek($fh, -24, SEEK_END);
+	sysseek($fh, -24, SEEK_END) or croak "seek: $!";
 	sysread($fh, my $buf, 24) == 24 or croak "read: $!";
-	close $fh or croak "close: $!";
 	my ($r, $c) = unpack(rev_map_fmt, $buf);
-	wantarray ? ($r, $c) : $r;
+	if ($want_commit && $c eq ('0' x40)) {
+		if ($size < 48) {
+			return $want_commit ? (0, undef) : 0;
+		}
+		sysseek($fh, -48, SEEK_END) or croak "seek: $!";
+		sysread($fh, $buf, 24) == 24 or croak "read: $!";
+		($r, $c) = unpack(rev_map_fmt, $buf);
+		if ($c eq ('0'x40)) {
+			croak "Penultimate record is all-zeroes in $map_path";
+		}
+	}
+	close $fh or croak "close: $!";
+	$want_commit ? ($r, $c) : $r;
 }
 
 sub rev_map_get {
@@ -2672,7 +2708,7 @@ sub rev_map_get {
 			$u = $i - 24;
 		} else { # $r == $rev
 			close($fh) or croak "close: $!";
-			return $c;
+			return $c eq ('0' x 40) ? undef : $c;
 		}
 	}
 	close($fh) or croak "close: $!";
@@ -3863,6 +3899,13 @@ sub gs_fetch_loop_common {
 				$ra_invalid = undef;
 			}
 		}
+		# pre-fill the .rev_db since it'll eventually get filled in
+		# with '0' x40 if something new gets committed
+		foreach my $gs (@$gsv) {
+			next if $gs->rev_map_max >= $max;
+			next if defined $gs->rev_map_get($max);
+			$gs->rev_map_set($max, 0 x40);
+		}
 		foreach my $g (@$globs) {
 			my $k = "svn-remote.$g->{remote}.$g->{t}-maxRev";
 			Git::SVN::tmp_config($k, $max);
-- 
1.5.3.7.1114.g6df1d
