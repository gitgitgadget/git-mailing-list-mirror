From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: whomto.pl -- finding out whom to send patches to
Date: Thu, 29 May 2008 23:00:18 +0200
Message-ID: <20080529210018.GA5508@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	Sverre Rabbelier <alturin@gmail.com>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 23:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1pHM-0002YC-Cc
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 23:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYE2VC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbYE2VC2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 17:02:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32748 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbYE2VC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 17:02:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1604949nfc.21
        for <git@vger.kernel.org>; Thu, 29 May 2008 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        bh=NPWnXNag/KT7gXrkcSAUJpI5lMd428dRdF8QO/NFsL0=;
        b=ZFvXxLTDrNvqmT1GPicS88n6h9FdvINpFa1y6+xl5vaheKRTqhd68Lo5OUjA+VxYchHhYJ93EDDTMIC4heWdodblEp1RFLRq7z1NpD57xJKBR2dsZKpPelaSZ2411GO+OOIO4qgsrcnEhDKPaJ3iHlapGPZ8fnHzFwFAlRzaYtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=dwlLFoFEGeOjSJgD5VjtNd8u5jEO2iKB4wRHeJ6q1n8xpeWFEWmNb20MgkoM/WL4c9dE9lm/mLJur1KPa60+U6lABFXbLhgH/xraypAB7uiurYRs/jg+DnS1a/TD5V5I6cKMY/9ZSJi2AG2o+Ed3kvPOvY6Up6Tb+BmBgk8Lk4s=
Received: by 10.210.87.19 with SMTP id k19mr3344748ebb.176.1212094945369;
        Thu, 29 May 2008 14:02:25 -0700 (PDT)
Received: from damson.getinternet.no ( [84.209.125.101])
        by mx.google.com with ESMTPS id 6sm10080599nfv.36.2008.05.29.14.00.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 14:02:24 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83244>

Hi,

I've written this perl script that takes a patch as input and prints the
authors/committers of the affected lines, using git-blame as the back end.

(The purpose of this is of course to find out whom to send patches to.)

There are some caveats:

- If I've understood correctly, git-blame incremental output doesn't split
  commits when a newer one is found, so we currently possibly take into
  account more than just the last patch to touch a line. This might not be
  a disadvantage, however...

- The patch must apply to the current working tree. I suppose there is
  some way to use the index information in the patch to determine what to
  run git-blame against, but this is currently beyond my git knowledge.

- It's a bit slow, particularly for large files. But doing the same thing
  by hand would be slower, so I suppose it's an overall improvement.

Running this on a random -mm patch, for example
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.26-rc2/2.6.26-rc2-mm1/broken-out/acpi-fix-fadt-parsing.patch
gives the following output:

  $ perl whomto2.pl acpi-fix-fadt-parsing.patch
  Running git-blame on drivers/acpi/tables/tbfadt.c...

  To: (Committers)
      48 Len Brown <len.brown@intel.com>
  Cc: (Authors)
      44 Bob Moore <robert.moore@intel.com>
       2 Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
       2 Len Brown <len.brown@intel.com>

Maybe this tool can be useful? :-)

(Improvements are of course also welcome.)


Vegard


#! /usr/bin/perl

use strict;
use warnings;

for my $file (@ARGV) {
	check($file);
}

sub git_apply {
	my $filename = shift;

	my @args = (
		'git-apply',
		'--check',
		$filename,
	);

	open(my $fh, '-|', @args) || die $!;
	my @b = <$fh>;
	close $fh;

	return $? ? undef : 1;
}

sub git_blame {
	my $filename = shift;

	my @args = (
		'git-blame',
		'--incremental',
		'--',
		$filename,
	);

	open(my $fh, '-|', @args) || die $!;
	chomp(my @b = <$fh>);
	close $fh;

	my %info = ();

	my %commits = ();

	my @blames = ();
	my $blame;

	my $start = 1;
	for (@b) {
		if ($start) {
			my($sha1, $source, $result, $num) = split;

			$blame = {
				sha1 => $sha1,
				source => $source,
				result => $result,
				num => $num,
			};

			%info = ();

			$start = 0;
			next;
		}

		my($key, $value) = split m/ /, $_, 2;
		$info{$key} = $value;

		if ($key eq 'filename') {
			my $sha1 = $blame->{sha1};
			$commits{$sha1} = {%info} unless exists $commits{$sha1};

			push @blames, $blame;
			$start = 1
		}
	}

	return $? ? undef : {
		commits => \%commits,
		blames => \@blames,
	};
}

