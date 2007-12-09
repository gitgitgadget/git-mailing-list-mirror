From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: replace .rev_db with a more space-efficient .rev_map format
Date: Sat,  8 Dec 2007 23:27:41 -0800
Message-ID: <1197185262-16765-2-git-send-email-normalperson@yhbt.net>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 08:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1GaE-0002l7-5N
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 08:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbXLIH1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 02:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbXLIH1s
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 02:27:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50850 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbXLIH1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 02:27:45 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 08A0D7DC109;
	Sat,  8 Dec 2007 23:27:44 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 23:27:43 -0800
X-Mailer: git-send-email 1.5.3.7.1114.g6df1d
In-Reply-To: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67601>

Migrations are done automatically on an as-needed basis when new
revisions are to be fetched.  Stale remote branches do not get
migrated, yet.

However, unless you set noMetadata or useSvkProps it's safe to
just do:

  find $GIT_DIR/svn -name '.rev_db*' -print0 | xargs rm -f

to purge all the old .rev_db files.

The new format is a one-way migration and is NOT compatible with
old versions of git-svn.

This is the replacement for the rev_db format, which was too big
and inefficient for large repositories with a lot of sparse history
(mainly tags).

The format is this:

  - 24 bytes for every record,
    * 4 bytes for the integer representing an SVN revision number
    * 20 bytes representing the sha1 of a git commit

  - No empty padding records like the old format

  - new records are written append-only since SVN revision numbers
    increase monotonically

  - lookups on SVN revision number are done via a binary search

  - Piping the file to xxd(1) -c24 is a good way of dumping it for
    viewing or editing, should the need ever arise.

As with .rev_db, these files are disposable unless noMetadata or
useSvmProps is set.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl               |  286 ++++++++++++++++++++++++++++----------------
 t/lib-git-svn.sh           |   26 ++++
 t/t9107-git-svn-migrate.sh |   16 ++-
 3 files changed, 218 insertions(+), 110 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9f884eb..b45c7e3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -529,7 +529,7 @@ sub cmd_find_rev {
 			    "$head history\n";
 		}
 		my $desired_revision = substr($revision_or_hash, 1);
