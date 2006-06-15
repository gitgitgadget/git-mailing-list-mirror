From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: fix several small bugs, enable branch optimization
Date: Thu, 15 Jun 2006 13:55:30 -0700
Message-ID: <11504049322660-git-send-email-normalperson@yhbt.net>
References: <11504049313192-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 15 22:55:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqysL-0007IT-PP
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031347AbWFOUzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031350AbWFOUzf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:55:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8412 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1031347AbWFOUze (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 16:55:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B8CF07DC021;
	Thu, 15 Jun 2006 13:55:32 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Jun 2006 13:55:32 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504049313192-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21911>

Share the repack counter between branches when doing
multi-fetch.

Pass the -d flag to git repack by default.  That's the
main reason we will want automatic pack generation, to
save space and improve disk cache performance.  I won't
add -a by default since it can generate extremely large
packs that make RAM-starved systems unhappy.

We no longer generate the .git/svn/$GIT_SVN_ID/info/uuid
file, either.  It was never read in the first place.

Check for and create .rev_db if we need to during fetch (in case
somebody manually blew away their .rev_db and wanted to start
over.  Mainly makes debugging easier).

Croak with $? instead of $! if there's an error closing pipes

Quiet down some of the chatter, too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |  146 +++++++++++++++++++++++-------------------
 1 files changed, 81 insertions(+), 65 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 88af9c5..27f1d68 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -368,7 +368,6 @@ sub fetch_lib {
 		defined(my $pid = fork) or croak $!;
 		if (!$pid) {
 			$SVN::Error::handler = \&libsvn_skip_unknown_revs;
-			print "Fetching revisions $min .. $max\n";
 
 			# Yes I'm perfectly aware that the fourth argument
 			# below is the limit revisions number.  Unfortunately
@@ -391,7 +390,6 @@ sub fetch_lib {
 							$log_msg, @parents);
 					}
 				});
-			$SVN::Error::handler = sub { 'quiet warnings' };
 			exit 0;
 		}
 		waitpid $pid, 0;
