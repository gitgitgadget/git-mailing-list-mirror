From: Chris Mason <mason@suse.com>
Subject: Finding file revisions
Date: Wed, 27 Apr 2005 12:50:59 -0400
Message-ID: <200504271251.00635.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 27 18:47:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQpfq-0003SE-7Y
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVD0Qv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 12:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVD0Qv2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 12:51:28 -0400
Received: from ns1.suse.de ([195.135.220.2]:30934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261806AbVD0QvE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 12:51:04 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 87538160D1A2
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 18:51:03 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I haven't seen a tool yet to find which changeset modified a given file, so 
I whipped up something.  The basic idea is to:

for each changeset in rev-list
	for each file in diff-tree -r parent changeset
		match against desired files

Is there a faster way?  This will scale pretty badly as the tree grows, but 
I usually only want to search back a few months in the history.  So, it 
might make sense to limit the results by date or commit/tag.

Usage:
file-changes [-c commit id] file1 ...

The file names can be perl regular expressions, and it will match any file 
starting with the expression listed.  So "file-changes fs/ext" will show 
everything in ext2 and ext3.

Example output:

diff-tree -r 56022b4d00cae3ff816d3ff05d9f8a80e1517c60 9bd104d712d710d53c35166e40bd5fe24caf893e
8a796b48e757e56b50802c28abf28e0199c45ad9->2db368df614de4799be2d1baffb6563dbe1b8926 fs/ext2/inode.c
dbc8fd9bab639b84b8cc94fdbbf850b1e4bf1b2b->a4cd819734ba2eea9d5d21039deca62057f72d44 fs/ext3/inode.c
cat-file commit 9bd104d712d710d53c35166e40bd5fe24caf893e
    tree cd4e40eae003e29c0d3be2aa769c3b572ab1b488
    parent 56022b4d00cae3ff816d3ff05d9f8a80e1517c60
    author mason <mason@coffee> 1114617717 -0400
    committer mason <mason@coffee> 1114617717 -0400

    comments go here

This is meant for cut n' paste.  If you find a changeset comment you like, 
run the diff-tree -r command on the first line to see a diff of the 
changeset (maybe I should add | diff-tree-helper here?)

-chris


#!/usr/bin/perl

use strict;

my $last;
my $ret;
my $i;
my @wanted = ();
my $matched;
my $argc = scalar(@ARGV);
my $commit;

sub print_usage() {
    print STDERR "usage: file-changes [-c commit] file_list\n";
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
    } else {
	push @wanted, $ARGV[$i];
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
    open(DT, "diff-tree -r $cur $last|") || die "diff-tree failed";
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
    $last = $cur;
}

close(RL);
if ($?) {
    $ret = $? >> 8;
    die "rev-list failed with $ret";
}
