From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 12:19:49 +0200
Organization: Private
Message-ID: <87d3z7dx2y.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 11:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nql37-0007DM-8L
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 11:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab0CNK1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 06:27:51 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:42341 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab0CNK1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 06:27:50 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2010 06:27:49 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 801A9EBBE3;
	Sun, 14 Mar 2010 12:19:53 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A067673F98B; Sun, 14 Mar 2010 12:19:53 +0200
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id D4B0AE51A7;
	Sun, 14 Mar 2010 12:19:49 +0200 (EET)
In-Reply-To: <7vtysjs9hi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 13 Mar 2010 22:28:09 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142130>

Junio C Hamano <gitster@pobox.com> writes:

> So please explain why asking your local MTA (either mailhost or local=
host)
> how it is configured to identify to other MTA is a good way to obtain=
 the
> HELO domain you should give $smtp_server.  Your answer could be "I ex=
pect
> that most people use $smtp_server set to 'mailhost' or 'localhost' an=
d
> have the MTA configured to talk with the outside world." (which by th=
e way
> I do not think is true for most people).  Or it could be "Xsmtp MTA t=
hat
> is used by many people to send out mails through their ISP's mailserv=
er
> uses the same trick to solve this issue".

The code is based on Perl library Test::Reporter

        http://search.cpan.org/~dagolden/Test-Reporter-1.55/lib/Test/Re=
porter.pm

        /usr/share/perl5/Test/Reporter/Mail/Util.pm =3D=3D> sub _maildo=
main ()

    Function _maildomain() in Test::Reporter uses much more intesive
    tests by scanning all kinds of files, like checking sendmail(1),
    smail(1) etc. configuration files before querying the MTA. I used
    only a portion of it, those parts that I was confortable with to
    handle.

Where to read the FQDN?

    git-send-email contacts MTA to see that it thinks the caller host i=
s
    named, because -- to my knowledge -- the FQDN information is not
    readily available elsewhere in all systems. The MTA does reverse IP
    lookup (DNS) for git-send-email to read.

Why FQDN is passed to MTA?

    Tightly configured MTAs require that the caller gives a real DNS
    domain name that corresponds the IP address in the handshake. This
    prevents spammers from trying to hide their identity.

> Side note.  Apparently this seems to be a common issue.  For example,
> msmtp has this configurable via command line and configuration option=
:
>
>    domain argument
>           Use  this  command to set the argument of the SMTP EHLO (or=
 LMTP
>           LHLO) command.  The default is localhost (stupid, but  work=
ing).
>           Possible  choices  are  the  domain  part  of  your mail ad=
dress
>           (provider.example for joe@provider.example) or the fully  q=
uali=E2=80=90
>           fied domain name of your host (if available).
>
> Interestingly, one of the suggestions above is to derive it from the =
=46rom
> address.
>
> In any case, I want to hear your justification.
>
>> +    --smtp-domain           <str>  * The domain name sent to HELO/E=
HLO handshake
>
> I think this addition makes sense. I suspect that we would also want =
to
> have sendemail.smtpdomain configuration variable.  They of course nee=
d to
> be documented.

Sure.

> +my $MAIL_DOMAIN;			# See maildomain()
> Why uppercase?=20

It might be good to convert all global variables to de facto UPPERCASE.
What do you think? (a separate patch?).

> +        return $MAIL_DOMAIN if $MAIL_DOMAIN;
> +
> +	my $maildomain;
> Looks like a funny indent here...

SP vs. TAB in diff. Fixed.

> Please drop extra SP immediately after '('

Done.

> But as I already said, I tend to think the logic implemented by this =
part
> is of dubious validity.

Does the above explation address this? I concluded that if the Perl
Module developers use MTA to find out the FQDN, it must be a working
solution. Especially as the code is in the Test:: module libraries.

>> @@ -917,6 +962,8 @@ X-Mailer: git-send-email $gitversion
>>  		}
>>  	}
>> =20
>> +	my $maildomain;
>> +
>>  	if ($dry_run) {
>>  		# We don't want to send the email.
>>  	} elsif ($smtp_server =3D~ m#^/#) {
>> @@ -936,13 +983,18 @@ X-Mailer: git-send-email $gitversion
>> ...
>> +			$maildomain =3D maildomain() || "localhost.localdomain";
>> +			$smtp ||=3D Net::SMTP::SSL->new($smtp_server,
>> +						      Hello =3D> $maildomain,
>> +						      Port =3D> $smtp_server_port);
>
> Why not use the same structure as how lifetime is defined for $smtp
> variable?  IOW,
>
> 			$mail_domain || =3D maildomain();
> 			$smtp ||=3D ...

This is now completely different. See new maildomain().

> without an extra local $maildomain variable?  If you do so, then
>
>  - You can lose the $maildomain variable local to this function;

It's needed in the error message (see variable's scope):

		if (!$smtp) {
			die "Unable to initialize SMTP properly. Check config and use --smtp=
-debug. ",
			    "VALUES: server=3D$smtp_server ",
			    "encryption=3D$smtp_encryption ",
!!			    "maildomain=3D$maildomain",
			    defined $smtp_server_port ? "port=3D$smtp_server_port" : "";

>  - "return what the user configured" does not have to be in the maild=
omain
>    sub;

Refactored.

>  - the maildomain sub can return "localhost.localdomain" as a fallbac=
k
>    default; and

Refactored.
=20
>  - various callsites of maildomain sub do not have to repeat the fall=
back
>    default like your patch does.
>
>> @@ -962,9 +1014,10 @@ X-Mailer: git-send-email $gitversion
>>  		}
>> =20
>>  		if (!$smtp) {
>> -			die "Unable to initialize SMTP properly. Check config. ",
>> +			die "Unable to initialize SMTP properly. Check config and use --=
smtp-debug. ",
>
> This part is a good addition, but it needs to be in the earlier patch=
, no?

The --smtp-debug was introduced in the current patch along with maildom=
ain().

See next message for a reworked patch.
Jari
