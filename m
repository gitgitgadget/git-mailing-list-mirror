From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Sat, 1 Nov 2008 20:56:37 +0100
Organization: One2team
Message-ID: <200811012056.37220.fg@one2team.net>
References: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <200811011834.32702.fg@one2team.com> <20081101174352.GG26229@artemis.corp>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1RLDJiLsCF6XOhC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 20:58:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMcK-0006cY-Ul
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYKAT51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYKAT51
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:57:27 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:58602 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKAT50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:57:26 -0400
Received: from erwin.kitchen.eel (AOrleans-157-1-98-121.w90-20.abo.wanadoo.fr [90.20.173.121])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id D548892C011
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 20:57:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081101174352.GG26229@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99766>

--Boundary-00=_1RLDJiLsCF6XOhC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Saturday 01 November 2008 18:43:52 Pierre Habouzit, vous avez =E9crit=A0:
[...]

> Your regex fails to parse:
>
> "Someone with a comma, and an escape double quote \" in its name"

Easy fix: replace "[^"]+" with "[^"]+(?:\\"[^"]*)*".

>   <regex.cant.be.used.for.serious.parsing@i.told.you.so>

Oh yes. Regexes _are_ the way to do serious parsing. All MIME packages you=
=20
will find floating around use regexes to parse mail headers correctly.

Granted, adhering to the RFC822 to the letter is rather hard. But I have a=
=20
sample program here that can not only parse the escaped double quote, but=20
also take account for the multiple line stuff and multiple headers of the=20
same type where email addresse are valid (To:, Cc:, Bcc:). See attachment.=
=20
=46eel free to use the code.

=2D---

fg@erwin ~ $ cat t.txt
To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,=20
Superman <batman@nyc.us>, "Someone with a comma, inside its tag name"=20
<a@b.com>
To: bbr@one2team.com,
 u1@whatever.org,
  u2@wherever.ru,
   u3@blah.com
fg@erwin ~ $ perl t.pl <t.txt
=46ound mail: John Doe <some.address@some.tld>
=46ound mail: Random Joe <random.joe@abc.def>
=46ound mail: Superman <batman@nyc.us>
=46ound mail: "Someone with a comma, inside its tag name" <a@b.com>
=46ound mail: bbr@one2team.com
=46ound mail: u1@whatever.org
=46ound mail: u2@wherever.ru
=46ound mail: u3@blah.com
=2D---


=2D-=20
fge

--Boundary-00=_1RLDJiLsCF6XOhC
Content-Type: application/x-perl;
  name="t.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="t.pl"

#!/usr/bin/perl -W

use strict;

my $headers = {};

my ($current_header, $last_recorded_header) = ("", "");

while (my $line = <STDIN>) {
	last if ($line =~ m/^\s*$/); # END of headers

	if ($line =~ m/^(^\w+): (.*)/) {
		$current_header = lc($1);
		next unless (
			("$current_header" eq "to") or
			("$current_header" eq "cc") or
			("$current_header" eq "bcc")
		);
		chomp (my $value = $2);
		$value =~ s/\s*,\s*$//;
		if ("$current_header" ne "$last_recorded_header") {
			$last_recorded_header = $current_header;
		} else {
			$headers->{"$last_recorded_header"} .= ", ";
		}
		$headers->{"$last_recorded_header"} .= "$value, ";
		next;
	}

	if ($line =~ m/\s+(.*)$/) {
		chomp (my $value = $1);
		$headers->{"$last_recorded_header"} .= "$value";
		next;
	}

	# Should never come here
	die "Invalid headers!\n";
}

my $email_regex_1 = qr/[^@,]+@[^@,]+/;

my $email_regex_2 = qr/(?:"[^"]+(?:\"[^"]*)*")?\s*<[^@]+@[^@]+>/;

my $emails_string = $headers->{"to"};

my @emails = ($emails_string =~ m/\s*($email_regex_1|$email_regex_2)\s*,?/g);

print "Found mail: $_\n" foreach (@emails);

exit(0);


--Boundary-00=_1RLDJiLsCF6XOhC--
