From: Randy Dunlap <rdunlap@xenotime.net>
Subject: author/commit counts
Date: Fri, 22 Dec 2006 18:10:30 -0800
Organization: YPO4
Message-ID: <20061222181030.d733deb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 23 03:17:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxwSL-0003Y7-6p
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 03:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWLWCRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 21:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbWLWCRq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 21:17:46 -0500
Received: from xenotime.net ([66.160.160.81]:59974 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753456AbWLWCRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 21:17:45 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 21:17:45 EST
Received: from midway.site ([71.245.99.70]) by xenotime.net for <git@vger.kernel.org>; Fri, 22 Dec 2006 18:09:10 -0800
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35252>

Hi,

Someone asked me a few days ago about their patches being merged yet
(e.g., how to see their commits in a git tree).
Someone else asked (in general) about commit or author counts.

I pointed the first person to "git log" and/or gitweb.
For the second, there are probably lots of scripts out there
but I didn't find them.  Where are they?

Is this useful?  or it needs fixing?
or you already have better solutions?

example:
git log v2.6.19.. | authorcount -m | less

# this is just the ones with >= 50 Author: lines

Al Viro : 213
Linus Torvalds : 94
Jiri Slaby : 90
Josef Sipek : 79
Gerrit Renker : 77
Adrian Bunk : 67
Andrew Morton : 59
Tejun Heo : 52
Mariusz Kozlowski : 52
Paul Mundt : 51
Ralf Baechle : 50
---

#! /usr/bin/perl
# Copyright (C) 2006, Randy Dunlap.

# read stdin, drop non-author: lines, count/sum/tally author: lines by
# each author after sanitizing author-name somewhat.
#
# optionally print out in author-name (-a) alpha order
# or in numeric/count (-n) order (low-to-high)
# or in numeric/count (-m) order (high-to-low) ("max" first)

# hash for author names:
my %authors;
my $auth;
my $sortby;

sub usage()
{
	print "usage: authorcount [-a | -n | -m] < git.log.lines\n";
	exit(1);
}

$sortby = $ARGV[0];
if (($sortby ne "") && ($sortby ne "-a") && ($sortby ne "-n") &&
    ($sortby ne "-m"))
{
	print "Invalid sort option: $sortby\n";
	usage();
}

READIN: while ($line = <STDIN>)
{
	chomp $line;
	next READIN if $line !~ /Author:/;

	$auth = $line;
	$auth =~ s/Author: //;
	$auth =~ s/<.*>//;

	$authors{$auth}++;

} # end READIN

sub byvalue
{
	$authors{$a} <=> $authors{$b};
}

# optionally sort by author name or author counts
# print out the tally array

if ($sortby eq "-a")
{
	foreach $auth (sort keys %authors)
	{
		print "$auth: $authors{$auth}\n";
	}
}
elsif ($sortby eq "-n")
{
	foreach $auth (sort byvalue keys %authors)
	{
		print "$auth: $authors{$auth}\n";
	}
}
elsif ($sortby eq "-m")
{
	foreach $auth (reverse sort byvalue keys %authors)
	{
		print "$auth: $authors{$auth}\n";
	}
}
else # no sort, just hash order
{
	while (($auth, $count) = each(%authors))
	{
		print "$auth: $count\n";
	}
}