-		$result = $gs->rev_db_get($desired_revision);
+		$result = $gs->rev_map_get($desired_revision);
 	} else {
 		my (undef, $rev, undef) = cmt_metadata($revision_or_hash);
 		$result = $rev;
@@ -1128,12 +1128,12 @@ sub working_head_info {
 		if (defined $url && defined $rev) {
 			next if $max{$url} and $max{$url} < $rev;
 			if (my $gs = Git::SVN->find_by_url($url)) {
-				my $c = $gs->rev_db_get($rev);
+				my $c = $gs->rev_map_get($rev);
 				if ($c && $c eq $hash) {
 					close $fh; # break the pipe
 					return ($url, $rev, $uuid, $gs);
 				} else {
-					$max{$url} ||= $gs->rev_db_max;
+					$max{$url} ||= $gs->rev_map_max;
 				}
 			}
 		}
@@ -1234,6 +1234,8 @@ sub md5sum {
 package Git::SVN;
 use strict;
 use warnings;
+use Fcntl qw/:DEFAULT :seek/;
+use constant rev_map_fmt => 'NH40';
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing $_minimize_url
@@ -1362,7 +1364,7 @@ sub fetch_all {
 	if ($fetch) {
 		foreach my $p (sort keys %$fetch) {
 			my $gs = Git::SVN->new($fetch->{$p}, $repo_id, $p);
-			my $lr = $gs->rev_db_max;
+			my $lr = $gs->rev_map_max;
 			if (defined $lr) {
 				$base = $lr if ($lr < $base);
 			}
@@ -1897,38 +1899,20 @@ sub last_rev_commit {
 			return ($rev, $c);
 		}
 	}
-	my $db_path = $self->db_path;
-	unless (-e $db_path) {
+	my $map_path = $self->map_path;
+	unless (-e $map_path) {
 		($self->{last_rev}, $self->{last_commit}) = (undef, undef);
 		return (undef, undef);
 	}
-	my $offset = -41; # from tail
-	my $rl;
-	open my $fh, '<', $db_path or croak "$db_path not readable: $!\n";
-	sysseek($fh, $offset, 2); # don't care for errors
-	sysread($fh, $rl, 41) == 41 or return (undef, undef);
-	chomp $rl;
-	while (('0' x40) eq $rl && sysseek($fh, 0, 1) != 0) {
-		$offset -= 41;
-		sysseek($fh, $offset, 2); # don't care for errors
-		sysread($fh, $rl, 41) == 41 or return (undef, undef);
-		chomp $rl;
-	}
-	if ($c && $c ne $rl) {
-		die "$db_path and ", $self->refname,
-		    " inconsistent!:\n$c != $rl\n";
-	}
-	my $rev = sysseek($fh, 0, 1) or croak $!;
-	$rev =  ($rev - 41) / 41;
-	close $fh or croak $!;
-	($self->{last_rev}, $self->{last_commit}) = ($rev, $c);
-	return ($rev, $c);
+	my ($rev, $commit) = $self->rev_map_max;
+	($self->{last_rev}, $self->{last_commit}) = ($rev, $commit);
+	return ($rev, $commit);
 }
 
 sub get_fetch_range {
 	my ($self, $min, $max) = @_;
 	$max ||= $self->ra->get_latest_revnum;
-	$min ||= $self->rev_db_max;
+	$min ||= $self->rev_map_max;
 	(++$min, $max);
 }
 
@@ -2073,7 +2057,7 @@ sub do_git_commit {
 		    " was r$lr, but we are about to fetch: ",
 		    "r$log_entry->{revision}!\n";
 	}
-	if (my $c = $self->rev_db_get($log_entry->{revision})) {
+	if (my $c = $self->rev_map_get($log_entry->{revision})) {
 		croak "$log_entry->{revision} = $c already exists! ",
 		      "Why are we refetching it?\n";
 	}
@@ -2116,14 +2100,14 @@ sub do_git_commit {
 		die "Failed to commit, invalid sha1: $commit\n";
 	}
 
-	$self->rev_db_set($log_entry->{revision}, $commit, 1);
+	$self->rev_map_set($log_entry->{revision}, $commit, 1);
 
 	$self->{last_rev} = $log_entry->{revision};
 	$self->{last_commit} = $commit;
 	print "r$log_entry->{revision}";
 	if (defined $log_entry->{svm_revision}) {
 		 print " (\@$log_entry->{svm_revision})";
-		 $self->rev_db_set($log_entry->{svm_revision}, $commit,
+		 $self->rev_map_set($log_entry->{svm_revision}, $commit,
 		                   0, $self->svm_uuid);
 	}
 	print " = $commit ($self->{ref_id})\n";
@@ -2465,25 +2449,44 @@ sub set_tree {
 	}
 }
 
+sub rebuild_from_rev_db {
+	my ($self, $path) = @_;
+	my $r = -1;
+	open my $fh, '<', $path or croak "open: $!";
+	while (<$fh>) {
+		length($_) == 41 or croak "inconsistent size in ($_) != 41";
+		chomp($_);
+		++$r;
+		next if $_ eq ('0' x 40);
+		$self->rev_map_set($r, $_);
+		print "r$r = $_\n";
+	}
+	close $fh or croak "close: $!";
+	unlink $path or croak "unlink: $!";
+}
+
 sub rebuild {
 	my ($self) = @_;
-	my $db_path = $self->db_path;
-	return if (-e $db_path && ! -z $db_path);
+	my $map_path = $self->map_path;
+	return if (-e $map_path && ! -z $map_path);
 	return unless ::verify_ref($self->refname.'^0');
-	if (-f $self->{db_root}) {
-		rename $self->{db_root}, $db_path or die
-		     "rename $self->{db_root} => $db_path failed: $!\n";
-		my ($dir, $base) = ($db_path =~ m#^(.*?)/?([^/]+)$#);
-		symlink $base, $self->{db_root} or die
-		     "symlink $base => $self->{db_root} failed: $!\n";
+	if ($self->use_svm_props || $self->no_metadata) {
+		my $rev_db = $self->rev_db_path;
+		$self->rebuild_from_rev_db($rev_db);
+		if ($self->use_svm_props) {
+			my $svm_rev_db = $self->rev_db_path($self->svm_uuid);
+			$self->rebuild_from_rev_db($svm_rev_db);
+		}
+		$self->unlink_rev_db_symlink;
 		return;
 	}
-	print "Rebuilding $db_path ...\n";
-	my ($log, $ctx) = command_output_pipe("log", '--no-color', $self->refname);
-	my $latest;
+	print "Rebuilding $map_path ...\n";
+	my ($log, $ctx) =
+	    command_output_pipe(qw/rev-list --pretty=raw --no-color --reverse/,
+	                        $self->refname, '--');
 	my $full_url = $self->full_url;
 	remove_username($full_url);
-	my $svn_uuid;
+	my $svn_uuid = $self->ra_uuid;
 	my $c;
 	while (<$log>) {
 		if ( m{^commit ($::sha1)$} ) {
@@ -2499,46 +2502,64 @@ sub rebuild {
 
 		# if we merged or otherwise started elsewhere, this is
 		# how we break out of it
-		if ((defined $svn_uuid && ($uuid ne $svn_uuid)) ||
+		if (($uuid ne $svn_uuid) ||
 		    ($full_url && $url && ($url ne $full_url))) {
 			next;
 		}
-		$latest ||= $rev;
-		$svn_uuid ||= $uuid;
 
-		$self->rev_db_set($rev, $c);
+		$self->rev_map_set($rev, $c);
 		print "r$rev = $c\n";
 	}
 	command_close_pipe($log, $ctx);
-	print "Done rebuilding $db_path\n";
+	print "Done rebuilding $map_path\n";
+	my $rev_db_path = $self->rev_db_path;
+	if (-f $self->rev_db_path) {
+		unlink $self->rev_db_path or croak "unlink: $!";
+	}
+	$self->unlink_rev_db_symlink;
 }
 
-# rev_db:
+# rev_map:
 # Tie::File seems to be prone to offset errors if revisions get sparse,
 # it's not that fast, either.  Tie::File is also not in Perl 5.6.  So
 # one of my favorite modules is out :<  Next up would be one of the DBM
-# modules, but I'm not sure which is most portable...  So I'll just
-# go with something that's plain-text, but still capable of
-# being randomly accessed.  So here's my ultra-simple fixed-width
-# database.  All records are 40 characters + "\n", so it's easy to seek
-# to a revision: (41 * rev) is the byte offset.
-# A record of 40 0s denotes an empty revision.
-# And yes, it's still pretty fast (faster than Tie::File).
+# modules, but I'm not sure which is most portable...
+#
+# This is the replacement for the rev_db format, which was too big
+# and inefficient for large repositories with a lot of sparse history
+# (mainly tags)
+#
+# The format is this:
+#   - 24 bytes for every record,
+#     * 4 bytes for the integer representing an SVN revision number
+#     * 20 bytes representing the sha1 of a git commit
+#   - No empty padding records like the old format
+#   - new records are written append-only since SVN revision numbers
+#     increase monotonically
+#   - lookups on SVN revision number are done via a binary search
+#   - Piping the file to xxd(1) -c24 is a good way of dumping it for
+#     viewing or editing, should the need ever arise.
+#
 # These files are disposable unless noMetadata or useSvmProps is set
 
-sub _rev_db_set {
+sub _rev_map_set {
 	my ($fh, $rev, $commit) = @_;
-	my $offset = $rev * 41;
-	# assume that append is the common case:
-	seek $fh, 0, 2 or croak $!;
-	my $pos = tell $fh;
-	if ($pos < $offset) {
-		for (1 .. (($offset - $pos) / 41)) {
-			print $fh (('0' x 40),"\n") or croak $!;
+
+	my $size = (stat($fh))[7];
+	($size % 24) == 0 or croak "inconsistent size: $size";
+
+	if ($size > 0) {
+		sysseek($fh, -24, SEEK_END) or croak "seek: $!";
+		my $read = sysread($fh, my $buf, 24) or croak "read: $!";
+		$read == 24 or croak "read only $read bytes (!= 24)";
+		my ($last_rev, $last_commit) = unpack(rev_map_fmt, $buf);
+		if ($last_rev >= $rev) {
+			croak "last_rev is higher!: $last_rev >= $rev";
 		}
 	}
-	seek $fh, $offset, 0 or croak $!;
-	print $fh $commit,"\n" or croak $!;
+	sysseek($fh, 0, SEEK_END) or croak "seek: $!";
+	syswrite($fh, pack(rev_map_fmt, $rev, $commit), 24) == 24 or
+	  croak "write: $!";
 }
 
 sub mkfile {
@@ -2551,10 +2572,10 @@ sub mkfile {
 	}
 }
 
-sub rev_db_set {
+sub rev_map_set {
 	my ($self, $rev, $commit, $update_ref, $uuid) = @_;
 	length $commit == 40 or die "arg3 must be a full SHA1 hexsum\n";
-	my $db = $self->db_path($uuid);
+	my $db = $self->map_path($uuid);
 	my $db_lock = "$db.lock";
 	my $sig;
 	if ($update_ref) {
@@ -2569,16 +2590,18 @@ sub rev_db_set {
 	# and we can't afford to lose it because rebuild() won't work
 	if ($self->use_svm_props || $self->no_metadata) {
 		$sync = 1;
-		copy($db, $db_lock) or die "rev_db_set(@_): ",
+		copy($db, $db_lock) or die "rev_map_set(@_): ",
 					   "Failed to copy: ",
 					   "$db => $db_lock ($!)\n";
 	} else {
-		rename $db, $db_lock or die "rev_db_set(@_): ",
+		rename $db, $db_lock or die "rev_map_set(@_): ",
 					    "Failed to rename: ",
 					    "$db => $db_lock ($!)\n";
 	}
-	open my $fh, '+<', $db_lock or die "Couldn't open $db_lock: $!\n";
-	_rev_db_set($fh, $rev, $commit);
+
+	sysopen(my $fh, $db_lock, O_RDWR | O_APPEND | O_CREAT)
+	     or croak "Couldn't open $db_lock: $!\n";
+	_rev_map_set($fh, $rev, $commit);
 	if ($sync) {
 		$fh->flush or die "Couldn't flush $db_lock: $!\n";
 		$fh->sync or die "Couldn't sync $db_lock: $!\n";
@@ -2589,7 +2612,7 @@ sub rev_db_set {
 		command_noisy('update-ref', '-m', "r$rev",
 		              $self->refname, $commit);
 	}
-	rename $db_lock, $db or die "rev_db_set(@_): ", "Failed to rename: ",
+	rename $db_lock, $db or die "rev_map_set(@_): ", "Failed to rename: ",
 	                            "$db_lock => $db ($!)\n";
 	delete $LOCKFILES{$db_lock};
 	if ($update_ref) {
@@ -2599,29 +2622,61 @@ sub rev_db_set {
 	}
 }
 
-sub rev_db_max {
+sub rev_map_max {
 	my ($self) = @_;
 	$self->rebuild;
-	my $db_path = $self->db_path;
-	my @stat = stat $db_path or return 0;
-	($stat[7] % 41) == 0 or die "$db_path inconsistent size: $stat[7]\n";
-	my $max = $stat[7] / 41;
-	(($max > 0) ? $max - 1 : 0);
+	my $map_path = $self->map_path;
+	stat $map_path or return wantarray ? (0, undef) : 0;
+	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
+	my $size = (stat($fh))[7];
+	($size % 24) == 0 or croak "inconsistent size: $size";
+
+	if ($size == 0) {
+		close $fh or croak "close: $!";
+		return wantarray ? (0, undef) : 0;
+	}
+
+	sysseek($fh, -24, SEEK_END);
+	sysread($fh, my $buf, 24) == 24 or croak "read: $!";
+	close $fh or croak "close: $!";
+	my ($r, $c) = unpack(rev_map_fmt, $buf);
+	wantarray ? ($r, $c) : $r;
 }
 
-sub rev_db_get {
+sub rev_map_get {
 	my ($self, $rev, $uuid) = @_;
-	my $ret;
-	my $offset = $rev * 41;
-	my $db_path = $self->db_path($uuid);
-	return undef unless -e $db_path;
-	open my $fh, '<', $db_path or croak $!;
-	if (sysseek($fh, $offset, 0) == $offset) {
-		my $read = sysread($fh, $ret, 40);
-		$ret = undef if ($read != 40 || $ret eq ('0'x40));
+	my $map_path = $self->map_path($uuid);
+	return undef unless -e $map_path;
+
+	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
+	my $size = (stat($fh))[7];
+	($size % 24) == 0 or croak "inconsistent size: $size";
+
+	if ($size == 0) {
+		close $fh or croak "close: $fh";
+		return undef;
 	}
-	close $fh or croak $!;
-	$ret;
+
+	my ($l, $u) = (0, $size - 24);
+	my ($r, $c, $buf);
+
+	while ($l <= $u) {
+		my $i = int(($l/24 + $u/24) / 2) * 24;
+		sysseek($fh, $i, SEEK_SET) or croak "seek: $!";
+		sysread($fh, my $buf, 24) == 24 or croak "read: $!";
+		my ($r, $c) = unpack('NH40', $buf);
+
+		if ($r < $rev) {
+			$l = $i + 24;
+		} elsif ($r > $rev) {
+			$u = $i - 24;
+		} else { # $r == $rev
+			close($fh) or croak "close: $!";
+			return $c;
+		}
+	}
+	close($fh) or croak "close: $!";
+	undef;
 }
 
 # Finds the first svn revision that exists on (if $eq_ok is true) or
@@ -2633,7 +2688,7 @@ sub find_rev_before {
 	--$rev unless $eq_ok;
 	$min_rev ||= 1;
 	while ($rev >= $min_rev) {
-		if (my $c = $self->rev_db_get($rev)) {
+		if (my $c = $self->rev_map_get($rev)) {
 			return ($rev, $c);
 		}
 		--$rev;
@@ -2648,9 +2703,9 @@ sub find_rev_before {
 sub find_rev_after {
 	my ($self, $rev, $eq_ok, $max_rev) = @_;
 	++$rev unless $eq_ok;
-	$max_rev ||= $self->rev_db_max();
+	$max_rev ||= $self->rev_map_max;
 	while ($rev <= $max_rev) {
-		if (my $c = $self->rev_db_get($rev)) {
+		if (my $c = $self->rev_map_get($rev)) {
 			return ($rev, $c);
 		}
 		++$rev;
@@ -2673,13 +2728,32 @@ sub _new {
 	bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
 	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
-	        db_root => "$dir/.rev_db", repo_id => $repo_id }, $class;
+	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
 }
 
-sub db_path {
+# for read-only access of old .rev_db formats
+sub unlink_rev_db_symlink {
+	my ($self) = @_;
+	my $link = $self->rev_db_path;
+	$link =~ s/\.[\w-]+$// or croak "missing UUID at the end of $link";
+	if (-l $link) {
+		unlink $link or croak "unlink: $link failed!";
+	}
+}
+
+sub rev_db_path {
+	my ($self, $uuid) = @_;
+	my $db_path = $self->map_path($uuid);
+	$db_path =~ s{/\.rev_map\.}{/\.rev_db\.}
+	    or croak "map_path: $db_path does not contain '/.rev_map.' !";
+	$db_path;
+}
+
+# the new replacement for .rev_db
+sub map_path {
 	my ($self, $uuid) = @_;
 	$uuid ||= $self->ra_uuid;
-	"$self->{db_root}.$uuid";
+	"$self->{map_root}.$uuid";
 }
 
 sub uri_encode {
@@ -3763,7 +3837,7 @@ sub gs_fetch_loop_common {
 
 			foreach my $gs ($self->match_globs(\%exists, $paths,
 			                                   $globs, $r)) {
-				if ($gs->rev_db_max >= $r) {
+				if ($gs->rev_map_max >= $r) {
 					next;
 				}
 				next unless $gs->match_paths($paths, $r);
@@ -3789,12 +3863,6 @@ sub gs_fetch_loop_common {
 				$ra_invalid = undef;
 			}
 		}
-		# pre-fill the .rev_db since it'll eventually get filled in
-		# with '0' x40 if something new gets committed
-		foreach my $gs (@$gsv) {
-			next if defined $gs->rev_db_get($max);
-			$gs->rev_db_set($max, 0 x40);
-		}
 		foreach my $g (@$globs) {
 			my $k = "svn-remote.$g->{remote}.$g->{t}-maxRev";
 			Git::SVN::tmp_config($k, $max);
@@ -4030,7 +4098,7 @@ sub git_svn_log_cmd {
 	push @cmd, @log_opts;
 	if (defined $r_max && $r_max == $r_min) {
 		push @cmd, '--max-count=1';
-		if (my $c = $gs->rev_db_get($r_max)) {
+		if (my $c = $gs->rev_map_get($r_max)) {
 			push @cmd, $c;
 		}
 	} elsif (defined $r_max) {
@@ -4311,6 +4379,16 @@ package Git::SVN::Migration;
 #              --use-separate-remotes option in git-clone (now default)
 #            - we do not automatically migrate to this (following
 #              the example set by core git)
+#
+# v5 layout: .rev_db.$UUID => .rev_map.$UUID
+#            - newer, more-efficient format that uses 24-bytes per record
+#              with no filler space.
+#            - use xxd -c24 < .rev_map.$UUID to view and debug
+#            - This is a one-way migration, repositories updated to the
+#              new format will not be able to use old git-svn without
+#              rebuilding the .rev_db.  Rebuilding the rev_db is not
+#              possible if noMetadata or useSvmProps are set; but should
+#              be no problem for users that use the (sensible) defaults.
 use strict;
 use warnings;
 use Carp qw/croak/;
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 8d4a447..9ee35e7 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -82,3 +82,29 @@ stop_httpd () {
 	test -z "$SVN_HTTPD_PORT" && return
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
 }
+
+convert_to_rev_db () {
+	perl -w -- - "$@" <<\EOF
+use strict;
+@ARGV == 2 or die "Usage: convert_to_rev_db <input> <output>";
+open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
+open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
+my $size = (stat($rd))[7];
+($size % 24) == 0 or die "Inconsistent size: $size";
+while (sysread($rd, my $buf, 24) == 24) {
+	my ($r, $c) = unpack('NH40', $buf);
+	my $offset = $r * 41;
+	seek $wr, 0, 2 or die $!;
+	my $pos = tell $wr;
+	if ($pos < $offset) {
+		for (1 .. (($offset - $pos) / 41)) {
+			print $wr (('0' x 40),"\n") or die $!;
+		}
+	}
+	seek $wr, $offset, 0 or die $!;
+	print $wr $c,"\n" or die $!;
+}
+close $wr or die $!;
+close $rd or die $!;
+EOF
+}
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 67fdf70..0a41d52 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -97,15 +97,19 @@ test_expect_success 'migrate --minimize on old inited layout' "
 	grep '^:refs/remotes/git-svn' fetch.out
 	"
 
-test_expect_success  ".rev_db auto-converted to .rev_db.UUID" "
+test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
 	git-svn fetch -i trunk &&
-	expect=$GIT_DIR/svn/trunk/.rev_db.* &&
+	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	expect=\"\$(ls $GIT_DIR/svn/trunk/.rev_map.*)\" &&
 	test -n \"\$expect\" &&
-	mv \$expect $GIT_DIR/svn/trunk/.rev_db &&
+	rev_db=\$(echo \$expect | sed -e 's,_map,_db,') &&
+	convert_to_rev_db \$expect \$rev_db &&
+	rm -f \$expect &&
+	test -f \$rev_db &&
 	git-svn fetch -i trunk &&
-	test -L $GIT_DIR/svn/trunk/.rev_db &&
-	test -f \$expect &&
-	cmp \$expect $GIT_DIR/svn/trunk/.rev_db
+	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	test ! -e $GIT_DIR/svn/trunk/.rev_db &&
+	test -f \$expect
 	"
 
 test_done
-- 
1.5.3.7.1114.g6df1d
