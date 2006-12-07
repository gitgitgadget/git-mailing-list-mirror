X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Topic descriptions
Date: Thu, 07 Dec 2006 01:34:30 -0800
Message-ID: <7v3b7suk0p.fsf@assigned-by-dhcp.cox.net>
References: <200612062153.30639.andyparkins@gmail.com>
	<7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
	<200612070837.16412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 09:34:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612070837.16412.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 7 Dec 2006 08:37:13 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33563>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsFeG-0008O6-Gm for gcvg-git@gmane.org; Thu, 07 Dec
 2006 10:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031891AbWLGJed (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 04:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031890AbWLGJed
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 04:34:33 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32789 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031891AbWLGJec (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 04:34:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207093431.NWAZ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 7
 Dec 2006 04:34:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vlZv1V00N1kojtg0000000; Thu, 07 Dec 2006
 04:33:55 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> The actual place it's stored isn't really relevant, more that I could see a 
> use for it.  If it's going in the config I suppose all it needs is a 
> magic "and so it shall be" hand wave.

I now have this in my .git/config:

-- >8 -- snippet from .git/config -- >8 --
[branch "ap/clone-origin"]
	description = set up a cloned repository with friendlier defaults.

[branch "jc/3way"]
	description = use three-way merge to preserve local changes upon branch switch and fast forward.
-- 8< --

and have the script attached at the end.  I can say:

	$ git-topic --base=master

to get something like that per-topic summary I sent out earlier.
The default $base is set to 'next' because usually I am
interested in keeping track of what could be merged but not yet
to next.

Hopefully gitweb (and perhaps gitk) can follow suit to read the
branch description from the same place.

-- >8 -- git-topic.perl -- >8 --
#!/usr/bin/perl -w
#
# Copyright (c) 2006 Junio C Hamano
#

use strict;
use Getopt::Long;

my $topic_pattern = '??/*';
my $base = 'next';
my @stage = qw(next pu);
my @mark = ('.', '?', '-', '+');
my $all = 0;

my @custom_stage;
my @custom_mark;
GetOptions("topic=s" => \$topic_pattern,
	   "base=s" => \$base,
	   "stage=s" => \@custom_stage,
	   "mark=s" => \@custom_mark,
	   "all!" => \$all)
    or die;

if (@custom_stage) { @stage = @custom_stage; }
if (@custom_mark) { @mark = @custom_mark; }

sub read_revs_short {
	my ($bottom, $top) = @_;
	my @revs;
	open(REVS, '-|', qw(git rev-list --no-merges), "$bottom..$top")
	    or die;
	while (<REVS>) {
		chomp;
		push @revs, $_;
	}
	close(REVS);
	return @revs;
}

sub read_revs {
	my ($bottom, $top, $mask) = @_;
	my @revs;
	open(REVS, '-|', qw(git rev-list --pretty=oneline --no-merges),
	     "$bottom..$top")
	    or die;
	while (<REVS>) {
		chomp;
		my ($sha1, $topic) = /^([0-9a-f]{40}) (.*)$/;
		push @revs, [$sha1, $topic, $mask];
	}
	close(REVS);
	return @revs;
}

sub describe_topic {
	my ($topic) = @_;
	open(CONF, '-|', qw(git repo-config --get),
		"branch.$topic.description")
		or die;
	my $it = join('',<CONF>);
	close(CONF);
	chomp($it);
	if ($it) {
		wrap_print("  $it");
	}
}

sub wrap_print {
	my ($string) = @_;
	format STDOUT =
~^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	$string
 ~~^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	$string
.
	write;
}

open(TOPIC, '-|', qw(git for-each-ref),
	'--sort=-authordate',
	'--format=%(objectname) %(authordate) %(refname)',
	"refs/heads/$topic_pattern")
	or die;

while (<TOPIC>) {
	chomp;
	my ($sha1, $date, $topic) = m|^([0-9a-f]{40})\s(.*?)\srefs/heads/(.+)$|
		or next;
	my @revs = read_revs($base, $sha1, (1<<@stage)-1);
	next unless (@revs || $all);

	my %revs = map { $_->[0] => $_ } @revs; # fast index
	for (my $i = 0; $i < @stage; $i++) {
		for my $item (read_revs_short($stage[$i], $sha1)) {
			if (exists $revs{$item}) {
				$revs{$item}[2] &= ~(1 << $i);
			}
		}
	}
	print "* $topic ($date)\n";
	describe_topic($topic);
	for my $item (@revs) {
		my $mark = $item->[2];
		if ($mark < @mark) {
			$mark = $mark[$mark];
		}
		wrap_print("$mark $item->[1]");
	}
}
