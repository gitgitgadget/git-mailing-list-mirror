From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Thu, 18 Jun 2015 17:08:51 +0200 (CEST)
Message-ID: <1444764681.621777.1434640131682.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <xmqqioam58kz.fsf@gitster.dls.corp.google.com> <989982277.592587.1434584914349.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqh9q56yaf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5bPd-00044z-HP
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbbFRPHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 11:07:25 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:39856 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752173AbbFRPHY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 11:07:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5964D3755;
	Thu, 18 Jun 2015 17:07:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEubWfhadnBk; Thu, 18 Jun 2015 17:07:21 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 398523753;
	Thu, 18 Jun 2015 17:07:21 +0200 (CEST)
In-Reply-To: <vpqh9q56yaf.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: Ggq9NPznEeUfjTO1l7Ms3128XiEkUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272012>

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> 
> > I've some more tests, maybe I should put them all in this post ?
> 
> Yes, please post as much as you have. Ideally, this should be
> automatically tested, but if you don't have time to write the automated
> tests, at least having a track of what you did on the list archives can
> help someone else to do it.

It may not be easily readable without colors, so there are the scripts
at the end. You can change the tested input by changing lines after
the "cat >.tmplist" line in testall.sh. (There are two scripts 
testall.sh and testone.perl).

Here are the tests results:

Input: 
Split: 
M::A : 
Same : Yes
----------
Input: Jane
Split: Jane
M::A : Jane
Same : Yes
----------
Input: jdoe@example.com
Split: jdoe@example.com
M::A : jdoe@example.com
Same : Yes
----------
Input: <jdoe@example.com>
Split: jdoe@example.com
M::A : jdoe@example.com
Same : Yes
----------
Input: Jane <jdoe@example.com>
Split: Jane <jdoe@example.com>
M::A : Jane <jdoe@example.com>
Same : Yes
----------
Input: Jane Doe <jdoe@example.com>
Split: Jane Doe <jdoe@example.com>
M::A : Jane Doe <jdoe@example.com>
Same : Yes
----------
Input: Jane\ Doe <jdoe@example.com>
Split: "Jane\ Doe" <jdoe@example.com>
M::A : "Jane \ Doe" <jdoe@example.com>
Same : No
----------
Input: "Jane" <jdoe@example.com>
Split: "Jane" <jdoe@example.com>
M::A : "Jane" <jdoe@example.com>
Same : Yes
----------
Input: "Doe, Jane" <jdoe@example.com>
Split: "Doe, Jane" <jdoe@example.com>
M::A : "Doe, Jane" <jdoe@example.com>
Same : Yes
----------
Input: "Doe, Ja"ne <jdoe@example.com>
Split: "Doe, Ja ne" <jdoe@example.com>
M::A : "Doe, Ja" ne <jdoe@example.com>
Same : No
----------
Input: "Doe, Katarina" Jane <jdoe@example.com>
Split: "Doe, Katarina Jane" <jdoe@example.com>
M::A : "Doe, Katarina" Jane <jdoe@example.com>
Same : No
----------
Input: "Jane@:;\>.,()<Doe" <jdoe@example.com>
Split: "Jane@:;\>.,()<Doe" <jdoe@example.com>
M::A : "Jane@:;\>.,()<Doe" <jdoe@example.com>
Same : Yes
----------
Input: Jane@:;\.,()<>Doe <jdoe@example.com>
Split: Jane@:
     : "\."
     : Doe <jdoe@example.com> ()
M::A : Jane@:
     : \.
     : Doe <jdoe@example.com> ()
Same : No
----------
Input: Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
Split: Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
M::A : Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
Same : Yes
----------
Input: "<jdoe@example.com>"
Split: "<jdoe@example.com>"
M::A : "<jdoe@example.com>"
Same : Yes
----------
Input: "Jane jdoe@example.com"
Split: "Jane jdoe@example.com"
M::A : "Jane jdoe@example.com"
Same : Yes
----------
Input: Jane Doe <jdoe    @   example.com  >
Split: Jane Doe <jdoe@example.com>
M::A : Jane Doe <jdoe@example.com>
Same : Yes
----------
Input: Jane       Doe <  jdoe@example.com  >
Split: Jane Doe <jdoe@example.com>
M::A : Jane Doe <jdoe@example.com>
Same : Yes
----------
Input: Jane @ Doe @ Jane @ Doe
Split: Jane@Doe@Jane@Doe
M::A : Jane@Doe@Jane@Doe
Same : Yes
----------
Input: Jane jdoe@example.com
Split: Janejdoe@example.com
M::A : Jane
     : jdoe@example.com
