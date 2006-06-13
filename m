From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 11/13] git-svn: add 'log' command, a facsimile of basic `svn log'
Date: Tue, 13 Jun 2006 11:02:13 -0700
Message-ID: <11502217502740-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE2-0004t6-Fi
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWFMSCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFMSCe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52677 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932175AbWFMSCb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:31 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8E1547DC020;
	Tue, 13 Jun 2006 11:02:30 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:30 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21796>

This quick feature should make it easy to look up svn log
messages when svn users refer to -r/--revision numbers.

The following features from `svn log' are supported:

  --revision=<n>[:<n>] - is supported, non-numeric args are not:
			 HEAD, NEXT, BASE, PREV, etc ...
  -v/--verbose         - just maps to --raw (in git log), so
			 it's completely incompatible with
			 the --verbose output in svn log
  --limit=<n>          - is NOT the same as --max-count,
			 doesn't count merged/excluded commits
  --incremental        - supported (trivial :P)

New features:

  --show-commit        - shows the git commit sha1, as well
  --oneline            - our version of --pretty=oneline

Any other arguments are passed directly to `git log'

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |  260 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 243 insertions(+), 17 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index d5c7e47..03416ae 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -15,6 +15,7 @@ use Cwd qw/abs_path/;
 $ENV{GIT_DIR} = $GIT_DIR;
 
 my $LC_ALL = $ENV{LC_ALL};
+my $TZ = $ENV{TZ};
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
@@ -27,7 +28,7 @@ use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
-use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
 use File::Spec qw//;
 use POSIX qw/strftime/;
 my $sha1 = qr/[a-f\d]{40}/;
@@ -36,8 +37,9 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_find_copies_harder, $_l, $_cp_similarity,
 	$_repack, $_repack_nr, $_repack_flags,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
+	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m);
-my (@_branch_from, %tree_map, %users);
+my (@_branch_from, %tree_map, %users, %rusers);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
 
@@ -87,6 +89,15 @@ my %cmd = (
 	'multi-fetch' => [ \&multi_fetch,
 			'Fetch multiple trees (like git-svnimport)',
 			\%fc_opts ],
+	'log' => [ \&show_log, 'Show commit logs',
+			{ 'limit=i' => \$_limit,
+			  'revision|r=s' => \$_revision,
+			  'verbose|v' => \$_verbose,
+			  'incremental' => \$_incremental,
+			  'oneline' => \$_oneline,
+			  'show-commit' => \$_show_commit,
+			  'authors-file|A=s' => \$_authors,
+			} ],
 );
 
 my $cmd;
@@ -101,9 +112,10 @@ for (my $i = 0; $i < @ARGV; $i++) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
-GetOptions(%opts, 'help|H|h' => \$_help,
-		'version|V' => \$_version,
-		'id|i=s' => \$GIT_SVN) or exit 1;
+my $rv = GetOptions(%opts, 'help|H|h' => \$_help,
+				'version|V' => \$_version,
+				'id|i=s' => \$GIT_SVN);
+exit 1 if (!$rv && $cmd ne 'log');
 
 set_default_vals();
 usage(0) if $_help;
@@ -173,18 +185,10 @@ sub rebuild {
 		croak "Non-SHA1: $c\n" unless $c =~ /^$sha1$/o;
 		my @commit = grep(/^git-svn-id: /,`git-cat-file commit $c`);
 		next if (!@commit); # skip merges
-		my $id = $commit[$#commit];
-		my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
-						\s([a-f\d\-]+)$/x);
-		if (!$rev || !$uuid || !$url) {
-			# some of the original repositories I made had
-			# indentifiers like this:
-			($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)
-							\@([a-f\d\-]+)/x);
-			if (!$rev || !$uuid) {
-				croak "Unable to extract revision or UUID from ",
-					"$c, $id\n";
-			}
+		my ($url, $rev, $uuid) = extract_metadata($commit[$#commit]);
+		if (!$rev || !$uuid) {
+			croak "Unable to extract revision or UUID from ",
+				"$c, $commit[$#commit]\n";
 		}
 
 		# if we merged or otherwise started elsewhere, this is
@@ -448,6 +452,81 @@ sub multi_fetch {
 	rec_fetch('', "$GIT_DIR/svn", @_);
 }
 
+sub show_log {
+	my (@args) = @_;
+	my ($r_min, $r_max);
+	my $r_last = -1; # prevent dupes
+	rload_authors() if $_authors;
+	if (defined $TZ) {
+		$ENV{TZ} = $TZ;
+	} else {
+		delete $ENV{TZ};
+	}
+	if (defined $_revision) {
+		if ($_revision =~ /^(\d+):(\d+)$/) {
+			($r_min, $r_max) = ($1, $2);
+		} elsif ($_revision =~ /^\d+$/) {
+			$r_min = $r_max = $_revision;
+		} else {
+			print STDERR "-r$_revision is not supported, use ",
+				"standard \'git log\' arguments instead\n";
+			exit 1;
+		}
+	}
+
+	my $pid = open(my $log,'-|');
+	defined $pid or croak $!;
+	if (!$pid) {
+		my @rl = (qw/git-log --abbrev-commit --pretty=raw
+				--default/, "remotes/$GIT_SVN");
+		push @rl, '--raw' if $_verbose;
+		exec(@rl, @args) or croak $!;
+	}
+	setup_pager();
+	my (@k, $c, $d);
+	while (<$log>) {
+		if (/^commit ($sha1_short)/o) {
+			my $cmt = $1;
+			if ($c && defined $c->{r} && $c->{r} != $r_last) {
+				$r_last = $c->{r};
+				process_commit($c, $r_min, $r_max, \@k) or
+								goto out;
+			}
+			$d = undef;
+			$c = { c => $cmt };
+		} elsif (/^author (.+) (\d+) ([\-\+]?\d+)$/) {
+			get_author_info($c, $1, $2, $3);
+		} elsif (/^(?:tree|parent|committer) /) {
+			# ignore
+		} elsif (/^:\d{6} \d{6} $sha1_short/o) {
+			push @{$c->{raw}}, $_;
+		} elsif (/^diff /) {
+			$d = 1;
+			push @{$c->{diff}}, $_;
+		} elsif ($d) {
+			push @{$c->{diff}}, $_;
+		} elsif (/^    (git-svn-id:.+)$/) {
+			my ($url, $rev, $uuid) = extract_metadata($1);
+			$c->{r} = $rev;
+		} elsif (s/^    //) {
+			push @{$c->{l}}, $_;
+		}
+	}
+	if ($c && defined $c->{r} && $c->{r} != $r_last) {
+		$r_last = $c->{r};
+		process_commit($c, $r_min, $r_max, \@k);
+	}
+	if (@k) {
+		my $swap = $r_max;
+		$r_max = $r_min;
+		$r_min = $swap;
+		process_commit($_, $r_min, $r_max) foreach reverse @k;
+	}
+out:
+	close $log;
+	print '-' x72,"\n" unless $_incremental || $_oneline;
+}
+
 ########################### utility functions #########################
 
 sub rec_fetch {
@@ -1638,6 +1717,17 @@ sub load_authors {
 	close $authors or croak $!;
 }
 
+sub rload_authors {
+	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
+	while (<$authors>) {
+		chomp;
+		next unless /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/;
+		my ($user, $name, $email) = ($1, $2, $3);
+		$rusers{"$name <$email>"} = $user;
+	}
+	close $authors or croak $!;
+}
+
 sub svn_propget_base {
 	my ($p, $f) = @_;
 	$f .= '@BASE' if $_svn_pg_peg_revs;
@@ -1803,6 +1893,142 @@ sub read_url_paths {
 	return $l_map;
 }
 
+sub extract_metadata {
+	my $id = shift;
+	my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
+							\s([a-f\d\-]+)$/x);
+	if (!$rev || !$uuid || !$url) {
+		# some of the original repositories I made had
+		# indentifiers like this:
+		($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
+	}
+	return ($url, $rev, $uuid);
+}
+
+sub tz_to_s_offset {
+	my ($tz) = @_;
+	$tz =~ s/(\d\d)$//;
+	return ($1 * 60) + ($tz * 3600);
+}
+
+sub setup_pager { # translated to Perl from pager.c
+	return unless (-t *STDOUT);
+	my $pager = $ENV{PAGER};
+	if (!defined $pager) {
+		$pager = 'less';
+	} elsif (length $pager == 0 || $pager eq 'cat') {
+		return;
+	}
+	pipe my $rfd, my $wfd or return;
+	defined(my $pid = fork) or croak $!;
+	if (!$pid) {
+		open STDOUT, '>&', $wfd or croak $!;
+		return;
+	}
+	open STDIN, '<&', $rfd or croak $!;
+	$ENV{LESS} ||= '-S';
+	exec $pager or croak "Can't run pager: $!\n";;
+}
+
+sub get_author_info {
+	my ($dest, $author, $t, $tz) = @_;
+	$author =~ s/(?:^\s*|\s*$)//g;
+	my $_a;
+	if ($_authors) {
+		$_a = $rusers{$author} || undef;
+	}
+	if (!$_a) {
+		($_a) = ($author =~ /<([^>]+)\@[^>]+>$/);
+	}
+	$dest->{t} = $t;
+	$dest->{tz} = $tz;
+	$dest->{a} = $_a;
+	# Date::Parse isn't in the standard Perl distro :(
+	if ($tz =~ s/^\+//) {
+		$t += tz_to_s_offset($tz);
+	} elsif ($tz =~ s/^\-//) {
+		$t -= tz_to_s_offset($tz);
+	}
+	$dest->{t_utc} = $t;
+}
+
+sub process_commit {
+	my ($c, $r_min, $r_max, $defer) = @_;
+	if (defined $r_min && defined $r_max) {
+		if ($r_min == $c->{r} && $r_min == $r_max) {
+			show_commit($c);
+			return 0;
+		}
+		return 1 if $r_min == $r_max;
+		if ($r_min < $r_max) {
+			# we need to reverse the print order
+			return 0 if (defined $_limit && --$_limit < 0);
+			push @$defer, $c;
+			return 1;
+		}
+		if ($r_min != $r_max) {
+			return 1 if ($r_min < $c->{r});
+			return 1 if ($r_max > $c->{r});
+		}
+	}
+	return 0 if (defined $_limit && --$_limit < 0);
+	show_commit($c);
+	return 1;
+}
+
+sub show_commit {
+	my $c = shift;
+	if ($_oneline) {
+		my $x = "\n";
+		if (my $l = $c->{l}) {
+			while ($l->[0] =~ /^\s*$/) { shift @$l }
+			$x = $l->[0];
+		}
+		$_l_fmt ||= 'A' . length($c->{r});
+		print 'r',pack($_l_fmt, $c->{r}),' | ';
+		print "$c->{c} | " if $_show_commit;
+		print $x;
+	} else {
+		show_commit_normal($c);
+	}
+}
+
+sub show_commit_normal {
+	my ($c) = @_;
+	print '-' x72, "\nr$c->{r} | ";
+	print "$c->{c} | " if $_show_commit;
+	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
+				 localtime($c->{t_utc})), ' | ';
+	my $nr_line = 0;
+
+	if (my $l = $c->{l}) {
+		while ($l->[$#$l] eq "\n" && $l->[($#$l - 1)] eq "\n") {
+			pop @$l;
+		}
+		$nr_line = scalar @$l;
+		if (!$nr_line) {
+			print "1 line\n\n\n";
+		} else {
+			if ($nr_line == 1) {
+				$nr_line = '1 line';
+			} else {
+				$nr_line .= ' lines';
+			}
+			print $nr_line, "\n\n";
+			print $_ foreach @$l;
+		}
+	} else {
+		print "1 line\n\n";
+
+	}
+	foreach my $x (qw/raw diff/) {
+		if ($c->{$x}) {
+			print "\n";
+			print $_ foreach @{$c->{$x}}
+		}
+	}
+}
+
 __END__
 
 Data structures:
-- 
1.4.0