sub parse_patch {
	my $filename = shift;

	open(my $fh, '<', $filename);
	chomp(my @p = <$fh>);
	close($fh);

	my %headers = ();
	for my $line (@p) {
		last if $line eq '';

		if(my($key, $value) = split m/: /, $line, 2) {
			$headers{$key} = $value;
		}
	}

	my %files = ();
	my $file;

	for (@p) {
		if (m/^--- .*?\/([^\s~]*)/) {
			$file = $files{$1} = {
				chunks => [],
			};
			next;
		}

		if (m/^@@ -(\d+),(\d+) \+\d+,\d+ @@/) {
			push @{$file->{chunks}}, [$1, $2];
			next;
		}
	}

	return {
		headers => \%headers,
		files => \%files,
	};
}

sub min {
	return $_[0] if $_[0] < $_[1];
	return $_[1];
}

sub max {
	return $_[0] if $_[0] > $_[1];
	return $_[1];
}

sub range_intersect {
	return [max($_[0], $_[2]), min($_[1], $_[3])];
}

sub range_size {
	return 0 if $_[0]->[0] > $_[0]->[1];
	return $_[0]->[1] - $_[0]->[0] + 1;
}

sub check_chunk {
	my $blame = shift;
	my $chunk = shift;

	my @results = ();

	my $a = $chunk->[0];
	my $b = $chunk->[0] + $chunk->[1] - 1;

	my $blames = $blame->{blames};
	for my $blame_chunk (@$blames) {
		my $c = $blame_chunk->{source};
		my $d = $blame_chunk->{source} + $blame_chunk->{num} - 1;

		my $size = range_size(range_intersect($a, $b, $c, $d));
		if ($size > 0) {
			push @results, {
				sha1 => $blame_chunk->{sha1},
				size => $size,
			};
		}
	}

	return \@results;
}

sub best_email {
	my $emails = shift;

	my $best = (keys %$emails)[0];
	for my $email (keys %$emails) {
		$best = $email if $emails->{$email} < $emails->{$best};
	}

	return $best;
}

sub hash_sort {
	my $h = shift;

	return sort { $h->{$a} <=> $h->{$b} } keys %$h;
}

sub check {
	my $filename = shift;

	# First try to apply the patch. This makes sure the patched files
	# exist in the first place, and that the line numbers are semi-
	# correct.
	git_apply($filename) || die "Patch won't apply.\n";

	# Get files and line numbers from the patch.
	my $patch = parse_patch($filename);

	my %all_commits = ();
	my @all_results = ();

	my $files = $patch->{'files'};
	for my $file (keys %$files) {
		printf STDERR "Running git-blame on %s...\n", $file;

		my $blame = git_blame($file) || die "git-blame failed\n";

		%all_commits = (%all_commits, %{$blame->{commits}});

		my $chunks = $files->{$file}->{chunks};
		for my $chunk (@$chunks) {
			push @all_results, @{check_chunk($blame, $chunk)};
		}
	}

	print STDERR "\n";

	# Flatten the commit data to store person -> email information
	my %emails = ();
	for my $commit (values %all_commits) {
		my $author = $commit->{author};
		my $author_mail = $commit->{'author-mail'};
		$emails{$author} = {} unless exists $emails{$author};
		$emails{$author}->{$author_mail} = 0 unless exists $emails{$author}->{$author_mail};
		$emails{$author}->{$author_mail}++;

		my $committer = $commit->{committer};
		my $committer_mail = $commit->{'committer-mail'};
		$emails{$committer} = {} unless exists $emails{$committer};
		$emails{$committer}->{$committer_mail} = 0 unless exists $emails{$committer}->{$committer_mail};
		$emails{$committer}->{$committer_mail}++;
	}

	# Find authors and committers...
	my %authors = ();
	my %committers = ();
	for my $result (@all_results) {
		my $commit = $all_commits{$result->{sha1}};
		my $author = $commit->{author};
		my $committer = $commit->{committer};

		$authors{$author} = 0 unless exists $authors{$author};
		$authors{$author} += $result->{size};

		$committers{$committer} = 0 unless exists $committers{$committer};
		$committers{$committer} += $result->{size};
	}

	print "To: (Committers)\n";
	for my $committer (reverse hash_sort \%committers) {
		printf "%6d %s %s\n",
			$committers{$committer},
			$committer,
			best_email($emails{$committer});
	}

	print "Cc: (Authors)\n";
	for my $author (reverse hash_sort \%authors) {
		printf "%6d %s %s\n",
			$authors{$author},
			$author,
			best_email($emails{$author});
	}
}