Same : No
----------
Input: <jdoe@example.com> Jane Doe
Split: jdoe@example.comJaneDoe
M::A : Jane Doe <jdoe@example.com>
Same : No
----------
Input: Jane <jdoe@example.com> Doe
Split: Jane <jdoe@example.comDoe>
M::A : Jane Doe <jdoe@example.com>
Same : No
----------
Input: "Jane, 'Doe'" <jdoe@example.com>
Split: "Jane, 'Doe'" <jdoe@example.com>
M::A : "Jane, 'Doe'" <jdoe@example.com>
Same : Yes
----------
Input: 'Doe, "Jane' <jdoe@example.com>
Split: 'Doe
     : " Jane' <jdoe@example.com>
M::A : 'Doe
     : " Jane' <jdoe@example.com>
Same : Yes
----------
Input: "Jane" "Do"e <jdoe@example.com>
Split: "Jane" "Do" e <jdoe@example.com>
M::A : "Jane" "Do" e <jdoe@example.com>
Same : Yes
----------
Input: "Jane' Doe" <jdoe@example.com>
Split: "Jane' Doe" <jdoe@example.com>
M::A : "Jane' Doe" <jdoe@example.com>
Same : Yes
----------
Input: "Jane Doe <jdoe@example.com>" <jdoe@example.com>
Split: "Jane Doe <jdoe@example.com>" <jdoe@example.com>
M::A : "Jane Doe <jdoe@example.com>" <jdoe@example.com>
Same : Yes
----------
Input: "Jane\" Doe" <jdoe@example.com>
Split: "Jane\" Doe" <jdoe@example.com>
M::A : "Jane\" Doe" <jdoe@example.com>
Same : Yes
----------
Input: Doe, jane <jdoe@example.com>
Split: Doe
     : jane <jdoe@example.com>
M::A : Doe
     : jane <jdoe@example.com>
Same : Yes
----------
Input: "Jane Doe <jdoe@example.com>
Split: " Jane Doe <jdoe@example.com>
M::A : " Jane Doe <jdoe@example.com>
Same : Yes
----------
Input: "Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>
Split: "Jane  Kat a ri na ,Doe" <jdoe@example.com>
M::A : "Jane " Kat "a" ri "na" ",Doe" <jdoe@example.com>
Same : No
----------
Input: Jane Doe
Split: Jane Doe
M::A : Jane
     : Doe
Same : No
----------
Input: Jane "Doe <jdoe@example.com>"
Split: "Jane Doe <jdoe@example.com>"
M::A : Jane
     : "Doe <jdoe@example.com>"
Same : No
----------
Input: \"Jane Doe <jdoe@example.com>
Split: "\"Jane Doe" <jdoe@example.com>
M::A : \ " Jane Doe <jdoe@example.com>
Same : No
----------
Input: Jane\"\" Doe <jdoe@example.com>
Split: "Jane\"\" Doe" <jdoe@example.com>
M::A : Jane \ " \ " Doe <jdoe@example.com>
Same : No
----------
Input: 'Jane 'Doe' <jdoe@example.com>
Split: 'Jane 'Doe' <jdoe@example.com>
M::A : 'Jane 'Doe' <jdoe@example.com>
Same : Yes
----------
Input: 'Jane "Katarina\" \' Doe' <jdoe@example.com>
Split: "'Jane  Katarina\" \' Doe'" <jdoe@example.com>
M::A : 'Jane " Katarina \ " \ ' Doe' <jdoe@example.com>
Same : No


**********************************************************************
*                          SCRIPTS PART                              *
**********************************************************************


---------------------------- testall.sh ----------------------------

#!/bin/sh

cat >.tmplist <<EOF

