From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Mon, 23 Jul 2007 01:37:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230136360.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <Pine.LNX.4.64.0707221959100.14781@racer.site> 
 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com> 
 <Pine.LNX.4.64.0707222013200.14781@racer.site> 
 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com> 
 <Pine.LNX.4.64.0707222238180.14781@racer.site> 
 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com> 
 <Pine.LNX.4.64.0707230048570.14781@racer.site>
 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClvi-0001Xh-7r
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764012AbXGWAhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 20:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763408AbXGWAhj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:37:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:49037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755286AbXGWAhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 20:37:38 -0400
Received: (qmail invoked by alias); 23 Jul 2007 00:37:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 23 Jul 2007 02:37:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ddpx1b3hdQtYpITPFZtgN9x1mfBlB/OMxy1hmgN
	umegKoRc9ZQyX7
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53377>

Hi,

On Sun, 22 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > This doesn't run on the two full kernel samples I sent you.
> > 
> > You mean my script?  Or your C program?
> 
> Your script, I sent two big samples directly to you as attachments
> three hours ago.

Okay, I did not really test thoroughly, it seems.  Sorry.  Next try.

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
	$key = 0;
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
		} elsif ($key && /^\+.*\$$key.*\$/) {
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
			$skip_logs = 0;
			$key = 0;
		} elsif (/^ .*\$Log.*\$/) {
			$current_hunk .= $_;
			$space++;
			$skip_logs = 1;
			$key = 0;
		} elsif (/^ /) {
			$current_hunk .= $_;
			$space++;
			$skip_logs = 0;
			$key = 0;
		} elsif (/^\+/) {
			$current_hunk .= $_;
			$plus++;
			$key = 0;
		} elsif (/^-/) {
			$current_hunk .= $_;
			$minus++;
			$skip_logs = 0;
			$key = 0;
		} elsif (/^\\/) {
			print $_;
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
