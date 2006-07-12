From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC] New REuse REcorded REsolve tool.
Date: Wed, 12 Jul 2006 05:33:14 -0400
Message-ID: <20060712093314.GA4571@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 11:33:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0b63-0005lr-VI
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 11:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWGLJd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 05:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWGLJd2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 05:33:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8102 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751066AbWGLJd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 05:33:27 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0b5t-0003eD-HC
	for git@vger.kernel.org; Wed, 12 Jul 2006 05:33:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69FEE20E43C; Wed, 12 Jul 2006 05:33:14 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23772>

What follows is a draft implementation of a different git-rerere tool.

Please use caution when testing this on any real repository.  It has
been very lightly tested and only for a small handful of cases.
Its probably going to fail on something that I haven't tried yet.
It could overwrite entries in your current index, making it possible
to commit a file with <<<< === >>>> conflict markers in it.  :-)

My goal with this tool is to get something that git-merge can use
as a pre-filter to the current git-rerere and by which git-merge
can automatically reuse prior resolutions on a more predictable
basis then what happens with git-rerere today.  Ideally I want
git-rerere2 to make the merge commit for me if it was successful
at resolving all unmerged entries and thus have git-merge return
with an exit code of 0 rather than 1.

Lots of TODOs still exist:
- Prune cache at some threshold in size/age.
- Anchor prior recorded merge commits along a special ref (to prevent
  them from pruning while they are still in the cache).
- Automatically create merge commit if successfully resolved.
- Test cases.
- More/better documentation.
- Friendly error handling on invalid command line option combinations.

And all of the above means no signoff yet.   :-)

-->8--
New REuse REcorded REsolve tool.

git-rerere2 attempts to remember lines of development that have been
merged together before by tracking merge commits in .git/rr2-cache.
When two lines of development are merged together again in the
future git-rerere2 searches its cache for the most recent merge
commit between the two branches and tries to select the merge commit
that contains the maximum number of commits from each branch.

If such a commit exists in the cache then git-rerere2 attempts
to resolve any unmerged index entries by comparing the conflicted
stage 1/2/3 from the chosen prior merge against the current index;
if stage 1 is unchanged and stage 2/3 are unchanged (but possibly
permuted in order) then the working directory (and current index)
are updated with resolved file as committed in the chosen commit.

Unlike git-rerere, git-rerere2 can remember and reuse structual
modifications (adds/deletes, mode changes, type changes) as well as
reuse binary file resolutions which the standard RCS `merge` tool
wouldn't have been able to process.  However, also unlike git-rerere,
git-rerere2 does not attempt to merge the contents of a file.
---
 .gitignore       |    1 
 Makefile         |    2 
 git-commit.sh    |    4 +
 git-merge.sh     |    4 +
 git-rerere2.perl |  281 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 291 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index fb0fa3f..1a3ed42 100644
--- a/.gitignore
+++ b/.gitignore
@@ -87,6 +87,7 @@ git-repack
 git-repo-config
 git-request-pull
 git-rerere
+git-rerere2
 git-reset
 git-resolve
 git-rev-list
diff --git a/Makefile b/Makefile
index 5b7bac8..e1fa96a 100644
--- a/Makefile
+++ b/Makefile
@@ -147,7 +147,7 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-shortlog.perl git-rerere.perl \
+	git-shortlog.perl git-rerere.perl git-rerere2.perl \
 	git-annotate.perl git-cvsserver.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
diff --git a/git-commit.sh b/git-commit.sh
index 802dd72..3451072 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -742,6 +742,10 @@ else
 fi
 ret="$?"
 rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
+if test -d "$GIT_DIR/rr2-cache"
+then
+	git-rerere2 --record
+fi
 if test -d "$GIT_DIR/rr-cache"
 then
 	git-rerere
diff --git a/git-merge.sh b/git-merge.sh
index a9cfafb..53a907b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -375,6 +375,10 @@ Conflicts:
 		sed -e 's/^[^	]*	/	/' |
 		uniq
 	} >>"$GIT_DIR/MERGE_MSG"
+	if test -d "$GIT_DIR/rr2-cache"
+	then
+		git-rerere2 --reset --remember-unmerged --reuse "$head_arg" "$@"
+	fi
 	if test -d "$GIT_DIR/rr-cache"
 	then
 		git-rerere
