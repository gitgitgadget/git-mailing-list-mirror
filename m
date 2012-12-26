From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: generating format-patch options from an e-mail
Date: Wed, 26 Dec 2012 21:28:30 +0100
Message-ID: <20121226202830.GA29813@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 21:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnxeF-0003VE-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab2LZU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:28:33 -0500
Received: from simaj.xs4all.nl ([83.160.71.26]:48560 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab2LZU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:28:32 -0500
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id E431E40C7B; Wed, 26 Dec 2012 21:28:30 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212149>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all

I've been very frustrated by the process to setup a commandline for git format-patch, to include everyone in the cc list and reply to the right message-id.

In my frustration I created a perl script to generate the options from a saved e-mail, I realise that it may be non-general and perhaps it could be written better using a module which understands e-mails, but well, it worked for me ;-)

Anyway, I could imagine this as optional flag of git format-patch, so you could say:
$ git format-patch -s --in-reply-to-email <mboxfile> a7fe7de8

But I'll save that as an exercise for the reader (or the future)

Cheers

Simon

PS, now with the script

--CE+1k2dSO48ffgeK
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="formatpatchreply.pl"

#!/usr/bin/perl

use warnings;
use strict;

our @to;
our @cc;
our @id;
our $emptyline=0;

if (defined $ARGV[0] and -f $ARGV[0]) {
	open (MAIL, "<$ARGV[0]") or die "cannot open $ARGV[0]\n";
	#while (my $line=<MAIL> && ($emptyline == 0) ) {
	while (my $line=<MAIL> ) {
			chomp $line;
			my $header="";
			my $content="";
		
			if ($line =~ /^(.*?):.*[ ,<](.*?@.*?)[>, ]/ ||
					$line =~ /^(.*ID?):.*[ ,<](.*?)[>, ]/) {
					$header=$1;
					$content=$2;
					if ($header eq "From") {
							push(@to, $content);
					} if ($header eq "To") {
							push(@cc, $content);
					} elsif ($header eq "Cc") {
							$line =~ /:(.*)$/;
							my @ccs=split(/,/, $1);
							foreach my $addr (@ccs) {
									if ($addr =~ /<(.*)>/) {
											push(@cc, $1);
									} else {
											push(@cc, $addr);
									}
							}
					} elsif ($header eq "Message-ID") {
							push(@id, $content);
					}
			}
			$emptyline++ if (length($line) == 0);

	}
	close (MAIL);
}


foreach my $item (@to) {
		print " --to \"$item\"";
}
foreach my $item (@cc) {
		print " --cc \"$item\"";
}
foreach my $item (@id) {
		print " --in-reply-to \"$item\"";
}

--CE+1k2dSO48ffgeK--
