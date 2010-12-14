From: Thomas Rast <trast@student.ethz.ch>
Subject: git-fixup-assigner.perl -- automatically decide where to "fixup!"
Date: Tue, 14 Dec 2010 03:09:59 +0100
Message-ID: <201012140309.59378.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKLF-00021N-9q
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759083Ab0LNCKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:10:02 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:54502 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758901Ab0LNCKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:10:01 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:09:55 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:10:00 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163621>

While cleaning up the 'log -L' series I gathered a large number of
little fixups, and decided it would be smart if git could
automatically figure out where to put them.

It works like this:

* Split the diff by hunk.  I'm using -U1 here for finer splits, but it
  could be tunable.

* For each hunk, run blame to find out which commit's lines were
  affected.

* Group the hunks by this commit, and output them with a suitable
  command to make a fixup.

My git-fixup is

  $ g config alias.fixup
  !sh -c 'r=$1; git commit -m"fixup! $(git log -1 --pretty=%s $r)"' -

so that is "suitable".

You would run it with the changes unstaged in your tree as

  ./git-fixup-assigner.perl > fixups

and can then review with 'less fixups', or run 'sh fixups' to commit
them.

It's certainly not perfect, notably the detection logic should ignore
context, but it got the job done.

--- 8< ---
#!/usr/bin/perl

use warnings;
use strict;

sub parse_hunk_header {
        my ($line) = @_;
        my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
            $line =~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
        $o_cnt = 1 unless defined $o_cnt;
        $n_cnt = 1 unless defined $n_cnt;
        return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
}

sub find_commit {
	my ($file, $begin, $end) = @_;
	my $blame;
	open($blame, '-|', 'git', '--no-pager', 'blame', 'HEAD', "-L$begin,$end", $file) or die;
	my %candidate;
	while (<$blame>) {
		$candidate{$1} += 1 if /^([0-9a-f]+)/;
	}
	close $blame or die;
	my @sorted = sort { $candidate{$b} <=> $candidate{$a} } keys %candidate;
	if (1 < scalar @sorted) {
		print STDERR "ambiguous split $file:$begin..$end\n";
		foreach my $c (@sorted) {
			print STDERR "\t$candidate{$c}\t$c\n";
		}
	}
	return $sorted[0];
}

my $diff;
open($diff, '-|', 'git', '--no-pager', 'diff', '-U1') or die;

my %by_commit;
my @cur_hunk = ();
my $cur_commit;
my ($filename, $prefilename, $postfilename);

while (<$diff>) {
        if (m{^diff --git ./(.*) ./\1$}) {
		if (@cur_hunk) {
			push @{$by_commit{$cur_commit}{$filename}}, @cur_hunk;
			@cur_hunk = ();
		}
		$filename = $1;
                $prefilename = "./" . $1;
                $postfilename = "./" . $1;
	} elsif (m{^index}) {
		# ignore
        } elsif (m{^new file}) {
		$prefilename = '/dev/null';
        } elsif (m{^delete file}) {
		$postfilename = '/dev/null';
        } elsif (m{^--- $prefilename$}) {
        } elsif (m{^\+\+\+ $postfilename$}) {
        } elsif (m{^@@ }) {
		if (@cur_hunk) {
			push @{$by_commit{$cur_commit}{$filename}}, @cur_hunk;
			@cur_hunk = ();
		}
		push @cur_hunk, $_;
		die "I don't handle this diff" if ($prefilename ne $postfilename);
                my ($o_ofs, $o_cnt, $n_ofs, $n_cnt)
                        = parse_hunk_header($_);
                my $o_end = $o_ofs + $o_cnt - 1;
		$cur_commit = find_commit($filename, $o_ofs, $o_end);
        } elsif (m{^[-+ \\]}) {
		push @cur_hunk, $_;
	} else {
		die "unhandled diff line: '$_'";
	}
}

close $diff or die;

if (@cur_hunk) {
	push @{$by_commit{$cur_commit}{$filename}}, @cur_hunk;
	@cur_hunk = ();
}

print "#!/bin/sh\n\n";

foreach my $commit (keys %by_commit) {
	print "git apply --cached <<EOF\n";
	foreach my $filename (keys %{$by_commit{$commit}}) {
		print "diff --git a/$filename b/$filename\n";
		print "--- a/$filename\n";
		print "+++ b/$filename\n";
		print @{$by_commit{$commit}{$filename}};
	}
	print "EOF\n\n";
	print "git fixup $commit\n\n";
}
--- >8 ---

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
