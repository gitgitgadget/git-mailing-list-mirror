From: Ryan Anderson <ryan@michonline.com>
Subject: [RFC] Applying a graft to a tree and "rippling" the changes through
 the history
Date: Sun, 06 Nov 2005 17:38:18 -0500
Message-ID: <436E85DA.1080904@michonline.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBEBF0CA56200E1822B921AE8"
X-From: git-owner@vger.kernel.org Sun Nov 06 23:39:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYt9q-0000eK-Ug
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVKFWi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVKFWi2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:38:28 -0500
Received: from mail.autoweb.net ([198.172.237.26]:20164 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1751243AbVKFWi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 17:38:28 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EYt9a-0000oY-9s
	for git@vger.kernel.org; Sun, 06 Nov 2005 17:38:22 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EYt9Z-00046I-00
	for <git@vger.kernel.org>; Sun, 06 Nov 2005 17:38:21 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EYt9Z-0000lR-EI
	for git@vger.kernel.org; Sun, 06 Nov 2005 17:38:21 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11233>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBEBF0CA56200E1822B921AE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


I've written a tool that will take a single commit, add it as a parent
of another commit, and recreate the history above that second commit in
a fully compatible manner.

This is mostly useful for creating a fully merged-up repository of the
Linux Historical tree, and the current working tree.

I run this with /graft-ripple.pl linux-history.tmp/ linus origin

Where "origin" is the branch the historical repository is on, and
"linus" is the branch the current repository is on.

Note: This does not end up fixing up HEAD or any branches, it just pulls
all the objects together and recreates the full history.

GPLv2, but I'll redo with a proper patch, signed-off-by, command line
options and help and docs if anyone else feels this is useful as a
general tool.

========= cut here =============

#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use IPC::Open2;


sub git_commit_tree {
        my ($tree,$comments,@parents) = @_;

        my @cparents;
        foreach my $p (@parents) {
                push @cparents,"-p",$p;
        }

        my $pid = open2(*Reader, *Writer,
		"git-commit-tree",$tree,@cparents);
        print Writer $comments;
        close(Writer);
        my $commit = <Reader>;

        waitpid $pid, 0;
        close(Reader);

        chomp $commit;

        return $commit;
}

chdir($ARGV[0]);
open(GRL,"-|","git-rev-list","--parents",$ARGV[1])
	or die "Failed to run git-rev-list: " . $!;

my %csets;
my @revs;
while(<GRL>) {
	chomp;
	my ($commit,@parents) = split /\s+/;
	$csets{$commit}{parents} = \@parents;
	push @revs, $commit;

	open(GCF,"-|","git-cat-file","commit",$commit)
		or die "Failed to open git-cat-file: " . $!;

	my $in_comments = 0;
	while(<GCF>) {
		chomp;
		if ($in_comments) {
			$csets{$commit}{comments} .= $_ . "\n";

		} elsif (m/^tree (.+)$/) {
			$csets{$commit}{tree} = $1;
			#printf("tree = %s\n",$1);

		} elsif (m/^parent (.+)$/) {
			# Do nothing, we already got
			# the parents from rev-list.

		} elsif (m/^(author|committer) (.*) <(.*)> (.*)$/) {
			#printf("%s = %s <%s> at %s\n",$1, $2,$3,$4);
			@{$csets{$commit}{$1}}{qw(name email datetime)}
				= ($2,$3,$4);

		} elsif (length == 0) {
			$in_comments = 1;
			$csets{$commit}{comments} = "";
			next;
		}
	}
	close(GCF);

}
close(GRL);

@revs = reverse @revs;
push @{$csets{$revs[0]}{parents}},$ARGV[2];

my %newcsets;
foreach my $old (@revs) {
	printf("Processing commit %s\n",$old);
        $ENV{GIT_AUTHOR_EMAIL} = $csets{$old}{author}{email};
        $ENV{GIT_AUTHOR_NAME} = $csets{$old}{author}{name};
        $ENV{GIT_AUTHOR_DATE} = $csets{$old}{author}{datetime};
        $ENV{GIT_COMMITTER_DATE} = $csets{$old}{committer}{datetime};
        $ENV{GIT_COMMITTER_EMAIL} = $csets{$old}{committer}{email};
        $ENV{GIT_COMMITTER_NAME} = $csets{$old}{committer}{name};

	my @parents = @{$csets{$old}{parents}};
	foreach my $p (@{$csets{$old}{parents}}) {
		if (exists $newcsets{$p}) {
			push @parents, $newcsets{$p}
				if exists $newcsets{$p};
			printf("Found new csetid %s for %s\n",
				$newcsets{$p},$p);
		}
	}
        my $commit = git_commit_tree($csets{$old}{tree},
		$csets{$old}{comments},@parents);
	$newcsets{$old} = $commit;
        printf("Commit for version %s is %s\n",$old,$newcsets{$old});
}


--------------enigBEBF0CA56200E1822B921AE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDboXcfhVDhkBuUKURApEkAJ0agOg1mCsEyvT8fxfOseNKrgRlywCgn/d5
bErtHpy7dvwcsyEO78NXp7w=
=1djc
-----END PGP SIGNATURE-----

--------------enigBEBF0CA56200E1822B921AE8--
