From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Sun, 22 Jul 2007 22:39:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222238180.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <Pine.LNX.4.64.0707221959100.14781@racer.site> 
 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com> 
 <Pine.LNX.4.64.0707222013200.14781@racer.site>
 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICj9u-0001OF-6v
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXGVVkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbXGVVkG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:40:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:51812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752965AbXGVVkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:40:04 -0400
Received: (qmail invoked by alias); 22 Jul 2007 21:40:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 22 Jul 2007 23:40:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MkfUpBEcMUbzSpvpY2M1tj2s3nzhm3BL4d4gIXg
	iULNB+naeUE1d3
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53325>

Hi,

On Sun, 22 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > But still, I think that it would be much better not to put this into Git.
> > We do have diff gitattributes now, so that you can roll your own diff for
> > specific files, but I still think that this is more a task for a
> > standalone perl script.  Possibly being called from filter-branch to be
> > done with the conversion once and for all times.
> 
> I can provide sample diffs if you want something to play with.

As you already did, this is my attempt at a perl script...  Feel free to 
bash my Perl capabilities, or to correct it...

Ciao,
Dscho

-- snipsnap --
#!/usr/bin/perl

sub init_hunk {
	$_ = $_[0];
	$current_hunk = "";
	$current_hunk_header = $_;
	($start_minus, $dummy, $start_plus, $dummy) =
		/^\@\@ -(\d+)(,\d+|) \+(\d+)(,\d+|) \@\@/;
	$plus = $minus = $space = 0;
	$skip_logs = 0;
}

sub flush_hunk {
	if ($plus > 0 || $minus > 0) {
		if ($current_file ne "") {
			print $current_file;
			$current_file = "";
		}
		$minus += $space;
		$plus += $space;
		print "\@\@ -$start_minus,$minus "
			. "+$start_plus,$plus \@\@\n";
		print $current_hunk;
	}
}

sub check_file {
	$_ = $_[0];
	$current_file = $_;
	while (<>) {
		if (/^\@\@/) {
			last;
		}
		$current_file .= $_;
	}

	init_hunk $_;

	# check hunks
	while (<>) {
		if ($skip_logs && /^\+ *\*/) {
			# do nothing
		} elsif (/^\@\@.*/) {
			flush_hunk;
			init_hunk $_;
		} elsif (/^diff/) {
			flush_hunk;
			return;
		} elsif (/^-.*\$(Id|Revision|Author|Date).*\$/) {
			$key = $1;
			s/^-/ /;
			$current_hunk .= $_;
			$space++;
			$_ = <>;
			if (!/\+.*\$Id.*\$/) {
				die "Expected some changed \$$key line: $_";
			}
			$skip_logs = 0;
		} elsif (/^ .*\$Log.*\$/) {
			$current_hunk .= $_;
			$space++;
			$skip_logs++;
		} elsif (/^ /) {
			$current_hunk .= $_;
			$space++;
			$skip_logs = 0;
		} elsif (/^\+/) {
			$current_hunk .= $_;
			$plus++;
		} elsif (/^-/) {
			$current_hunk .= $_;
			$minus++;
			$skip_logs = 0;
		} else {
			die "Unexpected line: $_";
		}
	}
}

while (<>) {
	if (/^diff/) {
		do {
			check_file $_;
		} while(/^diff/);
	} else {
		printf $_;
	}
}
