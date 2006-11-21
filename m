X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Computing delta sizes in pack files
Date: Tue, 21 Nov 2006 00:39:42 -0500
Message-ID: <20061121053942.GA3149@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
NNTP-Posting-Date: Tue, 21 Nov 2006 05:40:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31970>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmOMb-00017u-FY for gcvg-git@gmane.org; Tue, 21 Nov
 2006 06:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030740AbWKUFjs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 00:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbWKUFjs
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 00:39:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3020 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1030740AbWKUFjr
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 00:39:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmOMD-000551-10 for git@vger.kernel.org; Tue, 21 Nov 2006 00:39:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1195520FB09; Tue, 21 Nov 2006 00:39:42 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Recently I wanted to know how well Git's pack files were doing at
storing rather large JAR files.  So I wrote the attached script to
parse the output of `git verify-pack -v` and use that to determine
how many bytes are needed for each revision of any given file.

For example running it on builtin-blame.c:

  $ perl ../delta-sizes.pl builtin-blame.c 
  Caching cache-cdc41646a9de201b06a936fc3bddcbd51aeb532c.v...
  Pack index cache created.
  
  builtin-blame.c
  16660221... s 2         44
  066dee74... s 1         62
  176f51a4...   0      12797
  ----------------------------------------
           3 revs         12 KiB
  
           3 revs         12 KiB

There are 3 revisions of this file, totalling 12 KiB in disk space
within the pack files.  One of those revisions uses 44 bytes and the
other uses 62 bytes.  Given that this includes the complete overhead
(including the 20 byte OBJ_REF_DELTA header) we're talking about
~20 bytes of delta data in revision 16660221.  Pretty good.  :)

Of course this only looks at a single blob object and does not take
into account the tree and commit overheads for a given revision,
but it does give a really good idea of what is going on.

-- 
Shawn.

--FL5UXtIhxfXey3p5
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="delta-sizes.pl"

#!/usr/bin/perl

use strict;

unless ($ENV{GIT_DIR})
{
	$ENV{GIT_DIR} = '.git' if -f '.git/config';
}
unless ($ENV{GIT_DIR})
{
	$ENV{GIT_DIR} = shift || die "usage: $0 gitdir file...\n";
}

my %revs_by_path;
my %path_by_rev;
my %by_hash;

open(R, "git rev-list --objects --all |");
while (<R>)
{
	chomp;
	my ($sha1, $path) = split / /, $_, 2;
	next unless $path;
	push(@{$revs_by_path{$path}}, $sha1);
	$path_by_rev{$sha1}{$path} = 1;
}
close R;

sub index_pack
{
	my $idx = shift;
	my $pack = $idx;
	local *R, *V, $_;

	$pack =~ s/\.idx$/.pack/;
	$pack =~ /pack-([a-z0-9]{40})\.pack$/;
	my $cache = "cache-$1.v";
	my @objects;

	unless (open(R, $cache))
	{
		print STDERR "Caching $cache...\n";
		open(R, ">$cache");
		open(V, "git verify-pack -v $idx|");
		print R while $_ = <V>;
		close V;
		close R;
		print STDERR "Pack index cache created.\n\n";
		open(R, $cache);
	}

	while (<R>)
	{
		last if /^chain length/;
		chomp;
		my ($sha1, $type, $size, $offset, $depth, $base) = split /\s+/;
		my $o = {
			sha1 => $sha1,
			type => $type,
			uncompressed_size => $size,
			offset => $offset,
			depth => $depth,
			base => $base,
		};
		push @objects, $o;
		$by_hash{$sha1} = $o;
	}
	close R;

	my $last = undef;
	foreach my $o (sort {$a->{offset} <=> $b->{offset}} @objects)
	{
		$last->{pack_size} = $o->{offset} - $last->{offset} if $last;
		$last = $o;
	}
	$last->{pack_size} = ((-s $pack) - 20) - $last->{offset};
}

opendir(D, "$ENV{GIT_DIR}/objects/pack");
while (my $entry = readdir D)
{
	next unless $entry =~ /^pack-[a-z0-9]{40}\.idx$/;
	index_pack "$ENV{GIT_DIR}/objects/pack/$entry";
}
closedir D;

if (@ARGV)
{
	my $g_total = 0;
	my $g_revs = 0;

	foreach my $path (@ARGV)
	{
		print $path, "\n";

		my $total = 0;
		my $revs = 0;
		foreach my $sha1 (
			sort {$by_hash{$b}{depth} <=> $by_hash{$a}{depth}}
			grep {$by_hash{$_}}
			@{$revs_by_path{$path}})
		{
			my $o = $by_hash{$sha1};
			printf "%8s... %1s%2i %10i\n",
				substr($sha1, 0, 8),
				($o->{depth}
					? ($path_by_rev{$o->{base}}{$path}
						? 's'
						: 'o')
					: ''),
				$o->{depth},
				$o->{pack_size};
			$total += $o->{pack_size};
			$revs++;
		}

		$g_total += $total;
		$g_revs += $revs;

		my $units = 'bytes';
		if ($total >= 1024)
		{
			$units = 'KiB';
			$total /= 1024;

			if ($total >= 1024)
			{
				$units = 'MiB';
				$total /= 1024;
			}
		}

		print '-'x40, "\n";
		printf "%15s %10i %s\n",
			"$revs revs",
			$total, $units;
		print "\n";
	}

	my $units = 'bytes';
	if ($g_total >= 1024)
	{
		$units = 'KiB';
		$g_total /= 1024;

		if ($g_total >= 1024)
		{
			$units = 'MiB';
			$g_total /= 1024;
		}
	}

	printf "%15s %10i %s\n",
		"$g_revs revs",
		$g_total, $units;
}
else
{
	foreach my $path (sort keys %revs_by_path)
	{
		my $total = 0;
		my $revs = 0;
		foreach my $sha1 (
			sort {$by_hash{$b}{depth} <=> $by_hash{$a}{depth}}
			grep {$by_hash{$_}}
			@{$revs_by_path{$path}})
		{
			$total += $by_hash{$sha1}{pack_size};
			$revs++;
		}

		my $units = 'bytes';
		if ($total >= 1024)
		{
			$units = 'KiB';
			$total /= 1024;

			if ($total >= 1024)
			{
				$units = 'MiB';
				$total /= 1024;
			}
		}
		$total = int $total;

		printf "%3i revs %10i %-5s %s\n",
			$revs,
			$total, $units,
			$path;
	}
}

