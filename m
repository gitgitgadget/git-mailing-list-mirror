X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-add --interactive (wip)
Date: Mon, 11 Dec 2006 01:23:19 -0800
Message-ID: <7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<m2d56taoqu.fsf@ziti.local> <7vfybpg9yx.fsf@assigned-by-dhcp.cox.net>
	<200612100146.09175.Josef.Weidendorfer@gmx.de>
	<7vd56s8t9w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 09:23:28 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd56s8t9w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 09 Dec 2006 16:54:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33983>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthNd-0006Es-PK for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762663AbWLKJXW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762671AbWLKJXW
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:23:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62826 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762663AbWLKJXV (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 04:23:21 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061211092320.UAQD97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 11
 Dec 2006 04:23:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xMNi1V00C1kojtg0000000; Mon, 11 Dec 2006
 04:22:43 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A script to be driven when the user says "git add --interactive"
is introduced.

When it is run, first it runs its internal 'status' command to
show the current status, and then goes into its internactive
command loop.

The command loop shows the list of subcommands available, and
gives a prompt "What now> ".  In general, when the prompt ends
with a single '>', you can pick only one of the choices given
and type return, like this:

    *** Commands ***
      1: status       2: update       3: revert       4: add untracked
      5: patch        6: diff         7: quit         8: help
    What now> 1

You also could say "s" or "sta" or "status" above as long as the
choice is unique.

The main command loop has 6 subcommands (plus help and quit).

 * 'status' shows the change between HEAD and index (i.e. what
   will be committed if you say "git commit"), and between index
   and working tree files (i.e. what you could stage further
   before "git commit" using "git-add") for each path.  A sample
   output looks like this:

              staged     unstaged path
     1:       binary      nothing foo.png
     2:     +403/-35        +1/-1 git-add--interactive.perl

   It shows that foo.png has differences from HEAD (but that is
   binary so line count cannot be shown) and there is no
   difference between indexed copy and the working tree
   version (if the working tree version were also different,
   'binary' would have been shown in place of 'nothing').  The
   other file, git-add--interactive.perl, has 403 lines added
   and 35 lines deleted if you commit what is in the index, but
   working tree file has further modifications (one addition and
   one deletion).

 * 'update' shows the status information and gives prompt
   "Update>>".  When the prompt ends with double '>>', you can
   make more than one selection, concatenated with whitespace or
   comma.  Also you can say ranges.  E.g. "2-5 7,9" to choose
   2,3,4,5,7,9 from the list.  You can say '*' to choose
   everything.

   What you chose are then highlighted with '*', like this:

              staged     unstaged path
     1:       binary      nothing foo.png
   * 2:     +403/-35        +1/-1 git-add--interactive.perl

   To remove selection, prefix the input with - like this:

        Update>> -2

   After making the selection, answer with an empty line to
   stage the contents of working tree files for selected paths
   in the index.

 * 'revert' has a very similar UI to 'update', and the staged
   information for selected paths are reverted to that of the
   HEAD version.  Reverting new paths makes them untracked.

 * 'add untracked' has a very similar UI to 'update' and
   'revert', and lets you add untracked paths to the index.

 * 'patch' lets you choose one path out of 'status' like
   selection.  After choosing the path, it presents diff between
   the index and the working tree file and asks you if you want
   to stage the change of each hunk.  You can say:

        y - add the change from that hunk to index
        n - do not add the change from that hunk to index
        a - add the change from that hunk and all the rest to index
        d - do not the change from that hunk nor any of the rest to index
        j - do not decide on this hunk now, and view the next
            undecided hunk
        J - do not decide on this hunk now, and view the next hunk
        k - do not decide on this hunk now, and view the previous
            undecided hunk
        K - do not decide on this hunk now, and view the previous hunk

   After deciding the fate for all hunks, if there is any hunk
   that was chosen, the index is updated with the selected hunks.

 * 'diff' lets you review what will be committed (i.e. between
   HEAD and index).

This is still rough, but does everything except a few things I
think are needed.

 * 'patch' should be able to allow splitting a hunk into
   multiple hunks.

 * 'patch' does not adjust the line offsets @@ -k,l +m,n @@
   in the hunk header.  This does not have major problem in
   practice, but it _should_ do the adjustment.

 * It does not have any explicit support for a merge in
   progress; it may not work at all.

As is any of my initial WIP, the UI of this presents what it
does in a horribly crappy way.  Improvement patches are
appreciated, but wishlist without code are not really...

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore                |    1 +
 Makefile                  |    1 +
 builtin-add.c             |   15 ++
 git-add--interactive.perl |  534 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 551 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7f2cd55..edf93a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@ GIT-CFLAGS
 GIT-VERSION-FILE
 git
 git-add
+git-add--interactive
 git-am
 git-annotate
 git-apply
diff --git a/Makefile b/Makefile
index a1861de..cdd4bf0 100644
--- a/Makefile
+++ b/Makefile
@@ -174,6 +174,7 @@ SCRIPT_SH = \
 	git-lost-found.sh git-quiltimport.sh
 
 SCRIPT_PERL = \
+	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rerere.perl \
 	git-cvsserver.perl \
diff --git a/builtin-add.c b/builtin-add.c
index febb75e..37a236e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "dir.h"
+#include "exec_cmd.h"
 #include "cache-tree.h"
 
 static const char builtin_add_usage[] =
@@ -89,6 +90,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int verbose = 0, show_only = 0;
 	const char **pathspec;
 	struct dir_struct dir;
+	int add_interactive = 0;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp("--interactive", argv[i]))
+			add_interactive++;
+	}
+	if (add_interactive) {
+		const char *args[] = { "add--interactive", NULL };
+
+		if (add_interactive != 1 || argc != 2)
+			die("add --interactive does not take any parameters");
+		execv_git_cmd(args);
+		exit(1);
+	}
 
 	git_config(git_default_config);
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
new file mode 100755
index 0000000..7b42308
--- /dev/null
+++ b/git-add--interactive.perl
@@ -0,0 +1,534 @@
+#!/usr/bin/perl -w
+
+use strict;
+
+sub run_cmd_pipe {
+	my $fh = undef;
+	open($fh, '-|', @_) or die;
+	return <$fh>;
+}
+
+my ($GIT_DIR) = run_cmd_pipe(qw(git rev-parse --git-dir));
+
+if (!defined $GIT_DIR) {
+	exit(1); # rev-parse would have already said "not a git repo"
+}
+chomp($GIT_DIR);
+
+sub refresh {
+	system('git update-index --refresh 2>/dev/null');
+}
+
+sub list_untracked {
+	map {
+		chomp $_;
+		$_;
+	}
+	run_cmd_pipe(qw(git ls-files --others
+			--exclude-per-directory=.gitignore),
+		     "--exclude-from=$GIT_DIR/info/exclude",
+		     '--', @_);
+}
+
+my $status_fmt = '%12s %12s %s';
+my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
+
+# Returns list of five tuples:
+# 0: print message
+# 1: pathname
+# 2: add/del between HEAD and index
+# 3: add/del between index and working tree
+# 4: binary
+sub list_modified {
+	my ($only) = @_;
+	my (%data, @return);
+	my ($add, $del, $adddel, $file);
+
+	if (!$only || ($only eq 'index-only')) {
+		for (run_cmd_pipe(qw(git diff-index --cached
+				     --numstat --summary HEAD))) {
+			if (($add, $del, $file) =
+			    /^([-\d]+)	([-\d]+)	(.*)/) {
+				my ($change, $bin);
+				if ($add eq '-' && $del eq '-') {
+					$change = 'binary';
+					$bin = 1;
+				}
+				else {
+					$change = "+$add/-$del";
+				}
+				$data{$file} =
+				    [$change, 'nothing', undef, undef, $bin];
+			}
+			elsif (($adddel, $file) =
+			       /^ (create|delete) mode [0-7]+ (.*)$/) {
+				$data{$file}[2] = $adddel;
+			}
+		}
+	}
+
+	if (!$only || ($only eq 'file-only')) {
+		for (run_cmd_pipe(qw(git diff-files --numstat --summary))) {
+			if (($add, $del, $file) =
+			    /^([-\d]+)	([-\d]+)	(.*)/) {
+				if (!exists $data{$file}) {
+					$data{$file} =
+					    ['unchanged', undef, undef, undef];
+				}
+				my ($change, $bin);
+				if ($add eq '-' && $del eq '-') {
+					$change = 'binary';
+					$bin = 1;
+				}
+				else {
+					$change = "+$add/-$del";
+				}
+				$data{$file}[1] = $change;
+				if ($bin) {
+					$data{$file}[4] = 1;
+				}
+			}
+			elsif (($adddel, $file) =
+			       /^ (create|delete) mode [0-7]+ (.*)$/) {
+				$data{$file}[3] = $adddel;
+			}
+		}
+	}
+
+	for (sort keys %data) {
+		my $it = $data{$_};
+		push @return, [(sprintf $status_fmt, @{$it}[0,1], $_), $_,
+			       @{$it}[2,3,4]];
+	}
+	return @return;
+}
+
+
+sub find_unique {
+	my ($string, @stuff) = @_;
+	my $found = undef;
+	for (my $i = 0; $i < @stuff; $i++) {
+		my $it = $stuff[$i];
+		my $hit = undef;
+		if (ref $it) { $it = $it->[0]; }
+		eval {
+			if ($it =~ /^$string/) {
+				$hit = 1;
+			};
+		};
+		if (defined $hit && defined $found) {
+			return undef;
+		}
+		if ($hit) {
+			$found = $i + 1;
+		}
+	}
+	return $found;
+}
+
+sub list_and_choose {
+	my ($opts, @stuff) = @_;
+	my (@chosen, @return);
+	my $i;
+
+      TOPLOOP:
+	while (1) {
+		my $last_lf = 0;
+
+		if ($opts->{HEADER}) {
+			if (!$opts->{LIST_FLAT}) {
+				print "     ";
+			}
+			print "$opts->{HEADER}\n";
+		}
+		for ($i = 0; $i < @stuff; $i++) {
+			my $chosen = $chosen[$i] ? '*' : ' ';
+			my $print = $stuff[$i];
+			if (ref $print) {
+				$print = $print->[0];
+			}
+			printf("%s%2d: %s", $chosen, $i+1, $print);
+			if (($opts->{LIST_FLAT}) &&
+			    (($i + 1) % ($opts->{LIST_FLAT}))) {
+				print "\t";
+				$last_lf = 0;
+			}
+			else {
+				print "\n";
+				$last_lf = 1;
+			}
+		}
+		if (!$last_lf) {
+			print "\n";
+		}
+
+		return if ($opts->{LIST_ONLY});
+
+		print $opts->{PROMPT};
+		if ($opts->{SINGLETON}) {
+			print "> ";
+		}
+		else {
+			print ">> ";
+		}
+		my $line = <STDIN>;
+		last if (!$line);
+		chomp $line;
+		my $donesomething = 0;
+		for my $choice (split(/[\s,]+/, $line)) {
+			my $choose = 1;
+			my ($bottom, $top);
+
+			# Input that begins with '-'; unchoose
+			if ($choice =~ s/^-//) {
+				$choose = 0;
+			}
+			# A range can be specified like 5-7
+			if ($choice =~ /^(\d+)-(\d+)$/) {
+				($bottom, $top) = ($1, $2);
+			}
+			elsif ($choice =~ /^\d+$/) {
+				$bottom = $top = $choice;
+			}
+			elsif ($choice eq '*') {
+				$bottom = 1;
+				$top = 1 + @stuff;
+			}
+			else {
+				$bottom = $top = find_unique($choice, @stuff);
+				if (!defined $bottom) {
+					print "Huh ($choice)?\n";
+					next TOPLOOP;
+				}
+			}
+			if ($opts->{SINGLETON} && $bottom != $top) {
+				print "Huh ($choice)?\n";
+				next TOPLOOP;
+			}
+			for ($i = $bottom-1; $i <= $top-1; $i++) {
+				next if (@stuff <= $i);
+				$chosen[$i] = $choose;
+				$donesomething++;
+			}
+		}
+		last if (!$donesomething || $opts->{IMMEDIATE});
+	}
+	for ($i = 0; $i < @stuff; $i++) {
+		if ($chosen[$i]) {
+			push @return, $stuff[$i];
+		}
+	}
+	return @return;
+}
+
+sub status_cmd {
+	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
+			list_modified());
+	print "\n";
+}
+
+sub say_n_paths {
+	my $did = shift @_;
+	my $cnt = scalar @_;
+	print "$did ";
+	if (1 < $cnt) {
+		print "$cnt paths\n";
+	}
+	else {
+		print "one path\n";
+	}
+}
+
+sub update_cmd {
+	my @mods = list_modified('file-only');
+	return if (!@mods);
+
+	my @update = list_and_choose({ PROMPT => 'Update',
+				       HEADER => $status_head, },
+				     @mods);
+	if (@update) {
+		system(qw(git update-index --add --), map { $_->[1] } @update);
+		say_n_paths('updated', @update);
+	}
+	print "\n";
+}
+
+sub revert_cmd {
+	my @update = list_and_choose({ PROMPT => 'Revert',
+				       HEADER => $status_head, },
+				     list_modified());
+	if (@update) {
+		my @lines = run_cmd_pipe(qw(git ls-tree HEAD --),
+					 map { $_->[1] } @update);
+		my $fh;
+		open $fh, '|-', qw(git update-index --index-info)
+		    or die;
+		for (@lines) {
+			print $fh $_;
+		}
+		close($fh);
+		for (@update) {
+			if ($_->[2] && $_->[2] eq 'create') {
+				system(qw(git update-index --force-remove --),
+				       $_->[1]);
+				print "note: $_->[1] is untracked now.\n";
+			}
+		}
+		refresh();
+		say_n_paths('reverted', @update);
+	}
+	print "\n";
+}
+
+sub add_untracked_cmd {
+	my @add = list_and_choose({ PROMPT => 'Add untracked' },
+				  list_untracked());
+	if (@add) {
+		system(qw(git update-index --add --), @add);
+		say_n_paths('added', @add);
+	}
+	print "\n";
+}
+
+sub parse_diff {
+	my ($path) = @_;
+	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	my (@hunk) = { TEXT => [] };
+
+	for (@diff) {
+		if (/^@@ /) {
+			push @hunk, { TEXT => [] };
+		}
+		push @{$hunk[-1]{TEXT}}, $_;
+	}
+	return @hunk;
+}
+
+sub help_patch_cmd {
+	print <<\EOF ;
+y - stage this hunk
+n - do not stage this hunk
+a - stage this and all the remaining hunks
+d - do not stage this hunk nor any of the remaining hunks
+j - leave this hunk undecided, see next undecided hunk
+J - leave this hunk undecided, see next hunk
+k - leave this hunk undecided, see previous undecided hunk
+K - leave this hunk undecided, see previous hunk
+EOF
+}
+
+sub patch_update_cmd {
+	my @mods = list_modified('file-only');
+	@mods = grep { !($_->[4]) } @mods;
+	return if (!@mods);
+
+	my ($it) = list_and_choose({ PROMPT => 'Patch update',
+				     SINGLETON => 1,
+				     IMMEDIATE => 1,
+				     HEADER => $status_head, },
+				   @mods);
+	return if (!$it);
+
+	my ($ix, $num);
+	my $path = $it->[1];
+	my ($head, @hunk) = parse_diff($path);
+	for (@{$head->{TEXT}}) {
+		print;
+	}
+	$num = scalar @hunk;
+	$ix = 0;
+
+	while (1) {
+		my ($prev, $next, $other, $undecided);
+		$other = '';
+
+		if ($num <= $ix) {
+			$ix = 0;
+		}
+		for (my $i = 0; $i < $ix; $i++) {
+			if (!defined $hunk[$i]{USE}) {
+				$prev = 1;
+				$other .= '/k';
+				last;
+			}
+		}
+		if ($ix) {
+			$other .= '/K';
+		}
+		for (my $i = $ix + 1; $i < $num; $i++) {
+			if (!defined $hunk[$i]{USE}) {
+				$next = 1;
+				$other .= '/j';
+				last;
+			}
+		}
+		if ($ix < $num - 1) {
+			$other .= '/J';
+		}
+		for (my $i = 0; $i < $num; $i++) {
+			if (!defined $hunk[$i]{USE}) {
+				$undecided = 1;
+				last;
+			}
+		}
+		last if (!$undecided);
+
+		for (@{$hunk[$ix]{TEXT}}) {
+			print;
+		}
+		print "Stage this hunk [y/n/a/d$other/?]? ";
+		my $line = <STDIN>;
+		if ($line) {
+			if ($line =~ /^y/i) {
+				$hunk[$ix]{USE} = 1;
+			}
+			elsif ($line =~ /^n/i) {
+				$hunk[$ix]{USE} = 0;
+			}
+			elsif ($line =~ /^a/i) {
+				while ($ix < $num) {
+					if (!defined $hunk[$ix]{USE}) {
+						$hunk[$ix]{USE} = 1;
+					}
+					$ix++;
+				}
+				next;
+			}
+			elsif ($line =~ /^d/i) {
+				while ($ix < $num) {
+					if (!defined $hunk[$ix]{USE}) {
+						$hunk[$ix]{USE} = 0;
+					}
+					$ix++;
+				}
+				next;
+			}
+			elsif ($other =~ /K/ && $line =~ /^K/) {
+				$ix--;
+				next;
+			}
+			elsif ($other =~ /J/ && $line =~ /^J/) {
+				$ix++;
+				next;
+			}
+			elsif ($other =~ /k/ && $line =~ /^k/) {
+				while (1) {
+					$ix--;
+					last if (!$ix ||
+						 !defined $hunk[$ix]{USE});
+				}
+				next;
+			}
+			elsif ($other =~ /j/ && $line =~ /^j/) {
+				while (1) {
+					$ix++;
+					last if ($ix >= $num ||
+						 !defined $hunk[$ix]{USE});
+				}
+				next;
+			}
+			else {
+				help_patch_cmd($other);
+				next;
+			}
+			# soft increment
+			while (1) {
+				$ix++;
+				last if ($ix >= $num ||
+					 !defined $hunk[$ix]{USE});
+			}
+		}
+	}
+
+	my ($o_lno, $n_lno);
+	my @result = ();
+	for (@hunk) {
+		my $text = $_->{TEXT};
+		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
+		    $text->[0] =~ /^@@ -(\d+)(?:,(\d+)) \+(\d+)(?:,(\d+)) @@/;
+		if (!$_->{USE}) {
+			# Adjust offset here.
+			next;
+		}
+		else {
+			for (@$text) {
+				push @result, $_;
+			}
+		}
+	}
+
+	if (@result) {
+		my $fh;
+
+		open $fh, '|-', qw(git apply --cached);
+		for (@{$head->{TEXT}}, @result) {
+			print $fh $_;
+		}
+		close $fh;
+		refresh();
+	}
+
+	print "\n";
+}
+
+sub diff_cmd {
+	my @mods = list_modified('index-only');
+	@mods = grep { !($_->[4]) } @mods;
+	return if (!@mods);
+	my ($it) = list_and_choose({ PROMPT => 'Review diff',
+				     SINGLETON => 1,
+				     IMMEDIATE => 1,
+				     HEADER => $status_head, },
+				   @mods);
+	return if (!$it);
+	system(qw(git diff-index -p --cc --cached HEAD --), $it->[1]);
+}
+
+sub quit_cmd {
+	print "Bye.\n";
+	exit(0);
+}
+
+sub help_cmd {
+	print <<\EOF ;
+status        - show paths with changes
+update        - add working tree state to the staged set of changes
+revert        - revert staged set of changes back to the HEAD version
+patch         - pick hunks and update selectively
+diff	      - view diff between HEAD and index
+add untracked - add contents of untracked files to the staged set of changes
+EOF
+}
+
+sub main_loop {
+	my @cmd = ([ 'status', \&status_cmd, ],
+		   [ 'update', \&update_cmd, ],
+		   [ 'revert', \&revert_cmd, ],
+		   [ 'add untracked', \&add_untracked_cmd, ],
+		   [ 'patch', \&patch_update_cmd, ],
+		   [ 'diff', \&diff_cmd, ],
+		   [ 'quit', \&quit_cmd, ],
+		   [ 'help', \&help_cmd, ],
+	);
+	while (1) {
+		my ($it) = list_and_choose({ PROMPT => 'What now',
+					     SINGLETON => 1,
+					     LIST_FLAT => 4,
+					     HEADER => '*** Commands ***',
+					     IMMEDIATE => 1 }, @cmd);
+		if ($it) {
+			eval {
+				$it->[1]->();
+			};
+			if ($@) {
+				print "$@";
+			}
+		}
+	}
+}
+
+my @z;
+
+refresh();
+status_cmd();
+main_loop();
-- 
1.4.4.2.gdfd96