@@ -463,7 +461,7 @@ sub commit_lib {
 	my (@revs) = @_;
 	my ($r_last, $cmt_last) = svn_grab_base_rev();
 	defined $r_last or die "Must have an existing revision to commit\n";
-	my $fetched = fetch_lib();
+	my $fetched = fetch();
 	if ($r_last != $fetched->{revision}) {
 		print STDERR "There are new revisions that were fetched ",
 				"and need to be merged (or acknowledged) ",
@@ -523,7 +521,7 @@ sub commit_lib {
 				$no = 1;
 			}
 		}
-		close $fh or croak $!;
+		close $fh or croak $?;
 		if (! defined $r_new && ! defined $cmt_new) {
 			unless ($no) {
 				die "Failed to parse revision information\n";
@@ -633,17 +631,8 @@ sub multi_init {
 sub multi_fetch {
 	# try to do trunk first, since branches/tags
 	# may be descended from it.
-	if (-d "$GIT_DIR/svn/trunk") {
-		print "Fetching trunk\n";
-		defined(my $pid = fork) or croak $!;
-		if (!$pid) {
-			$GIT_SVN = $ENV{GIT_SVN_ID} = 'trunk';
-			init_vars();
-			fetch(@_);
-			exit 0;
-		}
-		waitpid $pid, 0;
-		croak $? if $?;
+	if (-e "$GIT_DIR/svn/trunk/info/url") {
+		fetch_child_id('trunk', @_);
 	}
 	rec_fetch('', "$GIT_DIR/svn", @_);
 }
@@ -725,6 +714,41 @@ out:
 
 ########################### utility functions #########################
 
+sub fetch_child_id {
+	my $id = shift;
+	print "Fetching $id\n";
+	my $ref = "$GIT_DIR/refs/remotes/$id";
+	my $ca = file_to_s($ref) if (-r $ref);
+	defined(my $pid = fork) or croak $!;
+	if (!$pid) {
+		$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
+		init_vars();
+		fetch(@_);
+		exit 0;
+	}
+	waitpid $pid, 0;
+	croak $? if $?;
+	return unless $_repack || -r $ref;
+
+	my $cb = file_to_s($ref);
+
+	defined($pid = open my $fh, '-|') or croak $!;
+	my $url = file_to_s("$GIT_DIR/svn/$id/info/url");
+	$url = qr/\Q$url\E/;
+	if (!$pid) {
+		exec qw/git-rev-list --pretty=raw/,
+				$ca ? "$ca..$cb" : $cb or croak $!;
+	}
+	while (<$fh>) {
+		if (/^    git-svn-id: $url\@\d+ [a-f0-9\-]+$/) {
+			check_repack();
+		} elsif (/^    git-svn-id: \S+\@\d+ [a-f0-9\-]+$/) {
+			last;
+		}
+	}
+	close $fh;
+}
+
 sub rec_fetch {
 	my ($pfx, $p, @args) = @_;
 	my @dir;
@@ -733,16 +757,7 @@ sub rec_fetch {
 			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
 			my $id = $pfx . basename $_;
 			next if $id eq 'trunk';
-			print "Fetching $id\n";
-			defined(my $pid = fork) or croak $!;
-			if (!$pid) {
-				$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
-				init_vars();
-				fetch(@args);
-				exit 0;
-			}
-			waitpid $pid, 0;
-			croak $? if $?;
+			fetch_child_id($id, @args);
 		} elsif (-d $_) {
 			push @dir, $_;
 		}
@@ -943,7 +958,6 @@ sub read_uuid {
 		$SVN_UUID = $info->{'Repository UUID'} or
 					croak "Repository UUID unreadable\n";
 	}
-	s_to_file($SVN_UUID,"$GIT_SVN_DIR/info/uuid");
 }
 
 sub quiet_run {
@@ -1107,7 +1121,7 @@ sub parse_diff_tree {
 			croak "Error parsing $_\n";
 		}
 	}
-	close $diff_fh or croak $!;
+	close $diff_fh or croak $?;
 
 	return \@mods;
 }
@@ -1348,7 +1362,7 @@ sub get_commit_message {
 				print $msg $_ or croak $!;
 			}
 		}
-		close $msg_fh or croak $!;
+		close $msg_fh or croak $?;
 	}
 	close $msg or croak $!;
 
@@ -1562,7 +1576,7 @@ sub svn_info {
 			push @{$ret->{-order}}, $1;
 		}
 	}
-	close $info_fh or croak $!;
+	close $info_fh or croak $?;
 	return $ret;
 }
 
@@ -1638,7 +1652,7 @@ sub do_update_index {
 		}
 		print $ui $x,"\0";
 	}
