From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 05:33:42 -0700
Message-ID: <7v64lbggrd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 14:33:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjyF-0002KC-Uw
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 14:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWDOMdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWDOMdp
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 08:33:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7049 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932502AbWDOMdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 08:33:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415123343.BWWP8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 08:33:43 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 15 Apr 2006 13:41:18 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18746>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	BTW I really would like to have a diffstat for combined diffs.
> 	Any ideas?

While I think combined diffs are somewhat overrated, I think
what makes some sense would be to count --cc output for each
parent's column, and show something like this:

 Makefile            | +-     +- 
 debian/changelog    | ++++++ ++++++++++++++++++++
 2 files changed, 7 and 91 insertions(+), 1 and 0 deletions(-)

This is for "diff-tree --cc v1.0.0"; the hand-merge (or evil
merge) changed from first parent 7(+),1(-) and from second
parent 91(+),0(-) respectively.

Count the maximum change per each parent (the above example the
second file has the max for both parents but that may not always
be the case), add them up to determine how many columns to
allocate for each parent (while taking one column gap between
each parent into account) and draw normally.

The code that counted this (I did not write code to draw it) is
like this:

-- >8 --
#!/usr/bin/perl

use strict;
my $filename;
my $num_parents = -1;
my %stat;

while (<>) {
	chomp;
	if (/^diff --cc (.*)$/) {
		$filename = $1;
		$stat{$filename} = undef;
		next;
	}
	if (/^(\@+) [-+0-9, ]* \1$/) {
		$num_parents = length($1) - 1;
		next;
	}
	next unless (/^([- +]{$num_parents})/);
	my @pfx = split('', $1);
	if (!defined $stat{$filename}) {
		$stat{$filename} = [];
		for (my $i = 0; $i < $num_parents; $i++) {
			push @{$stat{$filename}}, [0, 0];
		}
	}
	for (my $i = 0; $i < $num_parents; $i++) {
		if ($pfx[$i] eq '+') {
			$stat{$filename}[$i][0]++;
		}
		if ($pfx[$i] eq '-') {
			$stat{$filename}[$i][1]++;
		}
	}
}

for my $filename (sort keys %stat) {
	print "$filename	";
	for (my $i = 0; $i < $num_parents; $i++) {
		printf " +%d/-%d",
		$stat{$filename}[$i][0], $stat{$filename}[$i][1];
	}
	print "\n";
}
