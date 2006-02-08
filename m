From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 09:52:55 -0500
Message-ID: <11394103753694-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 15:57:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6qgx-0004ni-3f
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 15:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWBHOxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWBHOxG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 09:53:06 -0500
Received: from mail.autoweb.net ([198.172.237.26]:41879 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1030419AbWBHOxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 09:53:05 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F6qgk-0003dv-T8; Wed, 08 Feb 2006 09:53:00 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F6qgi-0006PX-Or; Wed, 08 Feb 2006 09:52:58 -0500
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan.michonline.com with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F6qgi-0003oJ-4g; Wed, 08 Feb 2006 09:52:56 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15736>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

I think this version is mostly ready to go.

Junio, the post you pointed me at was very helpful (once I got around to
listening to it), but the code it links to is missing - if that's a
better partial implementation than this, can you ressurrect it
somewhere?  I'd be happy to reintegrate it together.

 Makefile          |    1 
 git-annotate.perl |  291 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 0 deletions(-)
 create mode 100755 git-annotate.perl

86fa163e7fd1bee2929b7946456407dbc7745193
diff --git a/Makefile b/Makefile
index 5c32934..8d24660 100644
--- a/Makefile
+++ b/Makefile
@@ -117,6 +117,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-fmt-merge-msg.perl git-rerere.perl \
+	git-annotate.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
diff --git a/git-annotate.perl b/git-annotate.perl
new file mode 100755
index 0000000..a3ea201
--- /dev/null
+++ b/git-annotate.perl
@@ -0,0 +1,291 @@
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
+		if (scalar @parents > 0) {
+			$revs{$rev}{'parents'} = \@parents;
+			$revs{$rev}{'filename'} = $bound->{'filename'};
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
+	for (my $i = 0; $i < @filelines; $i++) {
+		$filelines[$i] = [ $filelines[$i], $rev, 'unknown', 'unknown', 0];
+			# line,
+			# rev,
+			# author,
+			# date,
+			# confirmed to actually belong to this rev (0 = tentative)
+	}
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
+			my $nlineoffsets = {%{$revs{$rev}{'lineoffsets'}}};
+			git_line_assign($p, $rev, $revs{$p}{'filename'}, $nlineoffsets,
+				%revinfo);
+			push @revqueue, $p;
+			$revs{$p}{'lineoffsets'} = $nlineoffsets;
+		}
+
+		for (my $i = 0; $i < @filelines; $i++) {
+			if ($filelines[$i][1] eq $rev) {
+				claim_line($i, $rev, %revinfo);
+			}
+		}
+
+		if (scalar @{$revs{$rev}{parents}} == 0) {
+			# We must be at the initial rev here, so claim everything that is left.
+			for (my $i = 0; $i < @filelines; $i++) {
+				if (ref $filelines[$i] eq '') {
+					claim_line($i, $rev, %revinfo);
+				}
+			}
+		}
+	
+		return 1 if all_lines_claimed();
+	}	
+}
+
+
+sub git_rev_list {
+	my ($rev, $file) = @_;
+	#printf("grl = %s, %s\n", $rev, $file);
+
+# 	printf("Calling: %s\n",join(" ","git-rev-list","--parents","--remove-empty",$rev,"--",$file));
+	open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)
+		or die "Failed to exec git-rev-list: $!";
+
+	my @revs;
+	while(my $line = <P>) {
+# 		print $line;
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
+# Examine a revision to see if it has unclaimed lines that we have,
+# if so, give those lines to that revision.
+sub git_line_assign {
+	my ($parent, $rev, $filename, $lineoffsets, %revinfo) = @_;
+
+	my @plines = git_cat_file($parent, $filename);
+
+	my ($i, $j, $jbase) = (0,0,0);
+	while ($i < @filelines && $filelines[$i][1] ne $rev) {
+		$i++;
+	}
+
+	if ($i == @filelines) {
+		printf("Skipping diff-parse - i = filelines)\n");
+	}
+	return if $i == @filelines;
+
+	while($i < @filelines && $j < @plines) {
+		if ($filelines[$i][0] eq $plines[$j]) {
+			# Our parent has this line, give it away.
+			$filelines[$i][1] = $parent;
+			$jbase = $j;
+			$i++;
+			$j++;
+			
+		} elsif ($j+1 == @plines) {
+			$i++;
+			$j = $jbase;
+		} else {
+			$j++;
+		}
+	}
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
+	my ($floffset, $rev, %revinfo) = @_;
+	my $oline = $filelines[$floffset][0];
+	$filelines[$floffset] =	[ $oline, $rev,
+		$revinfo{'author'}, $revinfo{'author_date'} ];
+	$leftover_lines--;
+	printf("Claiming line %d with rev %s: '%s'\n",
+			$floffset, $rev, $oline) if 0;
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
1.1.6.g3b91b
