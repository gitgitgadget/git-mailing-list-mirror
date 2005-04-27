From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Wed, 27 Apr 2005 14:23:37 -0400
Message-ID: <200504271423.37433.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pi9bCYOPSdM202a"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:20:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQr7C-0000uX-J0
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVD0SXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVD0SXt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:23:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52393 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261929AbVD0SXk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 14:23:40 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 247629582;
	Wed, 27 Apr 2005 20:23:40 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id AD72514E371; Wed, 27 Apr 2005 20:23:39 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_pi9bCYOPSdM202a
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 April 2005 13:34, Linus Torvalds wrote:
> On Wed, 27 Apr 2005, Chris Mason wrote:
> > Is there a faster way?
>
> Yes. Tell "diff-tree" what your desired files are, and it will cut down
> the amount of work by a _lot_ (because then diff-tree doesn't need to
> recurse into subdirectories that don't matter).

Thanks.  I originally called diff-tree without the file list so that I could 
do the regexp matching, but this is probably one of those features that will 
never get used.

My test case here is a tree with 400 commits, giving diff-tree the file list 
brings us down from 16s to 9s on a cold cache.  Hot cache is about 1.5 
seconds on both.

>
> > This will scale pretty badly as the tree grows, but
> > I usually only want to search back a few months in the history.  So, it
> > might make sense to limit the results by date or commit/tag.
>
> With more history, "rev-list" should do basically the right thing: it will
> be constant-time for _recent_ commits, and it is linear time in how far
> back you want to go. Which seems quite reasonable.
>
> And diff-tree is obviously constant-time (and very fast at that,
> especially if you limit it to just a few files, since then it won't even
> bother with any other subdirectories).

Usually the question I will want to ask is "how did foo.c change since tag X", 
which usually won't go back more then a few months.   This should be 
reasonable, and I'd rather not slow down common operations adding extra 
indexing for the uncommon file-changes run.

So, new prog attached.  New usage:

file-changes [-c commit_id] [-s commit_id] file ...

-c is the commit where you want to start searching
-s is the commit where you want to stop searching

-chris

--Boundary-00=_pi9bCYOPSdM202a
Content-Type: application/x-perl;
  name="file-changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="file-changes"

#!/usr/bin/perl

use strict;

my $last;
my $ret;
my $i;
my @wanted = ();
my $matched;
my $argc = scalar(@ARGV);
my $commit;
my $stop;
my $file_list = "";

sub print_usage() {
    print STDERR "usage: file-changes [-c commit] [-s stop commit] file_list\n";
    exit(1);
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

$last = $commit;

open(RL, "rev-list $commit|") || die "rev-list failed";
while(<RL>) {
    chomp;
    my $cur = $_;
    $matched = 0;
    if ($cur eq $last) {
        next;
    }
    # rev-list gives us the commits from newest to oldest
    open(DT, "diff-tree -r $cur $last $file_list|") || die "diff-tree failed";
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
		    print "diff-tree -r $cur $last\n";
		}
		print "$words[2] $file\n";
		$matched = 1;
	    }
	}
    }
    close(DT);
    if ($?) {
	$ret = $? >> 8;
	die "diff-tree failed with $ret";
    }
    if ($matched) {
	print "cat-file commit $last\n";
	open(COMMIT, "cat-file commit $last|") || die "cat-file $last failed";
	while(<COMMIT>) {
	    print "    $_";
	}
	close(COMMIT);
	if ($?) {
	    $ret = $? >> 8;
	    die "cat-file failed with $ret";
	}
	print "\n";
    }
    if ($cur eq $stop) {
        last;
    }
    $last = $cur;
}

close(RL);
if ($? && ($ret = $? >> 8)) {
    die "rev-list failed with $ret";
}


--Boundary-00=_pi9bCYOPSdM202a--
