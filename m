From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv6 3/3] git rebase -i: add static check for commands and
 SHA-1
Date: Tue, 23 Jun 2015 22:35:32 +0200 (CEST)
Message-ID: <1208569888.733725.1435091732761.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1435009369-11496-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqqpp4mciu7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Ut5-0002XG-1a
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbbFWUdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 16:33:39 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42930 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754901AbbFWUdi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:33:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A726837E3;
	Tue, 23 Jun 2015 22:33:36 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRYZz5qV96VI; Tue, 23 Jun 2015 22:33:36 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8017A37DE;
	Tue, 23 Jun 2015 22:33:36 +0200 (CEST)
In-Reply-To: <xmqqpp4mciu7.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: add static check for commands and SHA-1
Thread-Index: UlwCa9w96kyF8NxMDs6WzvAYqQ4/VQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272506>

Junio C Hamano <gitster@pobox.com> writes:
> Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>=20
> >  I used:
> >    read -r command sha1 rest <<EOF
> >    $line
> >    EOF
> >  because
> >    printf '%s' "$line" | read -r command sha1 rest
> >  doesn't work (the 3 variables have no value as a result).
> >  There might be a better way to do this, but I don't have it right =
now.
>=20
>         while read line
>         do
>                 (
>                         IFS=3D' '
>                         set x $line
>                         shift
>                         # now $1 is your command, $2 is sha1, $3 is r=
emainder
>                         ...
>                 )
>         done
>=20
> perhaps?

Will try, thanks!

> But more importantly, why do you even need to keep the bad ones in a
> separate .badcmd and .badsha files?  Isn't that bloating your changes
> unnecessarily, iow, if you issued your warning as you encounter them,
> wouldn't the change become cleaner and easier to understand (and as
> a side effect it may even become smaller)?  The _only_ thing that
> you would get by keeping them in temporary files is that you can do
> "one header and bunch of errors", but is it so common to make a bad
> edit to the insn sheet that "a sequence of errors, one per line"
> becomes more burdensome to the end user?
>=20
> I would think
>=20
>         stripspace |
>         while read -r command sha1 rest
>         do
>                 ...
>=20
> and showing the warning as you detect inside that loop would be
> sufficient.  Perhaps I am missing subtle details of what you are
> doing.

You're not missing subtle details, it is as you said, I tough it would
be clearer for the user to have "one header and a bunch of errors".
Moreover while it would make the patch smaller and easier to
understand, I am not sure about making it cleaner; I guess I will have
to try and see how it ends up.

What I'm not completely happy with your proposition is the fact that=20
if there are multiple errors of the same kind, the output would look=20
something like:
> Warning: the command isn't recognized in the following line:
> badcmd1 some_sha some_commit_message
> Warning: the command isn't recognized in the following line:
> badcmd2 some_sha some_commit_message
(I don't think it would be good to squash some understandable warning
message and the faulty line in one line, it would probably end up
being too long)
However as you say, such mistakes are uncommon so I guess it's fine.

Thanks,
R=C3=A9mi
