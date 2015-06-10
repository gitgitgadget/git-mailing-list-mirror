From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 3/3] git rebase -i: add static check for commands
 and SHA-1
Date: Wed, 10 Jun 2015 17:56:44 +0200 (CEST)
Message-ID: <58099623.334723.1433951804504.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433931035-20011-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpq8ubrtws0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iMN-0007TU-7I
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965580AbbFJP4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 11:56:08 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:35312 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965281AbbFJP4B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:56:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DBC672861;
	Wed, 10 Jun 2015 17:55:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JaaUJ5BQvvk3; Wed, 10 Jun 2015 17:55:58 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C946B2850;
	Wed, 10 Jun 2015 17:55:58 +0200 (CEST)
In-Reply-To: <vpq8ubrtws0.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: add static check for commands and SHA-1
Thread-Index: QHmKzt7qr5YtTDuxhEAWp2Ps239OFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271311>

> > +        git stripspace --strip-comments |
> > +        while read -r command sha1 rest
> > +        do
> > +                case $command in
> > +                ''|noop|x|"exec")
> > +                        ;;
> > +                pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
> > +                        if test -z $sha1
> > +                        then
> > +                                echo "$command $rest" >>"$todo".ba=
dsha
> > +                        else
> > +                                sha1_verif=3D"$(git rev-parse --ve=
rify --quiet $sha1^{commit})"
> > +                                if test -z $sha1_verif
> > +                                then
> > +                                        echo "$command $sha1 $rest=
" \
> > +                                                >>"$todo".badsha
>=20
> When you reach the right end of your screen because of indentation,
> cutting lines with \ is rarely the best option. Having 5 levels of
> indentation is a sign that you should make more functions.

Yeah, I wasn't overly happy with that either, I will try to add some
functions (your example seems like a good way of refactoring).

> > +                                commit=3D"$(git rev-list --oneline=
 -1 --ignore-missing $sha1 2>/dev/null)"
> > +                                if test -z "$commit"
> > +                                then
> > +                                        echo "$command $sha1 $rest=
" \
> > +                                                >>"$todo".badcmd
> > +                                else
> > +                                        echo "$command $commit" >>=
"$todo".badcmd
> > +                                fi
> > +                        fi
>=20
> What are you trying to do here? It seems that you are trying to recov=
er
> the line, but the line is your input, you shouldn't have to recompute
> it.
>=20
> Why isn't printf '%s %s %s' "$command" "$sha1" "$rest" sufficient in =
all
> cases?

It is mainly because here the SHA-1 is a long one (40 chars), however
I agree that computing short_sha1 and then printf '%s %s %s'
"$command" "$short_sha1" "$rest" should be good in this case.

> Maybe it would be better to read line by line (to avoid loosing
> whitespace information for example), like
>=20
>         while read -r line
>         do
>                 printf '%s' "$line" | read -r cmd sha1 rest
>                 case $sha1 in
>                         ...
>=20
> or maybe it's overkill.

Could be a good idea, though I am not completely convinced about it
yet.

Noted for the other points.

Thanks,
R=C3=A9mi
