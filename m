Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA9C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35E5223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gIZiNW8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgFSWwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:52:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729822AbgFSWwI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:52:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1EB1F60A6C;
        Fri, 19 Jun 2020 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607096;
        bh=JfIMLisphWeO+W56KfkiYhmAoUcNsACETXaUAtTQUiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gIZiNW8J9YFPEQ/IRjJePQqI9h5tqdTTw6W4pj9uiFDF1VNgXZKcnBG0dAKEx9cMW
         woroZmWh0nnoMAhBnFYbjVPzP7a1mNMggvXJ8/BUJCg6NBuLJl+YOfjrhaJLlliybI
         Gw/2dGMXqOpO1tMTBlD+3cmDUWzs1DyqilUsgcN75Lb4HT7MzCWnb/8N1aPZ5L47rF
         GBUc7zOjklMLGEW8UtMidO5G+ZOPCXOn/aKLfJPbr7MNqngmtfMV7ZfKfOeTfWIMH1
         9CNWimRGdCG5D3cKN+A6miH5i3MhD8XWudyE7Zg0BjZyBS8exN6+5f3T0rNYasV4U3
         7ct761SxO7i4gFLhUvhzjweEwDxVLhA6UYkL+98MJqMlziQ9l/0BmC31Ycd7Oc1+in
         ihwAkMRBfPLKR6hqq77YcRTdF8jYKhvuyp+6hlTKQXmyvjOanY/crNhrW4mxhIr2cL
         Jhhgr5f+nneDiHOq+iRJxTec1Qc2iI3wh0o0vHqJhjzm47uu6un
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 10/14] perl: make SVN code hash independent
Date:   Fri, 19 Jun 2020 22:39:43 +0000
Message-Id: <20200619223947.947067-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several places throughout git-svn that use various hard-coded
constants.  For matching object IDs, use the $oid variable.  Compute the
record size we use for our revision storage based on the object ID.

When parsing the revision map format, use a wildcard in the pack format
since we know that the data we're parsing is always exactly the record
size.  This lets us continue to use a constant for the pack format.