Jane
jdoe@example.com
<jdoe@example.com>
Jane <jdoe@example.com>
Jane Doe <jdoe@example.com>
Jane\ Doe <jdoe@example.com>
"Jane" <jdoe@example.com>
"Doe, Jane" <jdoe@example.com>
"Doe, Ja"ne <jdoe@example.com>
"Doe, Katarina" Jane <jdoe@example.com>
"Jane@:;\>.,()<Doe" <jdoe@example.com>
Jane@:;\.,()<>Doe <jdoe@example.com>
Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
"<jdoe@example.com>"
"Jane jdoe@example.com"
Jane Doe <jdoe    @   example.com  >
Jane       Doe <  jdoe@example.com  >
Jane @ Doe @ Jane @ Doe
Jane jdoe@example.com
<jdoe@example.com> Jane Doe
Jane <jdoe@example.com> Doe
"Jane, 'Doe'" <jdoe@example.com>
'Doe, "Jane' <jdoe@example.com>
"Jane" "Do"e <jdoe@example.com>
"Jane' Doe" <jdoe@example.com>
"Jane Doe <jdoe@example.com>" <jdoe@example.com>
"Jane\" Doe" <jdoe@example.com>
Doe, jane <jdoe@example.com>
"Jane Doe <jdoe@example.com>
"Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>
Jane Doe
Jane "Doe <jdoe@example.com>"
\"Jane Doe <jdoe@example.com>
Jane\"\" Doe <jdoe@example.com>
'Jane 'Doe' <jdoe@example.com>
'Jane "Katarina\" \' Doe' <jdoe@example.com>
EOF


cat .tmplist | while read -r line
do
    echo "Input: $line"
    ./testone.perl "$line"
    echo ----------
done

---------------------------- testone.perl ----------------------------

#!/usr/bin/perl

use strict;
use warnings;

use Term::ANSIColor;
use Mail::Address;
use Text::ParseWords;

my $string = $ARGV[0];

sub split_addrs {
	my $re_comment = qr/\((?:[^)]*)\)/;
	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
	my $re_word = qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
	my $re_token = qr/(?:$re_quote|$re_word|$re_comment|\S)/;

	my @tokens = map { $_ =~ /\s*($re_token)\s*/g } @_;
	push @tokens, ",";

	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
	foreach my $token (@tokens) {
		if ($token =~ /^[,;]$/) {
			if (@address) {
				push @address, @buffer;
			} else {
				push @phrase, @buffer;
			}
		
			my $str_phrase = join ' ', @phrase;
			my $str_address = join '', @address;
			my $str_comment = join ' ', @comment;
		
			if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
				$str_phrase =~ s/(^|[^\\])"/$1/g;
				$str_phrase = qq["$str_phrase"];
			}
		
			if ($str_address ne "" && $str_phrase ne "") {
				$str_address = qq[<$str_address>];
			}
		
			my $str_mailbox = "$str_phrase $str_address $str_comment";
			$str_mailbox =~ s/^\s*|\s*$//g;
			push @addr_list, $str_mailbox if ($str_mailbox);
		
			@phrase = @address = @comment = @buffer = ();
		} elsif ($token =~ /^\(/) {
			push @comment, $token;
		} elsif ($token eq "<") {
			push @phrase, (splice @address), (splice @buffer);
		} elsif ($token eq ">") {
			push @address, (splice @buffer);
		} elsif ($token eq "@") {
			push @address, (splice @buffer), "@";
		} elsif ($token eq ".") {
			push @address, (splice @buffer), ".";
		} else {
			push @buffer, $token;
		}
	}

	return @addr_list;
}

sub old_split {
	quotewords('\s*,\s*', 1, $_[0]);
}

my @tab = split_addrs($string);
my @ref = map { $_->format } Mail::Address->parse($string);
# my @old = old_split($string);  #can be printed to see the difference

my $tabstring = join "\n", @tab;
my $refstring = join "\n", @ref;
my $same = ($tabstring eq $refstring);

$tabstring =~ s/\n/\n     : /g;
$refstring =~ s/\n/\n     : /g;

print color 'bold yellow';
print "Split: ", "$tabstring", "\n";

print color 'bold blue';
print "M::A : ", "$refstring", "\n";

if ($same) {
	print color 'bold green';
	print "Same : ", "Yes", "\n";
} else {
	print color 'bold red';
	print "Same : ", "No", "\n";
}

print color 'reset';


 
