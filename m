From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git as an sfc member project
Date: Sat, 23 Oct 2010 17:48:29 -0500
Message-ID: <1287874109-15565-1-git-send-email-drafnel@gmail.com>
References: <cs0GhwZZ9W-pJdXPmTo0di_hrUwMa14GE8dSJeIQtOwrvDdl4KxJ_g@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, spearce@spearce.org,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 00:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9muJ-00022Z-L9
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 00:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab0JWWt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 18:49:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60438 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab0JWWt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 18:49:28 -0400
Received: by ywk9 with SMTP id 9so1466770ywk.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hP+FUab5TSh82sFrI4HKy+ijk5IAc4GlmnssAOmVw0c=;
        b=ELA+zPD8zs7bJWFwrmISZjgNTyqD4nRBH1o9K2Hf7QQYPw3E7wKiOzM21btuWnKp9N
         enyocmLzOQRTeczCIpFEOP83m6cbgvA8p6Q94Z3QYYVq9IzCQD/0w97ESVhqxiLo2Ykb
         m1xcDu3Aokm2iWSrrcSEhDGMqZsiVT9oDvXOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k6PQkWMubHVepXuYf/LboXNkenFsMpu/tzQMFJj6r5aPbiZMtc42kKayWM41/5N5ub
         e3vkxTRDObfRccm7Bi2FAlSF9usGN54A+YPBzYziwIugiUTNKi5CBDhr98Tg0L3/yLy7
         FmMEl7sgI5PGxcyTDFJMBxWKeuOjTu9D0GnkU=
Received: by 10.150.100.14 with SMTP id x14mr9458564ybb.405.1287874167769;
        Sat, 23 Oct 2010 15:49:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-159-204-203.bix.bellsouth.net [68.159.204.203])
        by mx.google.com with ESMTPS id z30sm3890327yhc.9.2010.10.23.15.49.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 15:49:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.45.g9855b
In-Reply-To: <cs0GhwZZ9W-pJdXPmTo0di_hrUwMa14GE8dSJeIQtOwrvDdl4KxJ_g@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159831>

Here's an updated version of this script if anyone is interested.

It can now do the git-blame calls in parallel.  Use -t #threads.

Here's the usage info:

      ' -c     print count of all lines in all files at the end',
      ' -f     produce file centric output (overrides -l and -s)',
      ' -l     produce longer format',
      ' -s     produce short format, line count and author only',
      ' -ls    Both -l and -s produce an even longer long format',
      ' -t n   set number of threads to use',
      ' -x re  exclude files matching regex',
      ' -v     be more verbose',

Enjoy.

-Brandon

---
 git_blame_stats.perl |  387 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 387 insertions(+), 0 deletions(-)
 create mode 100755 git_blame_stats.perl

