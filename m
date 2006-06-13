From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 9/13] git-svn: add some functionality to better support branches in svn
Date: Tue, 13 Jun 2006 11:02:11 -0700
Message-ID: <11502217472672-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE7-0004t6-He
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWFMSCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWFMSCb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50629 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932118AbWFMSC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:29 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E841E7DC005;
	Tue, 13 Jun 2006 11:02:27 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:27 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21794>

New commands:

graft-branches - The most interesting command of the bunch.  It
detects branches in SVN via various techniques (currently
regexes and file copies).   It can be later extended to handle
svk and other properties people may use to track merges in svk.
Basically, merge tracking is not standardized at all in the SVN
world, and git grafts are perfect for dealing with this
situation.

Existing branch support (via tree matches) is only handled at
fetch time.

The following tow were originally implemented as shell scripts
several months ago, but I just decided to streamline things a
bit and added them to the main script.

multi-init - supports git-svnimport-like command-line syntax for
importing repositories that are layed out as recommended by the
SVN folks.  This is a bit more tolerant than the git-svnimport
command-line syntax and doesn't require the user to figure out
where the repository URL ends and where the repository path
begins.

multi-fetch - runs fetch on all known SVN branches we're
tracking.  This will NOT discover new branches (unlike
git-svnimport), so multi-init will need to be re-run (it's
idempotent).

Consider these three to be auxilliary commands (like
show-ignore, and rebuild) so their behavior won't receive as
much testing or scrutiny as the core commands (fetch and
commit).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |  429 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 424 insertions(+), 5 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index d8f103e..d5c7e47 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -35,8 +35,8 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity,
 	$_repack, $_repack_nr, $_repack_flags,