Finally, update several comments to reflect the fact that an object ID
may be of one of multiple sizes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-svn.perl            |  4 +--
 perl/Git/SVN.pm         | 73 +++++++++++++++++++++--------------------
 perl/Git/SVN/Editor.pm  |  6 ++--
 perl/Git/SVN/Fetcher.pm |  6 ++--
 perl/Git/SVN/Ra.pm      |  4 +--
 5 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7c735cebd3..00276c051b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2008,10 +2008,10 @@ sub cmt_sha2rev_batch {
 		print $out $sha, "\n";
 
 		while (my $line = <$in>) {
-			if ($first && $line =~ /^[[:xdigit:]]{40}\smissing$/) {
+			if ($first && $line =~ /^$::oid\smissing$/) {
 				last;
 			} elsif ($first &&
-			       $line =~ /^[[:xdigit:]]{40}\scommit\s(\d+)$/) {
+			       $line =~ /^$::oid\scommit\s(\d+)$/) {
 				$first = 0;
 				$size = $1;
 				next;
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index fcf1e3bb5e..d1c352f92b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2,7 +2,7 @@ package Git::SVN;
 use strict;
 use warnings;
 use Fcntl qw/:DEFAULT :seek/;
-use constant rev_map_fmt => 'NH40';
+use constant rev_map_fmt => 'NH*';
 use vars qw/$_no_metadata
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing
@@ -2087,10 +2087,10 @@ sub rebuild_from_rev_db {
 	open my $fh, '<', $path or croak "open: $!";
 	binmode $fh or croak "binmode: $!";
 	while (<$fh>) {
-		length($_) == 41 or croak "inconsistent size in ($_) != 41";
+		length($_) == $::oid_length + 1 or croak "inconsistent size in ($_)";
 		chomp($_);
 		++$r;
-		next if $_ eq ('0' x 40);
+		next if $_ eq ('0' x $::oid_length);
 		$self->rev_map_set($r, $_);
 		print "r$r = $_\n";
 	}
@@ -2196,9 +2196,9 @@ sub rebuild {
 # (mainly tags)
 #
 # The format is this:
-#   - 24 bytes for every record,
+#   - 24 or 36 bytes for every record,
 #     * 4 bytes for the integer representing an SVN revision number
-#     * 20 bytes representing the sha1 of a git commit
+#     * 20 or 32 bytes representing the oid of a git commit
 #   - No empty padding records like the old format
 #     (except the last record, which can be overwritten)
 #   - new records are written append-only since SVN revision numbers
@@ -2207,7 +2207,7 @@ sub rebuild {
 #   - Piping the file to xxd -c24 is a good way of dumping it for
 #     viewing or editing (piped back through xxd -r), should the need
 #     ever arise.
-#   - The last record can be padding revision with an all-zero sha1
+#   - The last record can be padding revision with an all-zero oid
 #     This is used to optimize fetch performance when using multiple
 #     "fetch" directives in .git/config
 #
@@ -2215,38 +2215,39 @@ sub rebuild {
 
 sub _rev_map_set {
 	my ($fh, $rev, $commit) = @_;
+	my $record_size = ($::oid_length / 2) + 4;
 
 	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
-	($size % 24) == 0 or croak "inconsistent size: $size";
+	($size % $record_size) == 0 or croak "inconsistent size: $size";
 
 	my $wr_offset = 0;
 	if ($size > 0) {
-		sysseek($fh, -24, SEEK_END) or croak "seek: $!";
-		my $read = sysread($fh, my $buf, 24) or croak "read: $!";
-		$read == 24 or croak "read only $read bytes (!= 24)";
+		sysseek($fh, -$record_size, SEEK_END) or croak "seek: $!";
+		my $read = sysread($fh, my $buf, $record_size) or croak "read: $!";
+		$read == $record_size or croak "read only $read bytes (!= $record_size)";
 		my ($last_rev, $last_commit) = unpack(rev_map_fmt, $buf);
-		if ($last_commit eq ('0' x40)) {
-			if ($size >= 48) {
-				sysseek($fh, -48, SEEK_END) or croak "seek: $!";
-				$read = sysread($fh, $buf, 24) or
+		if ($last_commit eq ('0' x $::oid_length)) {
+			if ($size >= ($record_size * 2)) {
+				sysseek($fh, -($record_size * 2), SEEK_END) or croak "seek: $!";
+				$read = sysread($fh, $buf, $record_size) or
 				    croak "read: $!";
-				$read == 24 or
-				    croak "read only $read bytes (!= 24)";
+				$read == $record_size or
+				    croak "read only $read bytes (!= $record_size)";
 				($last_rev, $last_commit) =
 				    unpack(rev_map_fmt, $buf);
-				if ($last_commit eq ('0' x40)) {
+				if ($last_commit eq ('0' x $::oid_length)) {
 					croak "inconsistent .rev_map\n";
 				}
 			}
 			if ($last_rev >= $rev) {
 				croak "last_rev is higher!: $last_rev >= $rev";
 			}
-			$wr_offset = -24;
+			$wr_offset = -$record_size;
 		}
 	}
 	sysseek($fh, $wr_offset, SEEK_END) or croak "seek: $!";
-	syswrite($fh, pack(rev_map_fmt, $rev, $commit), 24) == 24 or
+	syswrite($fh, pack(rev_map_fmt, $rev, $commit), $record_size) == $record_size or
 	  croak "write: $!";
 }
 
@@ -2271,7 +2272,7 @@ sub mkfile {
 sub rev_map_set {
 	my ($self, $rev, $commit, $update_ref, $uuid) = @_;
 	defined $commit or die "missing arg3\n";
-	length $commit == 40 or die "arg3 must be a full SHA1 hexsum\n";
+	$commit =~ /^$::oid$/ or die "arg3 must be a full hex object ID\n";
 	my $db = $self->map_path($uuid);
 	my $db_lock = "$db.lock";
 	my $sigmask;
@@ -2344,29 +2345,30 @@ sub rev_map_max {
 
 sub rev_map_max_norebuild {
 	my ($self, $want_commit) = @_;
+	my $record_size = ($::oid_length / 2) + 4;
 	my $map_path = $self->map_path;
 	stat $map_path or return $want_commit ? (0, undef) : 0;
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
 	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
-	($size % 24) == 0 or croak "inconsistent size: $size";
+	($size % $record_size) == 0 or croak "inconsistent size: $size";
 
 	if ($size == 0) {
 		close $fh or croak "close: $!";
 		return $want_commit ? (0, undef) : 0;
 	}
 
-	sysseek($fh, -24, SEEK_END) or croak "seek: $!";
-	sysread($fh, my $buf, 24) == 24 or croak "read: $!";
+	sysseek($fh, -$record_size, SEEK_END) or croak "seek: $!";
+	sysread($fh, my $buf, $record_size) == $record_size or croak "read: $!";
 	my ($r, $c) = unpack(rev_map_fmt, $buf);
-	if ($want_commit && $c eq ('0' x40)) {
-		if ($size < 48) {
+	if ($want_commit && $c eq ('0' x $::oid_length)) {
+		if ($size < $record_size * 2) {
 			return $want_commit ? (0, undef) : 0;
 		}
-		sysseek($fh, -48, SEEK_END) or croak "seek: $!";
-		sysread($fh, $buf, 24) == 24 or croak "read: $!";
+		sysseek($fh, -($record_size * 2), SEEK_END) or croak "seek: $!";
+		sysread($fh, $buf, $record_size) == $record_size or croak "read: $!";
 		($r, $c) = unpack(rev_map_fmt, $buf);
-		if ($c eq ('0'x40)) {
+		if ($c eq ('0' x $::oid_length)) {
 			croak "Penultimate record is all-zeroes in $map_path";
 		}
 	}
@@ -2387,30 +2389,31 @@ sub rev_map_get {
 
 sub _rev_map_get {
 	my ($fh, $rev) = @_;
+	my $record_size = ($::oid_length / 2) + 4;
 
 	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
-	($size % 24) == 0 or croak "inconsistent size: $size";
+	($size % $record_size) == 0 or croak "inconsistent size: $size";
 
 	if ($size == 0) {
 		return undef;
 	}
 
-	my ($l, $u) = (0, $size - 24);
+	my ($l, $u) = (0, $size - $record_size);
 	my ($r, $c, $buf);
 
 	while ($l <= $u) {
-		my $i = int(($l/24 + $u/24) / 2) * 24;
+		my $i = int(($l/$record_size + $u/$record_size) / 2) * $record_size;
 		sysseek($fh, $i, SEEK_SET) or croak "seek: $!";
-		sysread($fh, my $buf, 24) == 24 or croak "read: $!";
+		sysread($fh, my $buf, $record_size) == $record_size or croak "read: $!";
 		my ($r, $c) = unpack(rev_map_fmt, $buf);
 
 		if ($r < $rev) {
-			$l = $i + 24;
+			$l = $i + $record_size;
 		} elsif ($r > $rev) {
-			$u = $i - 24;
+			$u = $i - $record_size;
 		} else { # $r == $rev
-			return $c eq ('0' x 40) ? undef : $c;
+			return $c eq ('0' x $::oid_length) ? undef : $c;
 		}
 	}
 	undef;
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 70b6d78cd9..c961444d4c 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -400,12 +400,12 @@ sub T {
 	    ($m->{mode_b} !~ /^120/ && $m->{mode_a} =~ /^120/)) {
 		$self->D({
 			mode_a => $m->{mode_a}, mode_b => '000000',
-			sha1_a => $m->{sha1_a}, sha1_b => '0' x 40,
+			sha1_a => $m->{sha1_a}, sha1_b => '0' x $::oid_length,
 			chg => 'D', file_b => $m->{file_b}
 		}, $deletions);
 		$self->A({
 			mode_a => '000000', mode_b => $m->{mode_b},
-			sha1_a => '0' x 40, sha1_b => $m->{sha1_b},
+			sha1_a => '0' x $::oid_length, sha1_b => $m->{sha1_b},
 			chg => 'A', file_b => $m->{file_b}
 		}, $deletions);
 		return;
@@ -434,7 +434,7 @@ ($$$$)
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
 	my $blob = $m->{"sha1_$which"};
-	return ($fh,) if ($blob =~ /^0{40}$/);
+	return ($fh,) if ($blob =~ /^0+$/);
 	my $size = $::_repository->cat_blob($blob, $fh);
 	croak "Failed to read object $blob" if ($size < 0);
 	$fh->flush == 0 or croak $!;
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 64e900a0e9..729e5337df 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -173,7 +173,7 @@ sub delete_entry {
 
 	# remove entire directories.
 	my ($tree) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
-	                 =~ /\A040000 tree ([a-f\d]{40})\t\Q$gpath\E\0/);
+	                 =~ /\A040000 tree ($::oid)\t\Q$gpath\E\0/);
 	if ($tree) {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
 		                                     -r --name-only -z/,
@@ -203,7 +203,7 @@ sub open_file {
 
 	my $gpath = $self->git_path($path);
 	($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
-	                     =~ /\A(\d{6}) blob ([a-f\d]{40})\t\Q$gpath\E\0/);
+	                     =~ /\A(\d{6}) blob ($::oid)\t\Q$gpath\E\0/);
 	unless (defined $mode && defined $blob) {
 		die "$path was not found in commit $self->{c} (r$rev)\n";
 	}
@@ -413,7 +413,7 @@ sub close_file {
 
 		$hash = $::_repository->hash_and_insert_object(
 				Git::temp_path($fh));
-		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
+		$hash =~ /^$::oid$/ or die "not an object ID: $hash\n";
 
 		Git::temp_release($fb->{base}, 1);
 		Git::temp_release($fh, 1);
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 56ad9870bc..2cfe055a9a 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -486,11 +486,11 @@ sub gs_fetch_loop_common {
 			$reload_ra->() if $ra_invalid;
 		}
 		# pre-fill the .rev_db since it'll eventually get filled in
-		# with '0' x40 if something new gets committed
+		# with '0' x $oid_length if something new gets committed
 		foreach my $gs (@$gsv) {
 			next if $gs->rev_map_max >= $max;
 			next if defined $gs->rev_map_get($max);
-			$gs->rev_map_set($max, 0 x40);
+			$gs->rev_map_set($max, 0 x $::oid_length);
 		}
 		foreach my $g (@$globs) {
 			my $k = "svn-remote.$g->{remote}.$g->{t}-maxRev";