diff --git a/git_blame_stats.perl b/git_blame_stats.perl
new file mode 100755
index 0000000..618cf0a
--- /dev/null
+++ b/git_blame_stats.perl
@@ -0,0 +1,387 @@
+#!/usr/bin/perl -w
+
+use lib (split(/:/, $ENV{GITPERLLIB} || '/path/to/git/lib/perl5/site_perl/5.10.0'));
+
+use strict;
+use threads;
+use Thread::Queue;
+use Getopt::Std;
+use Git;
+
+my @LSTREE_OPTS = ('-r', '--name-only');
+my @BLAME_OPTS = ('-C', '-C', '-w', '--incremental');
+
+$Getopt::Std::STANDARD_HELP_VERSION = 1;
+$main::VERSION = 1.0;
+
+sub usage {
+	my $name;
+
+	eval {
+		require File::Basename;
+		$name = File::Basename::basename($0);
+	} or do {
+		$name = substr $0, rindex($0, '/') + 1;
+	};
+
+	print 'Usage: ', $name, ' [--help] [-cflstvx] <rev> [paths...]', "\n";
+}
+
+sub main::HELP_MESSAGE {
+	my $fh = shift;
+
+	eval {select $fh; usage};
+
+	local $\ = "\n";
+	local $, = "\n";
+
+	print $fh '',
+	      'Generate authorship statistics from a git repository.',
+	      '',
+	      'OPTIONS',
+	      ' -c     print count of all lines in all files at the end',
+	      ' -f     produce file centric output (overrides -l and -s)',
+	      ' -l     produce longer format',
+	      ' -s     produce short format, line count and author only',
+	      ' -ls    Both -l and -s produce an even longer long format',
+	      ' -t n   set number of threads to use',
+	      ' -x re  exclude files matching regex',
+	      ' -v     be more verbose',
+	      ' --help this text',
+	      '';
+}
+
+sub parse_blame_entry {
+	my $fh = shift;
+
+	return () unless defined($_ = <$fh>);
+	chomp;
+
+	my ($sha1, $sourceline, $resultline, $num_lines) = split;
+
+	return () unless defined $num_lines;
+
+	my %h = (sha1 => $sha1, sourceline => $sourceline,
+		 resultline => $resultline, lines => $num_lines);
+	while (<$fh>) {
+		chomp;
+		my ($key, $val) = split ' ', $_, 2;
+		$h{$key} = $val;
+		last if m/^filename /;
+	}
+
+	return %h;
+}
+
+sub blame_file {
+	my $repo = shift;
+	my $ref = shift;
+	my $filename = shift;
+	my $authors = shift;
+
+	my ($fh, $ctx) = $repo->command_output_pipe('blame', @BLAME_OPTS,
+		$ref, '--', $filename);
+
+	my %commits;
+	while (my %h = parse_blame_entry $fh) {
+
+		if (! exists $commits{$h{'sha1'}}) {
+
+			if (! exists $authors->{$h{'author'}}->{$filename}) {
+				$authors->{$h{'author'}}->{$filename} = 0;
+			}
+			$commits{$h{'sha1'}} =
+				\$authors->{$h{'author'}}->{$filename};
+		}
+
+		${$commits{$h{'sha1'}}} += $h{'lines'};
+	}
+
+	$repo->command_close_pipe($fh, $ctx);
+}
+
+sub count_total_lines {
+	my $authors = shift;
+
+	my $lines = 0;
+
+	for (values %{$authors}) {
+		for (values %{$_}) { $lines += $_; }
+	}
+
+	return $lines;
+}
+
+# Returns hash
+# key: author name
+# value: authored lines
+sub count_author_lines {
+	my $authors = shift;
+
+	my %alines;
+
+	foreach my $author (keys %{$authors}) {
+		my $lines = 0;
+		for (values %{$authors->{$author}}) { $lines += $_; }
+		$alines{$author} = $lines;
+	}
+
+	return %alines;
+}
+
+# Returns hash
+# key: filename
+# value: lines in file
+sub count_file_lines {
+	my $authors = shift;
+
+	my %flines;
+
+	for (values %{$authors}) {
+		foreach my $file (keys %{$_}) {
+			$flines{$file} += $_->{$file};
+		}
+	}
+
+	return %flines;
+}
+
+# Short format
+#   lines author
+sub print_short {
+	my $authors = shift;
+
+	my %alines = count_author_lines $authors;
+
+	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
+		printf "%6d  %s\n", $alines{$author}, $author;
+	}
+}
+
+# Long format
+# author (lines):
+#    file_lines filename
+#    file_lines filename
+#    file_lines filename
+sub print_long {
+	my $authors = shift;
+
+	my %alines = count_author_lines $authors;
+
+	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
+		print $author, ' (', $alines{$author}, '):', "\n";
+		foreach my $file (sort
+		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
+		    keys %{$authors->{$author}}) {
+			printf "  %10d %s\n", $authors->{$author}->{$file},
+			      $file;
+		}
+	}
+}
+
+# Longer format
+# author (lines, % of all lines):
+#    file_lines (% of author lines) filename
+#    file_lines (% of author lines) filename
+sub print_longer {
+	my $authors = shift;
+
+	my %alines = count_author_lines $authors;
+	my $total_lines = count_total_lines $authors;
+
+	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
+		printf "%s (%d, %.2f%%):\n", $author, $alines{$author},
+			100. * $alines{$author} / $total_lines;
+		foreach my $file (sort
+		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
+		    keys %{$authors->{$author}}) {
+			printf "  %10d (%5.2f%%) %s\n",
+			       $authors->{$author}->{$file},
+			       100. *
+			       $authors->{$author}->{$file} / $alines{$author},
+			       $file;
+		}
+	}
+}
+
+# Longer format
+# author (# lines in X files, % of all lines, % of all files):
+#    lines (% of file) file_lines (% of author lines) filename
+#    lines (% of file) file_lines (% of author lines) filename
+sub print_with_file_percentage {
+	my $authors = shift;
+
+	my %alines = count_author_lines $authors;
+	my %flines = count_file_lines $authors;
+	my $total_lines = count_total_lines $authors;
+	my $total_files = scalar(keys %flines);
+
+	foreach my $author (sort {$alines{$b} <=> $alines{$a}} keys %alines) {
+		printf "%s (%d lines in %d files, " .
+		       "%.2f%% of all lines, %.2f%% of all files):\n",
+		       $author, $alines{$author},
+		       scalar(keys %{$authors->{$author}}),
+		       100. * $alines{$author} / $total_lines,
+		       100. * scalar(keys %{$authors->{$author}})/$total_files;
+		foreach my $file (sort
+		    {$authors->{$author}->{$b} <=> $authors->{$author}->{$a}}
+		    keys %{$authors->{$author}}) {
+			printf "  %10d (%6.2f%%) of %6d (%6.2f%%) %s\n",
+			       $authors->{$author}->{$file},
+			       100. *
+			       $authors->{$author}->{$file} / $flines{$file},
+			       $flines{$file},
+			       100. *
+			       $authors->{$author}->{$file} / $alines{$author},
+			       $file;
+		}
+	}
+}
+
+# File perspective format
+# filename (lines):
+#    lines author
+#    lines author
+sub print_with_file_perspective {
+	my $authors = shift;
+
+	my %flines = count_file_lines $authors;
+
+	foreach my $file (sort keys %flines) {
+		my @auths = grep {exists $authors->{$_}->{$file}}
+			keys %{$authors};
+		print $file, ' (', $flines{$file}, '):', "\n";
+		foreach my $author (sort
+		    {$authors->{$b}->{$file} <=> $authors->{$a}->{$file}}
+		    @auths) {
+			printf " %10d %s\n", $authors->{$author}->{$file},
+				$author;
+		}
+	}
+}
+
+
+my $verbose = 0;
+my $output_format = 0;
+my $show_total = 0;
+my $exclude_pattern;
+my $nthreads = 1;
+
+our ($opt_c, $opt_f, $opt_l, $opt_s, $opt_t, $opt_v, $opt_x);
+getopts('cflst:vx:') or die 'Invalid options specified';
+
+	if ($opt_c) {
+		$show_total = 1;
+	}
+	if ($opt_f) {
+		$output_format = 4;
+	} elsif ($opt_l && $opt_s) {
+		$output_format = 3;
+	} elsif ($opt_l) {
+		$output_format = 2;
+	} elsif ($opt_s) {
+		$output_format = 1;
+	}
+	if (defined $opt_t) {
+		$nthreads = $opt_t;
+		if ($nthreads !~ /^\d+$/ || $nthreads < 0) {
+			die 'Error: argument to -t must be integer >= 0';
+		}
+		if ($nthreads == 0) {
+			eval {
+				require Sys::CPU;
+				$nthreads = Sys::CPU::cpu_count();
+			} or $nthreads = 1;
+		}
+	}
+	if ($opt_v) {
+		$verbose = 1;
+	}
+	if ($opt_x) {
+		$exclude_pattern = $opt_x;
+	}
+
+eval {select STDERR; usage; exit 1} unless $#ARGV >= 0;
+
+my %authors;
+my @thr;
+my $repo = Git->repository();
+
+# Spawn ls-tree now, so it can fail before creating the threads
+my ($fh, $ctx) = $repo->command_output_pipe('ls-tree', @LSTREE_OPTS,
+	'--', @ARGV);
+
+print STDERR 'Using ', $nthreads, ' thread(s).', "\n" if $verbose;
+
+my $DataQueue = Thread::Queue->new();
+
+# start the threads
+for (my $i = 0; $i < $nthreads; $i++) {
+	($thr[$i]) = threads->create(sub {
+		my $tid = threads->tid();
+		my %a;
+		while (my $f = $DataQueue->dequeue()) {
+			print STDERR "[$tid]Processing file: $f\n" if $verbose;
+			blame_file $repo, $ARGV[0], $f, \%a;
+		}
+		return %a;
+	});
+}
+
+# now queue up the files
+while (<$fh>) {
+	chomp;
+
+	if ($exclude_pattern && m/$exclude_pattern/o) {
+		print STDERR "Skipping file: $_\n" if $verbose;
+		next;
+	} else {
+		print STDERR "Queuing file: $_\n" if $verbose;
+	}
+
+	$DataQueue->enqueue($_);
+}
+$repo->command_close_pipe($fh, $ctx);
+
+# queue up an undef entry for each thread
+for (my $i = 0; $i < $nthreads; $i++) {
+	$DataQueue->enqueue(undef);
+}
+
+# merge the author hash from each thread
+for (my $i = 0; $i < $nthreads; $i++) {
+	my %th_authors = $thr[$i]->join;
+
+	foreach my $author (keys %th_authors) {
+		if (! exists $authors{$author}) {
+			$authors{$author} = $th_authors{$author};
+			next;
+		}
+		foreach my $filename (keys %{$th_authors{$author}}) {
+			if (! exists $authors{$author}->{$filename}) {
+				$authors{$author}->{$filename} =
+					$th_authors{$author}->{$filename};
+			} else {
+				$authors{$author}->{$filename} +=
+					$th_authors{$author}->{$filename};
+			}
+		}
+	}
+}
+
+
+if ($output_format == 0) {
+	print_long \%authors;
+} elsif ($output_format == 1) {
+	print_short \%authors;
+} elsif ($output_format == 2) {
+	print_longer \%authors;
+} elsif ($output_format == 3) {
+	print_with_file_percentage \%authors;
+} elsif ($output_format == 4) {
+	print_with_file_perspective \%authors;
+}
+
+printf "%6d  total lines\n", count_total_lines(\%authors) if $show_total;
+
+exit;
-- 
1.7.3.1.45.g9855b
