From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: copy selected history between repostories
Date: Sat, 19 Jul 2008 11:01:22 +1000
Message-ID: <20080719010122.GA12047@mail.local.tull.net>
References: <18533605.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: luisgutz <luis@xmos.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK0qM-0001nT-G9
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 03:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbYGSBB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYGSBB0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 21:01:26 -0400
Received: from vps1.tull.net ([66.180.172.116]:52458 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592AbYGSBB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 21:01:26 -0400
Received: (qmail 11887 invoked by uid 1015); 19 Jul 2008 11:01:25 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Sat, 19 Jul 2008 11:01:25 +1000
Received: (qmail 12208 invoked by uid 1000); 19 Jul 2008 11:01:22 +1000
Content-Disposition: inline
In-Reply-To: <18533605.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89092>

On Fri, Jul 18, 2008 at 09:58:49AM -0700, luisgutz wrote:
> Is there any way to import that directory into repoA with all it's history,
> but NOT the history from the other commits?
> Another way of putting is this: can I make git forget the history of all
> other commits but those from this directory?

I couldn't figure out git-filter-branch, so I did the following,
which worked for me:

First, export commits as patches in mbox format:

	git log -p --first-parent --reverse --pretty=email $* > mbox

Second, run the mbox file through a filter which selectively
renames files (since almost always I want the files in a different
directory in the new repository):

	myfilter scripts=bin perllib=lib < mbox > mbox2

Finally, import into new repo:

	git-am mbox2

It's a bit slow on the import step but it meets my needs at this time.

Nick.

Filter script follows, for what it's worth ...


#!/usr/bin/perl
#	@(#) git-filter-rename.pl
#
#	Read an mbox file containing patches on standard input,
#	modify the filenames within according to a list of substitutions
#	supplied on the command line, and write the modified mbox file
#	to standard output.

my @subs;

foreach (@ARGV) {
	if (/(.*)=(.*)/) {
		my $len = length($1);
		push(@subs, [ $1, $2, $len ]);
	} else {
		print STDERR "Unknown arg: $_\n";
	}
}

while (<STDIN>) {
	chomp;
	my $line = $_;

	if ($line =~ /^(---|\+\+\+) ([ab]\/)(.+)$/) {
		my $line_1 = $1;
		my $line_2 = $2;
		my $line_3 = $3;

		subFilename($line_3);

		print "$line_1 $line_2$line_3\n";
		next;
	}

	if ($line =~ /^diff --git ([ab]\/)(\S+) ([ab]\/)(\S+)/) {
		my ($line_1, $line_2, $line_3, $line_4) = ($1, $2, $3, $4);
		subFilename($line_2);
		subFilename($line_4);
		print "diff --git $line_1$line_2 $line_3$line_4\n";
		next;
	}

	print $line, "\n";
}

exit(0);

# ------------------------------------------------------------------------
# Substitute a filename in-place (modifies argument)
# ------------------------------------------------------------------------

sub subFilename {

	foreach my $lr (@subs) {
		my ($lhs, $rhs, $len) = @$lr;
		if (substr($_[0], 0, $len) eq $lhs) {
			print STDERR "Match on $lhs, $_[0]\n";
			substr($_[0], 0, $len) = $rhs;
			last;
		}
	}
}