-	close $ui or croak $!;
+	close $ui or croak $?;
 }
 
 sub index_changes {
@@ -1765,11 +1779,15 @@ sub git_commit {
 
 	# this output is read via pipe, do not change:
 	print "r$log_msg->{revision} = $commit\n";
+	check_repack();
+	return $commit;
+}
+
+sub check_repack {
 	if ($_repack && (--$_repack_nr == 0)) {
 		$_repack_nr = $_repack;
 		sys("git repack $_repack_flags");
 	}
-	return $commit;
 }
 
 sub set_commit_env {
@@ -1877,6 +1895,10 @@ sub svn_cmd_checkout {
 }
 
 sub check_upgrade_needed {
+	if (!-r $REVDB) {
+		open my $fh, '>>',$REVDB or croak $!;
+		close $fh;
+	}
 	my $old = eval {
 		my $pid = open my $child, '-|';
 		defined $pid or croak $!;
@@ -2026,7 +2048,8 @@ sub migration_check {
 sub find_rev_before {
 	my ($r, $id, $eq_ok) = @_;
 	my $f = "$GIT_DIR/svn/$id/.rev_db";
-	# --$r unless $eq_ok;
+	return (undef,undef) unless -r $f;
+	--$r unless $eq_ok;
 	while ($r > 0) {
 		if (my $c = revdb_get($f, $r)) {
 			return ($r, $c);
@@ -2072,7 +2095,7 @@ sub set_default_vals {
 	if (defined $_repack) {
 		$_repack = 1000 if ($_repack <= 0);
 		$_repack_nr = $_repack;
-		$_repack_flags ||= '';
+		$_repack_flags ||= '-d';
 	}
 }
 
@@ -2352,7 +2375,7 @@ sub libsvn_get_file {
 	close $ho or croak $?;
 	$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
 	print $gui $mode,' ',$hash,"\t",$p,"\0" or croak $!;
-	close $fd or croak $!;
+	close $fd or croak $?;
 }
 
 sub libsvn_log_entry {
@@ -2381,7 +2404,7 @@ sub process_rm {
 		while (<$ls>) {
 			print $gui '0 ',0 x 40,"\t",$_ or croak $!;
 		}
-		close $ls or croak $!;
+		close $ls or croak $?;
 	} else {
 		print $gui '0 ',0 x 40,"\t",$f,"\0" or croak $!;
 	}
@@ -2411,7 +2434,7 @@ sub libsvn_fetch {
 		$pool->clear;
 	}
 	libsvn_get_file($gui, $_, $rev) foreach (@amr);
-	close $gui or croak $!;
+	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
 }
 
@@ -2514,36 +2537,30 @@ sub revisions_eq {
 }
 
 sub libsvn_find_parent_branch {
-	return undef; # XXX this function is disabled atm (not tested enough)
 	my ($paths, $rev, $author, $date, $msg) = @_;
 	my $svn_path = '/'.$SVN_PATH;
 
 	# look for a parent from another branch:
-	foreach (keys %$paths) {
-		next if ($_ ne $svn_path);
-		my $i = $paths->{$_};
-		my $branch_from = $i->copyfrom_path or next;
-		my $r = $i->copyfrom_rev;
-		print STDERR  "Found possible branch point: ",
-					"$branch_from => $svn_path, $r\n";
-		$branch_from =~ s#^/##;
-		my $l_map = read_url_paths();
-		my $url = $SVN->{url};
-		defined $l_map->{$url} or next;
-		my $id  = $l_map->{$url}->{$branch_from} or next;
-		my ($r0, $parent) = find_rev_before($r,$id,1);
-		if (defined $r0 && defined $parent &&
-					revisions_eq($branch_from, $r0, $r)) {
-			unlink $GIT_SVN_INDEX;
-			print STDERR "Found branch parent: $parent\n";
-			sys(qw/git-read-tree/, $parent);
-			return libsvn_fetch($parent, $paths, $rev,
-						$author, $date, $msg);
-		} else {
-			print STDERR
-				"Nope, branch point not imported or unknown\n";
-		}
-	}
+	my $i = $paths->{$svn_path} or return;
+	my $branch_from = $i->copyfrom_path or return;
+	my $r = $i->copyfrom_rev;
+	print STDERR  "Found possible branch point: ",
+				"$branch_from => $svn_path, $r\n";
+	$branch_from =~ s#^/##;
+	my $l_map = read_url_paths();
+	my $url = $SVN->{url};
+	defined $l_map->{$url} or return;
+	my $id = $l_map->{$url}->{$branch_from} or return;
+	my ($r0, $parent) = find_rev_before($r,$id,1);
+	return unless (defined $r0 && defined $parent);
+	if (revisions_eq($branch_from, $r0, $r)) {
+		unlink $GIT_SVN_INDEX;
+		print STDERR "Found branch parent: $parent\n";
+		sys(qw/git-read-tree/, $parent);
+		return libsvn_fetch($parent, $paths, $rev,
+					$author, $date, $msg);
+	}
+	print STDERR "Nope, branch point not imported or unknown\n";
 	return undef;
 }
 
@@ -2556,7 +2573,7 @@ sub libsvn_new_tree {
 	my $pool = SVN::Pool->new;
 	libsvn_traverse($gui, '', $SVN_PATH, $rev, $pool);
 	$pool->clear;
-	close $gui or croak $!;
+	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg);
 }
 
@@ -2630,7 +2647,7 @@ sub libsvn_commit_cb {
 			exit 1;
 		}
 	} else {
-		fetch_lib("$rev=$c");
+		fetch("$rev=$c");
 	}
 }
 
@@ -2664,7 +2681,6 @@ sub libsvn_skip_unknown_revs {
 	# 175002 - http(s)://
 	#   More codes may be discovered later...
 	if ($errno == 175002 || $errno == 160013) {
-		print STDERR "directory non-existent\n";
 		return;
 	}
 	croak "Error from SVN, ($errno): ", $err->expanded_message,"\n";
-- 
1.4.0