diff --git a/git-rerere2.perl b/git-rerere2.perl
new file mode 100644
index 0000000..8925faf
--- /dev/null
+++ b/git-rerere2.perl
@@ -0,0 +1,281 @@
+#!/usr/bin/perl
+#
+# REuse REcorded REsolve.  This tool records a conflicted automerge
+# result and its hand resolution, and helps to resolve future
+# automerge that results in the same conflict.
+#
+
+use strict;
+use warnings;
+use Getopt::Long;
+use Pod::Usage;
+use File::Spec::Functions qw(catfile);
+use Git;
+
+my $repo = Git->repository;
+my $cache_dir = catfile($repo->repo_path, 'rr2-cache');
+my $cache_toc = catfile($cache_dir, 'contents');
+my $tmp_lst = catfile($cache_dir, 'current_unmerged');
+
+my ($enable, $disable,
+	$reset, $remember_unmerged,
+	$reuse, $dry_run, $no_update,
+	$record,
+	$man, $help);
+GetOptions(
+	"enable" => \$enable,
+	"disable" => \$disable,
+	"reset" => \$reset,
+	"remember-unmerged" => \$remember_unmerged,
+	"reuse" => \$reuse,
+	"n|dry-run" =>, \$dry_run,
+	"no-update" =>, \$no_update,
+	"record" => \$record,
+	"man" => \$man,
+	"help" => \$help,
+);
+pod2usage(1) if $help;
+pod2usage(-exitstatus => 0, -verbose => 2) if $man;
+
+if ($enable) {
+	mkdir $cache_dir, 0777;
+	die "Failed to create $cache_dir: $!\n" unless -d $cache_dir;
+	print "Created $cache_dir\n";
+	exit 0;
+}
+exit unless -d $cache_dir;
+
+my (%unmerged);
+sub load_unmerged ($$);
+sub save_unmerged ($$);
+
+if ($reset) {
+	unlink $tmp_lst;
+} else {
+	if (open(T, '<',$tmp_lst)) {
+		load_unmerged \*T, \%unmerged;
+		close T;
+	}
+}
+
+if ($remember_unmerged) {
+	my ($f,$c) = $repo->command_output_pipe(qw(ls-files -z --unmerged));
+	load_unmerged $f, \%unmerged;
+	$repo->command_close_pipe($f,$c);
+
+	if (%unmerged) {
+		open(T, '>',$tmp_lst) or die "Can't overwrite $tmp_lst: $!\n";
+		save_unmerged \*T, \%unmerged;
+		close T;
+	} else {
+		unlink $tmp_lst;
+	}
+}
+
+if ($reuse && !$record && @ARGV > 1 && %unmerged) {
+	my %cache_by_parent;
+	if (open(T,'<',$cache_toc)) {
+		while (<T>) {
+			chop;
+			my ($then, $result, @parents) = split / /;
+			my $e = [$then, $result, @parents];
+			push @{$cache_by_parent{$_}}, $e foreach @parents;
+		}
+		close T;
+	}
+
+	my $base = $repo->command_oneline('merge-base',@ARGV);
+	my %possib_results;
+	foreach my $r (@ARGV) {
+		my ($f,$c) = $repo->command_output_pipe('rev-list',"^$base",$r);
+		while (<$f>) {
+			chop;
+			my $e_arr = $cache_by_parent{$_};
+			next unless $e_arr;
+			$possib_results{$_->[1]}++ foreach @$e_arr;
+		}
+		$repo->command_close_pipe($f,$c);
+	}
+	my @p = sort {$b->[0] <=> $a->[0]}
+		grep {$possib_results{$_} == @ARGV} keys %possib_results;
+	my $best = $p[0];
+
+	my @reuse;
+	if (open(T, '<',catfile($cache_dir, $best))) {
+		my %best_conflicts;
+		$_ = <T>;
+		load_unmerged \*T, \%best_conflicts;
+		close T;
+
+		print "Trying to reuse resolution(s) from $best.\n";
+		my ($name, $u);
+		while (($name,$u) = each %unmerged) {
+			my $b = $best_conflicts{$name};
+			next unless $b;  # no prior resolution
+			next unless $u->[1] eq $b->[1];  # different base
+			next unless (($u->[2] eq $b->[2] && $u->[3] eq $b->[3])
+				|| ($u->[2] eq $b->[3] && $u->[3] eq $b->[2]));
+
+			push @reuse, $name;
+		}
+	}
+
+	if (@reuse) {
+		print "Reuse ",$_,"\n" foreach @reuse;
+		print "\n";
+
+		if ($dry_run) {
+			print "Skipped checkout (--dry-run enabled).\n";
+		} else {
+			print "Checking out resolved versions...\n";
+			my $idx = catfile($repo->repo_path,'rerere2idx');
+			local $ENV{GIT_INDEX_FILE} = $idx;
+			$repo->command(qw(read-tree --reset),$best);
+			my ($f,$c) = $repo->command_input_pipe(
+				qw(checkout-index --force -z --stdin));
+			print $f $_, "\0" foreach @reuse;
+			$repo->command_close_pipe($f,$c);
+			unlink $idx;
+		}
+		delete $unmerged{$_} foreach @reuse;
+
+		if ($dry_run) {
+			print "Skipped index update (--dry-run enabled).\n";
+		} elsif ($no_update) {
+			print "Skipped index update (--no-update enabled).\n";
+		} else {
+			print "Updating index with resolved versions...\n";
+			my ($f,$c) = $repo->command_input_pipe(
+				qw(update-index -z --stdin));
+			print $f $_, "\0" foreach @reuse;
+			$repo->command_close_pipe($f,$c);
+		}
+
+		if (%unmerged) {
+			unless ($dry_run) {
+				open(T, '>',$tmp_lst)
+					or die "Can't overwrite $tmp_lst: $!\n";
+				save_unmerged \*T, \%unmerged;
+				close T;
+			}
+			print "Some conflicts remain.\n";
+			exit 1;
+		} else {
+			unlink $tmp_lst unless $dry_run;
+			print "Everything resolved.\n";
+			exit 0;
+		}
+	} else {
+		print "No matching resolutions available for reuse.\n";
+	}
+	exit 1;
+}
+
+if (!$reuse && $record && %unmerged) {
+	my $head = $repo->command_oneline(qw(rev-parse --verify HEAD));
+	my $now = time;
+
+	my @parents;
+	my ($f,$c) = $repo->command_output_pipe(qw(cat-file commit HEAD));
+	while (<$f>) {
+		push @parents, $1 if /^parent ([0-9a-f]{40})/;
+		last if /^author /;
+	}
+	$repo->command_close_pipe($f,$c);
+
+	unlink $tmp_lst;
+	exit unless @parents > 1;
+
+	open(T, '>',catfile($cache_dir,$head)) or die "Can't cache: $!\n";
+	print T $now,' ',$head,' ',join(' ', @parents),"\n";
+	save_unmerged \*T, \%unmerged;
+	close T;
+
+	my %toc;
+	if (open(T,'<',$cache_toc)) {
+		while (<T>) {
+			chop;
+			my ($then, $result, $ps) = split / /, $_, 3;
+			$toc{$ps} = [$then, $result, $ps];
+		}
+		close T;
+	}
+
+	my $ps = join(' ', sort @parents);
+	$toc{$ps} = [$now, $head, $ps];
+
+	open(T, '>',$cache_toc) or die "Can't update $cache_toc: $!\n";
+	foreach my $e (sort {$a->[0] <=> $b->[1]} values %toc) {
+		print T join(' ', @$e), "\n";
+	}
+	close T;
+}
+
+exit;
+
+sub load_unmerged ($$) {
+	my ($f, $um) = @_;
+	local $_;
+	local $/ = "\0";
+	my $cur_name;
+	my @cur_stages = ('', '', '', '');
+	while ($_ = <$f>) {
+		chomp;
+		my ($info,$name) = split /\t/, $_, 2;
+		if ($cur_name && $name ne $cur_name) {
+			$um->{$cur_name} = [@cur_stages];
+			@cur_stages = ('', '', '', '');
+		}
+		$cur_name = $name;
+		$info =~ / ([123])$/;
+		$cur_stages[$1] = $info;
+	}
+	$um->{$cur_name} = [@cur_stages] if $cur_name;
+}
+
+sub save_unmerged ($$) {
+	my ($f, $um) = @_;
+	foreach my $cur_name (sort keys %$um) {
+		my $u = $um->{$cur_name};
+		foreach my $stage (1..3) {
+			my $s = $u->[$stage];
+			next unless $s;
+			print $f $s,"\t",$cur_name,"\0";
+		}
+	}
+}
+
+__END__
+
+=head1 NAME
+
+git-rerere2 - REuse REcorded REsolve
+
+=head1 SYNOPSIS
+
+  git-rerere2 --enable    ; #to activate
+
+=head1 OPTIONS
+
+=over 4
+
+=item B<--enable>
+
+Activate git-rerere2 in the current repository.
+
+=item B<-n> | B<--dry-run>
+
+Perform reuse actions in memory but don't alter the working directory
+or the index.
+
+=item B<--no-update>
+
+Update the working directory with a reused resolution but don't
+update the index.  This will leave the index entry unmerged with
+all relevant stages still contained within it.  It is the caller's
+responsibility to update the index prior to commit.
+
+=back
+
+=cut
+
-- 
1.4.1.gd3d5
