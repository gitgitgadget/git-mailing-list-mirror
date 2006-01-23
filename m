From: Ryan Anderson <ryan@michonline.com>
Subject: [RFC] 1st pass at git-annotate (not-quite functional, however)
Date: Mon, 23 Jan 2006 03:05:33 -0500
Message-ID: <20060123080532.GD19212@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jan 23 09:06:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0wiY-0001zW-9o
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 09:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWAWIGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 03:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWAWIGX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 03:06:23 -0500
Received: from mail.autoweb.net ([198.172.237.26]:39905 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751409AbWAWIGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 03:06:22 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F0wiR-0004lm-Aa; Mon, 23 Jan 2006 03:06:21 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F0wiL-0003qS-NK; Mon, 23 Jan 2006 03:06:18 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F0wi1-00045k-AB; Mon, 23 Jan 2006 03:05:53 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15080>


Here's my stab at getting git-annotate working.  This requires the
--remove-empty addition to git-rev-list Linus sent out a few days ago.

This code is not complete, but on my test case (git-format-mbox.sh) it
does track through renames, and does figure out authorship of about half
the lines (rough guess).

I have learned that parsing an arbritrary length series of diffs is
hard, mostly because trying to infer line numbers from them is tricky
(especially when you contemplate tracking state down multiple merges
at once.)

I currently have a very naive approach of tracking offsets in here,
built as the diff is parsed.  I know it's wrong, but it's not too wrong,
if you ignore merges.

I haven't figured out exactly how I want to handle annotating across
merges, but I think the general idea I have here will work, it just
needs to be ripped out of global variables and stuck into some
structures that get passed around/split/merged up/etc.

I'm posting this tonight because I won't have time to look at this again
for a few days (probably the weekend), and someone else might see a way
to make this work a bit easier.

Without further ado, git-annotate:


 Makefile          |    2 
 git-annotate.perl |  309 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 310 insertions(+), 1 deletions(-)
 create mode 100755 git-annotate.perl

df7b8b7bf682411485aefa31c6dc24a4b8adf316
diff --git a/Makefile b/Makefile
index 6517204..505b353 100644
--- a/Makefile
+++ b/Makefile
@@ -118,7 +118,7 @@ SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-fmt-merge-msg.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
-	git-graft-ripple.perl
+	git-graft-ripple.perl git-annotate.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-annotate.perl b/git-annotate.perl
new file mode 100755
index 0000000..044828f
--- /dev/null
+++ b/git-annotate.perl
@@ -0,0 +1,309 @@
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
+use Data::Dumper;
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
+my @filelines = ();
+open(F,"<",$filename)
+	or die "Failed to open filename: $!";
+
+while(<F>) {
+	chomp;
+	push @filelines, $_;
+}
+close(F);
+
+my $revsprocessed = 0;
+W: while (my $bound = pop @stack) {
+	my @revisions = git_rev_list($bound->{'rev'}, $bound->{'filename'});
+	foreach my $revinst (@revisions) {
+		my ($rev, @parents) = @$revinst;
+		#last W if $revsprocessed++ > 3;
+
+		if (scalar @parents > 0) {
+			git_diff_parse($parents[0], $rev, $bound->{'filename'});
+			next;
+		}
+
+		printf("Boundary = %s\n", $rev);
+		my $newbound = find_parent_renames($rev, $bound->{'filename'});
+		if ( exists $newbound->{'filename'} && $newbound->{'filename'} ne $bound->{'filename'}) {
+			push @stack, $newbound;
+		}
+	}
+}
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
+		($rev, $committer, $date) = ('unknonw', 'unknown', 'unknown');
+	}
+
+	printf("(%8s %10s %10s %d)%s\n", $rev, $committer, $date, $i++, $output);
+}
+
+#print Data::Dumper->Dump([\@lineoffsets],[qw(*lineoffsets)]);
+
+
+sub git_rev_list {
+	my ($rev, $file) = @_;
+	#printf("grl = %s, %s\n", $rev, $file);
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
+	return @revs;
+}
+
+sub find_parent_renames {
+	my ($rev, $file) = @_;
+
+	open(P,"-|","git-diff", "-r","--name-status", "-z","$rev^1..$rev")
+		or die "Failed to exec git-diff: $!";
+
+	local $/ = "\0";
+	my %bound;
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
+				my $parent = git_find_parent($rev);
+				#printf("Found rename at boundary: %s-%s, %s\n", $rev, $parent, $oldfilename);
+				@bound{'rev','filename'} = ($parent, $oldfilename);
+
+				last;
+			} else {
+				#printf("Found unknown rename of %s => %s\n", $oldfilename, $filename);
+			}
+		} else {
+			#printf("Unknown name-status type of '%s'\n", $change);
+		}
+
+
+
+	}
+	close(P);
+
+	return \%bound;
+}
+
+
+sub git_find_parent {
+	my ($rev) = @_;
+
+	open(REVPARENT,"-|","git-rev-list","--parents","$rev^1..$rev")
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
+	my ($parent, $rev, $filename) = @_;
+
+	my %revinfo = git_commit_info($rev);
+
+	# To make this slightly simpler, we're going to do things backwards.
+	# git-diff $rev..$parent gets us line numbers that pertain to $rev, not
+	# $parent, and we can work with those easier than the reverse.
+	open(DIFF,"-|","git-diff","$rev..$parent",$filename)
+		or die "Failed to call git-diff for annotation: $!";
+
+	my ($gotheader) = (0);
+	my ($remstart, $remlength, $addstart, $addlength);
+	my ($hunk_actual_start, $hunk_index, $hunk_adds);
+	while(<DIFF>) {
+		print;
+		if (m/^@@ -(\d+),(\d+) \+(\d+),(\d+)/) {
+			if (0 && $gotheader) {
+				print "Filelines had:\n";
+				for (my $i = $remstart ; $i < $remstart + $remlength; $i++) {
+					print $filelines[$i];
+
+				}
+				print "===================================\n";
+			}
+			($remstart, $remlength, $addstart, $addlength) = ($1, $2, $3, $4);
+			# Adjust for 0-based arrays
+			$remstart--;
+			$addstart--;
+
+			# Record (but don't put into use right away) these offsets.
+			insert_into_lineoffsets( $remstart + $remlength, $remlength - $addlength );
+			$hunk_index = 0;
+			$hunk_adds = 0;
+			$hunk_actual_start = find_actual_start($remstart);
+			$gotheader = 1;
+			next;
+		} elsif (!$gotheader) {
+			next;
+		}
+
+		if (m/^\+/) {
+			next;
+
+		} elsif (m/^-(.*)$/) {
+			my $line = $1;
+			my $floffset = $hunk_actual_start + $hunk_index;
+
+			printf("\tline = %s\n\tfilelines entry = %s*\thas = %d, hi = %d\n",
+				$line, $filelines[$floffset],
+				$hunk_actual_start, $hunk_index) if 0;
+
+			if (ref $filelines[$floffset] eq '' && $filelines[$floffset] eq $line) {
+				my $oline = $filelines[$floffset];
+				$filelines[$floffset] =
+					[ $oline, $rev, $revinfo{'committer'}, $revinfo{'committer_date'} ];
+			}
+		}
+
+		$hunk_index++;
+	}
+	close(DIFF);
+
+	# Store these offsets for use when processing the next diff.
+	sync_line_offsets();
+}
+
+sub insert_into_lineoffsets {
+	my ($start, $offset) = @_;
+
+	push @pendinglineoffsets, [$start, $offset];
+
+}
+
+sub sync_line_offsets {
+	check_line_offsets(0);
+	#print Data::Dumper->Dump([\@pendinglineoffsets],[qw(*pending)]);
+	foreach my $o (@pendinglineoffsets) {
+		_insert_into_lineoffsets($$o[0],$$o[1]);
+	}
+	@pendinglineoffsets = ();
+
+	#print Data::Dumper->Dump([\@lineoffsets], [qw(*lineoffsets)]);
+	check_line_offsets(1);
+
+	if (defined $lineoffsets[0] && !defined $lineoffsets[0][0]) {
+		shift @lineoffsets;
+	}
+}
+
+sub check_line_offsets {
+	my $v = shift;
+	for(my $i = 0; $i < @lineoffsets; $i++) {
+		warn "lineoffsets[$i] undef at $v" if (!defined $lineoffsets[$i]);
+		warn "lineoffsets[$i][0] undef at $v" if (!defined $lineoffsets[$i][0]);
+	}
+}
+
+my $calls_to_lineoffsets = 1;
+sub _insert_into_lineoffsets {
+	my ($start, $offset) = @_;
+	#warn sprintf("lineoffsets has %d elements (%d)", scalar @lineoffsets, $calls_to_lineoffsets++);
+
+	if (@lineoffsets == 0) {
+		push @lineoffsets, [ $start, $offset ];
+		return;
+	}
+
+	# replace this with a binary search later ## FIXME ##
+	my $i = 0;
+	while ($i < @lineoffsets && $start < $lineoffsets[$i][0]) {
+		$i++;
+	}
+
+	if ($i < @lineoffsets && $start == $lineoffsets[$i][0]) {
+		$lineoffsets[$i][1] += $offset;
+	} else {
+		push @lineoffsets, [ $start, $offset ];
+		@lineoffsets = sort { $a->[0] <=> $b->[0] } @lineoffsets;
+	}
+}
+
+sub find_actual_start {
+	my ($start) = @_;
+	my $offset = 0;
+
+	for(my $i = 0; $i < @lineoffsets && $start < $lineoffsets[$i][0] ; $i++) {
+		$offset += $lineoffsets[$i][1];
+	}
+
+	printf("hunk_actual_start = %d (%d + %d)\n", $start + $offset, $start, $offset);
+	return $start + $offset;
+}
+
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
1.1.4.g31e9b


-- 

Ryan Anderson
  sometimes Pug Majere
