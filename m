From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 07:45:04 -0400
Message-ID: <200504280745.05505.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <200504271423.37433.mason@suse.com> <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BzMcCnwhyk1T7ZK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 13:41:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR7O4-0006qb-Js
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 13:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVD1LqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 07:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVD1LqR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 07:46:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:17115 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262086AbVD1LpL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 07:45:11 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3C0EE160D367;
	Thu, 28 Apr 2005 13:45:09 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_BzMcCnwhyk1T7ZK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 April 2005 18:19, Linus Torvalds wrote:
> On Wed, 27 Apr 2005, Chris Mason wrote:
> > So, new prog attached.  New usage:
> >
> > file-changes [-c commit_id] [-s commit_id] file ...
> >
> > -c is the commit where you want to start searching
> > -s is the commit where you want to stop searching
>
> Your script will do some funky stuff, because you incorrectly think that
> the rev-list is sorted linearly. It's not. It's sorted in a rough
> chronological order, but you really can't do the "last" vs "cur" thing
> that you do, because two commits after each other in the rev-list listing
> may well be from two totally different branches, so when you compare one
> tree against the other, you're really doing something pretty nonsensical.

One more rev that should work as you suggested Here's the example output 
from a cogito changeset with merges.  I print the diff-tree lines once for each 
matching parent and then print the commit once.  It's very primitive, but
hopefully some day someone will make a gui with happy clicky buttons
for changesets and filerevs.

diff-tree -r 2544d7558f0ce94ab9c163f5b67244f71d8c85b8 69eeae031bf5447e99b9274761e2361e8c5a944e
618fdb616cebbd2fc9f1cddc0b6b75fd575250a1->3579b5fd1182679a39b83eaaa9dd0e7c970f4545 diff-tree.c
diff-tree -r 9831d8f86095edde393e495d7a55cab9d35d5d05 69eeae031bf5447e99b9274761e2361e8c5a944e
2d2913b6b98ac836b43755b1304d2a838dad87dd->4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92 Makefile
cat-file commit 69eeae031bf5447e99b9274761e2361e8c5a944e
    tree 7510dc1b63e9e690ec73952e40a31e43af4b55bc
    parent 2544d7558f0ce94ab9c163f5b67244f71d8c85b8
    parent 9831d8f86095edde393e495d7a55cab9d35d5d05
    author Petr Baudis <pasky@ucw.cz> 1114544917 +0200
    committer Petr Baudis <xpasky@machine.sinus.cz> 1114544917 +0200

    Merge with rsync://www.kernel.org/pub/linux/kernel/people/torvalds/git.git

-chris

--Boundary-00=_BzMcCnwhyk1T7ZK
Content-Type: application/x-perl;
  name="file-changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="file-changes"

#!/usr/bin/perl

use strict;

my $ret;
my $i;
my @wanted = ();
my $argc = scalar(@ARGV);
my $commit;
my $stop;
my $file_list = "";

sub print_usage() {
    print STDERR "usage: file-changes [-c commit] [-s stop commit] file_list\n";
    exit(1);
}

sub print_commit($) {
    my ($c) = @_;
    print "cat-file commit $c\n";
    open(COMMIT, "cat-file commit $c|") || die "cat-file $c failed";
    while(<COMMIT>) {
	print "    $_";
    }
    close(COMMIT);
    if ($? && ($ret = $? >> 8)) {
	die "cat-file failed with $ret";
    }
    print "\n";
}

sub test_diff($$) {
    my ($a, $b) = @_;
    my $matched = 0;
    open(DT, "diff-tree -r $a $b $file_list|") || die "diff-tree failed";
    while(<DT>) {
        chomp;
	my @words = split;
	my $file = $words[3];
	# if the filename has whitespace, suck it in
	if (scalar(@words) > 4) {
	    if (m/$file(.*)/) {
	        $file .= $1;
	    }
	}
	foreach my $m (@wanted) {
	    if ($file =~ m/^$m/) {
		if (!$matched) {
		    print "diff-tree -r $a $b\n";
		}
		print "$words[2] $file\n";
		$matched = 1;
	    }
	}
    }
    close(DT);
    if ($? && ($ret = $? >> 8)) {
	die "diff-tree failed with $ret";
    }
    return $matched;
}

if ($argc < 1) {
    print_usage();
}

for ($i = 0 ; $i < $argc ; $i++)  {
    if ($ARGV[$i] eq "-c") {
    	if ($i == $argc - 1) {
	    print_usage();
	}
	$commit = $ARGV[++$i];
    } elsif ($ARGV[$i] eq "-s") {
    	if ($i == $argc - 1) {
	    print_usage();
	}
	$stop = $ARGV[++$i];
    } else {
	push @wanted, $ARGV[$i];
	$file_list .= "$ARGV[$i] ";
    }
}

if (!defined($commit)) {
    $commit = `commit-id`;
    if ($?) {
    	print STDERR "commit-id failed, try using -c to specify a commit\n";
	exit(1);
    }
    chomp $commit;
}

open(RL, "rev-list $commit|") || die "rev-list failed";
while(<RL>) {
    chomp;
    my $cur = $_;
    my $matched = 0;
    open(PARENT, "cat-file commit $cur|") || die "cat-file failed";
    while(<PARENT>) {
        chomp;
	my @words = split;
	if ($words[0] eq "tree") {
	    next;
	} elsif ($words[0] ne "parent") {
	    last;
	}
	$matched += test_diff($words[1], $cur);
    }
    close(PARENT);
    if ($? && ($ret = $? >> 8)) {
        die "cat-file failed with $ret";
    }
    if ($matched) {
        print_commit($cur);
    }
    if ($cur eq $stop) {
        last;
    }
}
close(RL);

if ($? && ($ret = $? >> 8)) {
    die "rev-list failed with $ret";
}


--Boundary-00=_BzMcCnwhyk1T7ZK--
