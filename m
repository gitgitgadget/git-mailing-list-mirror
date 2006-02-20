From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Mon, 20 Feb 2006 05:46:09 -0500
Message-ID: <11404323692193-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB8Yq-0005GM-4z
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 11:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWBTKq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWBTKq3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 05:46:29 -0500
Received: from mail.autoweb.net ([198.172.237.26]:15268 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S964868AbWBTKq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 05:46:28 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FB8Yk-0007CY-Cl; Mon, 20 Feb 2006 05:46:28 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FB8Ye-0007yw-FT; Mon, 20 Feb 2006 05:46:20 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FB8YT-00066a-Ru; Mon, 20 Feb 2006 05:46:09 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16477>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

(Pull from http://h4x0r5.com/~ryan/git/ryan.git/ annotate-upstream )

I'm pretty sure this version (finally) gets the edge cases correct.

I would appreciate some other testing on this, as I can't find a case
where it falls down, but the files with a lot of history tend to have a
lot of lines, making them hard to spotcheck without having been an
intimate part of that history.

Oh, this is the "functional" version, but it might not qualify as "nice
looking" yet, pleaes, feel free to complain.

 Makefile          |    1 
 git-annotate.perl |  321 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100755 git-annotate.perl

107045e8abb674a66ee7c682dd85a3d303f26e3c
diff --git a/Makefile b/Makefile
index 317be3c..86ffcf4 100644
--- a/Makefile
+++ b/Makefile
@@ -119,6 +119,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-fmt-merge-msg.perl git-rerere.perl \
+	git-annotate.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
diff --git a/git-annotate.perl b/git-annotate.perl
new file mode 100755
index 0000000..8f98431
--- /dev/null
+++ b/git-annotate.perl
@@ -0,0 +1,321 @@
+#!/usr/bin/perl
+# Copyright 2006, Ryan Anderson <ryan@michonline.com>
+#
+# GPL v2 (See COPYING)
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus Torvalds.
+
+use warnings;
+use strict;
+
+my $filename = shift @ARGV;
+
+
+my @stack = (
+	{
+		'rev' => "HEAD",
+		'filename' => $filename,
+	},
+);
+
+our (@lineoffsets, @pendinglineoffsets);
+our @filelines = ();
+open(F,"<",$filename)
+	or die "Failed to open filename: $!";
+
+while(<F>) {
+	chomp;
+	push @filelines, $_;
+}
+close(F);
+our $leftover_lines = @filelines;
+our %revs;
+our @revqueue;
+our $head;
+
+my $revsprocessed = 0;
+while (my $bound = pop @stack) {
+	my @revisions = git_rev_list($bound->{'rev'}, $bound->{'filename'});
+	foreach my $revinst (@revisions) {
+		my ($rev, @parents) = @$revinst;
+		$head ||= $rev;
+
+		$revs{$rev}{'filename'} = $bound->{'filename'};
+		if (scalar @parents > 0) {
+			$revs{$rev}{'parents'} = \@parents;
+			next;
+		}
+
+		my $newbound = find_parent_renames($rev, $bound->{'filename'});
+		if ( exists $newbound->{'filename'} && $newbound->{'filename'} ne $bound->{'filename'}) {
+			push @stack, $newbound;
+			$revs{$rev}{'parents'} = [$newbound->{'rev'}];
+		}
+	}
+}
+push @revqueue, $head;
+init_claim($head);
+$revs{$head}{'lineoffsets'} = {};
+handle_rev();
+
+
+my $i = 0;
+foreach my $l (@filelines) {
+	my ($output, $rev, $committer, $date);
+	if (ref $l eq 'ARRAY') {
+		($output, $rev, $committer, $date) = @$l;
+		if (length($rev) > 8) {
+			$rev = substr($rev,0,8);
+		}
+	} else {
+		$output = $l;
+		($rev, $committer, $date) = ('unknown', 'unknown', 'unknown');
+	}
+
+	printf("(%8s %10s %10s %d)%s\n", $rev, $committer, $date, $i++, $output);
+}
+
+sub init_claim {
+	my ($rev) = @_;
+	my %revinfo = git_commit_info($rev);
+	for (my $i = 0; $i < @filelines; $i++) {
+		$filelines[$i] = [ $filelines[$i], '', '', '', 1];
+			# line,
+			# rev,
+			# author,
+			# date,
+			# 1 <-- belongs to the original file.
+	}
+	$revs{$rev}{'lines'} = \@filelines;
+}
+
+
+sub handle_rev {
+	my $i = 0;
+	while (my $rev = shift @revqueue) {
+
+		my %revinfo = git_commit_info($rev);
+
+		foreach my $p (@{$revs{$rev}{'parents'}}) {
+
+			git_diff_parse($p, $rev, %revinfo);
+			push @revqueue, $p;
+		}
+
+
+		if (scalar @{$revs{$rev}{parents}} == 0) {
+			# We must be at the initial rev here, so claim everything that is left.
+			for (my $i = 0; $i < @{$revs{$rev}{lines}}; $i++) {
+				if (ref ${$revs{$rev}{lines}}[$i] eq '' || ${$revs{$rev}{lines}}[$i][1] eq '') {
+					claim_line($i, $rev, $revs{$rev}{lines}, %revinfo);
+				}
+			}
+		}
+	}
+}
+
+
+sub git_rev_list {
+	my ($rev, $file) = @_;
+
+	open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)
+		or die "Failed to exec git-rev-list: $!";
+
+	my @revs;
+	while(my $line = <P>) {
+		chomp $line;
+		my ($rev, @parents) = split /\s+/, $line;
+		push @revs, [ $rev, @parents ];
+	}
+	close(P);
+
+	printf("0 revs found for rev %s (%s)\n", $rev, $file) if (@revs == 0);
+	return @revs;
+}
+
+sub find_parent_renames {
+	my ($rev, $file) = @_;
+
+	open(P,"-|","git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
+		or die "Failed to exec git-diff: $!";
+
+	local $/ = "\0";
+	my %bound;
+	my $junk = <P>;
+	while (my $change = <P>) {
+		chomp $change;
+		my $filename = <P>;
+		chomp $filename;
+
+		if ($change =~ m/^[AMD]$/ ) {
+			next;
+		} elsif ($change =~ m/^R/ ) {
+			my $oldfilename = $filename;
+			$filename = <P>;
+			chomp $filename;
+			if ( $file eq $filename ) {
+				my $parent = git_find_parent($rev, $oldfilename);
+				@bound{'rev','filename'} = ($parent, $oldfilename);
+				last;
+			}
+		}
+	}
+	close(P);
+
+	return \%bound;
+}
+
+
+sub git_find_parent {
+	my ($rev, $filename) = @_;
+
+	open(REVPARENT,"-|","git-rev-list","--remove-empty", "--parents","--max-count=1","$rev","--",$filename)
+		or die "Failed to open git-rev-list to find a single parent: $!";
+
+	my $parentline = <REVPARENT>;
+	chomp $parentline;
+	my ($revfound,$parent) = split m/\s+/, $parentline;
+
+	close(REVPARENT);
+
+	return $parent;
+}
+
+
+# Get a diff between the current revision and a parent.
+# Record the commit information that results.
+sub git_diff_parse {
+	my ($parent, $rev, %revinfo) = @_;
+
+	my ($ri, $pi) = (0,0);
+	open(DIFF,"-|","git-diff-tree","-M","-p",$rev,$parent,"--",
+			$revs{$rev}{'filename'}, $revs{$parent}{'filename'})
+		or die "Failed to call git-diff for annotation: $!";
+
+	my $slines = $revs{$rev}{'lines'};
+	my @plines;
+
+	my $gotheader = 0;
+	my ($remstart, $remlength, $addstart, $addlength);
+	my ($hunk_start, $hunk_index, $hunk_adds);
+	while(<DIFF>) {
+		chomp;
+		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
+			($remstart, $remlength, $addstart, $addlength) = ($1, $2, $3, $4);
+			# Adjust for 0-based arrays
+			$remstart--;
+			$addstart--;
+			# Reinit hunk tracking.
+			$hunk_start = $remstart;
+			$hunk_index = 0;
+			$gotheader = 1;
+
+			for (my $i = $ri; $i < $remstart; $i++) {
+				$plines[$pi++] = $slines->[$i];
+				$ri++;
+			}
+			next;
+		} elsif (!$gotheader) {
+			next;
+		}
+
+		if (m/^\+(.*)$/) {
+			my $line = $1;
+			$plines[$pi++] = [ $line, '', '', '', 0 ];
+			next;
+
+		} elsif (m/^-(.*)$/) {
+			my $line = $1;
+			if (get_line($slines, $ri) eq $line) {
+				# Found a match, claim
+				claim_line($ri, $rev, $slines, %revinfo);
+			} else {
+				die sprintf("Sync error: %d/%d\n|%s\n|%s\n%s => %s\n",
+						$ri, $hunk_start + $hunk_index,
+						$line,
+						get_line($slines, $ri),
+						$rev, $parent);
+			}
+			$ri++;
+
+		} else {
+			if (substr($_,1) ne get_line($slines,$ri) ) {
+				die sprintf("Line %d (%d) does not match:\n|%s\n|%s\n%s => %s\n",
+						$hunk_start + $hunk_index, $ri,
+						substr($_,1),
+						get_line($slines,$ri),
+						$rev, $parent);
+			}
+			$plines[$pi++] = $slines->[$ri++];
+		}
+		$hunk_index++;
+	}
+	close(DIFF);
+	for (my $i = $ri; $i < @{$slines} ; $i++) {
+		push @plines, $slines->[$ri++];
+	}
+
+	$revs{$parent}{lines} = \@plines;
+	return;
+}
+
+sub get_line {
+	my ($lines, $index) = @_;
+
+	return ref $lines->[$index] ne '' ? $lines->[$index][0] : $lines->[$index];
+}
+
+sub git_cat_file {
+	my ($parent, $filename) = @_;
+	return () unless defined $parent && defined $filename;
+	my $blobline = `git-ls-tree $parent $filename`;
+	my ($mode, $type, $blob, $tfilename) = split(/\s+/, $blobline, 4);
+
+	open(C,"-|","git-cat-file", "blob", $blob)
+		or die "Failed to git-cat-file blob $blob (rev $parent, file $filename): " . $!;
+
+	my @lines;
+	while(<C>) {
+		chomp;
+		push @lines, $_;
+	}
+	close(C);
+
+	return @lines;
+}
+
+
+sub claim_line {
+	my ($floffset, $rev, $lines, %revinfo) = @_;
+	my $oline = get_line($lines, $floffset);
+	@{$lines->[$floffset]} = ( $oline, $rev,
+		$revinfo{'author'}, $revinfo{'author_date'} );
+	#printf("Claiming line %d with rev %s: '%s'\n",
+	#		$floffset, $rev, $oline) if 1;
+}
+
+sub git_commit_info {
+	my ($rev) = @_;
+	open(COMMIT, "-|","git-cat-file", "commit", $rev)
+		or die "Failed to call git-cat-file: $!";
+
+	my %info;
+	while(<COMMIT>) {
+		chomp;
+		last if (length $_ == 0);
+
+		if (m/^author (.*) <(.*)> (.*)$/) {
+			$info{'author'} = $1;
+			$info{'author_email'} = $2;
+			$info{'author_date'} = $3;
+		} elsif (m/^committer (.*) <(.*)> (.*)$/) {
+			$info{'committer'} = $1;
+			$info{'committer_email'} = $2;
+			$info{'committer_date'} = $3;
+		}
+	}
+	close(COMMIT);
+
+	return %info;
+}
-- 
1.2.2.gb342