-	$_template, $_shared,
-	$_version, $_upgrade, $_authors, $_branch_all_refs);
+	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
+	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
 my (@_branch_from, %tree_map, %users);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -48,6 +48,12 @@ my %fc_opts = ( 'no-ignore-externals' =>
 		'repack:i' => \$_repack,
 		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
+my ($_trunk, $_tags, $_branches);
+my %multi_opts = ( 'trunk|T=s' => \$_trunk,
+		'tags|t=s' => \$_tags,
+		'branches|b=s' => \$_branches );
+my %init_opts = ( 'template=s' => \$_template, 'shared' => \$_shared );
+
 # yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
 my %EOL = ( CR => "\015", LF => "\012", CRLF => "\015\012", native => "\012" );
 
@@ -56,8 +62,7 @@ my %cmd = (
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
 	init => [ \&init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
-			  { 'template=s' => \$_template,
-			    'shared' => \$_shared } ],
+			  \%init_opts ],
 	commit => [ \&commit, "Commit git revisions to SVN",
 			{	'stdin|' => \$_stdin,
 				'edit|e' => \$_edit,
@@ -71,7 +76,19 @@ my %cmd = (
 	rebuild => [ \&rebuild, "Rebuild git-svn metadata (after git clone)",
 			{ 'no-ignore-externals' => \$_no_ignore_ext,
 			  'upgrade' => \$_upgrade } ],
+	'graft-branches' => [ \&graft_branches,
+			'Detect merges/branches from already imported history',
+			{ 'merge-rx|m' => \@_opt_m,
+			  'no-default-regex' => \$_no_default_regex,
+			  'no-graft-copy' => \$_no_graft_copy } ],
+	'multi-init' => [ \&multi_init,
+			'Initialize multiple trees (like git-svnimport)',
+			{ %multi_opts, %fc_opts } ],
+	'multi-fetch' => [ \&multi_fetch,
+			'Fetch multiple trees (like git-svnimport)',
+			\%fc_opts ],
 );
+
 my $cmd;
 for (my $i = 0; $i < @ARGV; $i++) {
 	if (defined $cmd{$ARGV[$i]}) {
@@ -96,7 +113,7 @@ init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
 svn_compat_check();
-migration_check() unless $cmd eq 'init';
+migration_check() unless $cmd =~ /^(?:init|multi-init)$/;
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
 
@@ -219,6 +236,7 @@ when you have upgraded your tools and ha
 sub init {
 	$SVN_URL = shift or die "SVN repository location required " .
 				"as a command-line argument\n";
+	$SVN_URL =~ s!/+$!!; # strip trailing slash
 	unless (-d $GIT_DIR) {
 		my @init_db = ('git-init-db');
 		push @init_db, "--template=$_template" if defined $_template;
@@ -358,8 +376,283 @@ sub show_ignore {
 	}
 }
 
+sub graft_branches {
+	my $gr_file = "$GIT_DIR/info/grafts";
+	my ($grafts, $comments) = read_grafts($gr_file);
+	my $gr_sha1;
+
+	if (%$grafts) {
+		# temporarily disable our grafts file to make this idempotent
+		chomp($gr_sha1 = safe_qx(qw/git-hash-object -w/,$gr_file));
+		rename $gr_file, "$gr_file~$gr_sha1" or croak $!;
+	}
+
+	my $l_map = read_url_paths();
+	my @re = map { qr/$_/is } @_opt_m if @_opt_m;
+	unless ($_no_default_regex) {
+		push @re, (	qr/\b(?:merge|merging|merged)\s+(\S.+)/is,
+				qr/\b(?:from|of)\s+(\S.+)/is );
+	}
+	foreach my $u (keys %$l_map) {
+		if (@re) {
+			foreach my $p (keys %{$l_map->{$u}}) {
+				graft_merge_msg($grafts,$l_map,$u,$p);
+			}
+		}
+		graft_file_copy($grafts,$l_map,$u) unless $_no_graft_copy;
+	}
+
+	write_grafts($grafts, $comments, $gr_file);
+	unlink "$gr_file~$gr_sha1" if $gr_sha1;
+}
+
+sub multi_init {
+	my $url = shift;
+	$_trunk ||= 'trunk';
+	$_trunk =~ s#/+$##;
+	$url =~ s#/+$## if $url;
+	if ($_trunk !~ m#^[a-z\+]+://#) {
+		$_trunk = '/' . $_trunk if ($_trunk !~ m#^/#);
+		unless ($url) {
+			print STDERR "E: '$_trunk' is not a complete URL ",
+				"and a separate URL is not specified\n";
+			exit 1;
+		}
+		$_trunk = $url . $_trunk;
+	}
+	if ($GIT_SVN eq 'git-svn') {
+		print "GIT_SVN_ID set to 'trunk' for $_trunk\n";
+		$GIT_SVN = $ENV{GIT_SVN_ID} = 'trunk';
+	}
+	init_vars();
+	init($_trunk);
+	complete_url_ls_init($url, $_branches, '--branches/-b', '');
+	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
+}
+
+sub multi_fetch {
+	# try to do trunk first, since branches/tags
+	# may be descended from it.
+	if (-d "$GIT_DIR/svn/trunk") {
+		print "Fetching trunk\n";
+		defined(my $pid = fork) or croak $!;
+		if (!$pid) {
+			$GIT_SVN = $ENV{GIT_SVN_ID} = 'trunk';
+			init_vars();
+			fetch(@_);
+			exit 0;
+		}
+		waitpid $pid, 0;
+		croak $? if $?;
+	}
+	rec_fetch('', "$GIT_DIR/svn", @_);
+}
+
 ########################### utility functions #########################
 
+sub rec_fetch {
+	my ($pfx, $p, @args) = @_;
+	my @dir;
+	foreach (sort <$p/*>) {
+		if (-r "$_/info/url") {
+			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
+			my $id = $pfx . basename $_;
+			next if $id eq 'trunk';
+			print "Fetching $id\n";
+			defined(my $pid = fork) or croak $!;
+			if (!$pid) {
+				$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
+				init_vars();
+				fetch(@args);
+				exit 0;
+			}
+			waitpid $pid, 0;
+			croak $? if $?;
+		} elsif (-d $_) {
+			push @dir, $_;
+		}
+	}
+	foreach (@dir) {
+		my $x = $_;
+		$x =~ s!^\Q$GIT_DIR\E/svn/!!;
+		rec_fetch($x, $_);
+	}
+}
+
+sub complete_url_ls_init {
+	my ($url, $var, $switch, $pfx) = @_;
+	unless ($var) {
+		print STDERR "W: $switch not specified\n";
+		return;
+	}
+	$var =~ s#/+$##;
+	if ($var !~ m#^[a-z\+]+://#) {
+		$var = '/' . $var if ($var !~ m#^/#);
+		unless ($url) {
+			print STDERR "E: '$var' is not a complete URL ",
+				"and a separate URL is not specified\n";
+			exit 1;
+		}
+		$var = $url . $var;
+	}
+	chomp(my @ls = safe_qx(qw/svn ls --non-interactive/, $var));
+	my $old = $GIT_SVN;
+	defined(my $pid = fork) or croak $!;
+	if (!$pid) {
+		foreach my $u (map { "$var/$_" } (grep m!/$!, @ls)) {
+			$u =~ s#/+$##;
+			if ($u !~ m!\Q$var\E/(.+)$!) {
+				print STDERR "W: Unrecognized URL: $u\n";
+				die "This should never happen\n";
+			}
+			my $id = $pfx.$1;
+			print "init $u => $id\n";
+			$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
+			init_vars();
+			init($u);
+		}
+		exit 0;
+	}
+	waitpid $pid, 0;
+	croak $? if $?;
+}
+
+sub common_prefix {
+	my $paths = shift;
+	my %common;
+	foreach (@$paths) {
+		my @tmp = split m#/#, $_;
+		my $p = '';
+		while (my $x = shift @tmp) {
+			$p .= "/$x";
+			$common{$p} ||= 0;
+			$common{$p}++;
+		}
+	}
+	foreach (sort {length $b <=> length $a} keys %common) {
+		if ($common{$_} == @$paths) {
+			return $_;
+		}
+	}
+	return '';
+}
+
+# this isn't funky-filename safe, but good enough for now...
+sub graft_file_copy {
+	my ($grafts, $l_map, $u) = @_;
+	my $paths = $l_map->{$u};
+	my $pfx = common_prefix([keys %$paths]);
+
+	my $pid = open my $fh, '-|';
+	defined $pid or croak $!;
+	unless ($pid) {
+		exec(qw/svn log -v/, $u.$pfx) or croak $!;
+	}
+	my ($r, $mp) = (undef, undef);
+	while (<$fh>) {
+		chomp;
+		if (/^\-{72}$/) {
+			$mp = $r = undef;
+		} elsif (/^r(\d+) \| /) {
+			$r = $1 unless defined $r;
+		} elsif (/^Changed paths:/) {
+			$mp = 1;
+		} elsif ($mp && m#^   [AR] /(\S.*?) \(from /(\S+?):(\d+)\)$#) {
+			my $dbg = "r$r | $_";
+			my ($p1, $p0, $r0) = ($1, $2, $3);
+			my $c;
+			foreach my $x (keys %$paths) {
+				next unless ($p1 =~ /^\Q$x\E/);
+				my $i = $paths->{$x};
+				my $f = "$GIT_DIR/svn/$i/revs/$r";
+				unless (-r $f) {
+					print STDERR "r$r of $i not imported,",
+								" $dbg\n";
+					next;
+				}
+				$c = file_to_s($f);
+			}
+			next unless $c;
+			foreach my $x (keys %$paths) {
+				next unless ($p0 =~ /^\Q$x\E/);
+				my $i = $paths->{$x};
+				my $f = "$GIT_DIR/svn/$i/revs/$r0";
+				while ($r0 && !-r $f) {
+					# could be an older revision, too...
+					$r0--;
+					$f = "$GIT_DIR/svn/$i/revs/$r0";
+				}
+				unless (-r $f) {
+					print STDERR "r$r0 of $i not imported,",
+								" $dbg\n";
+					next;
+				}
+				my $r1 = file_to_s($f);
+				$grafts->{$c}->{$r1} = 1;
+			}
+		}
+	}
+}
+
+sub process_merge_msg_matches {
+	my ($grafts, $l_map, $u, $p, $c, @matches) = @_;
+	my (@strong, @weak);
+	foreach (@matches) {
+		# merging with ourselves is not interesting
+		next if $_ eq $p;
+		if ($l_map->{$u}->{$_}) {
+			push @strong, $_;
+		} else {
+			push @weak, $_;
+		}
+	}
+	foreach my $w (@weak) {
+		last if @strong;
+		# no exact match, use branch name as regexp.
+		my $re = qr/\Q$w\E/i;
+		foreach (keys %{$l_map->{$u}}) {
+			if (/$re/) {
+				push @strong, $_;
+				last;
+			}
+		}
+		last if @strong;
+		$w = basename($w);
+		$re = qr/\Q$w\E/i;
+		foreach (keys %{$l_map->{$u}}) {
+			if (/$re/) {
+				push @strong, $_;
+				last;
+			}
+		}
+	}
+	my ($rev) = ($c->{m} =~ /^git-svn-id:\s(?:\S+?)\@(\d+)
+					\s(?:[a-f\d\-]+)$/xsm);
+	unless (defined $rev) {
+		($rev) = ($c->{m} =~/^git-svn-id:\s(\d+)
+					\@(?:[a-f\d\-]+)/xsm);
+		return unless defined $rev;
+	}
+	foreach my $m (@strong) {
+		my ($r0, $s0) = find_rev_before($rev, $m);
+		$grafts->{$c->{c}}->{$s0} = 1 if defined $s0;
+	}
+}
+
+sub graft_merge_msg {
+	my ($grafts, $l_map, $u, $p, @re) = @_;
+
+	my $x = $l_map->{$u}->{$p};
+	my $rl = rev_list_raw($x);
+	while (my $c = next_rev_list_entry($rl)) {
+		foreach my $re (@re) {
+			my (@br) = ($c->{m} =~ /$re/g);
+			next unless @br;
+			process_merge_msg_matches($grafts,$l_map,$u,$p,$c,@br);
+		}
+	}
+}
+
 sub read_uuid {
 	return if $SVN_UUID;
 	my $info = shift || svn_info('.');
@@ -402,6 +695,7 @@ sub repo_path_split {
 		$url .= "/$n";
 	}
 	push @repo_path_split_cache, qr/^(\Q$url\E)/;
+	$path = join('/',@paths);
 	return ($url, $path);
 }
 
@@ -806,6 +1100,38 @@ sub svn_commit_tree {
 	return fetch("$committed=$commit")->{revision};
 }
 
+sub rev_list_raw {
+	my (@args) = @_;
+	my $pid = open my $fh, '-|';
+	defined $pid or croak $!;
+	if (!$pid) {
+		exec(qw/git-rev-list --pretty=raw/, @args) or croak $!;
+	}
+	return { fh => $fh, t => { } };
+}
+
+sub next_rev_list_entry {
+	my $rl = shift;
+	my $fh = $rl->{fh};
+	my $x = $rl->{t};
+	while (<$fh>) {
+		if (/^commit ($sha1)$/o) {
+			if ($x->{c}) {
+				$rl->{t} = { c => $1 };
+				return $x;
+			} else {
+				$x->{c} = $1;
+			}
+		} elsif (/^parent ($sha1)$/o) {
+			$x->{p}->{$1} = 1;
+		} elsif (s/^    //) {
+			$x->{m} ||= '';
+			$x->{m} .= $_;
+		}
+	}
+	return ($x != $rl->{t}) ? $x : undef;
+}
+
 # read the entire log into a temporary file (which is removed ASAP)
 # and store the file handle + parser state
 sub svn_log_raw {
@@ -1318,6 +1644,16 @@ sub svn_propget_base {
 	return safe_qx(qw/svn propget/, $p, $f);
 }
 
+sub git_svn_each {
+	my $sub = shift;
+	foreach (`git-rev-parse --symbolic --all`) {
+		next unless s#^refs/remotes/##;
+		chomp $_;
+		next unless -f "$GIT_DIR/svn/$_/info/url";
+		&$sub($_);
+	}
+}
+
 sub migration_check {
 	return if (-d "$GIT_DIR/svn" || !-d $GIT_DIR);
 	print "Upgrading repository...\n";
@@ -1344,6 +1680,16 @@ sub migration_check {
 	print "Done upgrading.\n";
 }
 
+sub find_rev_before {
+	my ($r, $git_svn_id) = @_;
+	my @revs = map { basename $_ } <$GIT_DIR/svn/$git_svn_id/revs/*>;
+	foreach my $r0 (sort { $b <=> $a } @revs) {
+		next if $r0 >= $r;
+		return ($r0, file_to_s("$GIT_DIR/svn/$git_svn_id/revs/$r0"));
+	}
+	return (undef, undef);
+}
+
 sub init_vars {
 	$GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
 	$GIT_SVN_DIR = "$GIT_DIR/svn/$GIT_SVN";
@@ -1384,6 +1730,79 @@ sub set_default_vals {
 	}
 }
 
+sub read_grafts {
+	my $gr_file = shift;
+	my ($grafts, $comments) = ({}, {});
+	if (open my $fh, '<', $gr_file) {
+		my @tmp;
+		while (<$fh>) {
+			if (/^($sha1)\s+/) {
+				my $c = $1;
+				if (@tmp) {
+					@{$comments->{$c}} = @tmp;
+					@tmp = ();
+				}
+				foreach my $p (split /\s+/, $_) {
+					$grafts->{$c}->{$p} = 1;
+				}
+			} else {
+				push @tmp, $_;
+			}
+		}
+		close $fh or croak $!;
+		@{$comments->{'END'}} = @tmp if @tmp;
+	}
+	return ($grafts, $comments);
+}
+
+sub write_grafts {
+	my ($grafts, $comments, $gr_file) = @_;
+
+	open my $fh, '>', $gr_file or croak $!;
+	foreach my $c (sort keys %$grafts) {
+		if ($comments->{$c}) {
+			print $fh $_ foreach @{$comments->{$c}};
+		}
+		my $p = $grafts->{$c};
+		delete $p->{$c}; # commits are not self-reproducing...
+		my $pid = open my $ch, '-|';
+		defined $pid or croak $!;
+		if (!$pid) {
+			exec(qw/git-cat-file commit/, $c) or croak $!;
+		}
+		while (<$ch>) {
+			if (/^parent ([a-f\d]{40})/) {
+				$p->{$1} = 1;
+			} else {
+				last unless /^\S/i;
+			}
+		}
+		close $ch; # breaking the pipe
+		print $fh $c, ' ', join(' ', sort keys %$p),"\n";
+	}
+	if ($comments->{'END'}) {
+		print $fh $_ foreach @{$comments->{'END'}};
+	}
+	close $fh or croak $!;
+}
+
+sub read_url_paths {
+	my $l_map = {};
+	git_svn_each(sub { my $x = shift;
+			my $u = file_to_s("$GIT_DIR/svn/$x/info/repo_url");
+			my $p = file_to_s("$GIT_DIR/svn/$x/info/repo_path");
+			# we hate trailing slashes
+			if ($u =~ s#(?:^\/+|\/+$)##g) {
+				s_to_file($u,"$GIT_DIR/svn/$x/info/repo_url");
+			}
+			if ($p =~ s#(?:^\/+|\/+$)##g) {
+				s_to_file($p,"$GIT_DIR/svn/$x/info/repo_path");
+			}
+			$l_map->{$u}->{$p} = $x;
+			});
+	return $l_map;
+}
+
 __END__
 
 Data structures:
-- 
1.4.0
