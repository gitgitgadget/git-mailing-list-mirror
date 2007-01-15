From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 01:44:56 +0100
Message-ID: <200701150144.56793.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 15 19:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWI-0000iR-Ok
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:18 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8g-0003eK-1M
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXAOAo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXAOAo5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 19:44:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36797 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXAOAo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 19:44:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1224598uga
        for <git@vger.kernel.org>; Sun, 14 Jan 2007 16:44:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bJs/olHi7GiDPGjyAR5pK4JM3fVd2FxHNrpq7GHUvDXn2j+Sz3jX8qf+0SeA2Sry09OI5XmJ7uos3acgY14zb3Cs+6zQ2ePUJp4vWQdyokZUx1SXOdVMsiYuITzAx9DmyzoGBjiZ/SvmcU3hf6WaOgcp23Vc+GxnrONMp8XZON4=
Received: by 10.67.101.10 with SMTP id d10mr4625403ugm.1168821895541;
        Sun, 14 Jan 2007 16:44:55 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id w40sm4936892ugc.2007.01.14.16.44.55;
        Sun, 14 Jan 2007 16:44:55 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36831>

To make gitweb faster I thought about adding to it, or to Git.pm,
simple nonvalidation config file reader. Nonvalidating means that
it would accept some input which git-repo-config considers invalid.

Some of the trouble is caused because of coner cases like this 
example

[section "sub ; # sect \" ion\\"] ; "]
	key = a " b ; " ; " c ; "

which is valid, but strange.

I'm not proficent in Perl, so help is appreciated.

-- >8 --
#!/usr/bin/perl

use strict;
use warnings;

use Text::Balanced qw(extract_delimited);


sub read_config {
	my $configfile = shift;
	my $section = shift;
	my %config;

	open my $fd, $configfile
		or die "Cannot open $configfile: $!";

	my $sectfull;
	while (my $line = <$fd>) {
		chomp $line;

		if ($line =~ m/^\s*\[\s*([^][:space:]]*)\s*\](.*)$/) {
			# section without subsection

			my $sect = lc($1);

			$sectfull = $sect;

		} elsif ($line =~ m/\s*\[([^][:space:]]*)\s"((?:\\.|[^"])*)"\](.*)$/) {
			# section with subsection

			my $sect = lc($1);
			my $subsect = $2;
			$subsect =~ s/\\(.)/$1/g;

			$sectfull = "$sect.$subsect";

		} elsif ($line =~ m/\s*(\w+)\s*=\s*(.*?)\s*$/) {
			# variable assignment

			my $key = lc($1);
			my $rhs = $2;

			my $value = '';
			my ($next, $remainder, $prefix) = qw();
		DELIM: {
				do {
					($next, $remainder, $prefix) =
						extract_delimited($rhs, '"', qr/(?:\\.|[^"])*/);

					if ($prefix =~ s/\s*[;#].*$//) {
						# comment in unquoted part
						$value .= $prefix;
						last DELIM;
					} else {
						$value .= $prefix if $prefix;
						if ($next && $next =~ s/^"(.*)"$/$1/) {
							$value .= $next;
						}
					}

					$rhs = $remainder;
				} while ($rhs && $next);
			} # DELIM:

			if ($remainder) {
				$remainder =~ s/\s*[;#].*$//;
				$value .= $remainder;
			}

			$value =~ s/\\(.)/$1/g;

			if (exists $config{"$sectfull.$key"}) {
				push @{$config{"$sectfull.$key"}}, $value;
			} else {
				$config{"$sectfull.$key"} = [ $value ];
			}

		} elsif ($line =~ m/^\s*(\w+)\s*(:?[;#].*)?$/) {
			# boolean variable without value

			my $key = lc($1);

			if (exists $config{"$sectfull.$key"}) {
				push @{$config{"$sectfull.$key"}}, undef;
			} else {
				$config{"$sectfull.$key"} = [ undef ];
			}
		} # end if
	}

	close $fd
		or die "Cannot close $configfile: $!";

	return wantarray ? %config : \%config;
}

# --------------------------------------------------------------------------

my %config;

%config = read_config("~/git/.git/config");
%config = read_config("/tmp/jnareb/gitconfig");

foreach my $ckey (sort keys %config) {
	foreach my $cvalue (@{$config{$ckey}}) {
		if (defined $cvalue) {
			print "$ckey=$cvalue\n";
		} else {
			print "$ckey\n";
		}
	}
}

__END__
