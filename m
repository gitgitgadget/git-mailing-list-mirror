From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] packed delta git
Date: Thu, 19 May 2005 14:28:50 -0400
Message-ID: <200505191428.52238.mason@suse.com>
References: <200505171857.46370.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 19 20:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYpl9-0007Lj-LU
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVESS3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVESS3W
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:29:22 -0400
Received: from ns.suse.de ([195.135.220.2]:7629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261163AbVESS24 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 14:28:56 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AB92ADB58;
	Thu, 19 May 2005 20:28:55 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <200505171857.46370.mason@suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 17 May 2005 18:57, Chris Mason wrote:
> Hello everyone,
>
> Here's a new version of my packed git patch, diffed on top of Nicolas'
> delta code (link below to that).  It doesn't change the core git commands
> to create packed/delta files, that is done via a new git-pack command.  The
> git-pack usage is very simple:
>
> git-pack [<reference_sha1>:]<target_sha1> [ <next_sha1> ... ]

My original git-pack-changes script didn't properly limit the length of the 
delta chains, so you could use it to create a repo that you can't later read.

The new one below fixes that, and also changes the direction of the delta.
Deltas are now done in reverse, leaving the most recent sha1 as a whole file
and diffing old revisions against it.

The result is the same size (62M for current linux-2.6 git tree) and faster
checkout times for head (9s vs 15s).  I also tested against the bk-cvs patch
set:
                                      vanilla               packed/delta
checkout-cache (hot)      (only 1.5G ram) 15s
checkout-cache (cold)     4m30s               1m19s  
size (du -sh .git)              2.5G                  227M

The steps to pack/delta the 2.6 git tree have changed:

# step one, pack all of HEAD together
git-ls-tree -r HEAD | awk '{print $3}' | xargs git-pack

# step two pack deltas for all revs back to the first commit
git-pack-changes-script | xargs git-pack

# step three, pack a delta from 2.6.12-rc2 to 2.6.11
git-pack-changes-script -t 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 c39ae07f393806ccf406ef966e9a15afc43cc36a | xargs git-pack

New git-pack-changes-script:

--
#!/usr/bin/perl
#
# script to search through the rev-list output and generate delta history
# you can specify either a start and stop commit or two trees to search.
# with no command line args it searches the entire revision history.
# output is suitable for piping to xargs git-pack

use strict;

my $ret;
my $i;
my @wanted = ();
my $argc = scalar(@ARGV);
my $commit;
my $stop;
my %delta = ();
my %packed = ();

sub add_packed($) {
    my ($sha1) = @_;
    if (defined($packed{$sha1})) {
        return 1;
    }
    if (defined($delta{$sha1})) {
        return 1;
    }
    $packed{$sha1} = 1;
    print "$sha1\n";
    return 0;
}

sub add_delta($$) {
    my ($ref, $target) = @_;
    my $chain = 0;
    my $recur = $ref;
    if (defined($delta{$target})) {
        return 1;
    }
    if (defined($packed{$target})) {
        return 1;
    }
    while(1) {
	last if (!defined($delta{$recur}));
	if ($target eq $delta{$recur}) {
	    add_packed($target);
	    return 1;
	}
	$chain++;
	if ($chain > 32) {
	    add_packed($target);
	    return 1;
	}
	$recur = $delta{$recur};
    }
    $delta{$target} = $ref;
    print "$ref:$target\n";
    return 0;
}

sub print_usage() {
    print STDERR "usage: pack-changes [-c commit] [-s stop commit] [-t tree1 tree2]\n";
    exit(1);
}

sub find_tree($) {
    my ($commit) = @_;
    open(CM, "git-cat-file commit $commit|") || die "git-cat-file failed";
    while(<CM>) {
        chomp;
	my @words = split;
	if ($words[0] eq "tree") {
	    return $words[1];
	} elsif ($words[0] ne "parent") {
	    last;
	}
    }
    close(CM);
    if ($? && ($ret = $? >> 8)) {
        die "cat-file $commit failed with $ret";
    }
    return undef;
}

sub test_diff($$) {
    my ($a, $b) = @_;
    open(DT, "git-diff-tree -r -t $a $b|") || die "diff-tree failed";
    while(<DT>) {
        chomp;
	my @words = split;
	my $sha1 = $words[2];
	my $change = $words[0];
	if ($change =~ m/^\*/) {
	    @words = split("->", $sha1);
	    add_delta($words[0], $words[1]);
	} elsif ($change =~ m/^\-/) {
	    next;
	} else {
	    add_packed($sha1);
	}
    }
    close(DT);
    if ($? && ($ret = $? >> 8)) {
	die "git-diff-tree failed with $ret";
    }
    return 0;
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
    } elsif ($ARGV[$i] eq "-t") {
        if ($argc != 3 || $i != 0) {
	    print_usage();
	}
	if (test_diff($ARGV[1], $ARGV[2])) {
	    die "test_diff failed\n";
	}
	add_delta($ARGV[1], $ARGV[2]);
	exit(0);
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

open(RL, "git-rev-list $commit|") || die "rev-list failed";
while(<RL>) {
    chomp;
    my $cur = $_;
    my $cur_tree;
    my $parent_tree;
    my $parent_commit = undef;
    open(PARENT, "git-cat-file commit $cur|") || die "cat-file failed";
    while(<PARENT>) {
        chomp;
	my @words = split;
	if ($words[0] eq "tree") {
	    $cur_tree = $words[1];
	    next;
	} elsif ($words[0] ne "parent") {
	    last;
	}
	$parent_commit = $words[1];
	my $next = <PARENT>;
	# ignore merge sets for now
	if ($next =~ m/^parent/) {
	    last;
	}
	# note that we run test_diff to generate a reverse
	# diff
	if (test_diff($cur, $words[1])) {
	    die "test_diff failed\n";
	}
	$parent_tree = find_tree($words[1]);
	if (!defined($parent_tree)) {
	    die "failed to find tree for $words[1]\n";
	}
	add_delta($cur_tree, $parent_tree);
	add_packed($cur);
	last;
    }
    close(PARENT);
    if (!defined($parent_commit)) {
        print STDERR "parentless commit $cur\n";
    }
    if ($? && ($ret = $? >> 8)) {
        die "cat-file failed with $ret";
    }
    if ($cur eq $stop) {
        last;
    }
}
close(RL);

if ($? && ($ret = $? >> 8)) {
    die "rev-list failed with $ret";
}

